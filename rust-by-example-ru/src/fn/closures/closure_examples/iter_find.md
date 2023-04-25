# Поиск через итераторы

`Iterator::find` - функция, которая перебирает значения итератора и ищет первое значение, удовлетворяющее условию. Если ни одно из значений не удовлетворяет условию, то возвращается `None`. Её сигнатура:

```rust,ignore
pub trait Iterator {
    // Тип, по которому выполняется итерирование.
    type Item;

    // `find` принимает `&mut self`, что означает, что вызывающий объект может быть заимствован
    // и изменён, но не поглощён.
    fn find<P>(&mut self, predicate: P) -> Option<Self::Item> where
        // `FnMut` означает, что любая захваченная переменная может максимум быть
        // изменена, но не поглощена. `&Self::Item`
        //казывает на то, что аргументы замыкания берутся по ссылке.
        P: FnMut(&Self::Item) -> bool;
}
```

```rust,editable
fn main() {
    let vec1 = vec![1, 2, 3];
    let vec2 = vec![4, 5, 6];

    // `iter()` для векторов выдаёт `&i32`.
    let mut iter = vec1.iter();
    // `into_iter()` для векторов выдаёт `i32`.
    let mut into_iter = vec2.into_iter();

    // `iter()` для векторов выдаёт `&i32`, а мы хотим ссылаться на один из его
    // элементов, поэтому нам нужно деструктурировать `&&i32` в `i32`
    println!("Найдём 2 в vec1: {:?}", iter     .find(|&&x| x == 2));
    // `into_iter()` для векторов выдаёт `i32`, а мы хотим ссылаться на один
    // из его элементов, поэтому нам нужно деструктурировать `&i32` в `i32`
    println!("Найдём 2 в vec2: {:?}", into_iter.find(| &x| x == 2));

    let array1 = [1, 2, 3];
    let array2 = [4, 5, 6];

    // `iter()` для массивов выдаёт `&i32`
    println!("Find 2 in array1: {:?}", array1.iter()     .find(|&&x| x == 2));
    // `into_iter()` для массивов выдаёт `i32`
    println!("Find 2 in array2: {:?}", array2.into_iter().find(|&x| x == 2));
}
```

`Iterator::find` даёт ссылку на элемент. Но если вы хотите получить его *индекс*, используйте `Iterator::position`.

```rust,editable
fn main() {
    let vec = vec![1, 9, 3, 3, 13, 2];

    // `iter()` для векторов выдаёт `&i32`, а `position()` не принимает ссылку, поэтому
    // мы должны деструктурировать `&i32` в `i32`
    let index_of_first_even_number = vec.iter().position(|&x| x % 2 == 0);
    assert_eq!(index_of_first_even_number, Some(5));
    
    // `into_iter()` для векторов выдаёт `i32`, а `position()` не принимает ссылку, поэтому
    // деструктуризация не требуется
    let index_of_first_negative_number = vec.into_iter().position(|x| x < 0);
    assert_eq!(index_of_first_negative_number, None);
}
```

### Смотрите также:

[`std::iter::Iterator::find`]

[`std::iter::Iterator::find_map`]

[`std::iter::Iterator::position`]

[`std::iter::Iterator::rposition`]


[`std::iter::Iterator::find`]: https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.find
[`std::iter::Iterator::find_map`]: https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.find_map
[`std::iter::Iterator::position`]: https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.position
[`std::iter::Iterator::rposition`]: https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.rposition