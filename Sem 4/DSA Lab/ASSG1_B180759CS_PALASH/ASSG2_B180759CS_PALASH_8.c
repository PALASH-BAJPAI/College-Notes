#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

typedef struct Node
{
char ch;
int freq;
struct Node *left, *right;
}Node;

Node *newnode(char c, int occur)
{ Node *temp= (Node *)malloc(sizeof(Node));
temp->ch = c;
temp->freq = occur;
temp->left = temp->right = NULL;
return temp;
}

Node **insert(Node **Tree, int *size, char ch, char freq, Node *l, Node *r)
{
Node *temp = newnode(ch, freq);
Tree[*size] = temp;
int p = *size - 1;
while (p >= 0 && (temp->freq < Tree[j]->freq))
{
Tree[j + 1] = Tree[j];
p--;
}
  temp->left = l;
  temp->right = r;
  Tree[p + 1] = temp;
  *size = *size + 1;
  return Tree;
}


Node *Min;
Node **Extractmin(Node **Tree, int *size)
{
 Min = Tree[0];
 for (int i = 0; i < (*size-1); i++)
Tree[i] = Tree[i+1];
 *size = *size - 1;
 return Tree;
}

Node **Find_huffman_Code(char *str)
{
  int i = 0, length = strlen(str);
  int freq[26] = {0};
 for (i = 0; i < length; i++)
  freq[str[i] - 'a']++;
 Node **Tree = (Node **)malloc(sizeof(Node *) * 1000);
 int size = 0;
 for (i = 0; i < 26; i++)
 if (freq[i])
 Tree = insert(Tree, &size, i + 'a', freq[i], NULL, NULL);
 while (size != 1)
 { Tree = Extractmin(Tree, &size);
Node *min1 = Min;
Tree = Extractmin(Tree, &size);
Node *min2 = Min;
Tree = insert(Tree, &size, '$', min1->freq + min2->freq, min1, min2);
 }
 return Tree;
}



char Code[26][100];
void print_Codes (Node *temp, char *code)
{
if (temp->left == NULL && temp->right == NULL)
 {
strcpy(Code[temp->ch - 'a'], code);
return;
}
int len = strlen(code);
char leftc[100], rightc[100];//left code and right code
strcpy(leftc, code);
strcpy(rightc, code);
leftc[len] = '0';
leftc[len + 1] = '\0';
rightc[len] = '1';
rightc[len + 1] = '\0';
print_Codes (temp->left, leftc);
print_Codes (temp->right, rightc);
}



int main()
{ char input[100];
 while (scanf("%s",input))
 {

 Node **head =Find_huffman_Code(input);
 char code[10] = "\0";
 print_Codes (head[0],code);
 int dist=0,ans = 0;
 int Hashed[26] = {0};
for (int i = 0; input[i]; i++)
{ ans += strlen(Code[input[i] - 'a']);
if(Hashed[input[i]-'a']==0) dist++;
 Hashed[input[i]-'a']++;

 }
 printf("%d\n",ans);
 }
 return 0;
}
