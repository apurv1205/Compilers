int prints(char *c);
int printi(int i);
int readi(int *eP);


int main () {
	int a = 5, b = 2, c;
	char ch = 'x';
	char* str;
	str = "abc\n";
	char* stri;
	stri = "abcd";
	int read;
	read = 5;
	int eP;
	if (a<b) {
		a++;
	}
	else {
		c = a+b;
	}
	prints("Please enter a number: ");
	read = readi(&eP);
	prints("You Entered ");
	c = printi(read);
	prints("\n");
//	prints(str);
	return;
}