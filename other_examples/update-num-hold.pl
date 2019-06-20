#!/usr/bin/perl

use strict;
use warnings;

# system
use DBI 1.59;
use File::Slurp 9999.12;
use POSIX 1.09;

#####
use lib '/usr/local/webmin/****/';
use MainConfig;

use Data::Dumper;

my $mc = MainConfig->new(); # initialized %main::config

my $dbh = DBI->connect(
        qq(DBI:mysql:database=$main::config{database};host=localhost),
        $main::config{login},
        $main::config{pass}
);
if ( ! $dbh || $DBI::err ) {
        die( 'failed to connect to database ['.$main::config{database}.'] : '.$DBI::errstr );
}

main(); #Run the main subroutine

sub main {
	my $table = 'PhoneNumberHold';
	my $location = '/var/cache/****/huzaifam/';
	my $filename = $location.'FILENAME';
	#my $filename = $location.'testing.txt';

	print $filename."\n";

	my @nums = read_file ( $filename );
	update_table( \@nums, $table );
}

sub read_file {
        my $filename = $_[0];
        my @return_numbers;

        open my $file, '<', $filename or die( "Could not open file." );
        foreach my $line (<$file>){
                chomp $line;
                push @return_numbers, $line;
        }
        close $file;

        return @return_numbers;
}

sub update_table {
        my @data = @{$_[0]};
	my $table = $_[1];
	my $where_clause = join( ' or Number = ', @data );
	my $sql = qq(
		update $table set Permanent='yes' where Number = $where_clause
	);
	print $sql."\n";
	my $sth = $dbh->prepare( $sql );
	_assert_dbi_ok();
	print "Are you sure you want to execute the above (y/n): ";
	my $yn = <STDIN>;
	chomp $yn;
	if ( $yn eq 'y' or $yn eq 'Y' ) {
		$sth->execute();
		_assert_dbi_ok();
	}

#	my $sql = qq( select * from $table where Number = $where_clause );
#	print "Are you sure you want to execute the above (y/n): ";
#	my $yn = <STDIN>;
#	chomp $yn;
#	if ( $yn eq 'y' or $yn eq 'Y' ) { print $sql."\n"; }	
}

sub _assert_dbi_ok {
        if ( $DBI::err ) {
                die( 'database error: '.$DBI::errstr );
        }
}

