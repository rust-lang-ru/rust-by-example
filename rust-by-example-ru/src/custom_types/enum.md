# Перечисления

Ключевое слово `enum` позволяет создавать тип данных,
который представляет собой один из нескольких возможных вариантов.
Любой вариант, действительный как `struct`, также действителен как `enum`.

```rust,editable
// Создаём `enum` для классификации web-событий. Обратите внимание
// как имена и информация о типе определяют вариант:
// `PageLoad != PageUnload` и `KeyPress(char) != Paste(String)`.
// Все они разные и независимые.
enum WebEvent {
    // `enum` может быть как `unit-подобным`,
    PageLoad,
    PageUnload,
    // так и кортежной структурой,
    KeyPress(char),
    Paste(String),
    // или c-подобной структурой.
    Click { x: i64, y: i64 },
}

// Функция, которая получает на вход `WebEvent` и ничего не возвращает.
fn inspect(event: WebEvent) {
    match event {
        WebEvent::PageLoad => println!("страница загружена"),
        WebEvent::PageUnload => println!("страница выгружена"),
        // Извлечём `c` из `enum`.
        WebEvent::KeyPress(c) => println!("нажата '{}'.", c),
        WebEvent::Paste(s) => println!("нажата \"{}\".", s),
        // Разберём `Click` на `x` и `y`.
        WebEvent::Click { x, y } => {
            println!("кликнуто на x={}, y={}.", x, y);
        },
    }
}

fn main() {
    let pressed = WebEvent::KeyPress('x');
    // `to_owned()` создаст `String` из строкового среза.
    let pasted  = WebEvent::Paste("мой текст".to_owned());
    let click   = WebEvent::Click { x: 20, y: 80 };
    let load    = WebEvent::PageLoad;
    let unload  = WebEvent::PageUnload;

    inspect(pressed);
    inspect(pasted);
    inspect(click);
    inspect(load);
    inspect(unload);
}
```

## Псевдонимы типов

Если вы используете псевдонимы типов, то вы можете обратиться к 
каждому варианту перечисления через его псевдоним. Это может 
быть полезно если перечисление имеет слишком длинное имя или 
слишком много обобщений и вы хотите переименовать его.

```rust,editable
enum VeryVerboseEnumOfThingsToDoWithNumbers {
    Add,
    Subtract,
}

// Создаётся псевдоним типа
type Operations = VeryVerboseEnumOfThingsToDoWithNumbers;

fn main() {
    // Мы можем обратиться в каждому варианту перечисления через его 
    // псевдоним, а не через его длиное неудобное имя.
    let x = Operations::Add;
}
```

Наиболее частое место, где вы можете это увидеть, это `impl`-блоки, которые используют `Self`.

```rust,editable
enum VeryVerboseEnumOfThingsToDoWithNumbers {
    Add,
    Subtract,
}

impl VeryVerboseEnumOfThingsToDoWithNumbers {
    fn run(&self, x: i32, y: i32) -> i32 {
        match self {
            Self::Add => x + y,
            Self::Subtract => x - y,
        }
    }
}
```

Чтобы больше узнать о перечислениях и псевдонимах типов, вы 
можете почитать [отчёт о стабилизации](https://github.com/rust-lang/rust/pull/61682/#issuecomment-502472847), в котором эта 
возможность была включена в Rust.

### Смотрите также:

[`match`](../flow_control/match.md), [`fn`](../fn.md), [`String`](../std/str.md) и ["Type alias enum variants" RFC](https://rust-lang.github.io/rfcs/2338-type-alias-enum-variants.html)
