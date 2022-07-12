#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int paren0[10001], paren1[10001], paren2[10001], paren3[10001];	//parents
int rank1[10001], rank3[10001];

void init()
{
    for (int j= 0; j<= 10000; ++j)
    {
        paren0[j] = paren1[j] = paren2[j] = paren3[j] = -1;
        rank1[j] = rank3[j] = 0;
    }
}

void Make_Set(int u)
{
    if (paren0[u] >= 0)
        printf( "PRESENT\n");
    else
    {
        printf( "%d\n", u);
        paren0[u] = paren1[u] = paren2[u] = paren3[u] = u;
    }
}

int f0 = 0, f1 = 0, f2 = 0, f3 = 0;

int find0(int u)
{
    f0++;
    if (paren0[u] == u)
        return u;
    return find0(paren0[u]);
}

int find1(int u)
{
    f1++;
    if (paren1[u] == u)
        return u;
    return find1(paren1[u]);
}

int find2(int u)
{
    f2++;
    if (paren2[u] == u)
        return u;
    return paren2[u] = find2(paren2[u]);
}

int find3(int u)
{
    f3++;
    if (paren3[u] == u)
        return u;
    return paren3[u] = find3(paren3[u]);
}

void find_set(int u)
{
    if (paren0[u] < 0)
        printf( "NOT FOUND NOT FOUND NOT FOUND NOT FOUND\n");
    else
    {
        printf( "%d %d %d %d\n", find0(u), find1(u), find2(u), find3(u));
    }
}

int connect0(int u, int v)
{
    u = find0(u);
    v = find0(v);
    paren0[v] = u;
    return u;
}

int connect1(int u, int v)
{
    u = find1(u);
    v = find1(v);
    if(u==v)
        return u;
    if (rank1[u] == rank1[v])
    {
        rank1[u]++;
        return paren1[v] = u;
    }
    if (rank1[u] >= rank1[v])
        return paren1[v] = u;
    else
        return paren1[u] = v;
}

int connect2(int u, int v)
{
    u = find2(u);
    v = find2(v);
    paren2[v] = u;
    return u;
}

int connect3(int u, int v)
{
    u = find3(u);
    v = find3(v);
    if(u==v)
        return u;
    if (rank3[u] == rank3[v])
    {
        rank3[u]++;
        return paren3[v] = u;
    }
    if (rank3[u] >= rank3[v])
        return paren3[v] = u;
    else
        return paren3[u] = v;
}

void union_set(int u, int v)
{
    if (paren0[u] < 0 || paren0[v] < 0)
        printf( "ERROR ERROR ERROR ERROR\n");
    else
    {
        printf( "%d %d %d %d\n", connect0(u, v), connect1(u, v), connect2(u, v), connect3(u, v));
    }
}

int main()
{
    init();
    char ch;
    int u, v;
    char c;
    while (ch != 's')
    {

        scanf( "%c", &ch);
        if(ch=='s')
        {
            printf( "%d %d %d %d", f0, f1, f2, f3);
            break;
        }
        else{
        switch (ch)
        {
        case 'm':
            scanf( "%d%c", &u,&c);
            Make_Set(u);
            break;
        case 'f':
            scanf( "%d%c", &u,&c);
            find_set(u);
            break;
        case 'u':
            scanf( " %d %d%c", &u, &v,&c);
            union_set(u, v);

            break;

        default:
            printf( "Invalid choice\n");
        }
    }
    }
    return 0;
#include <stdio.h>
#include <stdlib.h>

int paren0[10001], paren1[10001], paren2[10001], paren3[10001];
int rank1[10001], rank3[10001];

void init()
{
    for (int i = 0; i <= 10000; ++i)
    {
        paren0[i] = paren1[i] = paren2[i] = paren3[i] = -1;
        rank1[i] = rank3[i] = 0;
    }
}

void Make_Set(int u)
{
    if (paren0[u] >= 0)
        printf( "PRESENT\n");
    else
    {
        printf( "%d\n", u);
        paren0[u] = paren1[u] = paren2[u] = paren3[u] = u;
    }
}

int f0 = 0, f1 = 0, f2 = 0, f3 = 0;

int find0(int u)
{
    f0++;
    if (paren0[u] == u)
        return u;
    return find0(paren0[u]);
}

int find1(int u)
{
    f1++;
    if (paren1[u] == u)
        return u;
    return find1(paren1[u]);
}

int find2(int u)
{
    f2++;
    if (paren2[u] == u)
        return u;
    return paren2[u] = find2(paren2[u]);
}

int find3(int u)
{
    f3++;
    if (paren3[u] == u)
        return u;
    return paren3[u] = find3(paren3[u]);
}

void find_set(int u)
{
    if (paren0[u] < 0)
        printf( "NOT FOUND NOT FOUND NOT FOUND NOT FOUND\n");
    else
    {
        printf( "%d %d %d %d\n", find0(u), find1(u), find2(u), find3(u));
    }
}

int connect0(int x, int y)
{
    x = find0(x);
    y= find0(y);
    paren0[y] = x;
    return x;
}

int connect1(int u, int v)
{
    u = find1(u);
    v = find1(v);
    if(u==v)
        return u;
    if (rank1[u] == rank1[v])
    {
        rank1[u]++;
        return paren1[v] = u;
    }
    if (rank1[u] >= rank1[v])
        return paren1[v] = u;
    else
        return paren1[u] = v;
}

int connect2(int u, int v)
{
    u = find2(u);
    v = find2(v);
    paren2[v] = u;
    return u;
}

int connect3(int u, int v)
{
    u = find3(u);
    v = find3(v);
    if(u==v)
        return u;
    if (rank3[u] == rank3[v])
    {
        rank3[u]++;
        return paren3[v] = u;
    }
    if (rank3[u] >= rank3[v])
        return paren3[v] = u;
    else
        return paren3[u] = v;
}

void union_set(int u, int v)
{
    if (paren0[u] < 0 || paren0[v] < 0)
        printf( "ERROR ERROR ERROR ERROR\n");
    else
    {
        printf( "%d %d %d %d\n", connect0(u, v), connect1(u, v), connect2(u, v), connect3(u, v));
    }
}

int main()
{
    init();
    char ch;
    int u, v;
    char c;
    while (ch != 's')
    {

        scanf( "%c", &ch);
        if(ch=='s')
        {
            printf( "%d %d %d %d\n", f0, f1, f2, f3);
            break;
        }
        else{
        switch (ch)
        {
        case 'm':
            scanf( "%d%c", &u,&c);
            Make_Set(u);
            break;
        case 'f':
            scanf( "%d%c", &u,&c);
            find_set(u);
            break;
        case 'u':
            scanf( " %d %d%c", &u, &v,&c);
            union_set(u, v);

            break;

        default:
            printf( "Invalid choice\n");
        }
    }
    }
    return 0;
}
}
