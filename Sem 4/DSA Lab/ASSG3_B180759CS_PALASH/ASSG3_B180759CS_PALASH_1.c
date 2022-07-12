#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct node{
  int key;
  struct node* right;
  struct node* left;
  int height;
};


struct node* newNode(int value)
{
	struct node* temp = (struct node*)malloc(sizeof(struct node));
	temp->key =value;
	temp->left = NULL;
	temp->right = NULL;
	temp->height = 1;
	return(temp);
}


int max(int a, int b)
{
	if(a>b)
        return a;
    else
        return b;
}


int getheight(struct node* tree)
{
    if (tree == NULL)
        return 0;
    return tree->height;
}

int getBalance(struct node *tree)
{
	if (tree == NULL)
		return 0;
	return getheight(tree->left) - getheight(tree->right);
}


struct node *leftRotate(struct node *x)
{
	struct node *y = x->right;
	struct node *temp = y->left;
	y->left= x;
	x->right= temp;
	x->height= max(getheight(x->left), getheight(x->right))+1;
	y->height= max(getheight(y->left), getheight(y->right))+1;
	return y;
}



struct node *rightRotate(struct node *y)
{
	struct node *x = y->left;
	struct node *temp = x->right;
	x->right = y;
	y->left = temp;
	y->height = max(getheight(y->left), getheight(y->right))+1;
	x->height = max(getheight(x->left), getheight(x->right))+1;
	return x;
}




struct node* insert(struct node* tree, int item)
{
	if (tree== NULL)
		return(newNode(item));

	if (item < tree->key)
		tree->left= insert(tree->left,item);
	else if (item >= tree->key)
		tree->right = insert(tree->right,item);

	tree->height = 1 + max(getheight(tree->left),getheight(tree->right));

	int balance = getBalance(tree);

	if (balance > 1 && item < tree->left->key)
		return rightRotate(tree);

	if (balance < -1 && item > tree->right->key)
		return leftRotate(tree);

	if (balance > 1 && item > tree->left->key)
	{
		tree->left = leftRotate(tree->left);
		return rightRotate(tree);
	}

	if (balance < -1 && item < tree->right->key)
	{
		tree->right = rightRotate(tree->right);
		return leftRotate(tree);
	}

	return tree;
}

struct node* search(struct node* root,int ele)
{
    if((root==NULL)||root->key==ele)
        return root;
    if(root->key<=ele)
        return search(root->right,ele);
    return search(root->left,ele);
}

struct node * minValueNode(struct node* temp)
{
	struct node* current = temp;

	while (current->left!=NULL)
		current = current->left;

	return current;
}

struct node* deleteNode(struct node* root, int item)
{
	if (root == NULL)
		return root;

	if ( item < root->key)
		root->left = deleteNode(root->left,item);

	else if( item > root->key)
		root->right = deleteNode(root->right,item);

	else
	{
		if( (root->left == NULL) || (root->right == NULL) )
		{
			struct node *temp = root->left ? root->left : root->right;

			if (temp == NULL)
			{
				temp = root;
				root = NULL;
			}
			else
			*root = *temp;
			free(temp);
		}
		else
		{
			struct node* temp = minValueNode(root->right);
			root->key = temp->key;
			root->right = deleteNode(root->right, temp->key);
		}
	}

	if (root == NULL)
	return root;

	root->height = 1 + max(getheight(root->left),getheight(root->right));
	int balance = getBalance(root);

	if (balance > 1 && getBalance(root->left) >= 0)
		return rightRotate(root);

	if (balance > 1 && getBalance(root->left) < 0)
	{
		root->left = leftRotate(root->left);
		return rightRotate(root);
	}
	if (balance < -1 && getBalance(root->right) <= 0)
		return leftRotate(root);

	if (balance < -1 && getBalance(root->right) > 0)
	{
		root->right = rightRotate(root->right);
		return leftRotate(root);
	}

	return root;
}

void preOrder(struct node *root)
{
	if(root != NULL)
	{
		printf("%d ", root->key);
		preOrder(root->left);
		preOrder(root->right);
	}
}
int isAVL(struct node* root)
{
	if(root==NULL)
		return 1;
	int lh=getheight(root->left);
	int rh=getheight(root->right);
	if((lh-rh)>=-1 && (lh-rh)<=1 && isAVL(root->left) && isAVL(root->right))
		return 1;
	return 0;
}
void paren(struct node* root)
{
  if(root!=NULL)
  {
    printf("(");
    printf("%d",root->key);
    paren(root->left);
    paren(root->right);
    printf(")");
  }
  else
  {
    printf("()");
  }
}
void main()
{
  struct node* root=NULL;
  int ele;
  char x[20];
  wow:
  scanf("%s",x);
  if(!strcmp("insr",x))
  {
    scanf("%d",&ele);
    root=insert(root,ele);
    goto wow;
  }
  if(!strcmp("srch",x))
  {
    scanf("%d",&ele);
    if(search(root,ele)==NULL)
      printf("FALSE\n");
    else
      printf("TRUE\n");
    goto wow;
  }
  if(!strcmp("delt",x))
  {
    scanf("%d",&ele);
    root=deleteNode(root,ele);
    goto wow;
  }
  if(!strcmp("pbal",x))
  {
  	  scanf("%d",&ele);
  	  if(search(root,ele)==NULL)
  	  	printf("Element not found\n");
  	  else
  	  {
      printf("%d\n",getBalance(search(root,ele)));
      }
      goto wow;
  }

   if(!strcmp("avlc",x))
  {
      if(isAVL(root))
      {
      	printf("tree is AVL\n");
      }
      else
      {
      printf("tree is not AVL\n");
      }
      goto wow;
  }

   if(!strcmp("disp",x))
  {
      paren(root);
      printf("\n");
      goto wow;
  }

  if(!strcmp("stop",x))
  {
    exit(0);
  }
 }
