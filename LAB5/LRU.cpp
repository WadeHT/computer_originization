#include<stdio.h>
#include<iostream>
#include<string.h>
#define CachSizeT 32
#define BlockSize 8
#define nWay 4
using namespace std;
typedef struct
{
    bool vaild,d;
    int tag,recoder;
} Cache;
int CachSize=(CachSizeT<<10),nIndex=CachSize/BlockSize/nWay;
Cache cache[70000][nWay]= {{0},{0}};
int top[70000]= {0};
unsigned long long int time=0;
bool IsHit(int index,int tag,int label)
{
    bool ans=0;
    for(int i=0; i<top[index]; i++)
    {
        if(cache[index][i].tag==tag && cache[index][i].vaild)
        {
            ans=1;
            if(label == 1)cache[index][i].d=1;
            cache[index][i].recoder=time++;
        }
    }
    return ans;
}
int LeastTime(int index)
{
    int Least=-1;
    for(int i=0;i<top[index];i++)
    {
        if(Least==-1 || cache[index][Least].recoder>cache[index][i].recoder)Least=i;
    }
    return Least;
}
int main(void)
{
    int tag,index,offset,label,address;
    char Input_file[50]="gcc.din";
    int fetch=0,hit=0,miss=0,read=0,write=0,from=0,to=0;
    int Least;
    double rate;
    freopen(Input_file,"r",stdin);
    while(scanf("%x%x",&label,&address)!=EOF)
    {
        if(label==2 && address==0xffffffff)continue;
        address/=BlockSize;
        tag=address/nIndex;
        index=address%nIndex;
        switch(label)
        {
        case 0:
            read++;
            if(IsHit(index,tag,label))
            {
                hit++;
                //return data
            }
            else
            {
                miss++;
                if(top[index]<nWay)
                {
                    cache[index][top[index]].d=0;
                    cache[index][top[index]].vaild=1;
                    cache[index][top[index]].tag=tag;
                    cache[index][top[index]].recoder=time++;
                    top[index]++;
                }
                else
                {
                    Least=LeastTime(index);
                    if(cache[index][Least].d && cache[index][Least].vaild)
                        to+=BlockSize;
                    cache[index][Least].d=0;
                    cache[index][Least].vaild=1;
                    cache[index][Least].tag=tag;
                    cache[index][Least].recoder=time++;
                }
                from+=BlockSize;
            }
            break;
        case 1:
            write++;
            if(IsHit(index,tag,label))
            {
                hit++;
            }
            else
            {
                miss++;
                if(top[index]<nWay)
                {
                    cache[index][top[index]].d=1;
                    cache[index][top[index]].vaild=1;
                    cache[index][top[index]].tag=tag;
                    cache[index][top[index]].recoder=time++;
                    top[index]++;
                }
                else
                {
                    Least=LeastTime(index);
                    if(cache[index][Least].d && cache[index][Least].vaild)
                        to+=BlockSize;
                    cache[index][Least].d=1;
                    cache[index][Least].vaild=1;
                    cache[index][Least].tag=tag;
                    cache[index][Least].recoder=time++;
                }
                from+=BlockSize;
            }
            break;
        case 2:
            if(IsHit(index,tag,label))
            {
                hit++;
                //return data
            }
            else
            {
                miss++;
                if(top[index]<nWay)
                {
                    cache[index][top[index]].d=0;
                    cache[index][top[index]].vaild=1;
                    cache[index][top[index]].tag=tag;
                    cache[index][top[index]].recoder=time++;
                    top[index]++;
                }
                else
                {
                    Least=LeastTime(index);
                    if(cache[index][Least].d && cache[index][Least].vaild)
                        to+=BlockSize;
                    cache[index][Least].d=0;
                    cache[index][Least].vaild=1;
                    cache[index][Least].tag=tag;
                    cache[index][Least].recoder=time++;
                }
                from+=BlockSize;
            }
            break;
        }
    }
    for(int i=0; i<nIndex; i++)for(int j=0; j<nWay; j++)if(cache[i][j].d && cache[i][j].vaild)to+=BlockSize;
    fetch=miss+hit;
    rate=double(miss)/double(fetch);
    printf("Input file = %s\nDemand fetch = %d\nCache hit = %d\nCache miss = %d\nMiss rate = %lf\nRead data = %d\nWrite data = %d\nBytes from Memory= %d\nByte to memory = %d\n",Input_file,fetch,hit,miss,rate,read,write,from,to);
}
