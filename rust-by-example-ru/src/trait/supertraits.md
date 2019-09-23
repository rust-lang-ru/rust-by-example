# Супертрейты

В Rust нет "наследования", но вы можете объявить трейт, который 
будет надмножеством для другого. Например:

```rust,editable
trait Person {
    fn name(&self) -> String;
}

// `Student` - супертрейт для `Person`.
// Реализация `Student` требует, чтобы вы также реализовали и `Person`.
trait Student: Person {
    fn university(&self) -> String;
}

trait Programmer {
    fn fav_language(&self) -> String;
}

// `CompSciStudent` (студент факультета информацики) - супертрейт для `Programmer` 
// и `Student`. Реализация `CompSciStudent` требует реализации обоих подтрейтов.
trait CompSciStudent: Programmer + Student {
    fn git_username(&self) -> String;
}

fn comp_sci_student_greeting(student: &dyn CompSciStudent) -> String {
    format!(
        "Меня зовут {} и я посещаю {}. Моё имя в Git {}",
        student.name(),
        student.university(),
        student.git_username()
    )
}

fn main() {}
```

### Смотрите также:

[Глава "The Rust Programming Language" о супертрейтах](https://doc.rust-lang.org/book/ch19-03-advanced-traits.html#using-supertraits-to-require-one-traits-functionality-within-another-trait)
