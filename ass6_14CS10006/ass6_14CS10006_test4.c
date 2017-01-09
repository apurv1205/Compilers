//test file to check basic statements, expression, readi and printi library 
//functions created in assignment 2
//also checks the recursive fibonacci function to check the function call and return methodology


int prints(char *c);
int printi(int i);
int readi(int *eP);


int fib(int a){
  prints("\nEntered the function for i : ");
  printi(a);
  int b=a-1,c,d;
  if(b<=0) return 1;
  else {
    c=fib(b);
    b=b-1;
    d=fib(b);
    c=c+d;
    return c;
  }
  return 1;
}

int main () {
  int a = 5, b = 2, c;
  char ch = 'x';
  char* str;
  str = "Hello World\n";
  char* str1;
  str1 = "abcd";
  int read;
  read = 5;
  int eP;
  if (a<b) {
    a++;
  }
  else {
    c = a+b;
  }
  prints("Please enter a number for recursive fibonacci: ");
  read = readi(&eP);
  prints("You Entered ");
  c = printi(read);
  prints("\n");

  prints("Now testting for recursive fibonacci number ....Entering the function\n");
  int out=0;
  out=fib(read);
  prints("\n\nReturned from recursive fibonacci function");

}