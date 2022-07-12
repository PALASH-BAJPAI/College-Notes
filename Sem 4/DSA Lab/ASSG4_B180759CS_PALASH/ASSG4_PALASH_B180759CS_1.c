#include <stdio.h>

int main(void) {
	// your code goes here
	int T;
	scanf("%d",&T);
	while(T--)
	{
	    long int n,k;
	    scanf("%d %d",&n,&k);
	    int a[n],i;
	     int max=0,sum=0;
	    int b[n+k-1];
	    for(i=0;i<n;i++){
	    scanf("%d",&a[i]);
	    b[i]=a[i];
	    }
	    for(i=n;i<n+k-1;i++)
	    b[i]=a[i-n];
	    for(i=1;i<n+k-1;i++)
	    b[i]+=b[i-1];
	    for(i=0;i<n-1;i++)
	    {
	        sum=b[i+k]-b[i];
	        if(max<sum)
	        max=sum;
	    }

	    printf("%d\n",max);
	}
	return 0;
}
