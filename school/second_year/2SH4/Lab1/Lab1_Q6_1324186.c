/* 
 * File:   main.c
 * Author: mirzahw
 *
 * Created on September 18, 2014, 3:08 PM
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
int main(int argc, char** argv) {

    /* Part A*/
    double pi; /* Variable pi is a double so it can work with decimals*/
    float j = 1; /* Variable j is a float so it can work with decimals*/
    int n; /* Users input number*/
    int k = 0; /* Used for loop*/
    int z = 1; /* Used for loop*/
    int count = 0; /* Used as counter*/
    printf("Enter a positive nth term: "); /* Asks user to input a positive value*/
    scanf("%d" , &n); /* Stores value in n*/
    while (n<0) /* Used to determine if the inputted value is infact positive*/
    {
        if (n<0) /* Checks to see if n is a negative number*/
        {
            printf("That's not a positive number."); /* Lets the user know the number is not a positive one*/
        }
        printf("\nEnter a positive nth term: "); /* Asks the user once again*/
        scanf("%d" , &n); /* Stores value in n*/
    } /* Only leaves the loop when a positive number is inputted*/
    while (k<n) /* used to calculate pi*/
    {
        pi = pi + z*(4/j); /* pi calculation*/
        j = (j+2); /* Increases the denominator by 2 starting from 1*/
        z = z*-1; /* Used to alternate the sign, positive to negative*/
        k++; /* Adds one to k until k is the same as n then the loop will stop*/
    }
    printf("\nYour final value of pi is %f.\n\n" , pi); /* Final output*/
    /* Part B*/
    pi = 0; /* Sets the pi value back to 0*/
    j = 1; /* Sets the j value back to 1*/
    z = 1; /* Sets the z value back to 1*/
    int i; /* Used to determine number of terms*/
    do /* Loops to get the number of terms it takes to get 3.1415*/
    {
        pi = pi + z*(4/j); /* pi calculation*/
        i = pi*10000; /* Multiplies pi by a 1000 and stores it as an integer in i (always rounds down)*/
        j = (j+2); /* Increases the denominator by 2 starting from 1*/
        z = z*-1; /* Used to alternate the sign, positive to negative*/
        count++; /* Adds one to count, Counts how many time the loop runs*/
    }
    while (i != 31415); /* The loop will only exit when i equals 31415*/
    printf("\n\nIt take %d terms of n to get at least 3.1415\n\n" , count); /* Final output*/
    return (EXIT_SUCCESS);
}
