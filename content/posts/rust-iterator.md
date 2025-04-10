+++
title = "Iterator, IntoIterator, Iter, IterMut, IntoIter, iter, iter_mut, into_iter"
author = ["Steve Yu"]
date = 2022-10-05
tags = ["rust"]
categories = ["programming"]
draft = true
+++

처음 rust 를 배우기 시작 했을때 Iterator 는 다른 언어들에서도 쉽게 봐왔던거라 어렵지 않게 넘어갔었는데, 이후 여러 코드를 보면 볼수록 정확히 모르고 있구나 라고 생각되던 상황에 [Rust Stream: Iterators](https://www.youtube.com/watch?v=lQt0adYPdfQ&t=4158s) 동영상을 보고 나름 개념정리가 된 듯 하여 글로 작성해 둔다.

Iterator trait 은 잘 알려진 반복자 디자인 패턴의 그 iterator 이다. Iterator trait 에는 아주 많은 함수가 있는데, 필수 구현해야 하는 함수는 fn next(&amp;mut self) -&gt; Option&lt;Item&gt; 하나이다. Option 타입을 반환하니 has_next() 같은 함수가 필요 없다.

Vec&lt;T&gt;는 Iterator trait 를 직접 구현하지 않는다. Iterator 를 구현하려면 현재 위치라는 상태를 가지고 있어야 하는데, trait 의 impl 에서 별도의 상태를 가질 수 없고, 그렇다고 Vec&lt;T&gt; 가 Iterator 를 위해 상태를 가질수도 없기 때문이다.

그래서 Iterator를 구현하는 별도의 타입이 존재하는데, Vec&lt;T&gt; 의 경우 Iter&lt;'a, T&gt;, IterMut&lt;'a, T&gt;, IntoIter&lt;T&gt; 3가지 이다. 이름에서 알 수 있듯이 Iter는 immutable, IterMut 는 mutable, IntoIter는 move 의 semantic 을 가지는 Iterator 이다. Iter 와 IterMut 는 대상 collection 을 레퍼런스로 가지고 있어 generic lifetime 변수를 명시해야 한다.

Vec&lt;T&gt; 에는 fn iter(&amp;self), fn iter_mut(&amp;mut self) 함수가 있는데 각각 Iter, IterMut 를 반환하는 함수들이다. 이 함수들 외에도 IntoIterator trait 의 into_iter() 함수로부터 위 iterator 들을 만들 수 있는데, 어떤 타입을 구현하는가에 따라 다른 iterator 를 만들게 된다. Vec 의 경우 &amp;'a Vec&lt;T&gt;를 구현한 IntoIterator는 Iter를 &amp;'a mut Vec&lt;T&gt; 를 구현한 IntoIterator는 IterMut를, 마지막으로 Vec&lt;T&gt;를 구현한 IntoIterator 는 IntoIter를 만들어 낸다. IntoIter 는 IntoIterator trait 의 구현 함수로부터만 얻어낼 수 있다.

Vec의 iter() 함수 말고도 IntoIterator trait 이 존재하는 이유는, 컴파일러가 이 trait 을 구현한 타입의 변수를 for loop 문법에서 그냥 사용할 수 있게 해 주기 때문이다. Java 의 for in 문장에서 Iterable 을 구현한 객체를 바로 사용 할 수 있는 것과 동일한 것으로 이해된다.

아래 코드에서 values는 Vec&lt;i32&gt; 타입이고 Iterator 가 아니지만 IntoIterator 를 구현하고 있으므로 for 에서 values.iter() 로 Iterator 를 얻지 않고도 바로 사용할 수 있다. 아래 코드는 for x in values.into_iter() 로 해석할 수 있다. 단, 여기서는 IntoIter iterator가 만들어지고, x는 i32 타입이다. 그리고 move 되었으므로 for 이후에는 values 를 사용할 수 없게 된다.

```rust
let values = vec![1, 2, 3];
for x in values {
    println!("{x}");
}
```

move 가 아닌 borrow 를 하려면, 즉 Iter iterator를 얻으려면 아래와 같이 values의 레퍼런스를 명시하면 되고, 이 경우 x 는 &amp;i32 타입이 된다.

```rust
let values = vec![1, 2, 3];
for x in &values {
    println!("{x}");
}
println!("{}", values[0]); // OK
```

이 정도면 Iterator, IntoIterator, Iter, IterMut, IntoIter, iter, iter_mut, into_iter 등에 대한 개념은 잡히지만, 알아야 할 것들은 충분히 더 있다.
