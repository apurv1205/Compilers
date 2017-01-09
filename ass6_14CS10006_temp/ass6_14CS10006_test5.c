int prints(char *c);
int printi(int i);
int readi(int *eP);

int main() {
	int array[100], n, c, d, swap;
	int eP;
	prints("Enter number of elements\n");
	n = readi(&eP);
	prints("Enter ");
	printi(n);
	prints(" integers\n");
	
  for (c = 1; c <= n; c++)
		array[c-1] = readi(&eP);

  for (c = 1 ; c < ( n ); c++) {
    for (d = 1 ; d <= n - c ; d++) {
    // printi(array[d-1]);
    // prints("\t");
    // printi(array[d]);
    // prints("\n");
      if (array[d-1] > array[d]) {
        swap       = array[d-1];
        array[d-1]   = array[d];
        array[d] = swap;
      }
    }
  }

   prints("Sorted list in ascending order:\n");

   for ( c = 1 ; c <= n ; c++ ) {
      printi(array[c-1]);
  	prints("\n");
   }
   prints("Done.\n");
	
	return 0;
}