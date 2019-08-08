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
    // All have type `Option<i32>`
    let number = Some(7);
    let letter: Option<i32> = None;
    let emoticon: Option<i32> = None;

    // The `if let` construct reads: "if `let` destructures `number` into
    // `Some(i)`, evaluate the block (`{}`).
    if let Some(i) = number {
        println!("Matched {:?}!", i);
    }

    // If you need to specify a failure, use an else:
    if let Some(i) = letter {
        println!("Matched {:?}!", i);
    } else {
        // Destructure failed. Change to the failure case.
        println!("Didn't match a number. Let's go with a letter!");
    }

    // Provide an altered failing condition.
    let i_like_letters = false;

    if let Some(i) = emoticon {
        println!("Matched {:?}!", i);
    // Destructure failed. Evaluate an `else if` condition to see if the
    // alternate failure branch should be taken:
    } else if i_like_letters {
        println!("Didn't match a number. Let's go with a letter!");
    } else {
        // The condition evaluated false. This branch is the default:
        println!("I don't like letters. Let's go with an emoticon :)!");
    }
}
```

Точно так же, `if let` может быть использован для сравнения любого значения перечисления:

```rust,editable
// Наш пример перечисления
enum Foo {
    Bar,
    Baz,
    Qux(u32)
}

fn main() {
    // Создание переменных примера
    let a = Foo::Bar;
    let b = Foo::Baz;
    let c = Foo::Qux(100);
    
    // Переменная a соответствует Foo::Bar
    if let Foo::Bar = a {
        println!("a is foobar");
    }
    
    // Переменная b не соответствует Foo::Bar
    // So this will print nothing
    if let Foo::Bar = b {
        println!("b is foobar");
    }
    
    // Переменная c соответствует Foo::Qux, которая имеет значение
    // аналогичное Some() как в предыдущем примере:
    if let Foo::Qux(value) = c {
        println!("c is {}", value);
    }
}
```

Другое преимущество: `if let` позволяет сопоставлять не параметризованные варианты перечисления, даже если перечисление не `#[derive(PartialEq)]`, и мы не имплементировали `PartialEq` для них. В некоторых случаях, классический `if Foo::Bar == a` не работает, потому что такие перечисления не могут быть равны. Однако, `if let` работает.

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
