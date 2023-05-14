%{
int evenInts = 0 ;
int i= 0;
%}

%%
[0-9]+            { i=atoi(yytext);if(i%2==0)evenInts++ ;}
\n                {}
.                 {}
%%

int main()
{
  yylex();
  printf("%d\n",evenInts);
  return 0;
}
