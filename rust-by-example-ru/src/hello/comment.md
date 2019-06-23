# Комментарии

Каждая программа, безусловно, нуждается в комментариях и
Rust предоставляет несколько способов комментирования кода:

- *Обычные комментарии*, которые игнорируются компилятором:
    - `// Однострочный комментарий. Который завершается в конце строки.`
    - `/* Блочный комментарий, который продолжается до завершающего символа. */`
- *Doc комментарии*, которые будут сгенерированы в HTML[документацию](../meta/doc.md):
    - `/// Генерация документации для функции.`
    - `//! Генерация документации для модуля.`

```rust,editable
fn main() {
    // This is an example of a line comment
    // There are two slashes at the beginning of the line
    // And nothing written inside these will be read by the compiler

    // println!("Hello, world!");

    // Run it. See? Now try deleting the two slashes, and run it again.

    /* 
     * This is another type of comment, a block comment. In general,
     * line comments are the recommended comment style. But
     * block comments are extremely useful for temporarily disabling
     * chunks of code. /* Block comments can be /* nested, */ */
     * so it takes only a few keystrokes to comment out everything
     * in this main() function. /*/*/* Try it yourself! */*/*/
     */

    /*
    Note: The previous column of `*` was entirely for style. There's
    no actual need for it.
    */

    // You can manipulate expressions more easily with block comments
    // than with line comments. Try deleting the comment delimiters
    // to change the result:
    let x = 5 + /* 90 + */ 5;
    println!("Is `x` 10 or 100? x = {}", x);
}

```

### Смотрите также:

[Документирование библиотек](../meta/doc.md)
