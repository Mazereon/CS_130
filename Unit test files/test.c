#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "minunit.h"
 
FILE *test;
FILE *correct; 
FILE *fPr1;
FILE *fPr2;

int tests_run = 0;

int checkFiles(FILE *fPr1, FILE *fPr2);

 static char * check_out() {
     mu_assert("\nOutput is not okay!\n", checkFiles(test, correct) == 0);
     return 0;
 }
 
 static char * all_tests() {
     mu_run_test(check_out);
     return 0;
 }

// //this actually checks the spacing 
int checkFiles(FILE *fPr1, FILE *fPr2)
{

    int result = 0;

    char ch1 = getc(fPr1);
    char ch2 = getc(fPr2);

   do {
        ch1 = getc(fPr1);
        ch2 = getc(fPr2);

        if(ch1 != ch2) {
            result = -1;
            break;
        }
    }  while (ch1 != EOF && ch2 != EOF);

    return result;
}

int main(int argc, char **argv) {

    test = fopen(argv[1], "r");
    correct = fopen(argv[2], "r");

    if (test == NULL || correct == NULL)
    {
        printf("\nUnable to open file/s since file/s do/es not exist/s or the file/s do/es not have read privilege.\n");
        exit(EXIT_FAILURE);
    }

    char *result = all_tests();
     if (result != 0) {
         printf("%s\n", result);
     }
     else {
         printf("ALL TESTS PASSED\n");
     }
     printf("Tests run: %d\n", tests_run);
 
     return result != 0;
  
    fclose(test);
    fclose(correct);
}
