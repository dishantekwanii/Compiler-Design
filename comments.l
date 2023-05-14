/*%{
int error=0;
%}
%%
["][^"]*["] {printf("%s", yytext);}
"**".+ {} /*single line comment delete*/
"{"(.|\n)*"}" {} /*multi line comment delete*/
"{" {error=1 ;  return error;}
"}" {error=1 ; return error;}


%%
int main()
{
  error=yylex();
  if(error==1)printf("syntax error\n");
  return 0;
}*/


/*second version*/
%{

%}
%%
["][^"]*["]       {printf("%s", yytext);} /* anything in quotes*/
[{][.*][}]+       {} /*multi comment delete*/
"**".*+         {} /*single comment*/
[{](.*\n)*[}]+    {} /*multi*/
[{](\n.*)*[}]+    {} /*multi*/
[{]               {printf("syntax error\n"); return 0;}
[}]               {printf("syntax error\n"); return 0;}

%%
int main()
{
  yylex();
  return 0;
}
