# Потоки

Rust предоставляет механизм для создания собственных потоков операционной системы через функцию `spawn`. Аргументом этой функции является замыкание, которое принимает владение захваченным ею окружением.

```rust,editable
use std::thread;

static NTHREADS: i32 = 10;

// This is the `main` thread
fn main() {
    // Make a vector to hold the children which are spawned.
    let mut children = vec![];

    for i in 0..NTHREADS {
        // Spin up another thread
        children.push(thread::spawn(move || {
            println!("this is thread number {}", i);
        }));
    }

    for child in children {
        // Wait for the thread to finish. Returns a result.
        let _ = child.join();
    }
}
```

Эти потоки будут запланированы ОС.
