int prints(char *c);
int printi(int i);
int readi(int *eP);
int a;
int b = 1;
char c;
char d = 'a';

int add (int a, int b) {
	int ans;
	int c = 2, d, arr[10];
	int*p;
	prints("Got into function\n");
	ans = a+b;
	d = 2;
	if (a>=d) {
		a++;
	}
	else {
		c = a+b;
	}
	p = &c;
	b=*p;
	a++;
	*p=a;
	a = -a;
	arr[2] = a;
	a = arr[8];
	prints("Returning from function\n");
	return ans;
}
int main () {
	int c = 2, d, arr[10];
	int*p;
	int x, y, z;
	int eP;
	prints("Enter two numbers to find their sum using a function call\n");
	x = readi(&eP);
	y = readi(&eP);
	z = add(x,y);
	prints("Sum is equal to ");
	printi(z);
	prints("\n");
	arr[d] = a;
	arr[2] = a;
	a = arr[c];
	return c;
}