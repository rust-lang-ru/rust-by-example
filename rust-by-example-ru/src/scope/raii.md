# RAII

Переменные в Rust не только держат данные в стеке, они также могут *владеть*
ресурсами; к примеру, `Box<T>` владеет памятью в куче. Поскольку Rust строго
придерживается идиоме [RAII](https://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization), то когда объект выходит за зону видимости, вызывается
его деструктор, а ресурс, которым он *владеет* освобождается.

Такое поведение защищает от багов, связанных с *утечкой ресурсов.*
Вам больше никогда не потребуется вручную освобождать память или же беспокоиться
об её утечках! Небольшой пример:

```rust,editable
// raii.rs
fn create_box() {
    // Выделить память для целого число в куче
    let _box1 = Box::new(3i32);

    // `_box1` здесь уничтожается, а память освобождается
}

fn main() {
    // Выделить память для целого числа в куче
    let _box2 = Box::new(5i32);

    // Вложенная область видимости:
    {
        // Выделить память для ещё одного целого числа в куче
        let _box3 = Box::new(4i32);

        // `_box3` здесь уничтожается, а память освобождается
    }

    // Создаём большое количество упаковок. Просто потому что можем.
    // Здесь нет необходимости освобождать память вручную!
    for _ in 0u32..1_000 {
        create_box();
    }

    // `_box2` здесь уничтожается, а память освобождается
}
```

Конечно, мы можем убедиться, что в нашей программе нет ошибок с памятью,
используя [`valgrind`](http://valgrind.org/info/):

```bash
$ rustc raii.rs && valgrind ./raii
==26873== Memcheck, a memory error detector
==26873== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
==26873== Using Valgrind-3.9.0 and LibVEX; rerun with -h for copyright info
==26873== Command: ./raii
==26873==
==26873==
==26873== HEAP SUMMARY:
==26873==     in use at exit: 0 bytes in 0 blocks
==26873==   total heap usage: 1,013 allocs, 1,013 frees, 8,696 bytes allocated
==26873==
==26873== All heap blocks were freed -- no leaks are possible
==26873==
==26873== For counts of detected and suppressed errors, rerun with: -v
==26873== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 2 from 2)
```

Утечки отсутствуют!

## Деструктор

Понятие деструктора в Rust обеспечивается через типаж [`Drop`](https://doc.rust-lang.org/std/ops/trait.Drop.html).
Деструктор вызывается, когда ресурс выходит за пределы области видимости.
Этот типаж не требуется реализовать для каждого типа.
Реализовать его для вашего типа вам потребуется, только если
требуется своя логика при удалении экземпляра типа.

Выполните пример ниже, чтобы увидеть, как работает типаж [`Drop`](https://doc.rust-lang.org/std/ops/trait.Drop.html). Когда переменная в функции `main` выходит за пределы области действия,
будет вызван пользовательский деструктор.

```rust,editable
struct ToDrop;

impl Drop for ToDrop {
    fn drop(&mut self) {
        println!("ToDrop is being dropped");
    }
}

fn main() {
    let x = ToDrop;
    println!("Made a ToDrop!");
}
```

### Смотрите также:

[Упаковка](../std/box.md)
