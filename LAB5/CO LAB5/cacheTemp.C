#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<stdbool.h>
#define BlockSize 32
#define CachSize 8192
#define nWay 4
#define N (1<<20)

bool valid[N],dirty[N];
int tag[N],data[N];
unsigned int cache_size,block_size,associativity;
unsigned int location;
char replace_policy[5],file[50];
int _index,_tag;
int hit,miss;
int now,readcnt,writecnt;

unsigned int label,addr;

int tomemory;

int table[N];


void MRU()
{

    int i,Least=-1,record;
    for(i=0; i<associativity; i++)
        if(valid[location+i]&&_tag==tag[location+i])
        {
            table[location+i]=now;
            if(label==1)    dirty[location+i]=1;
            hit++;
            return;
        }
    miss++;
    for(i=0; i<associativity; i++)
        if(table[location+i]==0)
        {
            record=location+i;
            break;
        }
        else if(Least<table[location+i] || Least==-1)    Least=table[location+i],record=location+i;

    if(dirty[record]) tomemory++,dirty[record]=0;
    if(label==1)dirty[record]=1;
    valid[record]=1,tag[record]=_tag,table[record]=now;

}


int main(void)
{
    strcpy(replace_policy,"MRU");
    strcpy(file,"gcc.din");

    cache_size=CachSize,block_size=BlockSize,associativity;

    unsigned int blocks=cache_size/block_size;

    //if(argv[3][0]=='f')  associativity=blocks;
    //else
    associativity=1;
    blocks/=associativity;

    int i;

    freopen(file,"r",stdin);
    memset(valid,0,sizeof(valid));
    memset(dirty,0,sizeof(dirty));
    memset(table,0,sizeof(table));
    hit=miss=0;
    tomemory=0;
    now=0;
    readcnt=writecnt=0;

    int cnt=0;

    while(scanf("%x %x",&label,&addr)==2)
    {
        if(label==2&&addr==0xffffffff)  break;
        now++;
        if(label==0)    readcnt++;
        if(label==1)    writecnt++;
        unsigned block_addr;

        block_addr=addr/block_size;

        _index=block_addr%blocks;
        _tag=block_addr/blocks;
        location=_index*associativity;

        if(strcmp("MRU",replace_policy)==0 )
            MRU();
    }
    for(i=0; i<N; i++)if(dirty[i])tomemory++;
    printf("Input file = %s\n",file);
    printf("Demand fetch = %d\n",now);
    printf("Cache hit = %d\n",hit);
    printf("Cache miss = %d\n",miss);
    printf("Miss rate = %.4lf\n",(double)miss/now);
    printf("Read data = %d\n",readcnt);
    printf("Write data= %d\n",writecnt);
    printf("Bytes from memory = %d\n",miss*block_size);
    printf("Bytes to memory = %d\n",tomemory*block_size);
    return 0;
}
