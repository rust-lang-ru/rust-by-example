# Строки

There are two types of strings in Rust: `String` and `&str`.

A `String` is stored as a vector of bytes (`Vec<u8>`), but guaranteed to always be a valid UTF-8 sequence. `String` is heap allocated, growable and not null terminated.

`&str` is a slice (`&[u8]`) that always points to a valid UTF-8 sequence, and can be used to view into a `String`, just like `&[T]` is a view into `Vec<T>`.

```rust,editable
fn main() {     // (all the type annotations are superfluous)     // A reference to a string allocated in read only memory     let pangram: &'static str = "the quick brown fox jumps over the lazy dog";     println!("Pangram: {}", pangram);      // Iterate over words in reverse, no new string is allocated     println!("Words in reverse");     for word in pangram.split_whitespace().rev() {         println!("> {}", word);     }      // Copy chars into a vector, sort and remove duplicates     let mut chars: Vec<char> = pangram.chars().collect();     chars.sort();     chars.dedup();      // Create an empty and growable `String`     let mut string = String::new();     for c in chars {         // Insert a char at the end of string         string.push(c);         // Insert a string at the end of string         string.push_str(", ");     }      // The trimmed string is a slice to the original string, hence no new     // allocation is performed     let chars_to_trim: &[char] = &[' ', ','];     let trimmed_str: &str = string.trim_matches(chars_to_trim);     println!("Used characters: {}", trimmed_str);      // Heap allocate a string     let alice = String::from("I like dogs");     // Allocate new memory and store the modified string there     let bob: String = alice.replace("dog", "cat");      println!("Alice says: {}", alice);     println!("Bob says: {}", bob); }
```

More `str`/`String` methods can be found under the [std::str](https://doc.rust-lang.org/std/str/) and [std::string](https://doc.rust-lang.org/std/string/) modules

## Literals and escapes

There are multiple ways to write string literals with special characters in them. All result in a similar `&str` so it's best to use the form that is the most convenient to write. Similarly there are multiple ways to write byte string literals, which all result in `&[u8; N]`.

Обычно специальные символы экранируются с помощью обратной косой черты: `Обычно специальные символы экранируются с помощью обратной косой черты: . В этом случае вы можете добавить в вашу строку любые символы, даже непечатаемые и те, которые вы не знаете как набрать. Если вы хотите добавить обратную косую черту, экранируйте его с помощью ещё одной: `\`.

Строковые или символьные разделители литералов (кавычки, встречающиеся внутри другого литерала, должны быть экранированы: `"\""`, `'.'`.

```rust,editable
fn main() {     // You can use escapes to write bytes by their hexadecimal values...     let byte_escape = "I'm writing \x52\x75\x73\x74!";     println!("What are you doing\x3F (\\x3F means ?) {}", byte_escape);      // ...or Unicode code points.     let unicode_codepoint = "\u{211D}";     let character_name = "\"DOUBLE-STRUCK CAPITAL R\"";      println!("Unicode character {} (U+211D) is called {}",                 unicode_codepoint, character_name );       let long_string = "String literals                         can span multiple lines.                         The linebreak and indentation here ->\                         <- can be escaped too!";     println!("{}", long_string); }
```

Sometimes there are just too many characters that need to be escaped or it's just much more convenient to write a string out as-is. This is where raw string literals come into play.

```rust,
fn main() {     let raw_str = r"Escapes don't work here: \x3F \u{211D}";     println!("{}", raw_str);      // If you need quotes in a raw string, add a pair of #s     let quotes = r#"And then I said: "There is no escape!""#;     println!("{}", quotes);      // If you need "# in your string, just use more #s in the delimiter.     // There is no limit for the number of #s you can use.     let longer_delimiter = r###"A string with "# in it. And even "##!"###;     println!("{}", longer_delimiter); }
```

Want a string that's not UTF-8? (Remember, `str` and `String` must be valid UTF-8). Or maybe you want an array of bytes that's mostly text? Byte strings to the rescue!

```rust,
use std::str;

fn main() {
    // Note that this is not actually a `&str`
    let bytestring: &[u8; 21] = b"this is a byte string";

    // Byte arrays don't have the `Display` trait, so printing them is a bit limited
    println!("A byte string: {:?}", bytestring);

    // Byte strings can have byte escapes...
    let escaped = b"\x52\x75\x73\x74 as bytes";
    // ...but no unicode escapes
    // let escaped = b"\u{211D} is not allowed";
    println!("Some escaped bytes: {:?}", escaped);


    // Raw byte strings work just like raw strings
    let raw_bytestring = br"\u{211D} is not escaped here";
    println!("{:?}", raw_bytestring);

    // Converting a byte array to `str` can fail
    if let Ok(my_str) = str::from_utf8(raw_bytestring) {
        println!("And the same as text: '{}'", my_str);
    }

    let _quotes = br#"You can also use "fancier" formatting, \
                    like with normal raw strings"#;

    // Byte strings don't have to be UTF-8
    let shift_jis = b"\x82\xe6\x82\xa8\x82\xb1\x82\xbb"; // "ようこそ" in SHIFT-JIS

    // But then they can't always be converted to `str`
    match str::from_utf8(shift_jis) {
        Ok(my_str) => println!("Conversion successful: '{}'", my_str),
        Err(e) => println!("Conversion failed: {:?}", e),
    };
}
```

For conversions between character encodings check out the [encoding](https://crates.io/crates/encoding) crate.

A more detailed listing of the ways to write string literals and escape characters is given in the ['Tokens' chapter](https://doc.rust-lang.org/reference/tokens.html) of the Rust Reference.
