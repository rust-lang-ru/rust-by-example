# Итераторы

Типаж [`Iterator`] используется для итерирования по коллекциям, таким как массивы.

Типаж требует определить метод `next`, для получения следующего элемента. Данный метод в блоке `impl` может быть определён вручную или автоматически (как в массивах и диапазонах).

Для удобства использования, например в цикле `for`, некоторые коллекции превращаются в итераторы с помощью метода [`.into_iterator()`].

```rust,editable
struct Fibonacci {
    curr: u32,
    next: u32,
}

// Реализуем `Iterator` для `Fibonacci`.
// Для реализации типажа `Iterator` требуется реализовать только метод `next.
impl Iterator for Fibonacci {
    // Мы можем ссылаться на этот тип, используя Self::Item
    type Item = u32;

    // Здесь мы определяем последовательность, используя `.curr` и `.next`.
    // Возвращаем тип `Option`:
    //     * WКогда в `Iterator` больше нет значений, будет возвращено `None`.
    //     * В противном случае следующее значение оборачивается в `Some` и возвращается.
    // Мы используем Self::Item в указании возвращаемого типа, поэтому мы можем изменить
    // тип, не меняя сигнатуры функций.
    fn next(&mut self) -> Option<Self::Item> {
        let current = self.curr;

        self.curr = self.next;
        self.next = current + self.next;

        // Поскольку последовательность Фибоначчи бесконечна, `Iterator`
        // никогда не вернёт `None`, всегда возвращая `Some`.
        Some(current)
    }
}

// Возвращает генератор последовательности Фибоначчи.
fn fibonacci() -> Fibonacci {
    Fibonacci { curr: 0, next: 1 }
}

fn main() {
    // `0..3` это `Iterator`, который генерирует : 0, 1, и 2.
    let mut sequence = 0..3;

    println!("Четыре последовательных вызова `next` на 0..3");
    println!("> {:?}", sequence.next());
    println!("> {:?}", sequence.next());
    println!("> {:?}", sequence.next());
    println!("> {:?}", sequence.next());

    // `for` продолжает работу, пока `Iterator` не вернёт `None`.
    // Каждое значение `Some` распаковывается и привязывается к переменной (здесь это `i`).
    println!("Итерирование по 0..3 используя `for`");
    for i in 0..3 {
        println!("> {}", i);
    }

    // The `take(n)` Метод `take(n)` ограничивает `Iterator` до его первых `n` членов.
    println!("Первые четыре члена последовательности Фибоначчи: ");
    for i in fibonacci().take(4) {
        println!("> {}", i);
    }

    // Метод `skip(n)` сокращает `Iterator`, отбрасывая его первые `n` членов.
    println!("Следующие четыре члена последовательности Фибоначчи: ");
    for i in fibonacci().skip(4).take(4) {
        println!("> {}", i);
    }

    let array = [1u32, 3, 3, 7];

    // Метод `iter` выдаёт `Iterator` для массива или среза.
    println!("Итерирование по массиву {:?}", &array);
    for i in array.iter() {
        println!("> {}", i);
    }
}
```


[`.into_iterator()`]: https://doc.rust-lang.org/std/iter/trait.IntoIterator.html
[`Iterator`]: https://doc.rust-lang.org/core/iter/trait.Iterator.html