grammar Robot

entry Robot:
	Fonction+=Fonction*;

Fonction:
    'def' name=ID ('(' (args+=DeclaredParameter (',' args+=DeclaredParameter)*) ')')?
        body=Body;

Body:
 '{' statements+=Statement '}';

DeclaredParameter:
    name=ID;

Statement:
	Deplacement | ControlStructure | VariableDeclaration | UpdateVariable | CallFunction;

Deplacement:
	Forward | Backward | StrafeLeft | StrafeRight | SpeedCommand | Rotate;

ControlStructure:
	('If' | 'While' | 'Else') BooleanExpression Body;

VariableDeclaration:
	'var' name=ID '=' Term ';';

UpdateVariable:
	variableName=[VariableDeclaration:ID] '=' Term ';';

CallVariable:
    variableCall=[VariableDeclaration:ID] ';';

CallFunction:
	function=[Fonction:ID] ('(' (args+=DeclaredParameter(',' args+=DeclaredParameter)*) ')')?;

ArithmeticExpression:
	Term (OperandMath Term)*;

OperandMath returns string:
	'+' | '-' | '*' | '/';

Unit returns string:
	'mm'|'cm'|'m';

BooleanExpression:
	Term + (OperandBool Term)*;

OperandBool returns string:
	'>' | '>=' | '<' | '=<' | '!=' | '==' | 'and' | 'or';

BooleanValue returns string:
	'True' | 'False';

Term:
	CallVariable | CallFunction | ArithmeticExpression | GetSensor | DeclaredParameter | BooleanValue | INT;

GetSensor:
    timestamp=GetTimestamp | speed=GetSpeed | distance=GetDistance;

GetTimestamp returns string:
    'get_timestamp';

GetSpeed returns string:
    'get_speed';

GetDistance returns string:
    'get_distance';

Forward:
    'forward' distance=ArithmeticExpression unit=Unit ';';

Backward:
    'backward' distance=ArithmeticExpression unit=Unit ';';

StrafeLeft:
    'strafeleft' distance=ArithmeticExpression unit=Unit ';';

StrafeRight:
    'straferight' distance=ArithmeticExpression unit=Unit ';';

Rotate:
    'rotate' angle=ArithmeticExpression ';';

SpeedCommand:
	'setspeed' speed=ArithmeticExpression ';';


hidden terminal WS: /\s+/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal INT returns number: /[0-9]+/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;