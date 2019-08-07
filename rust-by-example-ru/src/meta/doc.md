# Документация

Используйте `cargo doc` для сборки документации в 
`target/doc`.

Используйте `cargo test` для запуска всех тестов 
(включая документационные тесты) и `cargo test --doc` 
для запуска только документационных тестов.

Эти команды, по мере необходимости, будут соответствующим 
образом вызывать `rustdoc` (и `rustc`).

### Документационные комментарии

Документационные комментарии очень полезны для больших 
проектов, требующих документирования. Эти комментарии 
компилируются в документацию при запуске `rustdoc`. Они 
обозначаются как `///` и поддерживают 
[Markdown](https://en.wikipedia.org/wiki/Markdown).

```rust,editable,ignore
#![crate_name = "doc"]

/// Эта структура представляет человека
pub struct Person {
    /// Человек должен иметь имя вне зависимости от того, на сколько Джульетта его ненавидит
    name: String,
}

impl Person {
    /// Возвращает человека с данным ему именем
    ///
    /// # Аргументы
    ///
    /// * `name` - Срез строки, содержащий имя человека
    ///
    /// # Прмер
    ///
    /// ```
    /// // Мы можете писать код на Rust внутри комментариев.
    /// // Если вы передадите `--test` в `rustdoc`, то он проверит его!
    /// use doc::Person;
    /// let person = Person::new("name");
    /// ```
    pub fn new(name: &str) -> Person {
        Person {
            name: name.to_string(),
        }
    }

    /// Дружественное приветствие!
    ///
    /// Говорит "Привет, [name]" для `Person` у которого он вызывается.
    pub fn hello(& self) {
        println!("Привет, {}!", self.name);
    }
}

fn main() {
    let john = Person::new("John");

    john.hello();
}
```

Для запуска тестов сначала соберите код как библиотеку, а затем 
скажите `rustdoc` где найти эту библиотеку, чтобы он мог 
подключить её к каждому документационному тесту:

```shell
$ rustc doc.rs --crate-type lib
$ rustdoc --test --extern doc="libdoc.rlib" doc.rs
```

### Смотрите также:

- [The Rust Book: Making Useful Documentation Comments](https://doc.rust-lang.org/book/ch14-02-publishing-to-crates-io.html#making-useful-documentation-comments)
- [The Rustdoc Book](https://doc.rust-lang.org/rustdoc/index.html)
- [The Reference: Doc comments](https://doc.rust-lang.org/stable/reference/comments.html#doc-comments)
- [RFC 1574: API Documentation Conventions](https://rust-lang.github.io/rfcs/1574-more-api-documentation-conventions.html#appendix-a-full-conventions-text)
- [RFC 1946: Relative links to other items from doc comments (intra-rustdoc links)](https://rust-lang.github.io/rfcs/1946-intra-rustdoc-links.html)
- [Is there any documentation style guide for comments? (reddit)](https://www.reddit.com/r/rust/comments/ahb50s/is_there_any_documentation_style_guide_for/)
