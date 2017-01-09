#include <stdio.h>
#include "y.tab.h"
extern int yyparse();

int main() {
  int i=yyparse();
  printf("++++++++++++Parser results\n\n");
  if(i) printf("Failure!\n");
  else printf("Success!\n");
  return 0;
  /*
  printf("\n\n\n++++++++++++Lexer results\n\n");
  int token;
  while(token=yylex()){
    if(token<=UNION)    printf("< KEYWORD, %d, %s >\n",token,yytext);
    else if(token==IDENTIFIER)      printf("< IDENTIFIER, %d, %s>\n",token,yytext);
    else if(token==INTEGER_CONSTANT)        printf("< INTEGER_CONSTANT, %d, %s>\n",token,yytext);
    else if(token==FLOATING_CONSTANT)     printf("< FLOATING_CONSTANT, %d, %s>\n",token,yytext);
    else if(token==CHARACTER_CONSTANT)     printf("< CHARACTER_CONSTANT, %d, %s>\n",token,yytext);
    else if(token==STRING_LITERAL)     printf("< STRING_LITERAL, %d, %s>\n",token,yytext);
    else if(token==SQBRAOPEN)       printf("< SQBRAOPEN, %d, %s>\n",token,yytext);
    else if(token==SQBRACLOSE)      printf("< SQBRACLOSE, %d, %s>\n",token,yytext);
    else if(token==ROBRAOPEN)       printf("< ROBRAOPEN, %d, %s>\n",token,yytext);
    else if(token==ROBRACLOSE)      printf("< ROBRACLOSE, %d, %s>\n",token,yytext); 
    else if(token==CURBRAOPEN)      printf("< CURBRAOPEN, %d, %s>\n",token,yytext);
    else if(token==CURBRACLOSE)     printf("< CURBRACLOSE, %d, %s>\n",token,yytext);
    else if(token==DOT)     printf("< DOT, %d, %s>\n",token,yytext);
    else if(token==ACC)     printf("< ACC, %d, %s>\n",token,yytext);
    else if(token==INC)     printf("< INC, %d, %s>\n",token,yytext);
    else if(token==DEC)     printf("< DEC, %d, %s>\n",token,yytext);
    else if(token==AMP)     printf("< AMP, %d, %s>\n",token,yytext);
    else if(token==MUL)     printf("< MUL, %d, %s>\n",token,yytext);
    else if(token==ADD)     printf("< ADD, %d, %s>\n",token,yytext);
    else if(token==SUB)     printf("< SUB, %d, %s>\n",token,yytext);
    else if(token==NEG)     printf("< NEG, %d, %s>\n",token,yytext);
    else if(token==EXCLAIM)     printf("< EXCLAIM, %d, %s>\n",token,yytext);
    else if(token==DIV)     printf("< DIV, %d, %s>\n",token,yytext);
    else if(token==MODULO)      printf("< MODULO, %d, %s>\n",token,yytext);
    else if(token==SHL)     printf("< SHL, %d, %s>\n",token,yytext);
    else if(token==SHR)     printf("< SHR, %d, %s>\n",token,yytext);
    else if(token==BITSHL)      printf("< BITSHL, %d, %s>\n",token,yytext);
    else if(token==BITSHR)      printf("< BITSHR, %d, %s>\n",token,yytext);
    else if(token==LTE)     printf("< LTE, %d, %s>\n",token,yytext);
    else if(token==GTE)     printf("< GTE, %d, %s>\n",token,yytext);
    else if(token==EQ)      printf("< EQ, %d, %s>\n",token,yytext);
    else if(token==NEQ)     printf("< NEQ, %d, %s>\n",token,yytext);
    else if(token==BITXOR)     printf("< BITXOR, %d, %s>\n",token,yytext);
    else if(token==BITOR)     printf("< BITOR, %d, %s>\n",token,yytext);
    else if(token==AND)     printf("< AND, %d, %s>\n",token,yytext);
    else if(token==OR)      printf("< OR, %d, %s>\n",token,yytext);
    else if(token==QUESTION)        printf("< QUESTION, %d, %s>\n",token,yytext);
    else if(token==COLON)       printf("< COLON, %d, %s>\n",token,yytext);
    else if(token==SEMICOLON)       printf("< SEMICOLON, %d, %s>\n",token,yytext);
    else if(token==DOTS)        printf("< DOTS, %d, %s>\n",token,yytext);
    else if(token==ASSIGN)      printf("< ASSIGN, %d, %s>\n",token,yytext);
    else if(token==STAREQ)      printf("< STAREQ, %d, %s>\n",token,yytext);
    else if(token==DIVEQ)       printf("< DIVEQ, %d, %s>\n",token,yytext);
    else if(token==MODEQ)       printf("< MODEQ, %d, %s>\n",token,yytext);
    else if(token==PLUSEQ)      printf("< PLUSEQ, %d, %s>\n",token,yytext);
    else if(token==MINUSEQ)     printf("< MINUSEQ, %d, %s>\n",token,yytext);
    else if(token==SHLEQ)       printf("< SHLEQ, %d, %s>\n",token,yytext);
    else if(token==SHREQ)       printf("< SHREQ, %d, %s>\n",token,yytext);
    else if(token==BINANDEQ)        printf("< BINANDEQ, %d, %s>\n",token,yytext);
    else if(token==BINXOREQ)        printf("< BINXOREQ, %d, %s>\n",token,yytext);
    else if(token==BINOREQ)     printf("< BINOREQ, %d, %s>\n",token,yytext);
    else if(token==COMMA)       printf("< COMMA, %d, %s>\n",token,yytext);
    else if(token==HASH)        printf("< HASH, %d, %s>\n",token,yytext);
    }
    */
}