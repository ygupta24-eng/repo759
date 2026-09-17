#include <iostream> 
#include <cstdio>
using namespace std;

int main(int argc, char *argv[])
{
    int N = std::atoi(argv[1]);
    for(int i = 0; i <= N; i++)
    {
        printf("%d", i);
        if(i != N)
        {
            printf(" ");
        }
    }
    printf("\n");

    for (int i = N; i >= 0; i--)
    {
        cout << i;
        if(i != 0)
        {
            cout << " ";
        }
    }
    cout << "\n";

    return 0;
}