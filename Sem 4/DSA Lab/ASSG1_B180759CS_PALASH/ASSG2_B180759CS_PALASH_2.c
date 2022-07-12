#include<stdio.h>
#include<string.h>

struct node{
int data;
struct node* right;
struct node* left;
};

struct node* newNode(int item)
{
struct node* temp=(struct node*)malloc(sizeof(struct node));
temp->data=item;
temp->left=temp->right=NULL;
return temp;
}
struct node* insert(struct node* tree,int i)
{
   if(tree==NULL)
        return newNode(i);
   if(i<tree->data)
        tree->left=insert(tree->left,i);
   else
        tree->right=insert(tree->right,i);
   return tree;
}

struct node* search(struct node* tree,int k)
{
    if((tree==NULL)||tree->data==k)
        return tree;
    if(tree->data<k)
        return search(tree->right,k);
    return search(tree->left,k);
}




void paren(struct node* tree)
{
    if(tree!=NULL)
    {
        printf("( ");
        printf("%d",tree->data);
        paren(tree->left);
        paren(tree->right);
        printf(") ");
    }
    else
        printf("( ) ");
}



int findMin(struct node* tree)
{
    if(tree==NULL)
        return 0;
    struct node* last=tree;
    while(last->left!=NULL)
        last=last->left;
    return(last->data);
}

int findMax(struct node* tree)
{
    if(tree==NULL)
        return 0;
    struct node* last=tree;
    while(last->right!=NULL)
        last=last->right;
    return(last->data);
}

struct node* Min(struct node* tree)
{
    struct node* last=tree;
    while(last->left!=NULL)
        last=last->left;
    return(last);
}
struct node* Max(struct node* tree)
{
    struct node* last=tree;
    while(last->right!=NULL)
        last=last->right;
    return(last);
}

struct node* predecessor(struct node *tree,int i)
{
  struct node* temp=tree;
  struct node* new=NULL;
  struct node* a=search(tree,i);
  if(a==NULL)
  {
   printf("NULL\n");
   return new;
  }

  if((Min(tree))->data==i){
    printf("-1\n");
    return new;
  }

  while(temp->data!=i)
  {
      if(temp->data!=i)
      {
          new=temp;
          temp=temp->left;
      }
      else
        temp=temp->right;
  }
  if(temp->left!=NULL)
    printf("%d\n",(Max(temp->left))->data);
  else
    printf("%d\n",new->data);
}

struct node* successor(struct node *tree,int i)
{
  struct node* temp=tree;
  struct node* new=NULL;
  struct node* a=search(tree,i);
  if(a==NULL)
  {
   printf("NULL\n");
   return new;
  }

  if((Max(tree))->data==i){
    printf("-1\n");
    return new;
  }
  while(temp->data!=i)
  {
      if(temp->data!=i)
      {
          new=temp;
          temp=temp->right;
      }
      else
        temp=temp->left;
  }
  if(temp->right!=NULL)
    printf("%d\n",(Min(temp->right))->data);
  else
    printf("%d\n",new->data);
}

void inorder(struct node* tree)
{
    if(tree==NULL)
        return;
    inorder(tree->left);
    printf("%d ",tree->data);
    inorder(tree->right);
}

void preorder(struct node* tree)
{
    if(tree==NULL)
        return;
    printf("%d ",tree->data);
    preorder(tree->left);
    preorder(tree->right);
}

void postorder(struct node* tree)
{
    if(tree==NULL)
        return;
    postorder(tree->left);
    postorder(tree->right);
    printf("%d ",tree->data);
}


struct node* delete(struct node* tree, int i)
{
    if (tree == NULL)
    {
        printf("NULL\n");
        return tree;
    }
    if (i < tree->data)
        tree->left = delete(tree->left,i);
    else if (i > tree->data)
        tree->right = delete(tree->right, i);
    else
    {
        if (tree->left == NULL)
        {
            struct node *temp = tree->right;
            free(tree);
            return temp;
        }
        else if (tree->right == NULL)
        {
            struct node *temp = tree->left;
            free(tree);
            return temp;
        }
        struct node* temp = Min(tree->right);
        tree->data= temp->data;
        tree->right = delete(tree->right, temp->data);
    }
    return tree;
}




int main()
{
    int i,k;
    struct node* tree=NULL;
    char s[20];
    while(1)
    {
        scanf("%s",s);

        if(!strcmp("insr",s))
        {
            scanf("%d",&i);
            tree=insert(tree,i);
        }

        if(!strcmp("srch",s))
        {
            scanf("%d",&k);
            if(search(tree,k)==NULL)
                printf("NOT FOUND\n");
            else
                printf("FOUND\n");
        }

        if(!strcmp("prep",s))
        {
          paren(tree);
          printf("\n");
        }
        if(!strcmp("maxm",s))
        {
            int a=findMax(tree);
            if(a!=0)
                printf("%d\n",a);
            else
                printf("NIL\n");
        }

        if(!strcmp("minm",s))
        {
            int a=findMin(tree);
            if(a!=0)
                printf("%d\n",a);
            else
                printf("NIL\n");
        }

        if(!strcmp("pred",s))
        {
            int a;
            struct node* pred;
            scanf("%d",&a);
            pred=predecessor(tree,a);
        }

          if(!strcmp("succ",s))
        {
            int a,b;
            scanf("%d",&a);
            struct node* succ;
            succ=successor(tree,a);
        }

        if(!strcmp("delt",s))
        {
            int a;
            scanf("%d",&a);
            tree=delete(tree,a);
        }

        if(!strcmp("inor",s))
        {
            inorder(tree);
            printf("\n");
        }

         if(!strcmp("prer",s))
        {
            preorder(tree);
            printf("\n");
        }

         if(!strcmp("post",s))
        {
            postorder(tree);
            printf("\n");
        }

        if(!strcmp("stop",s))
            return 0;
    }
        return 0;
}
