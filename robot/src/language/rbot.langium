grammar Robot

entry Robot:
	Fonction+=Fonction*;

Fonction:
    'def' name=ID '(' (args+=DeclaredParameter (',' args+=DeclaredParameter)*)? ')'
        body=Body;

Body:
 '{' (statements+=Statement)* '}';

DeclaredParameter:
    name=ID;

Statement:
	 ControlStructure | ((Deplacement | VariableDeclaration | UpdateVariable | CallFunction | Return) ';');

Return:
	'return' Expression;

Deplacement:
	Forward | Backward | StrafeLeft | StrafeRight | SpeedCommand | Rotate;

ControlStructure:
	Condition | Loop ;

Loop:
	'while' loop=Expression body=Body;

Condition:
	'if' ifcondition=Expression ifbody=Body ('else' 'if' elseifcondition+=Expression esleifbody+=Body)* ('else' elsebody=Body)* ;

VariableDeclaration:
	'var' name=ID '=' value=Expression;

UpdateVariable:
	variableName=[VariableDeclaration:ID] '=' newvalue=Expression;

CallVariable:
    variableCall=[VariableDeclaration:ID] | parameterCall=[DeclaredParameter:ID];

CallFunction:
	function=[Fonction:ID] '(' (args+=Expression (',' args+=Expression)*)? ')';

ArithmeticExpression:
	PlusMinus;

Unit returns string:
	'mm'|'cm'|'m';

Expression : Or;

Or infers Expression:
	left=And ( '||' right=And )*;

And infers Expression:
	left=Equality ( '&&' right+=Equality )*;

Equality infers Expression:
	left=Comparison (op+=( '==' | '!=' ) right+=Comparison)*;

Comparison infers Expression:
	left=PlusMinus (op+=( '<' | '<=' | '>=' | '>' ) right+=PlusMinus )*;

PlusMinus infers Expression:
	left=MultDiv (op+=( '+' | '-' ) right+=MultDiv )*;

MultDiv infers Expression:
	left=Term ( op+=( '*' | '/' ) right+=Term)*;

Term infers Expression:
	'(' Expression ')' | "not" expression=Term | param=DeclaredParameter | atom=Atomic;

Atomic infers Expression:
	value=INT | '-' value=INT |
	value=STRING |
	value=('true' | 'false') |
	variable=CallVariable |
	function=CallFunction |
	sensor=GetSensor;

GetSensor:
    timestamp=GetTimestamp | speed=GetSpeed | distance=GetDistance;

GetTimestamp returns string:
    'get_timestamp';

GetSpeed returns string:
    'get_speed';

GetDistance returns string:
    'get_distance';

Forward:
    'forward' distance=ArithmeticExpression unit=Unit;

Backward:
    'backward' distance=ArithmeticExpression unit=Unit;

StrafeLeft:
    'strafeleft' distance=ArithmeticExpression unit=Unit;

StrafeRight:
    'straferight' distance=ArithmeticExpression unit=Unit;

Rotate:
    'rotate' angle=ArithmeticExpression;

SpeedCommand:
	'setspeed' speed=ArithmeticExpression;


hidden terminal WS: /\s+/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal INT returns number: /[0-9]+/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;