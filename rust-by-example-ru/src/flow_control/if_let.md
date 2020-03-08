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
    
    // Переменная `a` соответствует `Foo::Bar`
    if let Foo::Bar = a {
        println!("a = Foo::Bar");
    }
    
    // Переменная `b` не соответствует `Foo::Bar`.
    // Поэтому ничего не выведется на экран
    if let Foo::Bar = b {
        println!("b = Foo::Bar");
    }
    
    // Переменная `c` соответствует `Foo::Qux`, которая имеет значение
    // аналогичное `Some()` как в предыдущем примере:
    if let Foo::Qux(value) = c {
        println!("c ={}", value);
    }

    // С `if let` также работает и привязка
    if let Foo::Qux(value @ 100) = c {
        println!("c = 100");
    }
}
```

Another benefit is that `if let` allows us to match non-parameterized enum variants. This is true even in cases where the enum doesn't implement or derive `PartialEq`. In such cases `if Foo::Bar == a` would fail to compile, because instances of the enum cannot be equated, however `if let` will continue to work.

Хотите вызов? Исправьте следующий пример с использованием `if let `:

```rust,editable,ignore,mdbook-runnable
// This enum purposely neither implements nor derives PartialEq.
// That is why comparing Foo::Bar == a fails below.
enum Foo {Bar}

fn main() {
    let a = Foo::Bar;

    // Variable a matches Foo::Bar
    if Foo::Bar == a {
    // ^-- this causes a compile-time error. Use `if let` instead.
        println!("a is foobar");
    }
}
```

### Смотрите также:

[`enum`](../custom_types/enum.md), [`Option`](../std/option.md), и [RFC](https://github.com/rust-lang/rfcs/pull/160)
