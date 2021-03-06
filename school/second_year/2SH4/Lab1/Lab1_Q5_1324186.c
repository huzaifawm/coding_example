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

    int PosNum = -1; /* Used to determine is inputted value is positive*/
    int j; /* Used to find the Reverse of the number*/
    int RevNum = 0; /* Used for the Reverse of the number*/
    while (PosNum<0) /* Will keep asking the user for a positive number until one is inputted*/
    {
    printf("Please enter a positive number: "); /* Asks the user for a positive number*/
    scanf("%d" , &PosNum); /* Stored that number in PosNum*/
    if (PosNum<0) /* Checks to make sure the user to enters a positive number*/
    {
        printf("\nThis is not a positive number. "); /* Tells the user the number is not positive*/
    }
    }
    while(PosNum>0) /* Performs the following code until the original number is 0*/
    {
       j = PosNum%10; /* Divides users number by 10 and gives j the value of the remainder*/
       RevNum = RevNum*10+j; /* Multiplies the Reverse number by 10 and adds the j*/
       PosNum /= 10; /* Gets rid of the last number of the original number*/
    }
    printf("\n\nThe reverse number is %d.\n\n" , RevNum); /* Final output, tells the Reverse number*/
    return (EXIT_SUCCESS);
}
