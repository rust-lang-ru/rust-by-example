# Pipes

Структура `std::Child` представляет собой запущенный 
дочерний процесс и предоставляет дескрипторы `stdin`, 
`stdout` и `stderr` для взаимодействия с 
этим процессом через каналы (pipes).

```rust,ignore
use std::error::Error;
use std::io::prelude::*;
use std::process::{Command, Stdio};

static PANGRAM: &'static str =
"the quick brown fox jumped over the lazy dog\n";

fn main() {
    // Создадим команду `wc`
    let process = match Command::new("wc")
                                .stdin(Stdio::piped())
                                .stdout(Stdio::piped())
                                .spawn() {
        Err(why) => panic!("не удалось создать wc: {}", why.description()),
        Ok(process) => process,
    };

    // Запишем строку в `stdin` созданной команды.
    //
    // `stdin` имеет тип `Option<ChildStdin>`, но так как мы знаем, что экземпляр должен быть только один,
    // мы можем напрямую вызвать `unwrap`.
    match process.stdin.unwrap().write_all(PANGRAM.as_bytes()) {
        Err(why) => panic!("не удалось записать в stdin команды wc: {}",
                           why.description()),
        Ok(_) => println!("пангамма отправлена"),
    }

    // Так как `stdin` не существует после вышележащих вызовов, он разрушается
    // и канал закрывается.
    //
    // Это очень важно, иначе `wc` не начал бы обработку только что
    // отправленных данных.

    // Поле `stdout` имеет тип `Option<ChildStdout>` и может быть извлечено.
    let mut s = String::new();
    match process.stdout.unwrap().read_to_string(&mut s) {
        Err(why) => panic!("невозможно прочесть stdout команды wc: {}",
                           why.description()),
        Ok(_) => print!("wc ответил:\n{}", s),
    }
}
```
