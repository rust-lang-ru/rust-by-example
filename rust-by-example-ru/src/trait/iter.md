# Итераторы

Типаж [`Iterator`](https://doc.rust-lang.org/core/iter/trait.Iterator.html) используется для итерирования
по коллекциям, таким как массивы.

Типаж требует определить метод `next`, для получения следующего элемента.
Данный метод в блоке `impl` может быть определён
вручную или автоматически (как в массивах и диапазонах).

Для удобства использования, например в цикле `for`, некоторые коллекции
превращаются в итераторы с помощью метода [`.into_iterator()`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html).

```rust,editable
struct Fibonacci {
    curr: u32,
    next: u32,
}

// Реализация `Iterator` для `Fibonacci`.
// Для реализации типажа `Iterator` требуется реализовать метод `next`.
impl Iterator for Fibonacci {
    type Item = u32;
    
    // Здесь мы определяем последовательность, используя `.curr` и `.next`.
    // Возвращаем тип `Option<T>`:
    //     * Когда в `Iterator` больше нет значений, будет возвращено `None`.
    //     * В противном случае следующее значение оборачивается в `Some` и возвращается.
    fn next(&mut self) -> Option<u32> {
        let new_next = self.curr + self.next;

        self.curr = self.next;
        self.next = new_next;

        // Поскольку последовательность Фибоначчи бесконечна,
        // то `Iterator` никогда не вернет `None`, и всегда будет
        // возвращаться `Some`.
        Some(self.curr)
    }
}

// Возвращается генератор последовательности Фибоначчи.
fn fibonacci() -> Fibonacci {
    Fibonacci { curr: 0, next: 1 }
}

fn main() {
    // `0..3` это `Iterator`, который генерирует : 0, 1, и 2.
    let mut sequence = 0..3;

    println!("Четыре подряд вызова `next`на 0..3");
    println!("> {:?}", sequence.next());
    println!("> {:?}", sequence.next());
    println!("> {:?}", sequence.next());
    println!("> {:?}", sequence.next());

    // `for` работает через `Iterator` пока тот не вернет `None`.
    // каждое значение `Some` распаковывается  и привязывается к переменной (здесь это `i`).
    println!("Итерирование по 0..3 используя `for`");
    for i in 0..3 {
        println!("> {}", i);
    }

    // Метод `take(n)` уменьшает `Iterator` до его первых `n` членов.
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

    // Метод `iter` превращает `Iterator` в массив/срез.
    println!("Итерирование по массиву {:?}", &array);
    for i in array.iter() {
        println!("> {}", i);
    }
}
```
