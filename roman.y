%{
#include <stdio.h>
%}

%token M CM D CD C XC L XL X IX V IV I ERROR

%%

input:
    | input line
    ;

line:
    romans '\n' {
        printf("%d\n", $1);
    }
    | ERROR '\n' {
        printf("syntax error\n");
    }
    ;

romans:
    roman {
        $$ = $1;
    }
    | romans roman {
        $$ = $1 + $2;
    }
    ;

roman:
    M {
        $$ = 1000;
    }
    | CM {
        $$ = 900;
    }
    | D {
        $$ = 500;
    }
    | CD {
        $$ = 400;
    }
    | C {
        $$ = 100;
    }
    | XC {
        $$ = 90;
    }
    | L {
        $$ = 50;
    }
    | XL {
        $$ = 40;
    }
    | X {
        $$ = 10;
    }
    | IX {
        $$ = 9;
    }
    | V {
        $$ = 5;
    }
    | IV {
        $$ = 4;
    }
    | I {
        $$ = 1;
    }
    ;

%%

int main(void) {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int yylex(void);
