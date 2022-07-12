#include<stdio.h>
#include<stdlib.h>

struct node
{
	int data;
	int color;
	struct node *left;
	struct node *right;
};

int black = 1;
int red=0;
struct node* tree=NULL;
int changed = 0;
int printinit = 0;


struct node *create(int data)
{
    struct node *temp = (struct node*)malloc(sizeof(struct node));
	temp->data = data;
	temp->color = red;
	temp->left = temp->right = NULL;
	return temp;
}


int check_color(struct node *X)
{
	if(X==NULL)
		return black;
	return X->color;
}

struct node *RightRotate(struct node *X) //RR rotation
{
	if(X==NULL || X->left==NULL)
		return X;
	struct node *temp = X->left;
	X->left = temp->right;
	temp->right = X;
	return temp;
}

struct node *LeftLeftRotate(struct node *X)
{
	if(X==NULL || X->right==NULL)
		return X;
	struct node *temp = X->right;
	X->right = temp->left;
	temp->left = X;
	return temp;
}



struct node* RB_insert(struct node *tree,int n)
{
	if(tree==NULL)
	{
		printinit = 1;
		return create(n);
	}
	if(tree->data==n)
	{
		printinit = 1;
		return tree;
	}
	if(tree->data < n)
		tree->right = RB_insert(tree->right,n);
	else tree->left = RB_insert(tree->left,n);
	if(printinit)
	{
		printinit = 0;
	}
	if(check_color(tree->left)==red)
	{
		if(check_color(tree->left->left)==red)
		{
			if(check_color(tree->right)==red)
			{
				changed= 1;
				tree->color = red;
				tree->right->color = tree->left->color = black;
			}
			else
			{
				changed = 1;
				tree= RightRotate(tree);
				tree->color = black;
				tree->right->color = tree->left->color = red;
			}
		}
	  if(check_color(tree->left->right)==red)
		{
			if(check_color(tree->right)==red)
			{
				changed = 1;
				tree->color = red;
				tree->right->color = tree->left->color = black;
			}
			else
			{
				changed = 1;
				tree->left = LeftLeftRotate(tree->left);
				tree = RightRotate(tree);
				tree->color = black;
				tree->right->color = tree->left->color = red;
			}
		}
	}
	if(check_color(tree->right)==red)
	{
		if(check_color(tree->right->right)==red)
		{
			if(check_color(tree->left)==red)
			{
				changed = 1;
				tree->color = red;
				tree->right->color = tree->left->color = black;
			}
			else
			{
				changed = 1;
				tree = LeftLeftRotate(tree);
				tree->color = black;
				tree->right->color = tree->left->color = red;
			}
		}
		if(check_color(tree->right->left)==red)
		{
			if(check_color(tree->left)==red)
			{
				changed = 1;
				tree->color = red;
				tree->right->color = tree->left->color = black;
			}
			else
			{
				changed = 1;
				tree->right = RightRotate(tree->right);
				tree = LeftLeftRotate(tree);
				tree->color = black;
				tree->right->color = tree->left->color = red;
			}
		}
	}
	return tree;
}



struct node* Rb_Tree_insert(struct node *tree,int x)
{
    changed = printinit = 0;
	if(tree==NULL)
	{
		tree = create(x);
		tree->color = black;
	}
	else
    tree = RB_insert(tree,x);
	tree->color = black;
	if(changed)
	{
		changed = 0;
	}
	return tree;
}


void print_tree(struct node *X)
{
	printf("( ");
	if(X!=NULL)
{
	if(X->color==red)
		printf("%d R ",X->data);
	else
		printf("%d B ",X->data);
		print_tree(X->left);
	print_tree(X->right);
}
	printf(") ");
}



int main()
{
	int x;
	while(scanf("%d",&x))
	{
		tree = Rb_Tree_insert(tree,x);
		print_tree(tree);
		printf("\n");
		if(x=="32")
			return 0;
	}
	return 0;
}
