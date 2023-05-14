%{
#include "romcalc.tab.h"
%}

%option noyywrap
%option nodefault

%{
int yylval;
%}

%%
[IVXLCDM]+ {
    yylval = roman_to_arabic(yytext);
    return NUMBER;
}
[\+\-*/\{\}] { return yytext[0]; }
[ \t\n]     { /* ignore whitespace */ }
.           { printf("syntax error\n"); return 0; }
%%

int roman_to_arabic(const char *roman) {
    int values[26] = {
        ['I'-'A'] = 1,
        ['V'-'A'] = 5,
        ['X'-'A'] = 10,
        ['L'-'A'] = 50,
        ['C'-'A'] = 100,
        ['D'-'A'] = 500,
        ['M'-'A'] = 1000
    };
    int arabic = 0;
    int prev = 0;
    for (int i = strlen(roman) - 1; i >= 0; i--) {
        int curr = values[roman[i] - 'A'];
        if (curr < prev) {
            arabic -= curr;
        } else {
            arabic += curr;
            prev = curr;
        }
    }
    return arabic;
}
