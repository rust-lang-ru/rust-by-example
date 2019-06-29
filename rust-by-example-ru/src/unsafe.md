# Небезопасные операции

В качестве введениz в этот раздел процитируем [официальную документацию](https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html),
"нужно стараться минимизировать количество небезопасного кода в кодовой базе." Имея это в виду, давайте начнем! Небезопасные аннотации в Rust используются для обхода блокировок
защиты, устанавливаемых компилятором; в частности, существует четыре основных варианта использования небезопасного кода:

- dereferencing raw pointers
- вызов функций или методов, которые являются `unsafe` (включая вызов функциичерез FFI см. [предыдущую главу](std_misc/ffi.md) книги)
- доступ или изменение статических изменяемых переменных
- implementing unsafe traits

### Сырые указатели

Сырые указатели `*` и ссылки `&T` имеют схожую функциональность, но ссылки
всегда безопасны, потому что они гарантированно указывают на достоверные данные за счёт механизма проверки заимствований. Разыменование же сырого указателя можно выполнить только через небезопасный блок.

```rust,editable
fn main() {
    let raw_p: *const u32 = &10;

    unsafe {
        assert!(*raw_p == 10);
    }
}
```

### Вызов небезопасных функций

Некоторые функции могут быть объявлены как `unsafe`, то есть за корректность этого кода несёт ответственность программист, написавший его, вместо компилятора. Пример -
это метод [`std::slice::from_raw_parts`](https://doc.rust-lang.org/std/slice/fn.from_raw_parts.html), который создаст срез из указателя на первый элемент и длины.

```rust,editable
use std::slice;

fn main() {
    let some_vector = vec![1, 2, 3, 4];

    let pointer = some_vector.as_ptr();
    let length = some_vector.len();

    unsafe {
        let my_slice: &[u32] = slice::from_raw_parts(pointer, length);

        assert_eq!(some_vector.as_slice(), my_slice);
    }
}
```

For `slice::from_raw_parts`, one of the assumptions which *must* be upheld is
that the pointer passed in points to valid memory and that the memory pointed to
is of the correct type. If these invariants aren't upheld then the program's
behaviour is undefined and there is no knowing what will happen.
