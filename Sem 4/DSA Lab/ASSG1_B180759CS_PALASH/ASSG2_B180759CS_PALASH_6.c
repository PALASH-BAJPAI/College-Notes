#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>
struct node
{
	int data;
	struct node * left;
	struct node * right;
};



int  mod_tree(struct node * tree)
{
if(tree==NULL)
   return 0;
if(tree->right==NULL&&tree->left==NULL)
	return tree->data;
int rs=mod_tree(tree->right);
int ls=mod_tree(tree->left);
tree->data+=ls+rs;
return tree->data;
}


void preorder(struct node *tree) {
if(tree!=NULL)
{
    printf(" ( ");
    printf("%d",tree->data);
    preorder(tree->left);
    preorder(tree->right);
    printf(") ");
}
else
    printf(" ( ) ");
}



struct node* newnode() {
	struct node *temp;
	temp=(struct node*)malloc(sizeof(struct node));
	temp->right=NULL;temp->left=NULL;
	return temp;
}
void create(struct node * tree,char *A,int i,int j) {
	int n=0;
	i=i+1;
     char s[5];
	while(isdigit(A[i])||A[i]=='-')
	{
	if(isdigit(A[i]))
	{n=n*10+(A[i]-'0');
		i=i+1;

	}
	if(A[i]=='-'&&isdigit(A[i+1]))
	{
		n=n*10+(A[i+1]-'0');
		n*=-1;

		i+=2;

	}
	}

	tree->data=n;int b;

	int a;

	a=i;

	i=i+1;int count;

	count=1;

	while(count!=0)

	{	if(A[i]=='(')

		count++;

		else if(A[i]==')')

			count--;

		i=i+1;

	}

	b=i-1;

	if(b!=a+1)

	{	tree->left=newnode();

		create(tree->left,A,a,b);

	}

	a=i;count=1;

	i=i+1;

	while(count!=0)

	{       if(A[i]=='(')

		count++;

		else if(A[i]==')')

			count--;

		i=i+1;

	}

	b=i-1;

	if(b!=a+1)

	{       tree->right=newnode();

		create(tree->right,A,a,b);

	}
	return;
}

int main()
{
 struct node *tree;
char input[100];
char x[100];
scanf("%[^\n]%*c", input);
int i,p,n;
i=0;p=0;
while(input[i])
{
    if(input[i]!=' ')
    {
    x[p]=input[i];
    p++;
    }
    i++;
   }
   x[p]='\0';
tree=newnode();
create(tree,x,0,p-1);
int a=mod_tree(tree);
preorder(tree);
}
