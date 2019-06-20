#!/usr/bin/perl

use lib '/usr/local/****/****/local/lib/perl5';

use Mojo::Base 'Mojolicious';
use Mojo::Pg;
use Mojo::Pg::Database;
use Data::Dumper qw(Dumper);

use DBI;
my $db = "****";
my $dbusername = "****";
my $dbpassword = "****";
my $dbhost = "****";

my $dbh = Mojo::Pg->new("postgresql://$dbusername:$dbpassword\@$dbhost/$db");

#my $sql = qq(select * from subscribers limit 5);
#my %return = $dbh->db->query($sql)->hash;

main();

sub main {
	
	my $location = '/****/****/';
	my $filename = $location.'FILENAME';

	my @data = read_file( $filename );
	shift @data;

	my $num = scalar @data;
	print "About to update $num line(s) from file $filename.\n";

	# Tables
	my $subTable = "subscribers";
	my $subEquipTable = "subscriber_equipment";
	my $cooTable = "coordinates_override";

	my $subscriberId = 30000;
	foreach my $str (@data) {
		my ($macUC, $subid, $add, $prov, $nd, $lat, $long) = split /,/, $str;
		# Setting mac to only lower case letters and number
		$macUC =~ s/\W//g;
		my $mac = lc $macUC;
		$add =~ s/['#]+//g;
		my $bsid = '001';
		# Setting a valid lat and long
		if ($lat eq '') { $lat = '0'; }
		if ($long eq '') { $long = '0'; }

		$subscriberId = subscriber_table($subTable, $subscriberId, $subid, $bsid, $add, $prov);

		subscriberEquipment_table($subEquipTable, $subTable, $mac, $subid);
		
		coordinatesOverride_table($cooTable, $bsid, $subid, $lat, $long);
	}

}

sub read_file {
	my $filename = $_[0];
	my @return_data;

	open my $file, '<', $filename or die( "Could not open file." );
	foreach my $line (<$file>){
		$line =~ s/\s*\z//;
		push @return_data, $line;
	}
	close $file;

	return @return_data;
}

sub subscriber_table {
	my ($sub_table, $subscriberId, $subid, $bsid, $add, $prov, ) = @_;
	my $subscriber_content = qq( {"bsid": "$bsid", "city": "", "subid": "$subid", "active": 1, "status": "SUBSTAT_ACT", "country": "","address1": "$add", "address2": "", "province": "$prov", "last_name": "", "first_name": "", "postal_code": "", "phone_number": ""} );
	my ($sub_fields, $sub_values) = ( qq( id,content ), qq( '$subscriberId','$subscriber_content'::jsonb ));
	my $sub_where = qq( content->> 'subid' = '$subid' );
	
	# First search if subscriber already exists
	my $sub_bool = select_sql($sub_table, $sub_where);

	# Subscriber doesn't exist in table
	if (!$sub_bool) { insert_sql($sub_table, $sub_fields, $sub_values); $subscriberId++; }

	return $subscriberId++;
}

sub subscriberEquipment_table {
	my ($subEquip_table, $sub_table, $mac, $subid) = @_;
	
	# First search if equipment already exists
	my $subEquip_where = qq( identifier = '$mac' );
	my $subEquip_bool = select_sql($subEquip_table, $subEquip_where);

        # Find subscriberid
	my $sub_where = qq( content->> 'subid' = '$subid' );
        my $sub_bool = select_sql($sub_table, $sub_where);
        my %hash = %$sub_bool;
        my $subscriberId = $hash{id};

	# If Equipment doesn't exist then find subsciberid
	if (!$subEquip_bool) {
		# Find subscriberid
		#my $sub_where = qq( content->> 'subid' = '$subid' );
		#my $sub_bool = select_sql($sub_table, $sub_where);
		#my %hash = %$sub_bool;
		#my $subscriberId = $hash{id};

		my ($subEquip_fields, $subEquip_values) = ( qq( subscriber_id,identifier,content ), qq( '$subscriberId','$mac','{"active" :1}' ));
		# insert into table
		insert_sql($subEquip_table, $subEquip_fields, $subEquip_values);
	} else {
		my $subEquip_set = qq( subscriber_id = $subscriberId );
		update_sql($subEquip_table, $subEquip_set, $subEquip_where);
	}
}


sub coordinatesOverride_table {
	my ($coo_table, $bsid, $subid, $lat, $long) = @_;
	my ($coo_fields, $coo_values) = ( qq( bsid,subid,lat,lng ), qq( '$bsid','$subid','$lat','$long' ));
	my $coo_where = qq( subid = '$subid' );
	
	# Check if coordinates exist
	my $coo_bool = select_sql($coo_table, $coo_where);
	
	# Coordinates don't exit
	if (!$coo_bool) { insert_sql($coo_table, $coo_fields, $coo_values); }
}


sub insert_sql {
	my ($table, $fields, $values) = @_;

	my $sql = qq(insert into $table ($fields) values ($values); );
	#print $sql."\n";

	$dbh->db->query($sql);
	_assert_dbi_ok();
}

sub update_sql {
	my ($table, $set, $where) = @_;

	my $sql = qq( update $table set $set where $where; );
	$dbh->db->query($sql);
	_assert_dbi_ok();
	#print $sql."\n";
}

sub select_sql {
	my ($table, $where) = @_;

	my $sql = qq( select * from $table where $where; );
	#print $sql."\n";

	my $return = $dbh->db->query($sql)->hash;
	_assert_dbi_ok();
	#if (!$return) { return 1 } else { return 0 };
	return $return;
}

sub _assert_dbi_ok {
        if ( $DBI::err ) {
                die( 'database error: '.$DBI::errstr );
        }
}

