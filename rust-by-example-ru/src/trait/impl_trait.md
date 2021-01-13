# `impl Trait`

Если ваша функция возвращает тип, реализующий `MyTrait`, вы можете записать возвращаемый тип как `-> impl MyTrait`. Это может достаточно сильно упростить сигнатуру вашей функции!

```rust,editable
use std::iter;
use std::vec::IntoIter;

// Эта функция объединяет два `Vec<i32>` и возвращает итератор.
// Посмотрите какой получается сложный тип возвращаемого значения!
fn combine_vecs_explicit_return_type(
    v: Vec<i32>,
    u: Vec<i32>,
) -> iter::Cycle<iter::Chain<IntoIter<i32>, IntoIter<i32>>> {
    v.into_iter().chain(u.into_iter()).cycle()
}

// Это та же самая функция, но в возвращаемом типе использует нотацию `impl Trait`.
// Посмотрите как он упростился!
fn combine_vecs(
    v: Vec<i32>,
    u: Vec<i32>,
) -> impl Iterator<Item=i32> {
    v.into_iter().chain(u.into_iter()).cycle()
}

fn main() {
    let v1 = vec![1, 2, 3];
    let v2 = vec![4, 5];
    let mut v3 = combine_vecs(v1, v2);
    assert_eq!(Some(1), v3.next());
    assert_eq!(Some(2), v3.next());
    assert_eq!(Some(3), v3.next());
    assert_eq!(Some(4), v3.next());
    assert_eq!(Some(5), v3.next());
    println!("готово");
}
```

Что более важно, некоторые типы в Rust не могут быть записаны. Например, каждое замыкание имеет свой собственный безымянный тип. До появления синтаксиса `impl Trait`, чтобы вернуть замыкание, вы должны были аллоцировать её в куче. Но теперь вы можете сделать это всё статически, например так:

```rust,editable
// Вернём функцию, которая добавляет `y` ко входному значению
fn make_adder_function(y: i32) -> impl Fn(i32) -> i32 {
    let closure = move |x: i32| { x + y };
    closure
}

fn main() {
    let plus_one = make_adder_function(1);
    assert_eq!(plus_one(2), 3);
}
```

Вы также можете использовать `impl Trait` для возврата итератора, который использует замыкания `map` или `filter`! Это упрощает использование `map` и `filter`. Из-за того, что замыкание не имеет имени, вы не можете явно записать возвращаемый тип для функции, возвращающей итератор с замыканием. Но с `impl Trait` вы можете сделать это:

```rust,editable
fn double_positives<'a>(numbers: &'a Vec<i32>) -> impl Iterator<Item = i32> + 'a {
    numbers
        .iter()
        .filter(|x| x > &&0)
        .map(|x| x * 2)
}
```
