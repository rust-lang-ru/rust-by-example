# С-подобные

`enum` могут быть использованы как C-подобные перечисления.

```rust,editable
// Атрибут, который убирает предупреждения компилятора
// о неиспользуемом коде
#![allow(dead_code)]

// enum с неявным дискриминатором (начинается с 0)
enum Number {
    Zero,
    One,
    Two,
}

// enum с явным дискриминатором
enum Color {
    Red = 0xff0000,
    Green = 0x00ff00,
    Blue = 0x0000ff,
}

fn main() {
    // `enums` может быть преобразован в целочисленное значение.
    println!("нулевой элемент {}", Number::Zero as i32);
    println!("первый элемент {}", Number::One as i32);

    println!("красный цвет #{:06x}", Color::Red as i32);
    println!("голубой цвет #{:06x}", Color::Blue as i32);
}
```

### Смотрите также:

[приведение типа](../../types/cast.md)
