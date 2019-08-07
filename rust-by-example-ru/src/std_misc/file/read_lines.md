# `read_lines`

Метод `lines()` возвращает итератор, проходящий через
все строки файла.

`File::open` работает с чем-то, что реализует типаж `AsRef<Path>`. Поэтому `read_lines()` будет ожидать это же.

```rust,no_run
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn main() {
    // Файл `hosts` должен существовать в текущей директории
    if let Ok(lines) = read_lines("./hosts") {
        // Получает итератор, который возвращает Option
        for line in lines {
            if let Ok(ip) = line {
                println!("{}", ip);
            }      
        }   
    }
}

// Для обработки ошибок, возвращаемое значение оборачивается в Result
// Возвращаем `Iterator` для построчного чтения файла.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}
```

Запуск этой программы просто выводит эти строки на экран по
отдельности.

```shell
$ echo -e "127.0.0.1\n192.168.0.1\n" > hosts
$ rustc read_lines.rs && ./read_lines
127.0.0.1
192.168.0.1
```

Такой подход более эффективен, чем создание `String` в памяти, особенно при работе с большими файлами.
