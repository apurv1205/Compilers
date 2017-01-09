%{
#include <iostream>
#include <cstdlib>
#include <string>
#include <stdio.h>
#include <sstream>
#include "ass6_14CS10006_translator.h"

extern int yylex();
void yyerror(string s);
extern string Type;
vector <string> allstrings;

using namespace std;
%}


%union {
  int intval;
  char* charval;
  int instr;
  sym* symp;
  symtype* symtp;
  expr* E;
  statement* S;
  array* A;
  char unaryOperator;
} 
%token AUTO
%token ENUM
%token RESTRICT
%token UNSIGNED
%token BREAK
%token EXTERN
%token RETURN
%token VOID
%token CASE
%token FLOAT
%token SHORT
%token VOLATILE
%token CHAR
%token FOR
%token SIGNED
%token WHILE
%token CONST
%token GOTO
%token SIZEOF
%token BOOL
%token CONTINUE
%token IF
%token STATIC
%token COMPLEX
%token DEFAULT
%token INLINE
%token STRUCT
%token IMAGINARY
%token DO
%token INT
%token SWITCH
%token DOUBLE
%token LONG
%token TYPEDEF
%token ELSE
%token REGISTER
%token UNION
%token<symp> IDENTIFIER
%token<intval> INTEGER_CONSTANT
%token<charval> FLOATING_CONSTANT
%token<charval> CHARACTER_CONSTANT ENUMERATION_CONSTANT
%token<charval> STRING_LITERAL
%token SQBRAOPEN
%token SQBRACLOSE
%token ROBRAOPEN
%token ROBRACLOSE
%token CURBRAOPEN
%token CURBRACLOSE
%token DOT
%token ACC
%token INC
%token DEC
%token AMP
%token MUL
%token ADD
%token SUB
%token NEG
%token EXCLAIM
%token DIV
%token MODULO
%token SHL
%token SHR
%token BITSHL
%token BITSHR
%token LTE
%token GTE
%token EQ
%token NEQ
%token BITXOR
%token BITOR
%token AND
%token OR
%token QUESTION
%token COLON
%token SEMICOLON
%token DOTS
%token ASSIGN
%token STAREQ
%token DIVEQ
%token MODEQ
%token PLUSEQ
%token MINUSEQ
%token SHLEQ
%token SHREQ
%token BINANDEQ
%token BINXOREQ
%token BINOREQ
%token COMMA
%token HASH

%start translation_unit
//to remove dangling else problem
%right THEN ELSE

//Expressions
%type <E>
	expression
	primary_expression 
	multiplicative_expression
	additive_expression
	shift_expression
	relational_expression
	equality_expression
	AND_expression
	exclusive_OR_expression
	inclusive_OR_expression
	logical_AND_expression
	logical_OR_expression
	conditional_expression
	assignment_expression
	expression_statement

%type <intval> argument_expression_list

//Array to be used later
%type <A> postfix_expression
	unary_expression
	cast_expression

%type <unaryOperator> unary_operator
%type <symp> constant initializer
%type <symp> direct_declarator init_declarator declarator
%type <symtp> pointer

//Auxillary non terminals M and N
%type <instr> M
%type <S> N


//Statements
%type <S>  statement
	labeled_statement 
	compound_statement
	selection_statement
	iteration_statement
	jump_statement
	block_item
	block_item_list

%%

primary_expression
	: IDENTIFIER {
	$$ = new expr();
	$$->loc = $1;
	$$->type = "NONBOOL";
	}
	| constant {
	$$ = new expr();
	$$->loc = $1;
	}
	| STRING_LITERAL {
	$$ = new expr();
	symtype* tmp = new symtype("PTR");
	$$->loc = gentemp(tmp, $1);
	$$->loc->type->ptr = new symtype("CHAR");

	allstrings.push_back($1);
	stringstream strs;
    strs << allstrings.size()-1;
    string temp_str = strs.str();
    char* intStr = (char*) temp_str.c_str();
	string str = string(intStr);
	emit("EQUALSTR", $$->loc->name, str);
	}
	| ROBRAOPEN expression ROBRACLOSE {
	$$ = $2;
	}
	;

constant
	:INTEGER_CONSTANT {
	stringstream strs;
    strs << $1;
    string temp_str = strs.str();
    char* intStr = (char*) temp_str.c_str();
	string str = string(intStr);
	$$ = gentemp(new symtype("INTEGER"), str);
	emit("EQUAL", $$->name, $1);
	}
	|FLOATING_CONSTANT {
	$$ = gentemp(new symtype("DOUBLE"), string($1));
	emit("EQUAL", $$->name, string($1));
	}
	|ENUMERATION_CONSTANT  {//later
	}
	|CHARACTER_CONSTANT {
	$$ = gentemp(new symtype("CHAR"),$1);
	emit("EQUALCHAR", $$->name, string($1));
	}
	;


postfix_expression
	:primary_expression {
		$$ = new array ();
		$$->array = $1->loc;
		$$->loc = $$->array;
		$$->type = $1->loc->type;
	}
	|postfix_expression SQBRAOPEN expression SQBRACLOSE {
		$$ = new array();
		
		$$->array = $1->loc;							// copy the base
		$$->type = $1->type->ptr;						// type = type of element
		$$->loc = gentemp(new symtype("INTEGER"));		// store computed address
		
		// New address =(if only) already computed + $3 * new width
		if ($1->cat=="ARR") {						// if already computed
			sym* t = gentemp(new symtype("INTEGER"));
			stringstream strs;
		    strs <<size_type($$->type);
		    string temp_str = strs.str();
		    char* intStr = (char*) temp_str.c_str();
			string str = string(intStr);				
 			emit ("MULT", t->name, $3->loc->name, str);
			emit ("ADD", $$->loc->name, $1->loc->name, t->name);
		}
 		else {
 			stringstream strs;
		    strs <<size_type($$->type);
		    string temp_str = strs.str();
		    char* intStr1 = (char*) temp_str.c_str();
			string str1 = string(intStr1);		
	 		emit("MULT", $$->loc->name, $3->loc->name, str1);
 		}

 		// Mark that it contains array address and first time computation is done
		$$->cat = "ARR";
	}
	|postfix_expression ROBRAOPEN ROBRACLOSE {
	//later
	}
	|postfix_expression ROBRAOPEN argument_expression_list ROBRACLOSE {
		$$ = new array();
		$$->array = gentemp($1->type);
		stringstream strs;
	    strs <<$3;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);		
		emit("CALL", $$->array->name, $1->array->name, str);
	}
	|postfix_expression DOT IDENTIFIER {//later
	}
	|postfix_expression ACC IDENTIFIER {//later
	}
	|postfix_expression INC {
		$$ = new array();

		// copy $1 to $$
		$$->array = gentemp($1->array->type);
		emit ("EQUAL", $$->array->name, $1->array->name);

		// Increment $1
		emit ("ADD", $1->array->name, $1->array->name, "1");
	}
	|postfix_expression DEC {
		$$ = new array();

		// copy $1 to $$
		$$->array = gentemp($1->array->type);
		emit ("EQUAL", $$->array->name, $1->array->name);

		// Decrement $1
		emit ("SUB", $1->array->name, $1->array->name, "1");
	}
	|ROBRAOPEN type_name ROBRACLOSE CURBRAOPEN initializer_list CURBRACLOSE {
		//later to be added more
		$$ = new array();
		$$->array = gentemp(new symtype("INTEGER"));
		$$->loc = gentemp(new symtype("INTEGER"));
	}
	|ROBRAOPEN type_name ROBRACLOSE CURBRAOPEN initializer_list COMMA CURBRACLOSE {
		//later to be added more
		$$ = new array();
		$$->array = gentemp(new symtype("INTEGER"));
		$$->loc = gentemp(new symtype("INTEGER"));
	}
	;

argument_expression_list
	:assignment_expression {
	emit ("PARAM", $1->loc->name);
	$$ = 1;
	}
	|argument_expression_list COMMA assignment_expression {
	emit ("PARAM", $3->loc->name);
	$$ = $1+1;
	}
	;

unary_expression
	:postfix_expression {
	$$ = $1;
	}
	|INC unary_expression {
		// Increment $2
		emit ("ADD", $2->array->name, $2->array->name, "1");

		// Use the same value as $2
		$$ = $2;
	}
	|DEC unary_expression {
		// Decrement $2
		emit ("SUB", $2->array->name, $2->array->name, "1");

		// Use the same value as $2
		$$ = $2;
	}
	|unary_operator cast_expression {
		$$ = new array();
		switch ($1) {
			case '&':
				$$->array = gentemp((new symtype("PTR")));
				$$->array->type->ptr = $2->array->type; 
				emit ("ADDRESS", $$->array->name, $2->array->name);
				break;
			case '*':
				$$->cat = "PTR";
				$$->loc = gentemp ($2->array->type->ptr);
				emit ("PTRR", $$->loc->name, $2->array->name);
				$$->array = $2->array;
				break;
			case '+':
				$$ = $2;
				break;
			case '-':
				$$->array = gentemp(new symtype($2->array->type->type));
				emit ("UMINUS", $$->array->name, $2->array->name);
				break;
			case '~':
				$$->array = gentemp(new symtype($2->array->type->type));
				emit ("BNOT", $$->array->name, $2->array->name);
				break;
			case '!':
				$$->array = gentemp(new symtype($2->array->type->type));
				emit ("LNOT", $$->array->name, $2->array->name);
				break;
			default:
				break;
		}
	}
	|SIZEOF unary_expression {
	//later
	}
	|SIZEOF ROBRAOPEN type_name ROBRACLOSE {
	//later
	}
	;

unary_operator
	:AMP {
		$$ = '&';
	}
	|MUL {
		$$ = '*';
	}
	|ADD {
		$$ = '+';
	}
	|SUB {
		$$ = '-';
	}
	|NEG {
		$$ = '~';
	}
	|EXCLAIM {
		$$ = '!';
	}
	;

cast_expression
	:unary_expression {
		$$=$1;
	}
	|ROBRAOPEN type_name ROBRACLOSE cast_expression {
		//to be added later
		$$=$4;
	}
	;

multiplicative_expression
	:cast_expression {
		$$ = new expr();
		if ($1->cat=="ARR") { // Array
			$$->loc = gentemp($1->loc->type);
			emit("ARRR", $$->loc->name, $1->array->name, $1->loc->name);
		}
		else if ($1->cat=="PTR") { // Pointer
			$$->loc = $1->loc;
		}
		else { // otherwise
			$$->loc = $1->array;
		}
	}
	|multiplicative_expression MUL cast_expression {
		if (typecheck ($1->loc, $3->array) ) {
			$$ = new expr();
			$$->loc = gentemp(new symtype($1->loc->type->type));
			emit ("MULT", $$->loc->name, $1->loc->name, $3->array->name);
		}
		else cout << "Type Error"<< endl;
	}
	|multiplicative_expression DIV cast_expression {
		if (typecheck ($1->loc, $3->array) ) {
			$$ = new expr();
			$$->loc = gentemp(new symtype($1->loc->type->type));
			emit ("DIVIDE", $$->loc->name, $1->loc->name, $3->array->name);
		}
		else cout << "Type Error"<< endl;
	}
	|multiplicative_expression MODULO cast_expression {
		if (typecheck ($1->loc, $3->array) ) {
			$$ = new expr();
			$$->loc = gentemp(new symtype($1->loc->type->type));
			emit ("MODOP", $$->loc->name, $1->loc->name, $3->array->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

additive_expression
	:multiplicative_expression {
		$$=$1;
	}
	|additive_expression ADD multiplicative_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			$$ = new expr();
			$$->loc = gentemp(new symtype($1->loc->type->type));
			emit ("ADD", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;
	}
	|additive_expression SUB multiplicative_expression {
			if (typecheck ($1->loc, $3->loc) ) {
			$$ = new expr();
			$$->loc = gentemp(new symtype($1->loc->type->type));
			emit ("SUB", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;

	}
	;

shift_expression
	:additive_expression {
		$$=$1;
	}
	|shift_expression SHL additive_expression {
		if ($3->loc->type->type == "INTEGER") {
			$$ = new expr();
			$$->loc = gentemp (new symtype("INTEGER"));
			emit ("LEFTOP", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;
	}
	|shift_expression SHR additive_expression{
		if ($3->loc->type->type == "INTEGER") {
			$$ = new expr();
			$$->loc = gentemp (new symtype("INTEGER"));
			emit ("RIGHTOP", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

relational_expression
	:shift_expression {$$=$1;}
	|relational_expression BITSHL shift_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			$$ = new expr();
			$$->type = "BOOL";

			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);
			emit("LT", "", $1->loc->name, $3->loc->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|relational_expression BITSHR shift_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			$$ = new expr();
			$$->type = "BOOL";

			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);
			emit("GT", "", $1->loc->name, $3->loc->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|relational_expression LTE shift_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			$$ = new expr();
			$$->type = "BOOL";

			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);
			emit("LE", "", $1->loc->name, $3->loc->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|relational_expression GTE shift_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			$$ = new expr();
			$$->type = "BOOL";

			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);
			emit("GE", "", $1->loc->name, $3->loc->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	;

equality_expression
	:relational_expression {$$=$1;}
	|equality_expression EQ relational_expression {
		if (typecheck ($1->loc, $3->loc)) {
			convertBool2Int ($1);
			convertBool2Int ($3);

			$$ = new expr();
			$$->type = "BOOL";

			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);
			emit("EQOP", "", $1->loc->name, $3->loc->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|equality_expression NEQ relational_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			// If any is bool get its value
			convertBool2Int ($1);
			convertBool2Int ($3);

			$$ = new expr();
			$$->type = "BOOL";

			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);
			emit("NEOP", "", $1->loc->name, $3->loc->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	;

AND_expression
	:equality_expression {$$=$1;}
	|AND_expression AMP equality_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			// If any is bool get its value
			convertBool2Int ($1);
			convertBool2Int ($3);
			
			$$ = new expr();
			$$->type = "NONBOOL";

			$$->loc = gentemp (new symtype("INTEGER"));
			emit ("BAND", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

exclusive_OR_expression
	:AND_expression {$$=$1;}
	|exclusive_OR_expression BITXOR AND_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			// If any is bool get its value
			convertBool2Int ($1);
			convertBool2Int ($3);
			
			$$ = new expr();
			$$->type = "NONBOOL";

			$$->loc = gentemp (new symtype("INTEGER"));
			emit ("XOR", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

inclusive_OR_expression
	:exclusive_OR_expression {$$=$1;}
	|inclusive_OR_expression BITOR exclusive_OR_expression {
		if (typecheck ($1->loc, $3->loc) ) {
			// If any is bool get its value
			convertBool2Int ($1);
			convertBool2Int ($3);
			
			$$ = new expr();
			$$->type = "NONBOOL";

			$$->loc = gentemp (new symtype("INTEGER"));
			emit ("INOR", $$->loc->name, $1->loc->name, $3->loc->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

logical_AND_expression
	:inclusive_OR_expression {$$=$1;}
	|logical_AND_expression N AND M inclusive_OR_expression {
		convertInt2Bool($5);

		// convert $1 to bool and backpatch using N
		backpatch($2->nextlist, nextinstr());
		convertInt2Bool($1);

		$$ = new expr();
		$$->type = "BOOL";

		backpatch($1->truelist, $4);
		$$->truelist = $5->truelist;
		$$->falselist = merge ($1->falselist, $5->falselist);
	}
	;

logical_OR_expression
	:logical_AND_expression {$$=$1;}
	|logical_OR_expression N OR M logical_AND_expression {
		convertInt2Bool($5);

		// convert $1 to bool and backpatch using N
		backpatch($2->nextlist, nextinstr());
		convertInt2Bool($1);

		$$ = new expr();
		$$->type = "BOOL";

		backpatch ($1->falselist, $4);
		$$->truelist = merge ($1->truelist, $5->truelist);
		$$->falselist = $5->falselist;
	}
	;

M 	: %empty{	// To store the address of the next instruction
		$$ = nextinstr();
	};

N 	: %empty { 	// gaurd against fallthrough by emitting a goto
		$$  = new statement();
		$$->nextlist = makelist(nextinstr());
		emit ("GOTOOP","");
	}

conditional_expression
	:logical_OR_expression {$$=$1;}
	|logical_OR_expression N QUESTION M expression N COLON M conditional_expression {
		$$->loc = gentemp($5->loc->type);
		$$->loc->update($5->loc->type);
		
		emit("EQUAL", $$->loc->name, $9->loc->name);
		list<int> l = makelist(nextinstr());
		emit ("GOTOOP", "");

	
		backpatch($6->nextlist, nextinstr());
		emit("EQUAL", $$->loc->name, $5->loc->name);
		list<int> m = makelist(nextinstr());
		l = merge (l, m);
		emit ("GOTOOP", "");

	
		backpatch($2->nextlist, nextinstr());
		convertInt2Bool($1);
		backpatch ($1->truelist, $4);
		backpatch ($1->falselist, $8);
		backpatch (l, nextinstr());
	}
	;

assignment_expression
	:conditional_expression {$$=$1;}
	|unary_expression assignment_operator assignment_expression {
		if($1->cat=="ARR") {
			$3->loc = conv($3->loc, $1->type->type);
			emit("ARRL", $1->array->name, $1->loc->name, $3->loc->name);	
			}
		else if($1->cat=="PTR") {
			emit("PTRL", $1->array->name, $3->loc->name);	
			}
		else{
			$3->loc = conv($3->loc, $1->array->type->type);
			emit("EQUAL", $1->array->name, $3->loc->name);
			}
		$$ = $3;
	}
	;

assignment_operator 
	:ASSIGN {//later
	}
	|STAREQ {//later
	}
	|DIVEQ {//later
	}
	|MODEQ {//later
	}
	|PLUSEQ {//later
	}
	|MINUSEQ {//later
	}
	|SHLEQ {//later
	}
	|SHREQ {//later
	}
	|BINANDEQ {//later
	}
	|BINXOREQ {//later
	}
	|BINOREQ {//later
	}
	;

expression
	:assignment_expression {$$=$1;}
	|expression COMMA assignment_expression {
	//later
	}
	;

constant_expression
	:conditional_expression {
	//later
	}
	;

declaration
	:declaration_specifiers init_declarator_list SEMICOLON {//later
	}
	|declaration_specifiers SEMICOLON {//later
	}
	;


declaration_specifiers
	:storage_class_specifier declaration_specifiers {//later
	}
	|storage_class_specifier {//later
	}
	|type_specifier declaration_specifiers {//later
	}
	|type_specifier {//later
	}
	|type_qualifier declaration_specifiers {//later
	}
	|type_qualifier {//later
	}
	|function_specifier declaration_specifiers {//later
	}
	|function_specifier {//later
	}
	;

init_declarator_list
	:init_declarator {//later
	}
	|init_declarator_list COMMA init_declarator {//later
	}
	;

init_declarator
	:declarator {$$=$1;}
	|declarator ASSIGN initializer {
		if ($3->initial_value!="") $1->initial_value=$3->initial_value;
		emit ("EQUAL", $1->name, $3->name);
	}
	;

storage_class_specifier
	: EXTERN {//later
	}
	| STATIC {//later
	}
	| AUTO {//later
	}
	| REGISTER {//later
	}
	;

type_specifier
	: VOID {Type="VOID";}
	| CHAR {Type="CHAR";}
	| SHORT 
	| INT {Type="INTEGER";}
	| LONG
	| FLOAT
	| DOUBLE {Type="DOUBLE";}
	| SIGNED
	| UNSIGNED
	| BOOL
	| COMPLEX
	| IMAGINARY
	| enum_specifier
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list {//later
	}
	| type_specifier {//later
	}
	| type_qualifier specifier_qualifier_list {//later
	}
	| type_qualifier {//later
	}
	;

enum_specifier
	:ENUM IDENTIFIER CURBRAOPEN enumerator_list CURBRACLOSE {//later
	}
	|ENUM CURBRAOPEN enumerator_list CURBRACLOSE {//later
	}
	|ENUM IDENTIFIER CURBRAOPEN enumerator_list COMMA CURBRACLOSE {//later
	}
	|ENUM CURBRAOPEN enumerator_list COMMA CURBRACLOSE {//later
	}
	|ENUM IDENTIFIER {//later
	}
	;

enumerator_list
	:enumerator {//later
	}
	|enumerator_list COMMA enumerator {//later
	}
	;

enumerator
	:IDENTIFIER {//later
	}
	|IDENTIFIER ASSIGN constant_expression {//later
	}
	;

type_qualifier
	:CONST {//later
	}
	|RESTRICT {//later
	}
	|VOLATILE {//later
	}
	;

function_specifier
	:INLINE {//later
	}
	;

declarator
	:pointer direct_declarator {
		symtype * t = $1;
		while (t->ptr !=NULL) t = t->ptr;
		t->ptr = $2->type;
		$$ = $2->update($1);
	}
	|direct_declarator {//later
	}
	;


direct_declarator
	:IDENTIFIER {
		$$ = $1->update(new symtype(Type));
		currentSymbol = $$;
	}
	| ROBRAOPEN declarator ROBRACLOSE {$$=$2;}
	| direct_declarator SQBRAOPEN type_qualifier_list assignment_expression SQBRACLOSE {//later
	}
	| direct_declarator SQBRAOPEN type_qualifier_list SQBRACLOSE {//later
	}
	| direct_declarator SQBRAOPEN assignment_expression SQBRACLOSE {
		symtype * t = $1 -> type;
		symtype * prev = NULL;
		while (t->type == "ARR") {
			prev = t;
			t = t->ptr;
		}
		if (prev==NULL) {
			int temp = atoi($3->loc->initial_value.c_str());
			symtype* s = new symtype("ARR", $1->type, temp);
			$$ = $1->update(s);
		}
		else {
			prev->ptr =  new symtype("ARR", t, atoi($3->loc->initial_value.c_str()));
			$$ = $1->update ($1->type);
		}
	}
	| direct_declarator SQBRAOPEN SQBRACLOSE {
		symtype * t = $1 -> type;
		symtype * prev = NULL;
		while (t->type == "ARR") {
			prev = t;
			t = t->ptr;
		}
		if (prev==NULL) {
			symtype* s = new symtype("ARR", $1->type, 0);
			$$ = $1->update(s);
		}
		else {
			prev->ptr =  new symtype("ARR", t, 0);
			$$ = $1->update ($1->type);
		}
	}
	| direct_declarator SQBRAOPEN STATIC type_qualifier_list assignment_expression SQBRACLOSE {//later
	}
	| direct_declarator SQBRAOPEN STATIC assignment_expression SQBRACLOSE {//later
	}
	| direct_declarator SQBRAOPEN type_qualifier_list MUL SQBRACLOSE {//later
	}
	| direct_declarator SQBRAOPEN MUL SQBRACLOSE {//later
	}
	| direct_declarator ROBRAOPEN CT parameter_type_list ROBRACLOSE {
		table->name = $1->name;

		if ($1->type->type !="VOID") {
			sym *s = table->lookup("return");
			s->update($1->type);		
		}
		$1->nested=table;
		$1->category = "function";
		table->parent = globalTable;
		changeTable (globalTable);				// Come back to globalsymbol table
		currentSymbol = $$;
	}
	| direct_declarator ROBRAOPEN identifier_list ROBRACLOSE {//later
	}
	| direct_declarator ROBRAOPEN CT ROBRACLOSE {
		table->name = $1->name;

		if ($1->type->type !="VOID") {
			sym *s = table->lookup("return");
			s->update($1->type);		
		}
		$1->nested=table;
		$1->category = "function";
		
		table->parent = globalTable;
		changeTable (globalTable);				// Come back to globalsymbol table
		currentSymbol = $$;
	}
	;

CT
	: %empty { 															// Used for changing to symbol table for a function
		if (currentSymbol->nested==NULL) changeTable(new symtable(""));	// Function symbol table doesn't already exist
		else {
			changeTable (currentSymbol ->nested);						// Function symbol table already exists
			emit ("FUNC", table->name);
		}
	}
	;

pointer
	:MUL type_qualifier_list {//later
	}
	|MUL {
		$$ = new symtype("PTR");
	}
	|MUL type_qualifier_list pointer {//later
	}
	|MUL pointer {
		$$ = new symtype("PTR", $2);
	}
	;

type_qualifier_list
	:type_qualifier {//later
	}
	|type_qualifier_list type_qualifier {//later
	}
	;

parameter_type_list
	:parameter_list {//later
	}
	|parameter_list COMMA DOTS {//later
	}
	;

parameter_list
	:parameter_declaration {//later
	}
	|parameter_list COMMA parameter_declaration {//later
	}
	;

parameter_declaration
	:declaration_specifiers declarator {
		$2->category = "param";
	}
	|declaration_specifiers {//later
	}
	;

identifier_list
	:IDENTIFIER {//later
	}
	|identifier_list COMMA IDENTIFIER {//later
	}
	;

type_name
	:specifier_qualifier_list {//later
	}
	;

initializer
	:assignment_expression {
		$$ = $1->loc;
	}
	|CURBRAOPEN initializer_list CURBRACLOSE {//later
	}
	|CURBRAOPEN initializer_list COMMA CURBRACLOSE {//later
	}
	;


initializer_list
	:designation initializer {//later
	}
	|initializer {//later
	}
	|initializer_list COMMA designation initializer {//later
	}
	|initializer_list COMMA initializer {//later
	}
	;

designation
	:designator_list ASSIGN {//later
	}
	;

designator_list
	:designator {//later
	}
	|designator_list designator {//later
	}
	;

designator
	:SQBRAOPEN constant_expression SQBRACLOSE {//later
	}
	|DOT IDENTIFIER {//later
	}
	;

statement
	:labeled_statement {//later
	}
	|compound_statement {$$=$1;}
	|expression_statement {
		$$ = new statement();
		$$->nextlist = $1->nextlist;
	}
	|selection_statement {$$=$1;}
	|iteration_statement {$$=$1;}
	|jump_statement {$$=$1;}
	;

labeled_statement
	:IDENTIFIER COLON statement {$$ = new statement();}
	|CASE constant_expression COLON statement {$$ = new statement();}
	|DEFAULT COLON statement {$$ = new statement();}
	;

compound_statement
	:CURBRAOPEN block_item_list CURBRACLOSE {$$=$2;}
	|CURBRAOPEN CURBRACLOSE {$$ = new statement();}
	;

block_item_list
	:block_item {$$=$1;}
	|block_item_list M block_item {
		$$=$3;
		backpatch ($1->nextlist, $2);
	}
	;

block_item
	:declaration {
		$$ = new statement();
	}
	|statement {$$ = $1;}
	;

expression_statement
	:expression SEMICOLON {$$=$1;}
	|SEMICOLON {$$ = new expr();}
	;

selection_statement
	:IF ROBRAOPEN expression N ROBRACLOSE M statement N %prec THEN{
		backpatch ($4->nextlist, nextinstr());
		convertInt2Bool($3);
		$$ = new statement();
		backpatch ($3->truelist, $6);
		list<int> temp = merge ($3->falselist, $7->nextlist);
		$$->nextlist = merge ($8->nextlist, temp);
	}
	|IF ROBRAOPEN expression N ROBRACLOSE M statement N ELSE M statement {
		backpatch ($4->nextlist, nextinstr());
		convertInt2Bool($3);
		$$ = new statement();
		backpatch ($3->truelist, $6);
		backpatch ($3->falselist, $10);
		list<int> temp = merge ($7->nextlist, $8->nextlist);
		$$->nextlist = merge ($11->nextlist,temp);
	}
	|SWITCH ROBRAOPEN expression ROBRACLOSE statement {//later
	}
	;

iteration_statement
	:WHILE M ROBRAOPEN expression ROBRACLOSE M statement {
		$$ = new statement();
		convertInt2Bool($4);
		// M1 to go back to boolean again
		// M2 to go to statement if the boolean is true
		backpatch($7->nextlist, $2);
		backpatch($4->truelist, $6);
		$$->nextlist = $4->falselist;
		// Emit to prevent fallthrough
		stringstream strs;
	    strs << $2;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);

		emit ("GOTOOP", str);
	}
	|DO M statement M WHILE ROBRAOPEN expression ROBRACLOSE SEMICOLON {
		$$ = new statement();
		convertInt2Bool($7);
		// M1 to go back to statement if expression is true
		// M2 to go to check expression if statement is complete
		backpatch ($7->truelist, $2);
		backpatch ($3->nextlist, $4);

		// Some bug in the next statement
		$$->nextlist = $7->falselist;
	}
	|FOR ROBRAOPEN expression_statement M expression_statement ROBRACLOSE M statement{
		$$ = new statement();
		convertInt2Bool($5);
		backpatch ($5->truelist, $7);
		backpatch ($8->nextlist, $4);
		stringstream strs;
	    strs << $4;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);

		emit ("GOTOOP", str);
		$$->nextlist = $5->falselist;
	}
	|FOR ROBRAOPEN expression_statement M expression_statement M expression N ROBRACLOSE M statement{
		$$ = new statement();
		convertInt2Bool($5);
		backpatch ($5->truelist, $10);
		backpatch ($8->nextlist, $4);
		backpatch ($11->nextlist, $6);
		stringstream strs;
	    strs << $6;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);
		emit ("GOTOOP", str);
		$$->nextlist = $5->falselist;
	}
	;

jump_statement
	:GOTO IDENTIFIER SEMICOLON {$$ = new statement();}
	|CONTINUE SEMICOLON {$$ = new statement();}
	|BREAK SEMICOLON {$$ = new statement();}
	|RETURN expression SEMICOLON {
		$$ = new statement();
		emit("RETURN",$2->loc->name);
	}
	|RETURN SEMICOLON {
		$$ = new statement();
		emit("RETURN","");
	}
	;

translation_unit
	:external_declaration {}
	|translation_unit external_declaration {}
	;

external_declaration
	:function_definition {}
	|declaration {}
	;

function_definition
	:declaration_specifiers declarator declaration_list CT compound_statement {}
	|declaration_specifiers declarator CT compound_statement {
		emit ("FUNCEND", table->name);
		table->parent = globalTable;
		changeTable (globalTable);
	}
	;

declaration_list
	:declaration {//later
	}
	|declaration_list declaration {//later
	}
	;



%%

void yyerror(string s) {
    cout<<s<<endl;
}