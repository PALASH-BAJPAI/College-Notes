#include<bits/stdc++.h>
using namespace std;
int declare_winner(int whoose_turn)
{
    if(whoose_turn==1)
        return 2;
    return 1;
}
int game_over(int pileA,int pileB)
{
    if(pileA==0 && pileB==0)
        return 1;
    return 0;
}
int find_score(int pileA,int pileB,int whoose_turn)
{
    int nimSum=pileA^pileB;
    if(nimSum)
    {
        if(whoose_turn==1)
            return 1;
        return-1;
    }
    else
    {
        if(whoose_turn==1)
            return -1;
        return 1;
    }
}
int play_game(int pileA,int pileB,int whoose_turn)
{
    if(game_over(pileA,pileB))
    {
        if(declare_winner(whoose_turn)==1)
            return 1;
        return 2;
    }
    int minNim=pileA^pileB;
    if(whoose_turn==1)
    {
        if(minNim!=0)
        {
            int maxA=INT_MIN;
            int maxB=INT_MIN;
            if((pileA^minNim)<pileA)
                maxA=find_score(pileA^minNim,pileB,2);
            if((pileB^minNim)<pileB)
                maxB=find_score(pileA,pileB^minNim,2);
            if(maxA>maxB)
            {
                cout<<"Current pile - "<<pileA<<" "<<pileB<<endl;
                int temp=pileA^minNim;
                cout<<"User moves "<<pileA-temp<<" Stones from pile 1"<<endl;
                pileA=pileA^minNim;
            }
            else
            {
                cout<<"Current pile - "<<pileA<<" "<<pileB<<endl;
                int temp=pileB^minNim;
                cout<<"User moves "<<pileB-temp<<" Stones from pile 2"<<endl;
                pileB=pileB^minNim;
            }
            return play_game(pileA,pileB,2);
        }
        else
        {
            int A,B;
            int maxA=INT_MIN;
            int maxB=INT_MIN;
            if(pileA>0)
            {
                A=1+(rand()%pileA);
                if(A<0)
                    A=0;
                maxA=find_score(pileA-A,pileB,2);
            }
            if(pileB>0)
            {
                B=1+(rand()%pileB);
                if(B<0)
                    B=0;
                maxB=find_score(pileA,pileB-B,2);
            }
            if(maxA>maxB)
                pileA=pileA-A;
            else
                pileB=pileB-B;
            return play_game(pileA,pileB,2);
        }
    }
    else
    {
        if(minNim!=0)
        {
            int minA=INT_MAX;
            int minB=INT_MAX;
            if((pileA^minNim)<pileA)
                minA=find_score(pileA^minNim,pileB,1);
            if((pileB^minNim)<pileB)
                minB=find_score(pileA,pileB^minNim,1);
            if(minA<minB)
            {
                cout<<"Current pile - "<<pileA<<" "<<pileB<<endl;
                int temp=pileA^minNim;
                cout<<"Agent moves "<<pileA-temp<<" Stones from pile 1"<<endl;
                pileA=pileA^minNim;
            }
            else
            {
                cout<<"Current pile - "<<pileA<<" "<<pileB<<endl;
                int temp=pileB^minNim;
                cout<<"Agent moves "<<pileB-temp<<" Stones from pile 2"<<endl;
                pileB=pileB^minNim;
            }
            return play_game(pileA,pileB,1);
        }
        else
        {
            int A,B;
            int minA=INT_MAX;
            int minB=INT_MAX;
            if(pileA>0)
            {
                A=1+(rand()%pileA);
                if(A<0)
                    A=0;
                minA=find_score(pileA-A,pileB,1);
            }
            if(pileB>0)
            {
                B=1+(rand()%pileB);
                if(B<0)
                    B=0;
                minB=find_score(pileA,pileB-B,1);
            }
            if(minA<minB)
                pileA=pileA-A;
            else
                pileB=pileB-B;
            return play_game(pileA,pileB,1);
        }
    }
}

int main()
{
    int pileA,pileB;
    cout<<"Enter stones in pileA"<<endl;
    cin>>pileA;
    cout<<"Enter stones in pileB"<<endl;
    cin>>pileB;
    int whoose_turn;
    while(1)
    {
        cout<<"Enter 1 for user play first ,2 for agent to play first"<<endl;
        cin>>whoose_turn;
        if(whoose_turn==1||whoose_turn==2)
            break;
        else
            cout<<"Enter valid input"<<endl;
    }
    int winner=play_game(pileA,pileB,whoose_turn);
    cout<<endl;
    if(winner==1)
        cout<<"User is Winner"<<endl;
    else
        cout<<"Agent is Winner"<<endl;
}