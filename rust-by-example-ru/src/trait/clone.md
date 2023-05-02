# Типаж Clone

При работе с ресурсами, стандартным поведением является передача их (ресурсов) в ходе выполнения или вызов функции. Однако, иногда нам нужно также объявить копию ресурса.

Типаж [`Clone`] помогает нам сделать именно это. Чаще всего, мы можем использовать метод `.clone()` объявленный типажом `Clone`.

```rust,editable
// Единичная структура без ресурсов
#[derive(Debug, Clone, Copy)]
struct Unit;

// Кортежная структура с ресурсами, которая реализует типаж `Clone`
#[derive(Clone, Debug)]
struct Pair(Box<i32>, Box<i32>);

fn main() {
    // Создадим экземпляр `Unit`
    let unit = Unit;
    // Скопируем `Unit`, который не имеет ресурсов для перемещения
    let copied_unit = unit;

    // Оба `Unit` могут быть использованы независимо
    println!("original: {:?}", unit);
    println!("copy: {:?}", copied_unit);

    // Создадим экземпляр `Pair`
    let pair = Pair(Box::new(1), Box::new(2));
    println!("original: {:?}", pair);

    // Переместим `pair` в `moved_pair`, перемещая и ресурсы
    let moved_pair = pair;
    println!("moved: {:?}", moved_pair);

    // Ошибка! Переменная `pair` потеряла свои ресурсы
    //println!("original: {:?}", pair);
    // ЗАДАНИЕ ^ Попробуйте раскомментировать эту строку

    // Клонируем `moved_pair` в `cloned_pair` (включая ресурсы)
    let cloned_pair = moved_pair.clone();
    // Удалим исходную пару, используя std::mem::drop
    drop(moved_pair);

    // Ошибка! `moved_pair` была удалена
    //println!("copy: {:?}", moved_pair);
    // ЗАДАНИЕ ^ Попробуйте раскомментировать эту строку

    // Результат, полученный из .clone(), все ещё можно использовать!
    println!("clone: {:?}", cloned_pair);
}
```


[`Clone`]: https://doc.rust-lang.org/std/clone/trait.Clone.html