// Pas de header Epitech !

#include <stdio.h>

int badFunction(int a,int b){    // Pas d'espace après virgule, accolade mal placée
	int result=a+b;  // Tab au lieu d'espaces, pas d'espaces autour de =
	
	// Ligne trop longue avec beaucoup de caractères pour dépasser la limite de 80 colonnes imposée par le coding style
	
	if(result>10){goto error;}  // goto interdit ! Et mauvais espacement
	
	return result;
	
error:
	return -1;
}

int veryLongFunctionThatViolatesTheMaximumLengthRuleByHavingMoreThanTwentyLinesOfCodeInItsFunctionBody(void)
{
    int a = 1;
    int b = 2;
    int c = 3;
    int d = 4;
    int e = 5;
    int f = 6;
    int g = 7;
    int h = 8;
    int i = 9;
    int j = 10;
    int k = 11;
    int l = 12;
    int m = 13;
    int n = 14;
    int o = 15;
    int p = 16;
    int q = 17;
    int r = 18;
    int s = 19;
    int t = 20;
    int u = 21;
    return u;
}

int main(void)   
{
    badFunction(1,2);
    return 0;
}
