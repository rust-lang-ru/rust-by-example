# Iterator::find

`Iterator::find` - это функция, которая принимает итератор и возвращает первый
элемент, который удовлетворяет предикату, в виде `Option`. Её объявление:

```rust,ignore
pub trait Iterator {
    // Тип, по которому выполняется итерирование
    type Item;

    // `find` принимает `&mut self`, что означает заимствование и
    // изменение, но не поглощение `self`.
    fn find<P>(&mut self, predicate: P) -> Option<Self::Item> where
        // `FnMut` означает, что любая захваченная переменная
        // может быть изменена, но не поглощена. `&Self::Item`
        // указывает на захват аргументов замыкания по ссылке.
        P: FnMut(&Self::Item) -> bool {}
}
```

```rust,editable
fn main() {
    let vec1 = vec![1, 2, 3];
    let vec2 = vec![4, 5, 6];

    // `iter()` для векторов даёт `&i32`.
    let mut iter = vec1.iter();
    // `into_iter()` для векторов даёт `i32`.
    let mut into_iter = vec2.into_iter();

    // Ссылка на это даёт `&&i32`. Приводим к `i32`.
    println!("Найти 2 в vec1: {:?}", iter     .find(|&&x| x == 2));
    // Ссылка на это даёт `&i32`. Приводим к `i32`.
    println!("Найти 2 в vec2: {:?}", into_iter.find(| &x| x == 2));

    let array1 = [1, 2, 3];
    let array2 = [4, 5, 6];

    // `iter()` для массивов даёт `&i32`
    println!("Найти 2 в array1: {:?}", array1.iter()     .find(|&&x| x == 2));
    // `into_iter()` для массивов неожиданно даёт `&i32`
    println!("Найти 2 в array2: {:?}", array2.into_iter().find(|&&x| x == 2));
}
```

### Смотрите также:

[`std::iter::Iterator::find`][find]

[find]: https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.find
