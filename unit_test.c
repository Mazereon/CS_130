 #include <stdio.h>
 #include "minunit.h"
 
 int tests_run = 0;
 
 FILE *test1;
 FILE *test2;
 FILE *correct1;
 FILE *correct1;

 static char * test_first() {
     mu_assert("error, output 1 wrong.", compareFiles(correct1, test1));
     return 0;
 }
 
 static char * test_second() {
     mu_assert("error, output 2 wrong.", compareFiles(correct2, test2));
     return 0;
 }
 
 static char * all_tests() {
     mu_run_test(test_first);
     mu_run_test(test_second);
     return 0;
 }
 
 void compareFiles(FILE *fp1, FILE *fp2) 
{ 
    // fetching character of two file 
    // in two variable ch1 and ch2 
    char ch1 = getc(fp1); 
    char ch2 = getc(fp2); 
  
    // error keeps track of number of errors 
    // pos keeps track of position of errors 
    // line keeps track of error line 
    int error = 0, pos = 0, line = 1; 
  
    // iterate loop till end of file 
    while (ch1 != EOF && ch2 != EOF) 
    { 
        pos++; 
  
        // if both variable encounters new 
        // line then line variable is incremented 
        // and pos variable is set to 0 
        if (ch1 == '\n' && ch2 == '\n') 
        { 
            line++; 
            pos = 0; 
        } 
  
        // if fetched data is not equal then 
        // error is incremented 
        if (ch1 != ch2) 
        { 
            error++; 
            printf("Line Number : %d \tError"
               " Position : %d \n", line, pos); 
        } 
  
        // fetching character until end of file 
        ch1 = getc(fp1); 
        ch2 = getc(fp2); 
    } 
  
    printf("Total Errors : %d\t", error); 
} 
 int main(int argc, char **argv) {

    FILE *fp1 = fopen(argv[1], "r");
    FILE *fp2 = fopen(argv[2], "r");
    char *result = all_tests();
     if (result != 0) {
         printf("%s\n", result);
     }
     else {
         printf("ALL TESTS PASSED\n");
     }
     printf("Tests run: %d\n", tests_run);
 
     return result != 0;
 }
