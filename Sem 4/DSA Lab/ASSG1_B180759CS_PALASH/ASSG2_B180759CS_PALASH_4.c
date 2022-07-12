#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
struct node
{
	int data;
	int height;
	int count;
	struct node *left;
	struct node *right;
};


void inorder(struct node * tree)
{
if(tree==NULL)
    return ;
inorder(tree->left);
while(tree->count--)
printf("%d ",tree->data);
inorder(tree->right);
}




struct node *newnode(int x)
{
	struct node *temp=(struct node *)malloc(sizeof(struct node));
	temp->data=x;
	temp->count=1;
	temp->height=1;
	temp->left=NULL;
	temp->right=NULL;
	return temp;
}

struct node *insert(struct node * tree,int x)
{
	if(tree==NULL)
      return newnode(x);
    if(tree->data==x)
    {
        (tree->count)+=1;
        return tree;
    }
	if(x>tree->data)
		tree->right=insert(tree->right,x);
	if(x<tree->data)
          tree->left=insert(tree->left,x);
    return tree;
}

int main()
{
int N;
scanf("%d",&N);
int input[N];
struct node *tree=NULL;
for(int i=0;i<N;i++)
{
	scanf("%d",&input[i]);
	tree=insert(tree,input[i]);
}
inorder(tree);
return 0;
}
