int prints(char *c);
int printi(int i);

int inc(int a,int b){
  prints("\n\nEntered the function \n");
  b=b+5+a;
  prints("Value to be returned is : ");
  printi(b);
  return b;
}

int main() {
  int i,j=10;
  i=1;
  prints("Entering the function inc... \n");
  j=inc(i,j);
  prints("\n\nThe value returned from the function is \n");
  printi(j);
  prints("\n");
  return 0;
}