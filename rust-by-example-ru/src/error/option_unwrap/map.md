# Комбинаторы: `map`

`match` - возможный метод для работы с `Option`.
Однако постоянное его использование может быть утомительным, 
особенно с операциями, которые получают только проверенные 
данные.
В этом случае можно использовать [комбинаторы](https://doc.rust-lang.org/book/glossary.html#combinators), которые 
позволяют управлять потоком выполнения в модульном режиме.

`Option` имеет встроенный метод, зовущийся `map()`, комбинатор для простого преобразования `Some -> Some` и `None -> None`. Для большей гибкости, несколько вызовов `map()` могут быть связаны друг с другом в цепочку.

В следующем примере, `process()` заменяет все предшествующие ей функции, оставаясь, при этом, компактной:

```rust,editable
#![allow(dead_code)]

#[derive(Debug)] enum Food { Apple, Carrot, Potato }

#[derive(Debug)] struct Peeled(Food);
#[derive(Debug)] struct Chopped(Food);
#[derive(Debug)] struct Cooked(Food);

// Очистка продуктов. Если продуктов нет, то возвращаем `None`.
// Иначе вернём очищенные продукты.
fn peel(food: Option<Food>) -> Option<Peeled> {
    match food {
        Some(food) => Some(Peeled(food)),
        None       => None,
    }
}

// Нарезка продуктов. Если продуктов нет, то возвращаем `None`.
// Иначе вернём нарезанные продукты.
fn chop(peeled: Option<Peeled>) -> Option<Chopped> {
    match peeled {
        Some(Peeled(food)) => Some(Chopped(food)),
        None               => None,
    }
}

// Приготовление еды. Здесь, для обработки вариантов, мы используем 
// `map()` вместо `match`.
fn cook(chopped: Option<Chopped>) -> Option<Cooked> {
    chopped.map(|Chopped(food)| Cooked(food))
}

// Функция для последовательной очистки, нарезке и приготовлении продуктов.
// Мы объединили в цепочку несколько вызовов `map()` для упрощения кода.
fn process(food: Option<Food>) -> Option<Cooked> {
    food.map(|f| Peeled(f))
        .map(|Peeled(f)| Chopped(f))
        .map(|Chopped(f)| Cooked(f))
}

// Проверим, есть ли еда, прежде чем её съесть
fn eat(food: Option<Cooked>) {
    match food {
        Some(food) => println!("Ммм. Я люблю {:?}", food),
        None       => println!("О, нет! Это не съедобно."),
    }
}

fn main() {
    let apple = Some(Food::Apple);
    let carrot = Some(Food::Carrot);
    let potato = None;

    let cooked_apple = cook(chop(peel(apple)));
    let cooked_carrot = cook(chop(peel(carrot)));
    // Давайте сейчас попробуем проще выглядящую `process()`.
    let cooked_potato = process(potato);

    eat(cooked_apple);
    eat(cooked_carrot);
    eat(cooked_potato);
}
```

### Смотрите также:

[Замыкания](../../fn/closures.md), [`Option`](https://doc.rust-lang.org/std/option/enum.Option.html), [`Option::map()`](https://doc.rust-lang.org/std/option/enum.Option.html#method.map)
