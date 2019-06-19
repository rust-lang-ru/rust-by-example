# Утверждения where

Ограничение типажа также может быть выражено с помощью утверждения `where`
непосредственно перед открытием `{`, а не при первом упоминании типа.
Кроме того, утверждения `where` могут применять ограничения типажей к 
произвольным типам, а не только к параметрам типа.

В некоторых случаях утверждение `where` является полезным:

* При указании обобщённых типов и ограничений типажей отдельно,
код становится более ясным:

```rust,ignore
impl <A: TraitB + TraitC, D: TraitE + TraitF> MyTrait<A, D> for YourType {}

// Выражение ограничений типажей через утверждение `where`
impl <A, D> MyTrait<A, D> for YourType where
    A: TraitB + TraitC,
    D: TraitE + TraitF {}
```

* Использование утверждения `where` более выразительно, чем использование
обычного синтаксиса. В этом примере `impl` не может быть непосредственно
выражен без утверждения `where`:

```rust,editable
use std::fmt::Debug;

trait PrintInOption {
    fn print_in_option(self);
}

// Потому что в противном случае мы должны были бы выразить это как
// `T: Debug` или использовать другой метод косвенного подхода,
// для этого требуется утверждение `where`:
impl<T> PrintInOption for T where
    Option<T>: Debug {
    // Мы хотим использовать `Option<T>: Debug` как наше ограничение
    // типажа, потому то это то, что будет напечатано. В противном случае
    // использовалось бы неправильное ограничение типажа.
    fn print_in_option(self) {
        println!("{:?}", Some(self));
    }
}

fn main() {
    let vec = vec![1, 2, 3];

    vec.print_in_option();
}
```

### Смотрите также:

[RFC][where], [`структуры`][struct], и [`типажи`][trait]

[struct]: custom_types/structs.html
[trait]: trait.html
[where]: https://github.com/rust-lang/rfcs/blob/master/text/0135-where.md
