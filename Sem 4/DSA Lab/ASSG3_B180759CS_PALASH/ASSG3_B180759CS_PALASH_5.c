#include<string.h>
#include<stdio.h>
#include<stdlib.h>


int pos(int keyValue,int m)
{
        int position = (keyValue % m);
        return position;
}

int* hashTable(int *x,int ele)
{
        int i;
        x = (int *)malloc(ele*sizeof(int ));
        for(i=0;i<ele;i++)
                x[i] = -9999;
        return x;
}


int prime(int a)
{
        int i,j,flag=0;
        for(i=a-1;i>1;i--)
        {
                for(j=2;j<i;j++)
                {
                        if(i%j==0)
                        {
                                flag=1;
                                break;
                        }
                }
                if(j==i && flag==0 )
                        return i;
                flag=0;
        }
}

void insert1(int hash[],int x,int m)
{
        int i=0;
        int key =x+i;
        while( ( hash[pos(key,m)] !=(-9999) )  && ( i <= (m-1) ) )
        {
                i++;
               key = x+i;
        }

        if( i <= (m-1) )
             hash[pos(key,m)] = x;
}

void insert2(int hash[],int x,int m,int c1,int c2 )
{
        int i=0;
        int key = x + c1*i + c2*i*i ;
        while( ( hash[pos(key,m)] !=(-9999) ) && ( i <= (m-1) ) )
        {
                i++;
                key = (x + c1*i + i*i*c2 );
        }

        if( i<= (m-1) )
           hash[pos(key,m)] = x;
}


void insert3(int hash[],int x,int m)
{
        int R=prime(m);
        int i=0;
        int key = (x%m) + i*( R-(x%R) );
        while( ( hash[pos(key,m)] !=(-9999) ) && ( i <= (m-1) ) )
        {
                i++;
                key = (x%m) + i*( R-(x%R) );
        }

        if( i<= (m-1) )
                hash[pos(key,m)] = x;
}



void delete1(int hash[],int x,int m)
{
        int i=0;
        int key =x+i;
        while( ( hash[pos(key,m)] !=(x) )  && ( i <= (m-1) ) )
        {
                i++;
               key = x+i;
        }

        if( i <= (m-1) )
             hash[pos(key,m)]=-9999;
}

void  delete2(int hash[],int x,int m,int c1,int c2 )
{
        int i=0;
        int key = x + c1*i + c2*i*i ;
        while( ( hash[pos(key,m)] !=(x) ) && ( i <= (m-1) ) )
        {
                i++;
                key = (x + c1*i + i*i*c2 );
        }

        if( i<= (m-1) )
           hash[pos(key,m)]=-9999;
}



void delete3(int hash[],int x,int m)
{
        int R=prime(m);
        int i=0;
        int key = (x%m) + i*( R-(x%R) );
        while( ( hash[pos(key,m)] !=(x) ) && ( i <= (m-1) ) )
        {
                i++;
                key = (x%m) + i*( R-(x%R) );
        }

        if( i<= (m-1) )
        hash[pos(key,m)]=-9999;
}


int search1(int hash[],int a,int m)
{
        int i=0;
        int key =a+i;
        while( ( hash[pos(key,m)] !=(a) )  && ( i <= (m-1) ) )
        {
                i++;
               key = a+i;
        }

        if( i <= (m-1) && hash[pos(key,m)] == a )
             return 1;
        return -1;
}

int  search2(int hash[],int x,int m,int c1,int c2 )
{
        int i=0;
        int key = x + c1*i + c2*i*i ;
        while( ( hash[pos(key,m)] !=(x) ) && ( i <= (m-1) ) )
        {
                i++;
                key = (x + c1*i + i*i*c2 );
        }

        if( i<= (m-1) && hash[pos(key,m)] == x )
           return 1;
        return -1;
}

int  search3(int hash[],int x,int m)
{
        int R=prime(m);
        int i=0;
        int key = (x%m) + i*( R-(x%R) );
        while( ( hash[pos(key,m)] !=(x) ) && ( i <= (m-1) ) )
        {
                i++;
                key = (x%m) + i*( R-(x%R) );
        }

        if( i<= (m-1) && hash[pos(key,m)] ==x )
            return 1;
        return -1;
}


void print(int hash[],int m)
{
        int i;
        for(i=0;i<m;i++)
        {
                if(hash[i]==(-9999) )
                        printf("%d ()\n",i);
                else
                        printf("%d (%d)\n",i,hash[i]);
        }
}


void main()
{
        char ch,s;
        int *A;
        int m,key,c1,c2;
        int a,b,c;
        scanf("%c%d",&ch,&m);
        A = hashTable(A,m);
        if( ch == 'a' )
        {
            while(1)
                {
                scanf("%c",&s);
                switch(s)
                {
                case 'i': scanf("%d",&key); insert1(A,key,m); break;
                case 's': scanf("%d",&key); printf("%d\n",search1(A,key,m));  break;
                case 'd': scanf("%d",&key); delete1(A,key,m);  break;
                case 'p': print(A,m); break;
                case 't': return;
                case 'T':return ;
                }
                }
                }
                else if( ch == 'b' )
                {
            scanf("%d%d",&c1,&c2);
            while(1)
            {
            scanf("%c",&s);
            switch(s)
            {
                    case 'i': scanf("%d",&key); insert2(A,key,m,c1,c2); break;
                    case 's': scanf("%d",&key); printf("%d\n",search2(A,key,m,c1,c2));  break;
                    case 'd': scanf("%d",&key); delete2(A,key,m,c1,c2);  break;
                    case 'p': print(A,m); break;
                    case 't': return;
                    case 'T':return;
            }
            }
    }
        else if( ch == 'c' )
            {
            while(1)
            {
            scanf("%c",&s);
            switch(s)
            {
                    case 'i': scanf("%d",&key); insert3(A,key,m); break;
                    case 's': scanf("%d",&key); printf("%d\n",search3(A,key,m));  break;
                    case 'd': scanf("%d",&key); delete3(A,key,m);  break;
                    case 'p': print(A,m); break;
                    case 't': return;
                    case 'T': return;
            }
        }
    }
}
