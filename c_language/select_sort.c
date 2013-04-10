/*选择法对10个整数进行排序*/
#include <stdio.h>
int main(int argc, const char *argv[])
{
	int i,j,min,a[10];
	for (i = 0; i < 10; i++) {
		scanf("%d",&a[i]);
	}
	for (i = 0; i < 10; i++) {
		printf("[%d]:%d\t",i,a[i]);
	}
	for (i = 0; i < 10-1; i++) {
		min = i;
		for (j = i+1; j < 10; j++) {
			if (a[min]>a[j]) {
				min = j;
			}
		}
		if (i!=min) {
			int tmp=a[i];
			a[i]=a[min];
			a[min]=tmp;
		}
	}
	printf("\n");
	for (i = 0; i < 10; i++) {
		printf("%d\t",a[i]);
	}
	return 0;
}
