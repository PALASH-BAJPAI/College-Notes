#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct node{
int key;
int count; // number of times a key appears in the array
int height;
struct node* left;
struct node* right;
};

int getheight(struct node *tree)
{
    if(tree==NULL)
        return 0;
    else
        return tree->height;
}

int max(int x,int y)
{
    if(x>y)
        return x;
    return y;
}

int getBalance(struct node* tree)
{
    if(tree==NULL)
        return 0;
    return (getheight(tree->left)-getheight(tree->right));
}

struct node* newNode(int value)
{
  struct node* temp=(struct node*)malloc(sizeof(struct node));
  temp->key= value;
  temp->left=NULL;
  temp->right=NULL;
  temp->height=1;
  temp->count=1;
  return temp;
}

struct node* leftRotate(struct node* x)
{
 struct node* y=x->right;
 struct node *temp=y->left;

 y->left=x;
 x->right=temp;

 x->height=max(getheight(x->left),getheight(x->right))+1;
 y->height=max(getheight(y->left),getheight(y->right))+1;

 return y;
}


 struct node* rightRotate(struct node* y)
{
 struct node* x=y->left;
 struct node *temp=x->right;

 x->right=y;
 x->left=temp;

 x->height=max(getheight(x->left),getheight(x->right))+1;
 y->height=max(getheight(y->left),getheight(y->right))+1;

 return x;
}


 struct node* insert(struct node* tree,int value)
 {

  if(tree==NULL)
        return (newNode(value));
  if(value<tree->key)
    tree->left=insert(tree->left,value);
  if(value>tree->key)
    tree->right=insert(tree->right,value);
  if(value==tree->key){
    tree->count++;
    return tree;
  }
  else{
    return tree;
  }

   tree->height=1+max(getheight(tree->left),getheight(tree->right));
   int balance=getBalance(tree);

   if(balance>1&&value<tree->left->key)
    return rightRotate(tree);

   if(balance<-1&&value>tree->right->key)
    return leftRotate(tree);

    if(balance>1 && value>tree->left->key){
        tree->left=leftRotate(tree->left);
        return rightRotate(tree);
    }

    if(balance<-1 && value<tree->right->key){
        tree->right=rightRotate(tree->right);
        return leftRotate(tree);
    }

     return tree;
 }

 void inorder(struct node* tree)
 {
    if(tree==NULL)
        return;
    inorder(tree->left);
    while(tree->count!=0)
    {
       printf("%d ",tree->key);
       tree->count--;
    }
       inorder(tree->right);
 }


 int main()
 {
     struct node* tree=NULL;
     int N;
     int value;
     scanf("%d",&N);
     while(N--)
     {
         scanf("%d",&value);
         tree=insert(tree,value);
     }
     inorder(tree);
     printf("\n");
 }
