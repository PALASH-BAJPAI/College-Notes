#include<stdio.h>
#include<string.h>
#include<ctype.h>
struct node
{
	int data;
	struct node * left;
	struct node * right;
};


void mirror(struct node * tree)
{ if(tree==NULL)
	return;
if(tree)
{
	mirror(tree->left);
	mirror(tree->right);
	struct node * temp;
	temp=tree->left;
	tree->left=tree->right;
	tree->right=temp;

}
return;
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
    printf("( ) ");
}
struct node* insr()

{
        char ch;
        int n ;
        scanf(" %c",&ch);
        if(scanf("%d",&n))
        {

                struct node* temp=(struct node*)malloc(sizeof(struct node)) ;
                temp->data=n;
                temp->left=insr() ;
                temp->right=insr() ;
                scanf(" %c",&ch);
                return temp ;
        }
        scanf(" %c",&ch);
        return NULL ;
}

struct node* newnode() {
	struct node *temp;
	temp=(struct node*)malloc(sizeof(struct node));
	temp->right=NULL;temp->left=NULL;
	return temp;
}

int main()
{
 struct node *tree;

tree=insr();
mirror(tree);
preorder(tree);
}
