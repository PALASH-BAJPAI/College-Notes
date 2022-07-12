#include<stdlib.h>
#include<stdio.h>
#include<string.h>

struct node{
	char word[20];
	struct node* next;
};


void print(struct node* temp)
{
	while(temp!=NULL)
	{
	    if(temp->word!='.'&&temp->word!=',')
            printf("%s ",temp->word);
		temp=temp->next;
	}
}



struct node* insert(struct node* temp,char letter[50])
{
	if(temp==NULL)
	{
		struct node *a=(struct node*)malloc(sizeof(struct node));
		strcpy(a->word,letter);
		a->next=NULL;
		return a;
	}
	struct node *last;
	last=temp;
	while(last->next!=NULL)
	{
		if(!strcmp(last->word,letter))
		{
			return temp;
		}
		last=last->next;
	}
	while(last->next!=NULL)
	{
		last=last->next;
	}
	struct node *a=(struct node*)malloc(sizeof(struct node));
	strcpy(a->word,letter);
	a->next=NULL;
	last->next=a;
	return temp;
}



void main()
{
	int N,l;
	int i;
	scanf("%d",&N);
	struct node* hash[N];
	for(i=0;i<N;i++)    //assigning all hash NULL
		hash[i]=NULL;
	char temp[50];
	char ch;

	while(scanf("%s",temp))
	{

        if(temp!='.'&&temp!=',')
        {
		l=strlen(temp);
		if(l!=1&&temp!=','&&temp!='.')
		hash[(l%N)]=insert(hash[(l%N)],temp);
        }
		scanf("%c",&ch);
		if(ch=='\n')
			break;
	}


	for(i=0;i<N;i++)    //to print final answer
	{
	    if(hash[i]==NULL)
            printf("NULL");
		print(hash[i]);
		printf("\n");
	}
}

