# `ref` паттерн

Когда мы используем сопоставление с образцом или 
деструктурируем при помощи `let`, можно 
использовать ключевое слово `ref` для получения 
ссылки на поле структуры или кортежа. Пример ниже показывает 
несколько случаев, когда это может быть полезно:

```rust,editable
#[derive(Clone, Copy)]
struct Point { x: i32, y: i32 }

fn main() {
    let c = 'Q';

    // Заимствование с `ref` по левую сторону от присваивания, эквивалетно
    // заимствованию с `&` по правую сторону.
    let ref ref_c1 = c;
    let ref_c2 = &c;

    println!("ref_c1 равно ref_c2: {}", *ref_c1 == *ref_c2);

    let point = Point { x: 0, y: 0 };

    // `ref` также может использоваться при деструктуризации структур.
    let _copy_of_x = {
        // `ref_to_x` - ссылка на поле `x` в `point`.
        let Point { x: ref ref_to_x, y: _ } = point;

        // Возвращаем копию поля `x` из `point`.
        *ref_to_x
    };

    // Изменяемая копия `point`
    let mut mutable_point = point;

    {
        // `ref` может использоваться вместе с `mut` для получения изменяемой ссылки.
        let Point { x: _, y: ref mut mut_ref_to_y } = mutable_point;

        // Изменяем поле `y` переменной `mutable_point` через изменяемую ссылку.
        *mut_ref_to_y = 1;
    }

    println!("point ({}, {})", point.x, point.y);
    println!("mutable_point ({}, {})", mutable_point.x, mutable_point.y);

    // Изменяемый кортеж с указателем
    let mut mutable_tuple = (Box::new(5u32), 3u32);
    
    {
        // Деструктурируем `mutable_tuple` чтобы изменить значение `last`.
        let (_, ref mut last) = mutable_tuple;
        *last = 2u32;
    }
    
    println!("tuple {:?}", mutable_tuple);
}
```
