#include <stdio.h>
#include <stdlib.h>
#include<string.h>

struct node
{
    int data;
    struct node *left;
    struct node *right;
};

int check_BST(struct node *temp, int MIN, int MAX)
{
    if (temp == NULL)
    {
        return 1;
    }
    if (temp->data<MIN || temp->data>MAX)
    {
        return 0;
    }
    return ((check_BST(temp->left, MIN, temp->data)) && check_BST(temp->right, temp->data, MAX));
}

int height(struct node *tree)
{
    if (tree == NULL)
        return 0;
    else
    {
         int r=0;
    int l=0;
    struct node* temp1=tree;
    while(temp1->left!=NULL)
    {
        l++;
    temp1=temp1->left;
    }
     struct node* temp2=tree;
     while(temp2->right!=NULL)
     {
         r++;
         temp2=temp2->right;
     }
     if(r>l)
        return (r+1);
     else
        return (l+1);
    }
}

int HeightBalancing(struct node *t)
{
    int l_t_Height, r_t_Height;
    if (t == NULL)
    {
        return 1;
    }
    l_t_Height = height(((t)->left));
    r_t_Height = height(t->right);
    if ((HeightBalancing(t->left)) && (abs(r_t_Height - l_t_Height) <= 1) && (HeightBalancing(t->right)))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

struct node *insert(struct node *tree)
{
    struct node *Temp;
    int i;
    char ch;
    scanf(" %c", &ch);
    if (scanf("%d", &i) == 1)
    {
        Temp = (struct node *)malloc(sizeof(struct node));
        Temp->data = i;
        Temp->left = NULL;
        Temp->right = NULL;
        tree = Temp;
        tree->left = insert(tree->left);
        tree->right = insert(tree->right);
        scanf(" %c",&ch);
        return tree;
    }
    else
    {
        scanf(" %c", &ch);
        return NULL;
    }
}

void isAVL(struct node *tree)
{
    if (HeightBalancing(tree) && check_BST(tree,-9999,9999))
        printf("1");
    else
        printf("0");
}



int main()
{
    struct node *tree = NULL;
    tree = insert(tree);
    isAVL(tree);
}
