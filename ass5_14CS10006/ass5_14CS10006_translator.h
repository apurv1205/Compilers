#ifndef TRANSLATE
#define TRANSLATE
#include <vector>
#include <algorithm>
#include <bits/stdc++.h>
#include <iostream>

#define CHAR_SIZE 		    1
#define INT_SIZE  		    4
#define DOUBLE_SIZE		    8
#define POINTER_SIZE		4

extern  char* yytext;
extern  int yyparse();

using namespace std;


////////////////////////////////////Forward class declarations to avoid conflicts
class symtype;					// Type of a symbol in symbol table
class quad;						// Entry in quad array
class quadArray;				// QuadArray
class sym;						// Entry in a symbol table
class symtable;					// Symbol Table


//////////////////////////////////////global variables used in the translator.cxx file are declared here
extern symtable* table;						// Current Symbbol Table
extern symtable* globalTable;				// Global Symbbol Table
extern quadArray q;							// Array of Quads
extern sym* currentSymbol;					// Pointer to just encountered symbol


///////////////////////////////////////Class definitions, non terminal type strucure and attributes and global functions
class symtype { // Type of symbols in symbol table
public:
	symtype(string type, symtype* ptr = NULL, int width = 1);
	string type;
	int width;					// Size of array (in case of arrays)
	symtype* ptr;				// for 2d arrays and pointers
};

class quad { // Quad Class
public:
	string op;					// Operator
	string result;				// Result
	string arg1;				// Argument 1
	string arg2;				// Argument 2

	void print ();								// Print Quad
	quad (string result, string arg1, string op = "EQUAL", string arg2 = "");			//constructors
	quad (string result, int arg1, string op = "EQUAL", string arg2 = "");				//constructors
	quad (string result, float arg1, string op = "EQUAL", string arg2 = "");			//constructors
};

class quadArray { // Array of quads
public:
	vector <quad> array;;		                // Vector of quads
	void print ();								// Print the quadArray
};

class sym { // Symbols class
public:
	string name;				// Name of the symbol
	symtype *type;				// Type of the Symbol
	string initial_value;		// Symbol initial valus (if any)
	int size;					// Size of the symbol
	int offset;					// Offset of symbol
	symtable* nested;				// Pointer to nested symbol table

	sym (string name, string t="INTEGER", symtype* ptr = NULL, int width = 0); //constructor declaration
	sym* update(symtype * t); 	// A method to update different fields of an existing entry.
	sym* link_to_symbolTable(symtable* t);
};

class symtable { // Symbol Table class
public:
	string name;				// Name of Table
	int count;					// Count of temporary variables
	list<sym> table; 			// The table of symbols
	symtable* parent;				// Immediate parent of the symbol table

	symtable (string name="NULL");
	sym* lookup (string name);								// Lookup for a symbol in symbol table
	void print();					            			// Print the symbol table
	void update();						        			// Update offset of the complete symbol table
};


/////////////////////////////////////////Attributes and their explanation for different non terminal type
//Attributes for statements
struct statement {
	list<int> nextlist;				// Nextlist for statement
};

//Attributes for array
struct array {
	string cat;
	sym* loc;					// Temporary used for computing array address
	sym* array;					// Pointer to symbol table
	symtype* type;				// type of the subarray generated
};


//Attributes for expressions
struct expr {
	string type; 							//to store whether the expression is of type int or bool

	// Valid for non-bool type
	sym* loc;								// Pointer to the symbol table entry

	// Valid for bool type
	list<int> truelist;						// Truelist valid for boolean
	list<int> falselist;					// Falselist valid for boolean expressions

	// Valid for statement expression
	list<int> nextlist;
};

//////////////////////////////////////////Global functions required for the translator
void emit(string op, string result, string arg1="", string arg2 = "");    //emits for adding quads to quadArray
void emit(string op, string result, int arg1, string arg2 = "");		  //emits for adding quads to quadArray (arg1 is int)
void emit(string op, string result, float arg1, string arg2 = "");        //emits for adding quads to quadArray (arg1 is float)


sym* conv (sym*, string);							// TAC for Type conversion in program
bool typecheck(sym* &s1, sym* &s2);					// Checks if two symbols have same type
bool typecheck(symtype* t1, symtype* t2);			//checks if two symtype objects have same type


void backpatch (list <int> lst, int i);
list<int> makelist (int i);							        // Make a new list contaninig an integer
list<int> merge (list<int> &lst1, list <int> &lst2);		// Merge two lists into a single list

expr* convertInt2Bool (expr*);				// convert any expression (int) to bool
expr* convertBool2Int (expr*);				// convert bool to expression (int)

void changeTable (symtable* newtable);               //for changing the current sybol table
int nextinstr();									// Returns the next instruction number

sym* gentemp (symtype* t, string init = "");		// Generate a temporary variable and insert it in current symbol table

int size_type (symtype*);							// Calculate size of any symbol type 
string print_type(symtype*);						// For printing type of symbol recursive printing of type

#endif