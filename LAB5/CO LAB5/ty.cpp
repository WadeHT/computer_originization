#include<queue>
#include<stdio.h>
using namespace std;
queue<int>N;
int main(void)
{
    N.push(1);
    N.push(2);
    N.push(3);
    N.pop();
    printf("%d %d\n",N.front(),N.back());
}
