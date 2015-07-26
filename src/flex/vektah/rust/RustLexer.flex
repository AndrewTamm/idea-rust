package vektah.rust;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.intellij.util.text.CharArrayUtil;
import com.intellij.psi.TokenType;
import vektah.rust.psi.RustTokens;

%%

%class RustLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%{
	private int start_comment;
	private int start_raw_string;
	private int raw_string_hashes;
	private int comment_depth;
	private boolean doc_comment;
%}

SINGLE_QUOTE = \x27
DOUBLE_QUOTE = \x22
ESCAPE = \x5c
NON_SINGLE_QUOTE = [^']
NON_DOUBLE_QUOTE = [^\"]
COMMON_ESCAPE = {ESCAPE} ([nrt0] | "x" {HEX_DIGIT} {2})
UNICODE_ESCAPE = "u{" {HEX_DIGIT} {1,6} "}"
CHAR_BODY = {NON_SINGLE_QUOTE} | ({ESCAPE} ({SINGLE_QUOTE} | {COMMON_ESCAPE} | {UNICODE_ESCAPE}))
CHAR_LIT = {SINGLE_QUOTE} {CHAR_BODY} {SINGLE_QUOTE}
STRING_BODY = {NON_DOUBLE_QUOTE} | ({ESCAPE} ({DOUBLE_QUOTE} | {COMMON_ESCAPE} | {UNICODE_ESCAPE}))
STRING_LIT = {DOUBLE_QUOTE} {STRING_BODY}* {DOUBLE_QUOTE}

WHITE_SPACE = [\ \t\n\r]
XID_START = [a-zA-Z_]
XID_CONTINUE = [a-zA-Z0-9_]
HEX_DIGIT = [a-fA-F0-9]
NUM_SUFFIX = {INT_SUFFIX} | {FLOAT_SUFFIX}
INT_SUFFIX = [ui] ( "8" | "16" | "32" | "64" | "size")
EXPONENT = [eE] [-+]? ([0-9] | "_" )+
FLOAT_SUFFIX = ( {EXPONENT} | "." [0-9_]+ {EXPONENT}?)? ("f" ("32" | "64"))?
DEC_LIT = [0-9] [0-9_]* {NUM_SUFFIX}?
BIN_LIT = "0b" [01_]+ {INT_SUFFIX}?
OCT_LIT = "0o" [0-7_]+ {INT_SUFFIX}?
HEX_LIT = "0x" [a-fA-F0-9_]+ {INT_SUFFIX}?

%state IN_BLOCK_COMMENT
%state IN_RAW_STRING

%%

<YYINITIAL> {
	{WHITE_SPACE}+                                  { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

	// Keywords
	"abstract"                                      { yybegin(YYINITIAL); return RustTokens.KW_ABSTRACT; }
	"alignof"                                       { yybegin(YYINITIAL); return RustTokens.KW_ALIGNOF; }
	"as"                                            { yybegin(YYINITIAL); return RustTokens.KW_AS; }
	"become"                                        { yybegin(YYINITIAL); return RustTokens.KW_BECOME; }
	"break"                                         { yybegin(YYINITIAL); return RustTokens.KW_BREAK; }
	"const"                                         { yybegin(YYINITIAL); return RustTokens.KW_CONST; }
	"crate"                                         { yybegin(YYINITIAL); return RustTokens.KW_CRATE; }
	"do"                                            { yybegin(YYINITIAL); return RustTokens.KW_DO; }
	"else"                                          { yybegin(YYINITIAL); return RustTokens.KW_ELSE; }
	"enum"                                          { yybegin(YYINITIAL); return RustTokens.KW_ENUM; }
	"extern"                                        { yybegin(YYINITIAL); return RustTokens.KW_EXTERN; }
	"false"                                         { yybegin(YYINITIAL); return RustTokens.KW_FALSE; }
	"final"                                         { yybegin(YYINITIAL); return RustTokens.KW_FINAL; }
	"fn"                                            { yybegin(YYINITIAL); return RustTokens.KW_FN; }
	"for"                                           { yybegin(YYINITIAL); return RustTokens.KW_FOR; }
	"if"                                            { yybegin(YYINITIAL); return RustTokens.KW_IF; }
	"impl"                                          { yybegin(YYINITIAL); return RustTokens.KW_IMPL; }
	"in"                                            { yybegin(YYINITIAL); return RustTokens.KW_IN; }
	"let"                                           { yybegin(YYINITIAL); return RustTokens.KW_LET; }
	"loop"                                          { yybegin(YYINITIAL); return RustTokens.KW_LOOP; }
	"match"                                         { yybegin(YYINITIAL); return RustTokens.KW_MATCH; }
	"mod"                                           { yybegin(YYINITIAL); return RustTokens.KW_MOD; }
	"move"                                          { yybegin(YYINITIAL); return RustTokens.KW_MOVE; }
	"mut"                                           { yybegin(YYINITIAL); return RustTokens.KW_MUT; }
	"offsetof"                                      { yybegin(YYINITIAL); return RustTokens.KW_OFFSETOF; }
	"override"                                      { yybegin(YYINITIAL); return RustTokens.KW_OVERRIDE; }
	"priv"                                          { yybegin(YYINITIAL); return RustTokens.KW_PRIV; }
	"proc"                                          { yybegin(YYINITIAL); return RustTokens.KW_PROC; }
	"move"                                          { yybegin(YYINITIAL); return RustTokens.KW_MOVE; }
	"pub"                                           { yybegin(YYINITIAL); return RustTokens.KW_PUB; }
	"pure"                                          { yybegin(YYINITIAL); return RustTokens.KW_PURE; }
	"ref"                                           { yybegin(YYINITIAL); return RustTokens.KW_REF; }
	"return"                                        { yybegin(YYINITIAL); return RustTokens.KW_RETURN; }
	"Self"                                          { yybegin(YYINITIAL); return RustTokens.KW_SELF_IMPLEMENTOR; }
	"self"                                          { yybegin(YYINITIAL); return RustTokens.KW_SELF; }
	"sizeof"                                        { yybegin(YYINITIAL); return RustTokens.KW_SIZEOF; }
	"static"                                        { yybegin(YYINITIAL); return RustTokens.KW_STATIC; }
	"struct"                                        { yybegin(YYINITIAL); return RustTokens.KW_STRUCT; }
	"super"                                         { yybegin(YYINITIAL); return RustTokens.KW_SUPER; }
	"true"                                          { yybegin(YYINITIAL); return RustTokens.KW_TRUE; }
	"trait"                                         { yybegin(YYINITIAL); return RustTokens.KW_TRAIT; }
	"type"                                          { yybegin(YYINITIAL); return RustTokens.KW_TYPE; }
	"typeof"                                        { yybegin(YYINITIAL); return RustTokens.KW_TYPEOF; }
	"unsafe"                                        { yybegin(YYINITIAL); return RustTokens.KW_UNSAFE; }
	"unsized"                                       { yybegin(YYINITIAL); return RustTokens.KW_UNSIZED; }
	"use"                                           { yybegin(YYINITIAL); return RustTokens.KW_USE; }
	"virtual"                                       { yybegin(YYINITIAL); return RustTokens.KW_VIRTUAL; }
	"while"                                         { yybegin(YYINITIAL); return RustTokens.KW_WHILE; }
	"continue"                                      { yybegin(YYINITIAL); return RustTokens.KW_CONTINUE; }
	"box"                                           { yybegin(YYINITIAL); return RustTokens.KW_BOX; }
	"where"                                         { yybegin(YYINITIAL); return RustTokens.KW_WHERE; }
	"macro_rules!"                                  { yybegin(YYINITIAL); return RustTokens.KW_MACRO_RULES; }

	"/*" ("!"|"*"[^*/])                             { yybegin(IN_BLOCK_COMMENT); start_comment = zzStartRead; doc_comment = true; comment_depth = 1; }
	"/**" / "/"                                     { yybegin(IN_BLOCK_COMMENT); start_comment = zzStartRead; doc_comment = true; comment_depth = 1; }
	"/*"                                            { yybegin(IN_BLOCK_COMMENT); start_comment = zzStartRead; doc_comment = false; comment_depth = 1; }
	"///" $                                         { yybegin(YYINITIAL); return RustTokens.LINE_DOC_COMMENT; }
	"//" ("!"|"/"[^/\n\r])[^\n\r]*                  { yybegin(YYINITIAL); return RustTokens.LINE_DOC_COMMENT; }
	"//" [^\n\r]*                                   { yybegin(YYINITIAL); return RustTokens.LINE_COMMENT; }
	{CHAR_LIT}                                      { yybegin(YYINITIAL); return RustTokens.CHAR_LIT; }
	{STRING_LIT}                                    { yybegin(YYINITIAL); return RustTokens.STRING_LIT; }
	"r" "#"* {DOUBLE_QUOTE}                         { yybegin(IN_RAW_STRING); start_raw_string = zzStartRead; raw_string_hashes = yytext().length() - 1; }

	{BIN_LIT}                                       { yybegin(YYINITIAL); return RustTokens.BIN_LIT; }
	{OCT_LIT}                                       { yybegin(YYINITIAL); return RustTokens.OCT_LIT; }
	{HEX_LIT}                                       { yybegin(YYINITIAL); return RustTokens.HEX_LIT; }
	// The 0. syntax can get ambiguious with range matches
	// ie 0..9 could be tokenized as 0. . 9, which would be bad.
	[0-9] [0-9_]* "." /[^\.0-9e]                         { yybegin(YYINITIAL); return RustTokens.DEC_LIT; }
	{DEC_LIT}                                       { yybegin(YYINITIAL); return RustTokens.DEC_LIT; }
	{XID_START}{XID_CONTINUE}*                      { yybegin(YYINITIAL); return RustTokens.IDENTIFIER; }


	"..."                                           { yybegin(YYINITIAL); return RustTokens.TRIPLE_DOT; }
	".."                                            { yybegin(YYINITIAL); return RustTokens.DOUBLE_DOT; }
	">>="                                           { yybegin(YYINITIAL); return RustTokens.ASSIGN_RIGHT_SHIFT; }
	"<<="                                           { yybegin(YYINITIAL); return RustTokens.ASSIGN_LEFT_SHIFT; }
	"=>"                                            { yybegin(YYINITIAL); return RustTokens.FAT_ARROW; }
	"->"                                            { yybegin(YYINITIAL); return RustTokens.THIN_ARROW; }
	"."                                             { yybegin(YYINITIAL); return RustTokens.DOT; }

	"&"                                             { yybegin(YYINITIAL); return RustTokens.BITWISE_AND; }
	"|"                                             { yybegin(YYINITIAL); return RustTokens.BITWISE_OR; }
	"^"                                             { yybegin(YYINITIAL); return RustTokens.BITWISE_XOR; }

	"::"                                            { yybegin(YYINITIAL); return RustTokens.DOUBLE_COLON; }
	":"                                             { yybegin(YYINITIAL); return RustTokens.COLON; }

	"+"                                             { yybegin(YYINITIAL); return RustTokens.PLUS; }
	"-"                                             { yybegin(YYINITIAL); return RustTokens.MINUS; }
	"*"                                             { yybegin(YYINITIAL); return RustTokens.MULTIPLY; }
	"/"                                             { yybegin(YYINITIAL); return RustTokens.DIVIDE; }
	"%"                                             { yybegin(YYINITIAL); return RustTokens.REMAINDER; }

	"=="                                            { yybegin(YYINITIAL); return RustTokens.EQUAL; }
	"="                                             { yybegin(YYINITIAL); return RustTokens.ASSIGN; }
	"!="                                            { yybegin(YYINITIAL); return RustTokens.NOT_EQUAL; }
	"<="                                            { yybegin(YYINITIAL); return RustTokens.LESS_THAN_OR_EQUAL; }
	"<"                                             { yybegin(YYINITIAL); return RustTokens.LESS_THAN; }
	">="                                            { yybegin(YYINITIAL); return RustTokens.GREATER_THAN_OR_EQUAL; }
	">"                                             { yybegin(YYINITIAL); return RustTokens.GREATER_THAN; }

	"!"                                             { yybegin(YYINITIAL); return RustTokens.NOT; }
	"@"                                             { yybegin(YYINITIAL); return RustTokens.AT; }
	"'"                                             { yybegin(YYINITIAL); return RustTokens.SINGLE_QUOTE; }
	"$"                                             { yybegin(YYINITIAL); return RustTokens.DOLLAR; }

	"#"                                             { yybegin(YYINITIAL); return RustTokens.HASH; }
	"["                                             { yybegin(YYINITIAL); return RustTokens.OPEN_SQUARE_BRACKET; }
	"]"                                             { yybegin(YYINITIAL); return RustTokens.CLOSE_SQUARE_BRACKET; }
	"("                                             { yybegin(YYINITIAL); return RustTokens.OPEN_PAREN; }
	")"                                             { yybegin(YYINITIAL); return RustTokens.CLOSE_PAREN; }
	"{"                                             { yybegin(YYINITIAL); return RustTokens.OPEN_BRACE; }
	"}"                                             { yybegin(YYINITIAL); return RustTokens.CLOSE_BRACE; }
	","                                             { yybegin(YYINITIAL); return RustTokens.COMMA; }
	";"                                             { yybegin(YYINITIAL); return RustTokens.SEMICOLON; }

	.                                               { yybegin(YYINITIAL); return TokenType.BAD_CHARACTER; }
}

<IN_BLOCK_COMMENT> {
	"*/"        {
		if (--comment_depth == 0) {
			yybegin(YYINITIAL);
			zzStartRead = start_comment;
			return doc_comment ? RustTokens.BLOCK_DOC_COMMENT : RustTokens.BLOCK_COMMENT;
		} else {
			yybegin(IN_BLOCK_COMMENT);
		}
	}
	"/*"        { yybegin(IN_BLOCK_COMMENT); ++comment_depth; }
	[^*/]+      { yybegin(IN_BLOCK_COMMENT); }
	<<EOF>>     { yybegin(YYINITIAL); zzStartRead = start_comment; return RustTokens.BLOCK_COMMENT; }
	.           { yybegin(IN_BLOCK_COMMENT); }
}

<IN_RAW_STRING> {
	{DOUBLE_QUOTE} "#"*   {
		if (yytext().length() >= raw_string_hashes) {
			// Greedily ate too many #'s ... lets rewind a sec.
			if (yytext().length() > raw_string_hashes) {
				yypushback(yytext().length() - raw_string_hashes);
			}
			yybegin(YYINITIAL);
			zzStartRead = start_raw_string;
			return RustTokens.RAW_STRING_LIT;
		} else {
			yybegin(IN_RAW_STRING);
		}
	}
	[^\"]   { yybegin(IN_RAW_STRING); }
	<<EOF>> { yybegin(YYINITIAL); zzStartRead = start_raw_string; return RustTokens.RAW_STRING_LIT; }
	.       { yybegin(IN_RAW_STRING); }
}
