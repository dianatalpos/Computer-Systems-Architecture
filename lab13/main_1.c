#include <stdio.h>
#include <string.h>

/*
Se cere sa se citeasca de la tastatura un sir de numere, date in baza 16 (se citeste de la tastatura un sir de 
caractere si in memorie trebuie stocat un sir de numere). Sa se afiseze valoarea zecimala a nr atat ca numere 
fara semn cat si ca numere cu semn.
*/

#define MAX_SIZE 50 

int hex_to_dec(char* s, int len);

//char data[100];       <-- nu e necesar să fie VARIABILĂ GLOBALĂ
//int numbers[200];     <-- nu e necesar să fie VARIABILĂ GLOBALĂ

int main()
{
    char data[MAX_SIZE];
    int numbers[MAX_SIZE];
    
    // initializam sirul de intrare
    int i = 0;
    for (i = 0; i < strlen(data); i++)
        data[i] = '\0';                     // caracterul NULL (valoarea 0)
    
    // initializam sirul de numere intregi
    for (i = 0; i < MAX_SIZE; i++)
        numbers[i] = 0;
    
    // citim sirul de intrare
    printf("Enter a string of hexadecimal numbers separated by space: ");
    scanf("%[^\n]s", data);
    
    // afisam sirul de intrare
    printf("Input string: %s\n", data);     // 1 FE ABC 2F34 ...
    
    i = 0;
    int j = 0;
    int k = 0;
    int len = 0;
    char tmp[10];
    tmp[0] = '\0';
    while (i < strlen(data))
    {
        if (data[i] == '\0')            // daca caracterul curent este NULL (sirul se termina)
            break;                      // iesim din bucla while

        if (data[i] != ' ')             // daca caracterul curent nu e spatiu
        {
            tmp[j] = data[i];           // il copiem pe pozitia curenta din sirul tmp
            j++;                        // incrementam pozitia curenta din sirul tmp
            len++;                      // incrementam lungimea curenta a sirului tmp
        }
        else
        {
            numbers[k] =
                hex_to_dec(tmp, len);   // obtinem valoarea in baza 10
            k++;                        // trecem urmatorul numar
            j = 0;                      // initializam pozitia curenta din sirul tmp
            len = 0;                    // initializam lungimea curenta a sirului tmp
            tmp[0] = '\0';              // initializam sirul tmp
        }
        
        i++;                            // trecem la urmatorul caracter din sirul data
    }
    
    // afisam rezultatul
    printf("Result string:");
    for (i = 0; i < k; i++)
        printf(" %d", numbers[i]);

    return 0;
}
