# Каналы

Rust предоставляет асинхронные каналы (`channel`) для 
взаимодействия между потоками. Каналы обеспечивают 
однонаправленную передачу информации между двумя конечными 
точками: отправителем (`Sender`) и получателем 
(`Receiver`).

```rust,editable
use std::sync::mpsc::{Sender, Receiver};
use std::sync::mpsc;
use std::thread;

static NTHREADS: i32 = 3;

fn main() {
    // Каналы имеют две конечные точки: Sender<T>` и `Receiver<T>`,
    // где `T` - тип передаваемового сообщения.
    // (аннотации типов избыточны)
    let (tx, rx): (Sender<i32>, Receiver<i32>) = mpsc::channel();
    let mut children = Vec::new();

    for id in 0..NTHREADS {
        // Отправитель может быть скопирован
        let thread_tx = tx.clone();

        // Каждый поток отправит через канал его id
        let child = thread::spawn(move || {
            // Поток забирает владение `thread_tx`
            // Каждый поток добавляет своё сообщение в очередь канала
            thread_tx.send(id).unwrap();

            // Отправка - не блокирующая операция, поток незамедлительно
            // продолжит работу после отправки сообщения
            println!("поток {} завершён", id);
        });

        children.push(child);
    }

    // Здесь все сообщения собираются
    let mut ids = Vec::with_capacity(NTHREADS as usize);
    for _ in 0..NTHREADS {
        // Метод `recv` "достаёт" сообщения из канала
        // `recv` блокирует текущий поток, если доступных сообщений нет
        ids.push(rx.recv());
    }
    
    // Ожидаем, когда потоки завершат всю оставшуюся работу
    for child in children {
        child.join().expect("Упс! Дочерний поток паникует");
    }

    // Посмотрите порядок, с которым сообщения были отправлeны
    println!("{:?}", ids);
}
```
