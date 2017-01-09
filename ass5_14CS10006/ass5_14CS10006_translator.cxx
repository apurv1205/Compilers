#include "ass5_14CS10006_translator.h"
#include <sstream>

using namespace std;

//reference to global variables declared in header file 
symtable* globalTable;					// Global Symbbol Table
quadArray q;							// Quad Array
string Type;							// Stores latest type
symtable* table;						// Points to current symbol table
sym* currentSymbol; 					// points to current symbol

symtype::symtype(string type, symtype* ptr, int width): 
	type (type), 
	ptr (ptr), 
	width (width) {};

quad::quad (string result, string arg1, string op, string arg2):
	result (result), arg1(arg1), arg2(arg2), op (op){};

quad::quad (string result, int arg1, string op, string arg2):
	result (result), arg2(arg2), op (op) {
		stringstream strs;
	    strs << arg1;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);
		this->arg1 = str;
	}

quad::quad (string result, float arg1, string op, string arg2):
	result (result), arg2(arg2), op (op) {
		std::ostringstream buff;
   		buff<<arg1;
		this->arg1 = buff.str();
	}

void quad::print () {
	// Binary Operations
	if (op=="ADD")					cout << result << " = " << arg1 << " + " << arg2;
	else if (op=="SUB")				cout << result << " = " << arg1 << " - " << arg2;
	else if (op=="MULT")			cout << result << " = " << arg1 << " * " << arg2;
	else if (op=="DIVIDE")			cout << result << " = " << arg1 << " / " << arg2;
	else if (op=="MODOP")			cout << result << " = " << arg1 << " % " << arg2;
	else if (op=="XOR")				cout << result << " = " << arg1 << " ^ " << arg2;
	else if (op=="INOR")			cout << result << " = " << arg1 << " | " << arg2;
	else if (op=="BAND")			cout << result << " = " << arg1 << " & " << arg2;
	// Shift Operations
	else if (op=="LEFTOP")			cout << result << " = " << arg1 << " << " << arg2;
	else if (op=="RIGHTOP")			cout << result << " = " << arg1 << " >> " << arg2;
	else if (op=="EQUAL")			cout << result << " = " << arg1 ;				
	// Relational Operations
	else if (op=="EQOP")			cout << "if " << arg1 <<  " == " << arg2 << " goto " << result;
	else if (op=="NEOP")			cout << "if " << arg1 <<  " != " << arg2 << " goto " << result;
	else if (op=="LT")				cout << "if " << arg1 <<  " < "  << arg2 << " goto " << result;
	else if (op=="GT")				cout << "if " << arg1 <<  " > "  << arg2 << " goto " << result;
	else if (op=="GE")				cout << "if " << arg1 <<  " >= " << arg2 << " goto " << result;
	else if (op=="LE")				cout << "if " << arg1 <<  " <= " << arg2 << " goto " << result;
	else if (op=="GOTOOP")			cout << "goto " << result;		
	//Unary Operators
	else if (op=="ADDRESS")			cout << result << " = &" << arg1;
	else if (op=="PTRR")			cout << result	<< " = *" << arg1 ;
	else if (op=="PTRL")			cout << "*" << result	<< " = " << arg1 ;
	else if (op=="UMINUS")			cout << result 	<< " = -" << arg1;
	else if (op=="BNOT")			cout << result 	<< " = ~" << arg1;
	else if (op=="LNOT")			cout << result 	<< " = !" << arg1;

	else if (op=="ARRR")	 		cout << result << " = " << arg1 << "[" << arg2 << "]";
	else if (op=="ARRL")	 		cout << result << "[" << arg1 << "]" <<" = " <<  arg2;
	else if (op=="RETURN") 			cout << "ret " << result;
	else if (op=="PARAM") 			cout << "param " << result;
	else if (op=="CALL") 			cout << result << " = " << "call " << arg1<< ", " << arg2;
	else if (op=="LABEL")			cout << result << ": ";	
	else							cout << "op";			
	cout << endl;
}

void quadArray::print() {
	cout << setw(30) << setfill ('=') << "="<< endl;
	cout << "Quad Translation" << endl;
	cout << setw(30) << setfill ('-') << "-"<< setfill (' ') << endl;
	for (vector<quad>::iterator it = array.begin(); it!=array.end(); it++) {
		if (it->op != "LABEL") {
			cout << "\t" << setw(4) << it - array.begin() << ":\t";
			it->print();
		}
		else {
			cout << "\n";
			it->print();
			cout << "\n";
		}
	}
	cout << setw(30) << setfill ('-') << "-"<< endl;
}

sym::sym (string name, string t, symtype* ptr, int width): name(name)  {
	type = new symtype (t, ptr, width);
	nested = NULL;
	initial_value = "";
	offset = 0;
	size = size_type(type);
}

sym* sym::update(symtype* t) {
	type = t;
	this -> size = size_type(t);
	return this;
}

symtable::symtable (string name): name (name), count(0) {}

void symtable::print() {
	list<symtable*> tablelist;
	cout << setw(115) << setfill ('=') << "="<< endl;
	cout << "Symbol Table: " << setfill (' ') << left << setw(50)  << this -> name ;
	cout << right << setw(25) << "Parent: ";
	if (this->parent!=NULL)
		cout << this -> parent->name;
	else cout << "null" ;
	cout << endl;
	cout << setw(100) << setfill ('-') << "-"<< endl;
	cout << setfill (' ') << left << setw(20) << "Name";
	cout << left << setw(25) << "Type";
	cout << left << setw(20) << "Initial Value";
	cout << left << setw(12) << "Size";
	cout << left << setw(12) << "Offset";
	cout << left << "Nested" << endl;
	cout << setw(115) << setfill ('-') << "-"<< setfill (' ') << endl;
	
	for (list <sym>::iterator it = table.begin(); it!=table.end(); it++) {
		cout << left << setw(20) << it->name;
		string stype = print_type(it->type);
		cout << left << setw(25) << stype;
		cout << left << setw(17) << it->initial_value;
		cout << left << setw(12) << it->size;
		cout << left << setw(11) << it->offset;
		cout << left;
		if (it->nested == NULL) {
			cout << "null" <<  endl;	
		}
		else {
			cout << it->nested->name <<  endl;
			tablelist.push_back (it->nested);
		}
	}
	cout << setw(115) << setfill ('-') << "-"<< setfill (' ') << endl;
	cout << endl;
	for (list<symtable*>::iterator iterator = tablelist.begin();
			iterator != tablelist.end();
			++iterator) 
		{
	    	(*iterator)->print();
		}		
}

void symtable::update() {
	list<symtable*> tablelist;
	int off;
	for (list <sym>::iterator it = table.begin(); it!=table.end(); it++) {
		if (it==table.begin()) {
			it->offset = 0;
			off = it->size;
		}
		else {
			it->offset = off;
			off = it->offset + it->size;
		}
		if (it->nested!=NULL) tablelist.push_back (it->nested);
	}
	for (list<symtable*>::iterator iterator = tablelist.begin(); 
			iterator != tablelist.end(); 
			++iterator) {
	    (*iterator)->update();
	}
}

sym* symtable::lookup (string name) {
	sym* s;
	list <sym>::iterator it;
	for (it = table.begin(); it!=table.end(); it++) {
		if (it->name == name ) break;
	}
	if (it!=table.end() ) {
		return &*it;
	}
	else {
		//new symbol to be added to table
		s =  new sym (name);
		table.push_back (*s);
		return &table.back();
		}
}


void emit(string op, string result, string arg1, string arg2) {
	q.array.push_back(*(new quad(result,arg1,op,arg2)));
}
void emit(string op, string result, int arg1, string arg2) {
	q.array.push_back(*(new quad(result,arg1,op,arg2)));
}
void emit(string op, string result, float arg1, string arg2) {
	q.array.push_back(*(new quad(result,arg1,op,arg2)));
}


sym* conv (sym* s, string t) {
	sym* temp = gentemp(new symtype(t));
	if (s->type->type=="INTEGER" ) {
		if (t=="DOUBLE") {
			emit ("EQUAL", temp->name, "int2double(" + s->name + ")");
			return temp;
		}
		else if (t=="CHAR") {
			emit ("EQUAL", temp->name, "int2char(" + s->name + ")");
			return temp;
		}
		return s;
	}
	else if (s->type->type=="DOUBLE" ) {
		if (t=="INTEGER") {
			emit ("EQUAL", temp->name, "double2int(" + s->name + ")");
			return temp;
		}
		else if (t=="CHAR") {
			emit ("EQUAL", temp->name, "double2char(" + s->name + ")");
			return temp;
		}
		return s;
	}
	else if (s->type->type=="CHAR") {
		if (t=="INTEGER") {
				emit ("EQUAL", temp->name, "char2int(" + s->name + ")");
				return temp;
			}
		if (t=="DOUBLE") {
				emit ("EQUAL", temp->name, "char2double(" + s->name + ")");
				return temp;
			}
		return s;
	}
	return s;
}


bool typecheck(sym*& s1, sym*& s2){ 	// Check if the symbols have same type or not
	symtype* type1 = s1->type;
	symtype* type2 = s2->type;
	if ( typecheck (type1, type2) ) return true;
	else if (s1 = conv (s1, type2->type) ) return true;
	else if (s2 = conv (s2, type1->type) ) return true;
	else return false;
}

bool typecheck(symtype* t1, symtype* t2){ 	// Check if the symbol types are same or not
	if (t1 != NULL || t2 != NULL) {
		if (t1==NULL) return false;
		if (t2==NULL) return false;
		if (t1->type==t2->type) return typecheck(t1->ptr, t2->ptr);
		else return false;
	}
	return true;
}

void backpatch (list <int> l, int addr) {
	stringstream strs;
    strs << addr;
    string temp_str = strs.str();
    char* intStr = (char*) temp_str.c_str();
	string str = string(intStr);
	for (list<int>::iterator it= l.begin(); it!=l.end(); it++) {
		q.array[*it].result = str;
	}
}


list<int> makelist (int i) {
	list<int> l(1,i);
	return l;
}
list<int> merge (list<int> &a, list <int> &b) {
	a.merge(b);
	return a;
}

expr* convertInt2Bool (expr* e) {	// Convert any expression to bool
	if (e->type!="BOOL") {
		e->falselist = makelist (nextinstr());
		emit ("EQOP", "", e->loc->name, "0");
		e->truelist = makelist (nextinstr());
		emit ("GOTOOP", "");
	}
}
expr* convertBool2Int (expr* e) {	// Convert any expression to bool
	if (e->type=="BOOL") {
		e->loc = gentemp(new symtype("INTEGER"));
		backpatch (e->truelist, nextinstr());
		emit ("EQUAL", e->loc->name, "true");
		stringstream strs;
	    strs << nextinstr()+1;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);
		emit ("GOTOOP", str);
		backpatch (e->falselist, nextinstr());
		emit ("EQUAL", e->loc->name, "false");
	}
}

void changeTable (symtable* newtable) {	// Change current symbol table
	table = newtable;
} 


int nextinstr() {
	return q.array.size();
}

sym* gentemp (symtype* t, string init) {
	char n[10];
	sprintf(n, "t%02d", table->count++);
	sym* s = new sym (n);
	s->type = t;
	s->size=size_type(t);
	s-> initial_value = init;
	table->table.push_back ( *s);
	return &table->table.back();
}

int size_type (symtype* t){
	if(t->type=="VOID")	return 0;
	else if(t->type=="CHAR") return CHAR_SIZE;
	else if(t->type=="INTEGER")return INT_SIZE;
	else if(t->type=="DOUBLE") return  DOUBLE_SIZE;
	else if(t->type=="PTR") return POINTER_SIZE;
	else if(t->type=="ARR") return t->width * size_type (t->ptr);
	else if(t->type=="FUNC") return 0;
}


string print_type (symtype* t){
	if (t==NULL) return "null";
	if(t->type=="VOID")	return "void";
	else if(t->type=="CHAR") return "char";
	else if(t->type=="INTEGER") return "integer";
	else if(t->type=="DOUBLE") return "double";
	else if(t->type=="PTR") return "ptr("+ print_type(t->ptr)+")";
	else if(t->type=="ARR") {
		stringstream strs;
	    strs << t->width;
	    string temp_str = strs.str();
	    char* intStr = (char*) temp_str.c_str();
		string str = string(intStr);
		return "arr(" + str + ", "+ print_type (t->ptr) + ")";
		}
	else if(t->type=="FUNC") return "function";
	else return "_";
}



int  main (int argc, char* argv[]){
	globalTable = new symtable("Global");
	table = globalTable;
	yyparse();
	globalTable->update();
	globalTable->print();
	q.print();
};