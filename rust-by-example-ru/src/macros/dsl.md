# Domain Specific Languages (DSLs)

A DSL is a mini "language" embedded in a Rust macro. It is completely valid
Rust because the macro system expands into normal Rust constructs, but it looks
like a small language. This allows you to define concise or intuitive syntax for
some special functionality (within bounds).

Предположим, я хочу определить небольшое API для калькулятора. 
Я хотел бы предоставить выражение и вывести результат в консоль.

```rust,editable
macro_rules! calculate {
    (eval $e:expr) => {{
        {
            let val: usize = $e; // Заставим быть переменную целым числом.
            println!("{} = {}", stringify!{$e}, val);
        }
    }};
}

fn main() {
    calculate! {
        eval 1 + 2 // хе-хе, `eval` _не_ ключевое слово Rust!
    }

    calculate! {
        eval (1 + 2) * (3 / 4)
    }
}
```

Вывод:

```txt
1 + 2 = 3
(1 + 2) * (3 / 4) = 0
```

Это очень простой пример, но можно разработать и гораздо более 
сложные интерфейсы, такие как [`lazy_static`](https://crates.io/crates/lazy_static) 
или [`clap`](https://crates.io/crates/clap).

Также обратите внимание на две пары скобок в макросе. Внешняя 
пара является частью синтаксиса `macro_rules!`, в 
дополнение к `()` или `[]`.