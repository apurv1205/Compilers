int prints(char *c);
int printi(int i);
int readi(int *eP);

int inc(int a,int b){
  b=b+5+a;
  return b;
}

int main() {
  int i,j=10;
  i=1;
  prints("HELLO\n");
  j=inc(i,j);
  printi(j);
  return 0;
}