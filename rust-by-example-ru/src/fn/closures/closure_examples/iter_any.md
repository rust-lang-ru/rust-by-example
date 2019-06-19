# Iterator::any

`Iterator::any` - это функция, которая принимает итератор и возвращает `true`,
если любой элемент удовлетворяет предикату. Иначе возвращает `false`. Её
объявление:

```rust,ignore
pub trait Iterator {
    // Тип, по которому выполняется итерирование
    type Item;

    // `any` принимает `&mut self`, что означает заимствование
    // и изменение, но не поглощение `self`.
    fn any<F>(&mut self, f: F) -> bool where
        // `FnMut` означает, что любая захваченная переменная
        // может быть изменена, но не поглощена. `Self::Item`
        // указывает на захват аргументов замыкания по значению.
        F: FnMut(Self::Item) -> bool {}
}
```

```rust,editable
fn main() {
    let vec1 = vec![1, 2, 3];
    let vec2 = vec![4, 5, 6];

    // `iter()` для векторов даёт `&i32`. Приводим к `i32`.
    println!("2 в vec1: {}", vec1.iter()     .any(|&x| x == 2));
    // `into_iter()` для векторов даёт `i32`. Приведения не требуется.
    println!("2 в vec2: {}", vec2.into_iter().any(| x| x == 2));

    let array1 = [1, 2, 3];
    let array2 = [4, 5, 6];

    // `iter()` для массивов даёт `&i32`.
    println!("2 в array1: {}", array1.iter()     .any(|&x| x == 2));
    // `into_iter()` для массивов неожиданно даёт `&i32`.
    println!("2 в array2: {}", array2.into_iter().any(|&x| x == 2));
}
```

### Смотрите также:

[`std::iter::Iterator::any`][any]

[any]: https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.any
