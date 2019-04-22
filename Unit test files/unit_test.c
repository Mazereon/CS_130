#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
FILE *test1;
FILE *test2;
FILE *correct1; 
FILE *correct2;
FILE * fPtr1;
FILE * fPtr2;

int compareFiles(FILE * fPtr1, FILE * fPtr2);

 
int compareFiles(FILE * fPtr1, FILE * fPtr2)
{
    char ch1, ch2;

    ch1 = fgetc(fPtr1);
    ch2 = fgetc(fPtr2);

    do
    {
        // Input character from both files
        ch1 = fgetc(fPtr1);
        ch2 = fgetc(fPtr2);
        // If characters are not same then return -1
        if (ch1 != ch2)
            return -1;

    } while (ch1 != EOF && ch2 != EOF);


    /* If both files have reached end */
    if (ch1 == EOF && ch2 == EOF)
        return 0;
    else
        return -1;
}

int main(int argc, char **argv) {

    FILE *test1 = fopen(argv[1], "r");
    FILE *test2 = fopen(argv[3], "r");

    FILE *correct1 = fopen(argv[2], "r");
    FILE *correct2 = fopen(argv[4], "r");

    if (test1 == NULL || test2 == NULL || correct1 == NULL || correct2 == NULL)
    {
        /* Unable to open file hence exit */
        printf("\nUnable to open file.\n");
        printf("Please check whether file exists and you have read privilege.\n");
        exit(EXIT_FAILURE);
    }
    if (compareFiles(test1, correct1) == 0 )
    {
         printf("Output 1 is correct.\n");
    }
    if (compareFiles(test2, correct2) == 0 )
    {
         printf("Output 2 is correct.\n");
    }

    if (compareFiles(test1, correct1) != 0 )
    {
         printf("Output 1 is incorrect.\n");
    }

    if (compareFiles(test2, correct2) != 0 )
    {
         printf("Output 2 is incorrect.\n");
    } 

    fclose(test1);
    fclose(test2);
    fclose(correct1);
    fclose(correct2);
}
