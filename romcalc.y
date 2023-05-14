%{
#include <stdio.h>
#include <string.h>

int roman_to_int(char c);
void calculate(char op, char* op1, char* op2, char* result);
%}

%token M D C L X V I
%token PLUS MINUS TIMES DIV LPAREN RPAREN
%token EOL

%left PLUS MINUS
%left TIMES DIV

%%

program:
    | program expression EOL { printf("%s\n", $2); }
    ;

expression:
      term
    | expression PLUS term { calculate('+', $1, $3, $$); }
    | expression MINUS term { calculate('-', $1, $3, $$); }
    ;

term:
      factor
    | term TIMES factor { calculate('*', $1, $3, $$); }
    | term DIV factor { calculate('/', $1, $3, $$); }
    ;

factor:
      LPAREN expression RPAREN { $$ = strdup($2); }
    | M { $$ = strdup("1000"); }
    | D { $$ = strdup("500"); }
    | C { $$ = strdup("100"); }
    | L { $$ = strdup("50"); }
    | X { $$ = strdup("10"); }
    | V { $$ = strdup("5"); }
    | I { $$ = strdup("1"); }
    ;

%%

int main() {
    yyparse();
    return 0;
}

void calculate(char op, char* op1, char* op2, char* result) {
    int op1_int = roman_to_int(*op1);
    int op2_int = roman_to_int(*op2);
    int res_int;

    switch (op) {
        case '+': res_int = op1_int + op2_int; break;
        case '-': res_int = op1_int - op2_int; break;
        case '*': res_int = op1_int * op2_int; break;
        case '/': res_int = op1_int / op2_int; break;
    }

    if (res_int < 0) {
        strcpy(result, "-");
        res_int = -res_int;
    } else {
        result[0] = '\0';
    }

    while (res_int >= 1000) {
        strcat(result, "M");
        res_int -= 1000;
    }
    if (res_int >= 900) {
        strcat(result, "CM");
        res_int -= 900;
    }
    if (res_int >= 500) {
        strcat(result, "D");
        res_int -= 500;
    }
    if (res_int >= 400) {
        strcat(result, "CD");
        res_int -= 400;
    }
    while (res_int >= 100) {
        strcat(result, "C");
        res_int -= 100;
    }
    if (res_int >= 90) {
        strcat(result, "XC");
        res_int -= 90;
    }
    if (res_int >= 50) {
        strcat(result, "L");
        res_int -= 50;
    }
    if (res_int >= 40) {
        strcat(result, "XL");
        res_int -= 40;
    }
    while (res_int >= 10) {
        strcat(result, "X");
        res_int -= 10;
    }
    if (res_int >= 9) {
        strcat(result, "IX");
        res_int -= 9;
    }
    if (res_int >= 5) {
