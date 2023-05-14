%{

%}

NUM [0-9]{1,6}[ \t\n]+
NEWCOUNTY   C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
OLDCOUNTY   C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
OLDYR [0-9]{2}
NEWYR [0-9]{2}[12]

%%
{OLDYR}-{OLDCOUNTY}-{NUM}     {
                                char y[2];
                                strncpy(y, yytext, 2);
                                int yInt =atoi(y);
                                if(yInt < 13) yInt= yInt + 2000;
                                else yInt = yInt + 1900;

                                printf("%d\n", 2019-yInt);

                              }
{NEWYR}-{NEWCOUNTY}-{NUM}     {
                                char y[2];
                                strncpy(y, yytext,2);
                                int yInt = atoi(y);

                                printf("%d\n", 19-yInt);

                              }
.+[ \t\n]                     { printf("INVALID\n");}
\n                            {}



%%


int main(){
  yylex();
  return 0;
}
