#include <stdio.h>
#include <stdlib.h>
int gcd(int a, int b);
int main(int argc, const char *argv[])
{
	int a,b;
	printf("Input to number e.g: 8 16\n");
	scanf("%d %d",&a,&b);
	printf("最大公约数为: %d\n",gcd(a,b));
	// 最小公倍数公式: |a x b| / gcd
	printf("最小公倍数为: %d\n",(abs(a)*abs(b))/gcd(a,b));
	return 0;
}
/*辗转相除法求最大公约数*/
int gcd(int a, int b)
{
	int c;
	while (a != 0) {
		c = a;
	       	a = b % a;
		b = c;
	}
	return b;
}
