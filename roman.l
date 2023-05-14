%{
#include "roman.tab.h"
%}

%option noyywrap

%%

M+     { return M; }
CM     { return CM; }
D+     { return D; }
CD     { return CD; }
C+     { return C; }
XC     { return XC; }
L+     { return L; }
XL     { return XL; }
X+     { return X; }
IX     { return IX; }
V+     { return V; }
IV     { return IV; }
I+     { return I; }
\n     { return 0; }
.      { return ERROR; }

%%
