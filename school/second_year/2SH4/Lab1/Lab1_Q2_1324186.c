/* 
 * File:   main.c
 * Author: mirzahw
 *
 * Created on September 18, 2014, 3:07 PM
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
int main(int argc, char** argv) {

    int SequenceNum; /* Number of values user wants to input*/
    int IncrementNum = 0; /* Used for the Loop*/
    int j = 1; /* Used to ask the user for nth value*/
    int z; /* Used to get value from user*/
    int HighestNum = 0; /* Used as a place holder for highest value, initial1y set to 0*/
    printf("How many number would the user like to input? "); /* Asks user how many values will be inputed*/
    scanf ("%d" , &SequenceNum); /* Stores number in SequenceNum*/
    while (IncrementNum < SequenceNum) /* Loops until all values the user wants to input are inputed*/
    {
        printf("Please Enter number %d: " , j); /* Asks the user for the nth value*/
        scanf("%d" , &z); /* Stores value in z*/
        if (z > HighestNum) /* Compares the value the user inputed with the previous highest value*/
        {
            HighestNum = z; /* If the users number was higher than the previous highest value, it becomes the new highest value*/
        }
        j++; /* Adds one to the asking nth number*/
        IncrementNum++; /* Adds one to the incrementing number*/
    }
    printf("\nThe Highest Number was %d.\n\n", HighestNum); /* Prints the highest value*/
    return (EXIT_SUCCESS);
}
