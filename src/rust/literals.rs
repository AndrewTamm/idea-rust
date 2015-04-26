pub fn main() {
    'c';
    '\'';


    "asdf";
    "asdf \" ffff";
    "aa\t\n";
    "\x7F";
    "\u{0A4f}";
    "\u{BEEF}CAFE";
    "soe\\path\\to\\hello.txt";

    "\r";
    "イロハニホヘト チリヌルヲ ワカヨタレソ ツネ";

    r"foo";
    r##"foo #"# bar"##;

    123; 0xff00;                       // type determined by program context
                                       // defaults to i32 in absence of type
                                       // information

    123u32;                            // type u32
    123_u32;                           // type u32
    0xff_u8;                           // type u8
    0o70_i16;                          // type i16
    0b1111_1111_1001_0000_i32;         // type i32
    123isize;                          // type isize
    123usize;                          // type usize

    123.0;                             // type f64
    0.1;                               // type f64
    0.1f32;                            // type f32
    12E+99_f64;                        // type f64

    0.;                                 // Uugh

    1e20;                               // Okay...
    1e20f64;                            // Totally valid, barely resembles a number
}