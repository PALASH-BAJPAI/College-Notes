#include<stdio.h>
#include<string.h>
#include<ctype.h>
struct node
{
	int data;
	struct node * left;
	struct node * right;
};

int height(struct node* tree)
{
    int l,r;
    if (tree == NULL)
        return 0;
    else
    {
    l = height(tree->left);
    r = height(tree->right);
    if (l>r)
        return(l+1);
    else return(r+1);
    }
}



int longest_path(struct node* tree)
{
    if(tree==NULL)
        return 0;
    if(tree->left==NULL&&tree->right==NULL)
        return 0;
    if(tree->left==NULL)
        return(height(tree->right));
    if(tree->right==NULL)
        return(height(tree->left));

    return(height(tree->right)+height(tree->left));
}

struct node* newnode() {
	struct node *temp;
	temp=(struct node*)malloc(sizeof(struct node));
	temp->right=NULL;temp->left=NULL;
	return temp;
}
void create(struct node * tree,char *A,int i,int j) {
	int N=0;
	i=i+1;
	while(isdigit(A[i]))
	{
	    N=N*10+(A[i]-'0');
		i=i+1;
	}
	tree->data=N;
	int b;
	int a;
	a=i;
	i=i+1;
	int count=1;
	while(count!=0)
	{
    if(A[i]=='(')
    count++;
    else if(A[i]==')')
    count--;
    i=i+1;
	}
	b=i-1;
	if(b!=a+1)
	{
    tree->left=newnode();
    create(tree->left,A,a,b);
	}
	a=i;count=1;
	i=i+1;
	while(count!=0)
	{
    if(A[i]=='(')
    count++;
    else if(A[i]==')')
    count--;
    i=i+1;
	}
	b=i-1;
	if(b!=a+1)
	{
    tree->right=newnode();
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
int h=height(tree)-1;
if(tree==NULL)
    h=0;
int l=longest_path(tree);
printf("%d %d\n",h,l);
return 0;
}
