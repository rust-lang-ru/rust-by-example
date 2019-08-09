# if let

В некоторых случаях использование `match` выглядит неуклюже. Например:

```rust
// Создаём переменную `optional` типа `Option<i32>`
let optional = Some(7);

match optional {
    Some(i) => {
        println!("Это очень большая строка и `{:?}`", i);
        // ^ Нужно 2 отступа только для того, чтобы извлечь `i`
    },
    _ => {},
    // ^ Обязателен, так как `match` исчерпывающий. Не выглядит ли это
    // как потерянное пространство?
};

```

`if let` намного компактнее и выразительнее для данного случая и, кроме того, позволяет рассмотреть различные варианты ошибок.

```rust,editable
fn main() {
    // Все переменные типа `Option<i32>`
    let number = Some(7);
    let letter: Option<i32> = None;
    let emoticon: Option<i32> = None;

    // Конструкция `if let` читает, как: "Если `let` деструктуризирует `number` в
    // `Some(i)`, выполнить блок (`{}`).
    if let Some(i) = number {
        println!("Соответствует {:?}!", i);
    }

    // Если нужно указать, что делать, в случае ошибки, можно добавить else:
    if let Some(i) = letter {
        println!("Соответствует {:?}!", i);
    } else {
        // Ошибка деструктуризации. Переходим к обработке ошибки.
        println!("Не соответствует числу. Давайте попробуем строку!");
    }

    // Добавляем ещё одну ситуацию несоответствия образцу.
    let i_like_letters = false;

    if let Some(i) = emoticon {
        println!("Соответствует {:?}!", i);
    // Оцените условие `else if`, чтобы увидеть, 
    // должна ли быть альтернативная ветка отказа:
    } else if i_like_letters {
        println!("Не соответствует числу. Давайте попробуем строку!");
    } else {
        // Рассматриваем ложное условие. Эта ветвь по умолчанию:
        println!("Мне не нравится сравнивать строки. Давайте возьмём смайлик :)!");
    }
}
```

Точно так же, `if let` может быть использован для сравнения любого значения перечисления:

```rust,editable
// Our example enum
enum Foo {
    Bar,
    Baz,
    Qux(u32)
}

fn main() {
    // Create example variables
    let a = Foo::Bar;
    let b = Foo::Baz;
    let c = Foo::Qux(100);
    
    // Variable a matches Foo::Bar
    if let Foo::Bar = a {
        println!("a is foobar");
    }
    
    // Variable b does not match Foo::Bar
    // So this will print nothing
    if let Foo::Bar = b {
        println!("b is foobar");
    }
    
    // Variable c matches Foo::Qux which has a value
    // Similar to Some() in the previous example
    if let Foo::Qux(value) = c {
        println!("c is {}", value);
    }

    // Binding also works with `if let`
    if let Foo::Qux(value @ 100) = c {
        println!("c is one hundred");
    }
}
```

Другое преимущество: if let позволяет сопоставлять не параметризованные варианты перечисления, даже если перечисление не #[derive(PartialEq)], и мы не реализовали PartialEq для них. В некоторых случаях, классический if Foo::Bar == a не работает, потому что такие перечисления не могут быть равны. Однако, if let работает.

Хотите вызов? Исправьте следующий пример с использованием `if let `:

```rust,editable,ignore
// Для это перечисление намеренно не добавлен #[derive(PartialEq)],
// и мы не реализовывали для него PartialEq. Вот почему сравнение Foo::Bar==a терпит неудачу.
enum Foo {Bar}

fn main() {
    let a = Foo::Bar;

    // Переменная соответствует Foo::Bar
    if Foo::Bar == a {
    // ^-- это вызовет ошибку компиляции. Используйте `if let` вместо этого.
        println!("a is foobar");
    }
}
```

### Смотрите также:

[`enum`](../custom_types/enum.md), [`Option`](../std/option.md), и [RFC](https://github.com/rust-lang/rfcs/pull/160)
