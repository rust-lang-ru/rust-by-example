# Raw identifiers

Rust, like many programming languages, has the concept of "keywords".
These identifiers mean something to the language, and so you cannot use them in
places like variable names, function names, and other places.
Raw identifiers let you use keywords where they would not normally be allowed.
This is particularly useful when Rust introduces new keywords, and a library
using an older edition of Rust has a variable or function with the same name
as a keyword introduced in a newer edition.

Например, рассмотрим крейт `foo`, скомпилированный с 2015 редакцией Rust, и который экспортирует функцию с именем `try`. Это ключевое слово зарезервировано для новой функциональности в 2018 редакции, из-за чего без сырых идентификаторов мы не можем назвать так функцию.

```rust,ignore
extern crate foo;

fn main() {
    foo::try();
}
```

Вы получите ошибку:

```text
error: expected identifier, found keyword `try`
 --> src/main.rs:4:4
  |
4 | foo::try();
  |      ^^^ expected identifier, found keyword
```

Вы можете записать это при помощи сырого идентификатора:

```rust,ignore
extern crate foo;

fn main() {
    foo::r#try();
}
```
