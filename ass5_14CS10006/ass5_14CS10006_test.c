// Test Everything
int test = 5;
double d = 2.3;
int i, w[10];
int a = 4, *p, b;
void func(int i, double d);
char c;
int main () {
	a = 10;
	if(a==2)
		return 1;
	else
		return 1;

	int *x, y;
	x = &y;
	*x = y;
	y = *x;
	int a=1, b=2, c;
	c = a + b;
	a++;
	int check = a+b*c;
	if (check < c) 
		c = a|b;
	i = ++a;
	int n = 6;
	int fn;
	fn = factorial(n);
	int i, a[10], v = 5;
	double d;
	for (i=1; i<a[10]; i++) 
		i++;
	do i = i - 1; while (a[i] < v);
	i = 2;
	if (i&&v) i = 1;
	return;
}
int factorial (int n) {
	int m = n-1;
	int r = 1;
	if (m) {
		int fn = factorial(m-1);
		r = n*fn;
	}
	return r;
}
int add (int a, int b) {
	a = 10;
	int *x, y;
	x = &y;
	*x = y;
	y = *x;
}