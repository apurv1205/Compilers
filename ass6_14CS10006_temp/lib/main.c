#include"stdio.h"
#include "myl.h"
int main(){
	char string[100];
	printf("\n\n\n++++			Testing for prints(char *) :\nEnter the string (without spaces)\n");
	scanf("%s",string);
	printf("\nUsing prints function : \n");
	int len=prints(string);
	printf("\nLength of characters is : %d\n\n",len);


	int n;
	printf("\n++++			Testing for printi(int) :\nEnter the Number\n");
	scanf("%d",&n);
	printf("\nUsing printi function : \n");
	len=printi(n);
	printf("\nLength of characters is : %d\n\n",len);


	while(1) {
	int ep=0;
	printf("\n++++			Testing for readi(int *) :\nEnter the Number\n");
	printf("\nUsing readi function : \n");
	int num=readi(&ep);
	if(ep==0) {
		printf("%d\n\n",num);
		break;
		}
	else printf("ERROR\n\n");
	}	


	float f=0.0;
	while(1) {
	int error=0;
	printf("\n++++			Testing for readf(float*) :\nEnter the Number\n");
	printf("\nUsing readf function : \n");
	error=readf(&f);
	if(error) 
		printf("ERROR\n\n");
	else {
		printf("%f\n\n",f);
		break;
		}
	}


	f=0.0;
	printf("\n++++			Testing for printd(float) :\nEnter the Number\n");
	scanf("%f",&f);
	printf("\nUsing printd function : \n");
	len=printd(f);
	printf("\nLength of characters is : %d\n\n",len);



return 0;
}