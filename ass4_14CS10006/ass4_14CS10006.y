%{
#include <stdio.h>
extern int yylex();
void yyerror(char *s);
%}
%union {
  int intval;
  float floatval;
  char *charval;
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
%token IDENTIFIER
%token<intval> INTEGER_CONSTANT
%token<floatval> FLOATING_CONSTANT
%token<charval> CHARACTER_CONSTANT
%token ENUMERATION_CONSTANT
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

%right THEN ELSE
%%

primary_expression
	: IDENTIFIER
	| constant
	| STRING_LITERAL
	| ROBRAOPEN expression ROBRACLOSE
	;

constant
	:INTEGER_CONSTANT
	|FLOATING_CONSTANT
	|ENUMERATION_CONSTANT
	|CHARACTER_CONSTANT
	;

argument_expression_list_opt
	:argument_expression_list
	|
	;

postfix_expression
	:primary_expression
	|postfix_expression SQBRAOPEN expression SQBRACLOSE
	|postfix_expression ROBRAOPEN argument_expression_list_opt ROBRACLOSE
	|postfix_expression DOT IDENTIFIER
	|postfix_expression ACC IDENTIFIER
	|postfix_expression INC
	|postfix_expression DEC
	|ROBRAOPEN type_name ROBRACLOSE CURBRAOPEN initializer_list CURBRACLOSE
	|ROBRAOPEN type_name ROBRACLOSE CURBRAOPEN initializer_list COMMA CURBRACLOSE
	;

argument_expression_list
	:assignment_expression
	|argument_expression_list COMMA assignment_expression
	;

unary_expression
	:postfix_expression
	|INC unary_expression
	|DEC unary_expression
	|unary_operator cast_expression
	|SIZEOF unary_expression
	|SIZEOF ROBRAOPEN type_name ROBRACLOSE
	;

unary_operator
	:AMP
	|MUL
	|ADD
	|SUB
	|NEG
	|EXCLAIM
	;

cast_expression
	:unary_expression
	|ROBRAOPEN type_name ROBRACLOSE cast_expression
	;

multiplicative_expression
	:cast_expression
	|multiplicative_expression MUL cast_expression
	|multiplicative_expression DIV cast_expression
	|multiplicative_expression MODULO cast_expression
	;

additive_expression
	:multiplicative_expression
	|additive_expression ADD multiplicative_expression
	|additive_expression SUB multiplicative_expression
	;

shift_expression
	:additive_expression
	|shift_expression SHL additive_expression
	|shift_expression SHR additive_expression
	;

relational_expression
	:shift_expression
	|relational_expression BITSHL shift_expression
	|relational_expression BITSHR shift_expression
	|relational_expression LTE shift_expression
	|relational_expression GTE shift_expression
	;

equality_expression
	:relational_expression
	|equality_expression EQ relational_expression
	|equality_expression NEQ relational_expression
	;

AND_expression
	:equality_expression
	|AND_expression AMP equality_expression
	;

exclusive_OR_expression
	:AND_expression
	|exclusive_OR_expression BITXOR AND_expression
	;

inclusive_OR_expression
	:exclusive_OR_expression
	|inclusive_OR_expression BITOR exclusive_OR_expression
	;

logical_AND_expression
	:inclusive_OR_expression
	|logical_AND_expression AND inclusive_OR_expression
	;

logical_OR_expression
	:logical_AND_expression
	|logical_OR_expression OR logical_AND_expression
	;

conditional_expression
	:logical_OR_expression
	|logical_OR_expression QUESTION expression COLON conditional_expression
	;

assignment_expression
	:conditional_expression
	|unary_expression assignment_operator assignment_expression
	;

assignment_operator 
	:ASSIGN
	|STAREQ
	|DIVEQ
	|MODEQ
	|PLUSEQ
	|MINUSEQ
	|SHLEQ
	|SHREQ
	|BINANDEQ
	|BINXOREQ
	|BINOREQ
	;

expression
	:assignment_expression
	|expression COMMA assignment_expression
	;

constant_expression
	:conditional_expression
	;

declaration
	:declaration_specifiers init_declarator_list_opt SEMICOLON
	;

init_declarator_list_opt
	:init_declarator_list
	|;

declaration_specifiers_opt
	:declaration_specifiers
	|
	;

declaration_specifiers
	:storage_class_specifier declaration_specifiers_opt
	|type_specifier declaration_specifiers_opt
	|type_qualifier declaration_specifiers_opt
	|function_specifier declaration_specifiers_opt
	;

init_declarator_list
	:init_declarator
	|init_declarator_list COMMA init_declarator
	;

init_declarator
	:declarator
	|declarator ASSIGN initializer
	;

storage_class_specifier
	: EXTERN
	| STATIC
	| AUTO
	| REGISTER
	;

type_specifier
	: VOID
	| CHAR
	| SHORT
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| BOOL
	| COMPLEX
	| IMAGINARY
	| enum_specifier
	;

specifier_qualifier_list_opt
	:specifier_qualifier_list
	|
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list_opt
	| type_qualifier specifier_qualifier_list_opt
	;

identifier_opt
	:IDENTIFIER
	|
	;

enum_specifier
	:ENUM identifier_opt CURBRAOPEN enumerator_list CURBRACLOSE
	|ENUM identifier_opt CURBRAOPEN enumerator_list COMMA CURBRACLOSE
	|ENUM IDENTIFIER
	;

enumerator_list
	:enumerator
	|enumerator_list COMMA enumerator
	;

enumerator
	:IDENTIFIER
	|IDENTIFIER ASSIGN constant_expression
	;

type_qualifier
	:CONST
	|RESTRICT
	|VOLATILE
	;

function_specifier
	:INLINE
	;

pointer_opt 
	:pointer
	|
	;

declarator
	:pointer_opt direct_declarator
	;

type_qualifier_list_opt
	:type_qualifier_list
	|
	;

assignment_expression_opt
	:assignment_expression
	|
	;

direct_declarator
	:IDENTIFIER
	|ROBRAOPEN declarator ROBRACLOSE
	|direct_declarator SQBRAOPEN type_qualifier_list_opt assignment_expression_opt SQBRACLOSE
	| direct_declarator SQBRAOPEN STATIC type_qualifier_list_opt assignment_expression SQBRACLOSE
	| direct_declarator SQBRAOPEN type_qualifier_list_opt MUL SQBRACLOSE
	| direct_declarator ROBRAOPEN parameter_type_list ROBRACLOSE
	| direct_declarator ROBRAOPEN identifier_list ROBRACLOSE
	| direct_declarator ROBRAOPEN ROBRACLOSE
	;

pointer
	:MUL type_qualifier_list_opt
	|MUL type_qualifier_list_opt pointer
	;

type_qualifier_list
	:type_qualifier
	|type_qualifier_list type_qualifier
	;

parameter_type_list
	:parameter_list
	|parameter_list COMMA DOTS
	;

parameter_list
	:parameter_declaration
	|parameter_list COMMA parameter_declaration
	;

parameter_declaration
	:declaration_specifiers declarator
	|declaration_specifiers
	;

identifier_list
	:IDENTIFIER
	|identifier_list COMMA IDENTIFIER
	;

type_name
	:specifier_qualifier_list
	;

initializer
	:assignment_expression
	|CURBRAOPEN initializer_list CURBRACLOSE
	|CURBRAOPEN initializer_list COMMA CURBRACLOSE
	;

designation_opt
	:designation
	|
	;

initializer_list
	:designation_opt initializer
	|initializer_list COMMA designation_opt initializer
	;

designation
	:designator_list ASSIGN
	;

designator_list
	:designator
	|designator_list designator
	;

designator
	:SQBRAOPEN constant_expression SQBRACLOSE
	|DOT IDENTIFIER
	;

statement
	:labeled_statement
	|compound_statement
	|expression_statement
	|selection_statement
	|iteration_statement
	|jump_statement
	;

labeled_statement
	:IDENTIFIER COLON statement
	|CASE constant_expression COLON statement
	|DEFAULT COLON statement
	;

block_item_list_opt
	:block_item_list
	|
	;

compound_statement
	:CURBRAOPEN block_item_list_opt CURBRACLOSE
	;

block_item_list
	:block_item
	|block_item_list block_item
	;

block_item
	:declaration
	|statement
	;

expression_opt
	:expression
	|
	;

expression_statement
	:expression_opt SEMICOLON
	;

selection_statement_base
	:IF ROBRAOPEN expression ROBRACLOSE statement
	;

selection_statement
	:selection_statement_base %prec THEN
	|selection_statement_base ELSE statement
	|SWITCH ROBRAOPEN expression ROBRACLOSE statement
	;

iteration_statement
	:WHILE ROBRAOPEN expression ROBRACLOSE statement
	|DO statement WHILE ROBRAOPEN expression ROBRACLOSE SEMICOLON
	|FOR ROBRAOPEN expression_opt SEMICOLON expression_opt SEMICOLON expression_opt ROBRACLOSE statement
	|FOR ROBRAOPEN declaration expression_opt SEMICOLON expression_opt ROBRACLOSE statement
	;

jump_statement
	:GOTO IDENTIFIER SEMICOLON
	|CONTINUE SEMICOLON
	|BREAK SEMICOLON
	|RETURN expression_opt SEMICOLON
	;

translation_unit
	:external_declaration
	|translation_unit external_declaration
	;

external_declaration
	:function_definition
	|declaration
	;

declaration_list_opt
	:declaration_list
	|
	;

function_definition
	:declaration_specifiers declarator declaration_list_opt compound_statement
	;

declaration_list
	:declaration
	|declaration_list declaration
	;



%%

void yyerror(char *s) {
    printf("%s\n",s);
}