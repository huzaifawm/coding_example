/* 
 * File:   main.c
 * Author: mirzahw
 *
 * Created on September 18, 2014, 3:06 PM
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
int main(int argc, char** argv) {

    int n; /* Variable that is used for calculations */
    int k; /* Place holder Variable */
    for (n=1; n<=30; n++) /* The For Loop */
    {
        k = (n*n); /* Calculation */      
    }
    printf("Using a For Loop we get %d:\n" , k); /* Prints Final k after calculations*/
    n = 1; /* Set n back to 1*/
    k = 0; /* Set the value of k back to 0*/
    while (n<=30) /* The While Loop */
    {
        k = (n*n); /* Calculation */
        n++; /* Adding one to value of n */
    }
    printf("Using a While Loop we get %d:\n" , k); /* Prints Final k after calculations*/
    n = 1; /* Set n back to 1*/
    k = 0; /* Set the value of k back to 0*/
    do /* Do While Loop */
    {
        k = (n*n); /* Calculation */
        n++; /* Adding one to value of n */
    }
    while (n<=30); /* Condition */
    printf("Using a Do While Loop we get %d:\n" , k); /* Prints Final k after calculations*/
    return (EXIT_SUCCESS);
}
