# Строки

В Rust есть два типа строк: `String` и `&str`.

`String` сохраняется как вектор байт 
(`Vec<u8>`), но с гарантией, что это всегда будет 
действительная UTF-8 последовательность. `String` 
выделяется в куче, расширяемая и не заканчивается нулевым байтом 
(не null-terminated).

`&str` - это срез (`&[u8]`), 
который всегда указывает на действительную UTF-8 
последовательность, и является отображением 
`String`, так же как и `&[T]` - 
отображение `Vec<T>`.

```rust,editable
fn main() {
    // (все аннотации типов избыточны)
    // Ссылка на строку, размещённую в read-only памяти
    let pangram: &'static str = "the quick brown fox jumps over the lazy dog";
    println!("Pangram: {}", pangram);

    // Итерируемся по словам в обратном прядке, новая строка не аллоцируется
    println!("Words in reverse");
    for word in pangram.split_whitespace().rev() {
        println!("> {}", word);
    }

    // Копируем символы в вектор, сортируем и удаляем дубликаты
    let mut chars: Vec<char> = pangram.chars().collect();
    chars.sort();
    chars.dedup();

    // Создаём пустую расширяемую `String`
    let mut string = String::new();
    for c in chars {
        // Добавляем символ в конец строки
        string.push(c);
        // Добавляем в конец строки другую строку
        string.push_str(", ");
    }

    // Усечённая строка - это срез оригинальной строки, а значит новых 
    // аллокаций не производится
    let chars_to_trim: &[char] = &[' ', ','];
    let trimmed_str: &str = string.trim_matches(chars_to_trim);
    println!("Used characters: {}", trimmed_str);

    // Строка, аллоцированная в куче
    let alice = String::from("I like dogs");
    // Выделяется новая память, в которую сохраняется модифицированная строка
    let bob: String = alice.replace("dog", "cat");

    println!("Alice says: {}", alice);
    println!("Bob says: {}", bob);
}
```

Больше методов `str` и `String` вы 
можете найти в описании модулей [std::str](https://doc.rust-lang.org/std/str/) и 
[std::string](https://doc.rust-lang.org/std/string/).

## Литералы и экранирование

Есть несколько способов написать строковый литерал со 
специальными символами в нём. Все способы приведут к одной и 
той же строке, так что лучше использовать тот способ, который 
легче всего написать. Аналогично все способы записать строковый 
литера из байтов в итоге дадут `&[u8; N]`.

Обычно специальные символы экранируются с помощью обратной косой черты: `Обычно специальные символы экранируются с помощью обратной косой черты: . В этом случае вы можете добавить в вашу 
строку любые символы, даже непечатаемые и те, которые вы не 
знаете как набрать. Если вы хотите добавить обратную косую черту, 
экранируйте его с помощью ещё одной: `\`.

Строковые или символьные разделители литералов (кавычки, встречающиеся внутри другого литерала, должны быть экранированы: `"\""`, `'.'`.

```rust,editable
fn main() {
    // You can use escapes to write bytes by their hexadecimal values...
    let byte_escape = "I'm writing \x52\x75\x73\x74!";
    println!("What are you doing\x3F (\\x3F means ?) {}", byte_escape);

    // ...or Unicode code points.
    let unicode_codepoint = "\u{211D}";
    let character_name = "\"DOUBLE-STRUCK CAPITAL R\"";

    println!("Unicode character {} (U+211D) is called {}",
                unicode_codepoint, character_name );


    let long_string = "String literals
                        can span multiple lines.
                        The linebreak and indentation here ->\
                        <- can be escaped too!";
    println!("{}", long_string);
}
```

Иногда приходится экранировать слишком много символов или 
легче записать строку как она есть. В этот момент в игру вступают 
сырые строковые литералы.

```rust,
fn main() {
    let raw_str = r"Экранирование здесь не работает: \x3F \u{211D}";
    println!("{}", raw_str);

    // Если вам необходимы кавычки с сырой строке, добавьте пару `#`
    let quotes = r#"И затем я сказал: "Здесь нет экранирования!""#;
    println!("{}", quotes);

    // Если вам необходимо добавить в вашу строку `"#`, то просто добавьте больше `#` в разделитель.
    // Здесь нет ограничений на количество `#` которое вы можете использовать.
    let longer_delimiter = r###"Строка с "# внутри неё. И даже с "##!"###;
    println!("{}", longer_delimiter);
}
```

Хотите строку, которая не UTF-8? (Помните, `str` и 
`String` должны содержать действительные UTF-8 
последовательности). Или возможно вы хотите массив байтов, 
которые в основном текст? Байтовые строки вас спасут!

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
    let shift_jis = b"\x82\xe6\x82\xa8\x82\xb1\x82"; // "ようこそ" in SHIFT-JIS

    // But then they can't always be converted to `str`
    match str::from_utf8(shift_jis) {
        Ok(my_str) => println!("Conversion successful: '{}'", my_str),
        Err(e) => println!("Conversion failed: {:?}", e),
    };
}
```

Для преобразования между кодировками символов, посмотрите крейт [encoding](https://crates.io/crates/encoding).

Более детальный список способов записи строковых литералов и 
экранирования символов можно найти в [главе 'Tokens'](https://doc.rust-lang.org/reference/tokens.html) Rust Reference.
