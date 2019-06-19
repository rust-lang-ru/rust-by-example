# Функции высшего порядка

Rust предоставляет Функций Высшего Порядка(ФВП). Это функций которые берут один или
больше функций и производит более полезные функций.
ФВП и ленивые итераторы дают языку Rust функциональную особенность.

```rust,editable
fn is_odd(n: u32) -> bool {
    n % 2 == 1
}

fn main() {
    println!("Найти сумму всех квадратов нечётных числ не больше 1000");
    let upper = 1000;

    // Императивный подход
    // Объявляем переменную накопитель
    let mut acc = 0;
    // Итерировать: 0, 1, 2, ... до бесконечности
    for n in 0.. {
        // Квадрат числа
        let n_squared = n * n;

        if n_squared >= upper {
            // Остановить цикл, если превысили верхний лимит
            break;
        } else if is_odd(n_squared) {
            // Складывать число, если оно нечётное
            acc += n_squared;
        }
    }
    println!("imperative style: {}", acc);

    // Функциональный подход
    let sum_of_squared_odd_numbers: u32 =
        (0..).map(|n| n * n)             // Все натуральные числа в квадрате
             .take_while(|&n| n < upper) // Ниже верхнего предела
             .filter(|n| is_odd(*n))     // Это нечётные
             .fold(0, |sum, i| sum + i); // Суммируем
    println!("functional style: {}", sum_of_squared_odd_numbers);
}
```

[Option][option]
и
[Iterator][iter]
реализуют свою часть функций высшего порядка..

[option]: https://doc.rust-lang.org/core/option/enum.Option.html
[iter]: https://doc.rust-lang.org/core/iter/trait.Iterator.html
