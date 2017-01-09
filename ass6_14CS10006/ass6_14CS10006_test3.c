//test file to check functions and iterations and also some of the
//functions created in assignment 2

int prints(char *c);
int printi(int i);
int readi(int *eP);


int fib(int a){
  prints("Entered the fib function\n");
  int f=1,f_1=0;
  int i=1,temp;
  while(i<a) {
    temp=f;
    f=f+f_1;
    f_1=temp;
    i=i+1;
  }
  prints("\nThe fibonacci number is : ");
  printi(f);
  return f;
}

int main () {
  prints("enter the i for finding its fibonacci number : ");
  int i,ep;
  i=readi(&ep);
  prints("\n\nYou Entered : ");
  printi(i);

  prints("\nNow, entering the function to calculate fibonacci numbers for i entered\n");
  int j;
  j=fib(i);
  prints("\n\nReturned from the fib function\n\n");
  return;
}