#include <stdio.h>
#include <string.h>

/*
Se cere sa se citeasca de la tastatura un sir de numere, date in baza 16 (se citeste de la tastatura un sir de 
caractere si in memorie trebuie stocat un sir de numere). Sa se afiseze valoarea zecimala a nr atat ca numere 
fara semn cat si ca numere cu semn.
*/




int zecimal();

int zecimal_unsigned(char sir[], int len);


char data[256];
int numbers[200];
char number[8];

int main()
{
    printf("Enter a string without . ? < + = > ... \n");
    scanf("%[^\n]s", data);
    int i =0;
    while (data[i] == ' ')
    {
        i = i+1;
    }
    while ( i < strlen(data))
    {
        int nr_signed, nr_unsigned;
        int j = i;
        while( data[i] != ' ' && i < strlen(data) )
        {
            i = i+1;
        }
        strncpy(number, data+j ,i-j+1);
        number[i-j+1] = NULL;
        zecimal_unsigned(number, strlen(number), nr_unsigned);
        printf("For the number: %s, the zecimal form as unsigned is %d", number, nr_unsigned);
        while (data[i] == ' ' && i<strlen(data))
        {
            i = i+1;
        } 
    }
    return 0;
}
