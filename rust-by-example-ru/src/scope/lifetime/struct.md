# Структуры

Аннотирование времени жизни в структурах аналогично функциям:

```rust,editable
// Тип `Borrowed`, в котором находится ссылка на `i32`.
// Ссылка на `i32` должна пережить `Borrowed`.
#[derive(Debug)]
struct Borrowed<'a>(&'a i32);

// Аналогично, обе ссылки расположенные здесь, должны пережить эту структуру.
#[derive(Debug)]
struct NamedBorrowed<'a> {
    x: &'a i32,
    y: &'a i32,
}

// Перечисление, которое указывает на `i32` или на ссылку.
#[derive(Debug)]
enum Either<'a> {
    Num(i32),
    Ref(&'a i32),
}

fn main() {
    let x = 18;
    let y = 15;

    let single = Borrowed(&x);
    let double = NamedBorrowed { x: &x, y: &y };
    let reference = Either::Ref(&x);
    let number = Either::Num(y);

    println!("x заимствован в {:?}", single);
    println!("x и y заимствованы в {:?}", double);
    println!("x заимствован в {:?}", reference);
    println!("y *не* заимствован в {:?}", number);
}
```

### Смотрите также:

[`Структуры`][structs]


[structs]: custom_types/structs.html
