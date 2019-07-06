# Ожидание

Если вы хотите дождаться завершения `process::Child`, вы должны вызвать `Child::wait`, который вернёт `process::ExitStatus`.

```rust,ignore
use std::process::Command;

fn main() {
    let mut child = Command::new("sleep").arg("5").spawn().unwrap();
    let _result = child.wait().unwrap();

    println!("достигнут конец функции main");
}
```

```bash
$ rustc wait.rs && ./wait
# `wait` продолжает работать в течение 5 секунд, пока команда `sleep 5` не завершится
достигнут конец функции main
```
