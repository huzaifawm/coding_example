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

    char c; /* Used as the character the user wants counted*/
    int b;
    char C;
    char text; /* Used to get a list of characters by the user*/
    int count = 0; /* Counter*/
    printf("Enter a Character to count the number of appearances of: "); /* Asks the user for the character that is to be counted*/
    scanf("%c" , &c); /* Stores that value in */
    printf("Enter a text: "); /* Asks the user for a text*/
    while ((text = getchar()) != '!') /* Continues to get a character by the user until a '!' has been inputted*/
    {
        if (text == c || text == C) /* Checks to see if the character the user inputs is the same as the intended character*/
        {
            count = (count +1); /* If the user enters a character that is the same as the intended character the counter increases by 1*/
        }
    }
    printf("\n\nYour letter appeared %d time(s)\n\n",count); /* Outputs the final number of the specific characters*/
    return (EXIT_SUCCESS);
}
