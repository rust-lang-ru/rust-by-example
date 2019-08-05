# `create`

Статический метод `create` открывает файл в режиме 
только для записи. Если файл уже существует, то его содержимое 
уничтожится, в противном же случае, создастся новый файл.

```rust,ignore
static LOREM_IPSUM: &str =
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
";

use std::error::Error;
use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

fn main() {
    let path = Path::new("out/lorem_ipsum.txt");
    let display = path.display();

    // Откроем файл в режиме для записи. Возвращается `io::Result<File>`
    let mut file = match File::create(&path) {
        Err(why) => panic!("невозможно создать {}: {}", display, why.description()),
        Ok(file) => file,
    };

    // Запишем строку `LOREM_IPSUM` в `file`. Возвращается `io::Result<()>`
    match file.write_all(LOREM_IPSUM.as_bytes()) {
        Err(why) => panic!("невозможно записать в {}: {}", display, why.description()),
        Ok(_) => println!("успешно записано в {}", display),
    }
}
```

Вот расширенный ожидаемый результат:

```shell
$ mkdir out
$ rustc create.rs && ./create
успешно записано в out/lorem_ipsum.txt
$ cat out/lorem_ipsum.txt
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
```

(Как и в предыдущем примере, предлагаем вам протестировать этот 
код с различными вариантами отказа.)

Существует структура [`OpenOptions`](https://doc.rust-lang.org/std/fs/struct.OpenOptions.html), которая 
может использоваться для настройки того, как файл будет открыт.
