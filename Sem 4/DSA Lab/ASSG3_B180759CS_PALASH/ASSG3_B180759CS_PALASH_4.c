#include<stdio.h>

int main()
{
    int T;
    scanf("%d",&T);
    while(T--)
    {
        char x[100];
        char y[1000];

        scanf("%s",x);
        scanf("%s",y);

        int count1[26]={0};
        int count2[26]={0};

        int i,j;

        for(i=0;x[i]!=0;i++)
        {
            count1[x[i]-'a']++;
        }
         for(i=0;y[i]!=0;i++)
        {
            count2[y[i]-'a']++;
        }
        int flag=0;
        for(i=0;i<26;i++)
        {
            if(count1[i]>count2[i])
            {
                flag=1;
                break;
            }
        }

        if(flag==1)
            printf("NO\n");
        else
            printf("YES\n");
    }

}
