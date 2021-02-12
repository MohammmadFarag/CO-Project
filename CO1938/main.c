#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define PARAGRAPH_SIZE 100

void search(char paragraph[PARAGRAPH_SIZE]);
void substring (char string[10],int start,int end);
void capsfirst (char paragraph[PARAGRAPH_SIZE]);
void lowerupper(char paragraph[PARAGRAPH_SIZE],int x);
void join (char s1[10],char s2[10]);

int main()
{
    char paragraph[PARAGRAPH_SIZE];
    int choice;
    char string2[10];
    int start,end;
    char s1[10],s2[10];
    printf("Enter a Paragraph MAX 100 characters(End it with TAB):\n");
    scanf("%100[^\t]s", paragraph); //100 to fix overflow
    printf("\nChoose an operation\n(1)Search on a specific word/character\n(2)Extract a substring from a word\n(3)Join strings\n(4)Capitalize first letter in each word\n(5)Convert all characters in the paragraph to Lower/Upper case\n");
    scanf("%d",&choice);
    switch (choice)
    {
    case 1:
        search(paragraph);
        break;
    case 2:

        printf("enter the string:");
        scanf("%s",string2);
        printf("enter the start:");
        scanf("%d",&start);
        printf("enter the end:");
        scanf("%d",&end);
        substring(string2,start,end);
        break;

    case 3:
        printf("Type string 1: ");
        scanf("%s",s1);
        printf("Type string 2: ");
        scanf("%s",s2);
        join(s1,s2);
        break;

    case 4:
        capsfirst(paragraph);
        break;
    case 5:
        printf("Select 1 For LowerCase OR 2 For UpperCase :");
        int n;
        scanf("%d",&n);
        while(n>2 || n<1)
        {
        printf("\nONLY 1 OR 2 Available selection \nSelect 1 For LowerCase OR 2 For UpperCase :");
        scanf("%d",&n);
        }
        lowerupper(paragraph,n);
        break;
    }
    return 0;
}

void search(char paragraph[PARAGRAPH_SIZE])
{
    char searchfield[10];
    int found;
    int pgLen, sfLen;
    printf("enter search field: ");
    scanf("%s",searchfield);
    pgLen  = strlen(paragraph);
    sfLen = strlen(searchfield);
    int i=0;
    while(i<pgLen - sfLen) // Run a loop from starting index of string to length of string - word length
    {
        // Match word at current position
        found = 1;
        int j=0;
        while (j<sfLen)
        {
            // If word is not matched
            if(paragraph[i + j] != searchfield[j])
            {
                found = 0;
                break;
            }
          j++;
        }

        // If word have been found then print found message
        if(found == 1)
        {
            printf("'%s' found at index: %d \n", searchfield, i);
        }
        i++;
    }
}

void substring (char string[10],int start,int end)
{
    int substrsize = end-start;
    char substring[substrsize];
    int subcounter=0;
    do{
        substring[subcounter]=string[start];
        start++;
        subcounter++;
    }
    while(start != end);
    printf("\nthe sub string is:%s", substring);

    return 0;

}

void lowerupper(char paragraph[PARAGRAPH_SIZE],int x) // x is selection between two cases
{
    int i = 0;
    int PLen  = strlen(paragraph);

    if (x == 1)
    {
    while(i < PLen)
    {

        if(paragraph[i]>=65 && paragraph[i]<=90) // upper ASCII Values from A to Z
        {
            paragraph[i] = paragraph[i] + 32; // +32 To convert A to a in ASCII values [upper to lower]
        }
        i++;
    }
    printf("Converted Paragraph Is\n%s", paragraph);
    }

    else if(x == 2)
    {
    while(i < PLen)
    {

        if(paragraph[i]>=97 && paragraph[i]<=122  ) // Lower ASCII Values from a to z
        {
            paragraph[i] = paragraph[i] - 32; // -32 To convert a to A in ASCII values [lower to upper]
        }
        i++;
    }
    printf("Converted Paragraph Is\n%s", paragraph);
    }

}

void capsfirst (char paragraph[PARAGRAPH_SIZE])
{
    int i;
    //capitalize first character of words
	for(i=0; paragraph[i]!='\0'; i++)
	{
    //check first character is lowercase alphabet
		if(i==0)
		{
			if((paragraph[i]>='a' && paragraph[i]<='z'))
				paragraph[i]=paragraph[i]-32; //subtract 32 to make it capital
			continue; //continue to the loop
		}
		if(paragraph[i]==' ')//check space
		{
			//if space is found, check next character
			++i;
			//check next character is lowercase alphabet
			if(paragraph[i]>='a' && paragraph[i]<='z')
			{
				paragraph[i]=paragraph[i]-32; //subtract 32 to make it capital
				continue; //continue to the loop
			}
		}
	}

	printf("Capitalize string is: %s\n",paragraph);
}

void join(char s1[10],char s2[10])
{
    int length=0;
    while (s1[length] != '\0')
    {
        ++length;
    }
    for (int i=0; s2[i] != '\0'; ++i, ++length)
    {
    s1[length] = s2[i];
    }

    s1[length] = '\0';
    printf("%s",s1);
}
