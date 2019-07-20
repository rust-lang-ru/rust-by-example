# Функции высшего порядка

Rust предоставляет Функции Высшего Порядка (ФВП). Это функции,
которые получают на вход одну или больше функций и
производят более полезные функции.
ФВП и ленивые итераторы дают языку Rust функциональный вид.

```rust,editable
fn is_odd(n: u32) -> bool {
    n % 2 == 1
}

fn main() {
    println!("Найти сумму всех квадратов нечётных чисел не больше 1000");
    let upper = 1000;

    // Императивный подход
    // Объявляем переменную-накопитель
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
    println!("императивный стиль: {}", acc);

    // Функциональный подход
    let sum_of_squared_odd_numbers: u32 =
        (0..).map(|n| n * n)             // Все натуральные числа возводим в квадрат
             .take_while(|&n| n < upper) // Ниже верхнего предела
             .filter(|n| is_odd(*n))     // Выбираем нечётные
             .fold(0, |sum, i| sum + i); // Суммируем
    println!("функциональный стиль: {}", sum_of_squared_odd_numbers);
}
```

[Option](https://doc.rust-lang.org/core/option/enum.Option.html)
и
[Iterator](https://doc.rust-lang.org/core/iter/trait.Iterator.html)
реализуют свою часть функций высшего порядка..
