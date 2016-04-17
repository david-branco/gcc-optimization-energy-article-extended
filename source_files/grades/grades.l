%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
NOTAS		{return NOTAS;}
[0-9]+		{yylval.num = atoi(yytext);return NUM;}	
[\.\,\;\)\(]		{return yytext[0];}
[a-zA-Z]+		{yylval.nome = strdup(yytext);return NOME;}
[ \t\r\n]+		{;}
.			{fprintf(stderr,"Erro: caracter não reconhecido.");}
%%

int yywrap(void){return 1;}
