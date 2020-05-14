# `open`

Статический метод `open` может использоваться для открытия файла в режиме только для чтения.

Структура `File` владеет ресурсом, файловым дескриптором, и заботится о том, чтобы он был закрыт, когда структура удаляется из памяти.

```rust,editable,ignore
use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

fn main() {
    // Создадим "путь" к нужному файлу
    let path = Path::new("hello.txt");
    let display = path.display();

    // Откроем "путь" в режиме "только чтение". Возвращается `io::Result<File>`
    let mut file = match File::open(&path) {
        Err(why) => panic!("невозможно открыть {}: {}", display, why),
        Ok(file) => file,
    };

    // Читаем содержимое файла в строку. Метод возвращает `io::Result<usize>`
    let mut s = String::new();
    match file.read_to_string(&mut s) {
        Err(why) => panic!("невозможно прочесть {}: {}", display, why),
        Ok(_) => print!("{} содержит:\n{}", display, s),
    }

    // `file` выходит из области видимости и файл "hello.txt" закрывается
}
```

Вот ожидаемый результат:

```shell
$ echo "Hello World!" > hello.txt
$ rustc open.rs && ./open
hello.txt содержит:
Hello World!
```

(Рекомендуем протестировать предыдущий пример при различных  условиях сбоев: файл` hello.tx`t не существует или`  hello.t`xt не читаемый и другое)
