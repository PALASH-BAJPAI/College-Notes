#include<stdio.h>

int main()
{
    int T;
    scanf("%d",&T);
    while(T--)
    {
        int n;
        scanf("%d",&n);
        int i,nc=0,pc=0,max=0,min=0,index;
        int a[n];

        for(i=0;i<n;i++){
            scanf("%d",&a[i]);
            if(a[i]>=0)
                pc++;
            else
                nc++;
            if(a[i]>max)
                max=a[i];
                index=1;
            if(a[i]<min)
                min=a[i];
        }

        if(nc==0)
        {
            printf("%d\n",max);
        }


        else {
                        if(pc==1)
                            {
                            if(i>0&&(a[index]+a[index-1]>a[index]+a[index+1]))
                                    printf("%d\n",a[index]+a[index-1]);
                            else
                                    printf("%d\n",a[index]+a[index+1]);
                        }


            else{

                int ans=0,j;
                if(nc>pc)
                {
                  max=a[0];
                    for(i=0;i<n;i++)
                    {
                        j=i;
                        if(a[i]>=0)
                            ans+=a[i];

                        else{
                     while(a[i]<0)
                     {
                         if(a[i]>max)
                         max=a[i];
                     }
                        }
                         ans+=a[i-1];
                     i=j;


                    }
                }


                if(nc<=pc)
                {


                }
            }



        }

    }
    return 0;

}

