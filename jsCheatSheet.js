/*
includes

The includes() method determines whether an array includes 
a certain element, returning true or false as appropriate.
*/

const array = [1,2,3];

console.log(array.includes(2));
// result: true

console.log(array.includes(77));
// result: false

/*
Number to String Method
*/

let num = 15,
	n = num.toString();

/*
Repeat a string
*/
// Must use a positive integer.
str.repeat(count);
'hey'.repeat(4);
// result: heyheyheyhey

/*
switch

The switch statement evaluates an expression, matching 
the expression's value to a case clause, and executes 
statements associated with that case, as well as statements
in cases that follow the matching case.

JavaScript has the following expression categories:

Arithmetic: evaluates to a number, for example 3.14159. 
String: evaluates to a character string, for example, "Fred" or "234".
Logical: evaluates to true or false.
Primary expressions: Basic keywords and general expressions in JavaScript.
Left-hand-side expressions: 
Left values are the destination of an assignment.
*/
example:
switch(fruit) {
	case 'strawberries':
		console.log('We have strawberries!');
		break;
	case 'peaches':
		console.log('We have peaches!!');
		break;
	default:
		console.log("Sorry, we ain't got" + fruit + ".");
}