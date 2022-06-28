#include<bits/stdc++.h>
using namespace std;
int simulator(char location,vector<char>&dirt,int lifetime)
{
    int performance=0;
    while(lifetime!=0)
    {
        if(dirt.size()==0)
        return performance+lifetime*2;
        performance+=2-dirt.size();
        if(find(dirt.begin(),dirt.end(),location)!=dirt.end())
        {
            auto it=find(dirt.begin(),dirt.end(),location);
            dirt.erase(it);
            cout<<"Action: suck, ";
        }
        else
        {
            if(location=='A')
            {
                location='B';
                cout<<"Action: right, ";
            }
            else
            {
                location='A';
                cout<<"Action: left, ";
            }
        }
        vector<char>::iterator it1,it2;
        it1=find(dirt.begin(),dirt.end(),'A');
        it2=find(dirt.begin(),dirt.end(),'B');
        if(it1!=dirt.end()&&it2!=dirt.end())
        {
            cout<<"Initial state:[(A, dirty), (B, dirty)], ";
        }
        else if(it1!=dirt.end())
        {
            cout<<"Initial state:[(A, dirty), (B, clean)], ";
        }
        else if(it2!=dirt.end())
        {
            cout<<"Initial state:[(A, clean), (B, dirty)], ";
        }
        else
        {
            cout<<"Initial state:[(A, clean), (B, clean)], ";
        }
        cout<<"Location of Agent:"<<location<<endl; 
        lifetime-=1;
    }
    return performance;
}


int main()
{
    cout<<"Enter the position of the agent(A,B)"<<endl;
    char loc,temp;
    cin>>loc;
    int t=2;
    cout<<"Enter the positions of dirt"<<endl;
    string s;
    cin.ignore();
    getline(cin,s);
    vector<char> dirt;
    for(int i=0;i<s.length();i++)
    {
        if(s[i]!=' ')
        dirt.push_back(s[i]);
    }
    vector<char>::iterator it1,it2;
    it1=find(dirt.begin(),dirt.end(),'A');
    it2=find(dirt.begin(),dirt.end(),'B');
    if(it1!=dirt.end()&&it2!=dirt.end())
    {
        cout<<"Initial state:[(A, dirty), (B, dirty)], ";
    }
    else if(it1!=dirt.end())
    {
        cout<<"Initial state:[(A, dirty), (B, clean)], ";
    }
    else if(it2!=dirt.end())
    {
        cout<<"Initial state:[(A, clean), (B, dirty)], ";
    }
    else
    {
        cout<<"Initial state:[(A, clean), (B, clean)], ";
    }
    cout<<"Location of Agent:"<<loc<<endl;
    int lifetime=1000;
    int performance=simulator(loc,dirt,lifetime);
    cout<<"Performance = "<<performance<<endl;
}