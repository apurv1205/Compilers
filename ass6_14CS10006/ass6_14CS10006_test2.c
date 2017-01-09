//This test file extensively checks the expressions both boolean and algebraic
//and also the funciton calling and returning process in detail

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
  prints("got into function\n");
  ans = a+b;
  d = 2;
  if (a>=d) {
    a++;
  }
  else {
    c = a+b;
  }
  prints("returning from function\n");
  return ans;
}
int main () {
  int c = 2, d, arr[10];
  int*p;
  int x, y, z;
  int eP;
  prints("Enter two numbers :\n");
  x = readi(&eP);
  y = readi(&eP);
  z = add(x,y);
  prints("Sum is equal to ");
  printi(z);
  prints("\n");
  return c;
}