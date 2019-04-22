# CS_130

[![Build Status](https://travis-ci.com/Mazereon/CS_130.svg?token=5UwYrrDuwqoi1qu46f5D&branch=master)](https://travis-ci.com/Mazereon/CS_130)

**Files**: Flex file, Bison file, Unit Testing file, input files, expected output files  <br/>

**Requirements**: C, Flex, Bison

**Flex**: http://gnuwin32.sourceforge.net/packages/flex.htm  <br/>
**Bison**: http://ftp.gnu.org/gnu/bison/  <br/>  <br/>
**NOTE: REMEMBER TO ADD THEM BOTH TO PATH IN WINDOWS**

**Steps**:
1.  Generate the Bison file first since the flex file requires the header file generated by Bison. <br/>
	**bison -t -d Parser.y** <br/>
	**-t** is for debugging <br/>
	**-d** is for generating the header file
	
2.	Generate the Flex C file using the command **flex Lexer.l**
3.  Compile both of these using the command **gcc Parser.tab.c lex.yy.c -o hello**
4.  To run the main method use the command **hello input.txt output1.txt output2.txt**  <br/>

**Testing**:
1.  Compile the unit testing code located in Unit testing files using the command **gcc -o check unit_test.c**
2.  Run using the command **check output1.txt expected_output1.txt output2.txt expected_output2.txt** <br/>
**NOTE: REMEMBER TO PLACE THE OUTPUTS AND EXPECTED OUTPUTS IN THE UNIT TESTING FOLDER.**