# Path

The `Path` struct represents file paths in the underlying filesystem. There are
two flavors of `Path`: `posix::Path`, for UNIX-like systems, and
`windows::Path`, for Windows. The prelude exports the appropriate
platform-specific `Path` variant.

`Path` может быть создан из `OsStr`, и 
предоставляет некоторые методы для получения информации о 
файле или директории, на которые он указывает.

Обратите внимание, что внутренне представление 
`Path` *не является* UTF-8 строкой, но вместо 
этого хранит вектор байт (`Vec<u8>`). 
Следовательно, преобразование `Path` в 
`&str` *не* бесплатно и может закончиться 
неудачей (возвращается `Option`).

```rust,editable
use std::path::Path;

fn main() {
    // Создаём `Path` из `&'static str`
    let path = Path::new(".");

    // Метод `display` возвращает показываемую структуру
    let _display = path.display();

    // `join` соединяет `path` с байтовым контейнером, используя ОС-специфичный
    // разделитель, и возвращает новый путь
    let new_path = path.join("a").join("b");

    // Конвертируем путь в строковый срез
    match new_path.to_str() {
        None => panic!("новый путь не является действительной UTF-8 последовательностью"),
        Some(s) => println!("новый путь {}", s),
    }
}

```

Не забудьте проверить остальные методы `Path`
(`posix::Path` или `windows::Path`) и
структуры `Metadata`.

### Смотрите также:

[OsStr](https://doc.rust-lang.org/std/ffi/struct.OsStr.html) и [Metadata](https://doc.rust-lang.org/std/fs/struct.Metadata.html).
