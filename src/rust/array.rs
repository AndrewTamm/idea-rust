// new fixed-size array syntax
pub struct Matrix([MatrixColumn; 4]);
type MatrixColumn = [Coord; 4];

fn main () {
	let a = [0i8; 4*4];
}
