# Приведение типов

Приведение типов в Rust осуществляется с помощью [типажей].
В общем, при приведении к типу используются [`From`] и [`Into`],
но есть и более специфические типажи для часто используемых
случаев, например, для конвертации в `String` и обратно.

[типажей]: trait.html
[`From`]: https://doc.rust-lang.org/std/convert/trait.From.html
[`Into`]: https://doc.rust-lang.org/std/convert/trait.Into.html
