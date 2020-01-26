# Rust на примерах

[![Build Status](https://travis-ci.org/rust-lang-ru/rust-by-example.svg?branch=master)](https://travis-ci.org/rust-lang-ru/rust-by-example)
[![gitlocalized ](https://gitlocalize.com/repo/2509/ru/badge.svg)](https://gitlocalize.com/repo/2509/ru?utm_source=badge)

Здесь находится перевод книги "Rust by example".

В rust-by-example лежит оригинал, в rust-by-example-ru - перевод.
И оригинал, и перевод синхронизируются вручную (ибо пока что тест, в
дальнейшем возможно подключение GitLocalize к основному репозиторию
с переводом).

Если хотите поучаствовать в переводе, welcome! Для этого нужно зарегистрироваться
в [GitLocalize](https://gitlocalize.com) и перейти в [проект перевода](https://gitlocalize.com/repo/2509).

Отдельное спасибо @suhr и @AKhranovskiy. Перевод основан на их работе.

## Для чего нужен GitLocalize?

Для отслеживания изменений в оригинале и поддержании структуры перевода.
GitLocalize индексирует оригинал и все переводы. При изменении абзаца
оригинала, GitLocalize помечает соответствующий абзац в переводах для проверки.

## Использование

Для сборки локальной копии книги Вам нужно [установить компилятор Rust][install Rust]
и выполнить следующие команды:

```bash
$ git clone https://github.com/rust-lang-ru/rust-by-example
$ cd rust-by-example/rust-by-example-ru
$ cargo install mdbook
$ mdbook build
$ mdbook serve
```

[install Rust]: https://www.rust-lang.org/ru-RU/install.html

Для запуска примеров, приведённых в книге, Вам необходимо подключение к сети интернет;
Однако вы можете читать все содержимое без подключения к сети интернет (автономно)!

## Лицензия

`Rust на примерах` распространяется по двойной лицензии - лицензия Apache 2.0 и лицензия MIT.
Более подробную информацию можно найти в файлах LICENSE-APACHE и LICENSE-MIT соответственно.

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or
   http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or
   http://opensource.org/licenses/MIT)

Если вы явно не указываете иное, любой вклад преднамеренно представлен
для включения в `Rust на примерах`, как определено в лицензии Apache-2.0, необходима
двойная лицензия, как указано выше, без каких-либо дополнительных условий.
