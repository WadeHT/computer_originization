#include<stdio.h>
#include<iostream>
#include<string.h>
#define BlockSize 32
#define CachSizeT 8
#define test 0
using namespace std;
typedef struct
{
    bool vaild,d;
    int tag;
} Cache;
int main(void)
{
    int CachSize=(CachSizeT<<10),tag,index,offset,label,address,nBlock=CachSize/BlockSize;
    char Input_file[50]="gcc.din";
    int fetch=0,hit=0,miss=0,read=0,write=0,from=0,to=0;
    double rate;
    Cache cache[nBlock];
    int temp=0;
    memset(cache,0,sizeof(cache));
    freopen(Input_file,"r",stdin);
    while(scanf("%x%x",&label,&address)!=EOF)
    {
        if(label==2 && address==0xffffffff)continue;
        address/=BlockSize;
        tag=address/nBlock;
        index=address%nBlock;
        switch(label)
        {
        case 0:
            read++;
            if(cache[index].tag==tag && cache[index].vaild)
            {
                hit++;
                //return data
            }
            else
            {
                miss++;
                if(cache[index].d && cache[index].vaild)
                {
                    //data to memory
                    to+=BlockSize;
                }
                //data from memory
                cache[index].d=0;
                cache[index].tag=tag;
                cache[index].vaild=1;
                //return data
                from+=BlockSize;
            }
            break;
        case 1:
            write++;
            if(cache[index].tag==tag && cache[index].vaild)
            {
                hit++;
                //write data
                cache[index].d=1;
            }
            else
            {
                miss++;
                if(cache[index].d && cache[index].vaild)
                {
                    //data to memory
                    to+=BlockSize;
                }
                //write data
                cache[index].d=1;
                cache[index].tag=tag;
                cache[index].vaild=1;
                from+=BlockSize;
            }
            break;
        case 2:
            if(cache[index].tag==tag && cache[index].vaild)
            {
                //return data
                hit++;
            }
            else
            {
                miss++;
                if(cache[index].d && cache[index].vaild)
                {
                    //data to memory
                    to+=BlockSize;
                }
                //data from memory
                cache[index].tag=tag;
                cache[index].vaild=1;
                cache[index].d=0;
                from+=BlockSize;
            }
            break;
        }
    }
    for(int i=0; i<nBlock; i++)if(cache[i].d && cache[index].vaild)to+=BlockSize;
    fetch=miss+hit;
    rate=double(miss)/double(fetch);
    printf("Input file = %s\nDemand fetch = %d\nCache hit = %d\nCache miss = %d\nMiss rate = %lf\nRead data = %d\nWrite data = %d\nBytes from Memory= %d\nByte to memory = %d\n",Input_file,fetch,hit,miss,rate,read,write,from,to);
}
