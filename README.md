# CS_130

[![Build Status](https://travis-ci.com/Mazereon/CS_130.svg?token=5UwYrrDuwqoi1qu46f5D&branch=master)](https://travis-ci.com/Mazereon/CS_130)

Requirements: C, Flex, Bison

Flex: http://gnuwin32.sourceforge.net/packages/flex.htm  <br/>
Bison: http://ftp.gnu.org/gnu/bison/

Steps
1.  Generate the Bison file first since the flex file requires the header file generated by Bison. <br/>
	**bison -t -d Parser.y** <br/>
	**-t** is for debugging <br/>
	**-d** is for generating the header file
	
2.	Generate the Flex C file using the command **flex Lexer.l**
3.  Compile both of these using the command **gcc Parser.tab.c lex.yy.c -o hello**
4.  To run the main method use the command **hello input.txt output1.txt output2.txt**  <br/>
NOTE: REMEMBER TO ADD THEM BOTH TO PATH IN WINDOWS
