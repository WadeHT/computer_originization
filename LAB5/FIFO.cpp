#include<stdio.h>
#include<iostream>
#include<string.h>
#include<queue>
#define CachSizeT 32
#define BlockSize 8
#define nWay 4

using namespace std;
typedef struct
{
    bool vaild,d;
    int tag;
} Cache;
int CachSize=(CachSizeT<<10),nIndex=CachSize/BlockSize/nWay;
queue<Cache>cache[70000];
bool IsHit(int index,int tag,int label)
{
    bool ans=0;
    Cache t;
    queue<Cache>temp;
    while(!cache[index].empty())
    {
        if(cache[index].front().tag==tag && cache[index].front().vaild)
        {
            ans=1;
            t=cache[index].front();
            if(label == 1)t.d=1;
            temp.push(t);
        }
        else  temp.push(cache[index].front());
        cache[index].pop();
    }
    while(!temp.empty())
    {
        cache[index].push(temp.front());
        temp.pop();
    }
    // if(ans)cache[index].push(t);
    return ans;
}
int main(void)
{
    int tag,index,offset,label,address;
    char Input_file[50]="gcc.din";
    int fetch=0,hit=0,miss=0,read=0,write=0,from=0,to=0;
    double rate;
    Cache temp;
    freopen(Input_file,"r",stdin);
    while(scanf("%x%x",&label,&address)!=EOF )
    {
        if(label==2 && address==0xffffffff)continue;
        address/=BlockSize;
        tag=address/nIndex;
        index=address%nIndex;
        //printf("%d %d\n",index,nIndex);
        switch(label)
        {
        case 0:
            read++;
            if(IsHit(index,tag,label))/**/
            {
                hit++;
                //return data
            }
            else
            {
                miss++;
                if(cache[index].size()<nWay)
                {
                    temp.d=0;
                    temp.vaild=1;
                    temp.tag=tag;
                    cache[index].push(temp);
                }
                else
                {
                    if(cache[index].front().d && cache[index].front().vaild)
                    {
                        to+=BlockSize;
                        //data to memory
                    }
                    //return data
                    temp.d=0;
                    temp.vaild=1;
                    temp.tag=tag;
                    cache[index].push(temp);
                    cache[index].pop();
                }
                from+=BlockSize;
            }
            break;
        case 1:
            write++;
            if(IsHit(index,tag,label))/**/
            {
                hit++;
            }
            else
            {
                miss++;
                if(cache[index].size()<nWay)
                {
                    temp.d=1;
                    temp.vaild=1;
                    temp.tag=tag;
                    cache[index].push(temp);
                }
                else
                {
                    if(cache[index].front().d && cache[index].front().vaild)
                    {
                        to+=BlockSize;
                        //data to memory
                    }
                    //write data
                    temp.d=1;
                    temp.vaild=1;
                    temp.tag=tag;
                    cache[index].push(temp);
                    cache[index].pop();
                }
                from+=BlockSize;
            }
            break;
        case 2:
            if(IsHit(index,tag,label))/**/
            {
                hit++;
                //return data
            }
            else
            {
                miss++;
                if(cache[index].size()<nWay)
                {
                    temp.d=0;
                    temp.vaild=1;
                    temp.tag=tag;
                    cache[index].push(temp);
                }
                else
                {
                    if(cache[index].front().d && cache[index].front().vaild)
                    {
                        to+=BlockSize;
                        //data to memory
                    }
                    //return data
                    temp.d=0;
                    temp.vaild=1;
                    temp.tag=tag;
                    cache[index].push(temp);
                    cache[index].pop();
                }
                from+=BlockSize;
            }
            break;
        }
    }
    for(int i=0; i<nIndex; i++)
        while(!cache[i].empty())
        {
            if(cache[i].front().d && cache[i].front().vaild)to+=BlockSize;
            cache[i].pop();
        }
    fetch=miss+hit;
    rate=double(miss)/double(fetch);
    printf("Input file = %s\nDemand fetch = %d\nCache hit = %d\nCache miss = %d\nMiss rate = %lf\nRead data = %d\nWrite data = %d\nBytes from Memory= %d\nByte to memory = %d\n",Input_file,fetch,hit,miss,rate,read,write,from,to);
}
