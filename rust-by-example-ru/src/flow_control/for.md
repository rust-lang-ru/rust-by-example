# Цикл for

## `for` и диапазоны

Конструкция `for in` может быть использована для итерации по `Итераторам (Iterator)`.
Один из самых простых способов создать итератор это использовать
диапазон значений `a..b`. Это вернёт нам значения от `a` (включительно) до `b`
(исключительно) за один шаг.

Давайте напишем FizzBuzz, используя `for` вместо `while`.

```rust,editable
fn main() {
    // `n` будет принимать значения: 1, 2, ..., 100 с каждой итерации
    for n in 1..101 {
        if n % 15 == 0 {
            println!("fizzbuzz");
        } else if n % 3 == 0 {
            println!("fizz");
        } else if n % 5 == 0 {
            println!("buzz");
        } else {
            println!("{}", n);
        }
    }
}
```

Alternatively, `a..=b` can be used for a range that is inclusive on both ends.
The above can be written as:

```rust,editable
fn main() {
    // `n` будет принимать значения: 1, 2, ..., 100 с каждой итерации
    for n in 1..=100 {
        if n % 15 == 0 {
            println!("fizzbuzz");
        } else if n % 3 == 0 {
            println!("fizz");
        } else if n % 5 == 0 {
            println!("buzz");
        } else {
            println!("{}", n);
        }
    }
}
```

## `for` и итераторы

Конструкция `for in` может взаимодействовать с  `Iterator` разными способами. 
Как обсуждается далее про [типаж `Iterator`](../trait/iter.md), цикл 
`for` применяет к предоставленной коллекции метод 
`into_iter`, чтобы преобразовать её в итератор. 
Это не единственный способ преобразования коллекции в 
итератор, также существуют другие функции: `iter` и 
`iter_mut`.

Эти 3 функции вернут разные отображения данных в вашей 
коллекции.

- `iter` - This borrows each element of the collection through each iteration.Thus leaving the collection untouched and available for reuse after the loop.

```rust,
fn main() {
    let names = vec!["Bob", "Frank", "Ferris"];

    for name in names.iter() {
        match name {
            &"Ferris" => println!("There is a rustacean among us!"),
            _ => println!("Hello {}", name),
        }
    }
}
```

- `into_iter` - эта функция потребляет коллекцию так что на каждой итерации предоставляются данные.Коллекция больше не доступна для использования так как владение ею перешло в эту функцию.

```rust,
fn main() {
    let names = vec!["Bob", "Frank", "Ferris"];

    for name in names.into_iter() {
        match name {
            "Ferris" => println!("There is a rustacean among us!"),
            _ => println!("Hello {}", name),
        }
    }
}
```

- `iter_mut` - эта функция делает изменяемое заимствование каждого элемента коллекции, позволяя изменять коллекцию на месте.

```rust,
fn main() {
    let mut names = vec!["Bob", "Frank", "Ferris"];

    for name in names.iter_mut() {
        match name {
            &mut "Ferris" => println!("There is a rustacean among us!"),
            _ => println!("Hello {}", name),
        }
    }
}
```

In the above snippets note the type of `match` branch, that is the key
difference in the types or iteration. The difference in type then of course
implies differing actions that are able to be performed.

### Смотрите также:

[Итераторы (Iterator)](../trait/iter.md)
