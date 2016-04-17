%{
	#include <stdio.h>
	#include <fcntl.h>

	int yylex(void);
	void yyerror(char *);
	void cabec();
	void rodape();
	void linha(char *n1, char *n2, float media);
	int i;
%}

%union{
	int num;
	char *nome;
}

%token<num> NUM
%token<nome> NOME
%token NOTAS
%type<num> listaNotas nota
%type<nome> Aluno

%%
frase : {cabec();} NOTAS lstAlunos '.'{rodape();}	
			;

lstAlunos : Aluno				
					| lstAlunos ';' Aluno
					;

Aluno: NOME NOME '(' listaNotas ')'	{ linha($1, $2, $4/i); }
     ;

listaNotas : nota				{i=1;$$ = $1;}		
			     | listaNotas ',' nota		{i++;$$ = $1 + $3;}
			     ;

nota : NUM {$$ = $1;}
     ;

%%

void cabec() { 
	printf("<html>\n<head><title>Grades</title></head>\n<body>\n"); 
}

void rodape() {
	printf("</body>\n</html>\n"); 
}

void linha(char *n1, char *n2, float media) { 
	printf("The mean of <b>%s %s</b> is: %1.0f<br>\n",n1, n2, media); 
}

void yyerror(char *s) {
	fprintf(stderr,"ERRO : %s\n",s);
}

int main() {
	int fdin, fdout, fderr;

	if(chdir("source_files/grades"));
	fdin = open("grades.txt", O_RDONLY, 0666);
	dup2(fdin, 0);
	close(fdin);

	fdout = open("grades.html", O_CREAT|O_TRUNC|O_WRONLY, 0666);
	dup2(fdout, 1);
	close(fdout);

	fderr = open("grades.html", O_WRONLY, 0666);
	dup2(fderr, 2);
	close(fderr);

	yyparse();
	return 0;
}

