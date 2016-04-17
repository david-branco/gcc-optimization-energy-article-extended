CC = gcc
LEX = flex
YACC = yacc
CFLAGS = -Os

all: clean grades

grades: grades.y grades.l
	$(YACC) -d grades.y
	$(CC) $(CFLAGS) -c y.tab.c
	$(LEX) grades.l
	$(CC) $(CFLAGS) -c lex.yy.c
	$(CC) $(CFLAGS) y.tab.o lex.yy.o -lfl -o grades

clean: 
	rm -f *.o *.html lex.yy.c y.tab.c y.tab.h grades