#include <stdio.h>
#include <math.h>
float my_sqrt(float a);
int main(int argc, const char *argv[])
{
	float a;
	printf("Input the num to cal root: \n");
	scanf("%f",&a);
	printf("%.0f 的平方根等于: %.2f\n",a,my_sqrt(a));
	return 0;
}
/*迭代法求平方根*/
float my_sqrt(float a)
{
	float x0,x1;
	x0 = a / 2;
	x1 = (x0 + a / x0) / 2;
	while (fabs(x1 - x0) >= 1e-5) {
		x0 = x1;
		x1 = (x0 + a / x0) / 2;
	}
	return x1;
}
