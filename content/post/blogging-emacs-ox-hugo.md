+++
title = "blogging, emacs, ox-hugo, hugo"
author = ["Steve Yu"]
publishDate = 2021-10-23T21:00:00+09:00
tags = ["emacs", "hugo"]
draft = false
+++

블로깅을 시작하겠다고 hugo 셋팅하고 간단하게 github 에다 테스트 같은 포스트 하나 올려놓고 방치해 놨는데 이제 진짜 해보려 한다.

일단 설정부터. 블로깅 환경은 hugo, emacs, ox-hugo, github page 이다.

emacs 에서 org 로 포스트 작성하고 hugo markdown 파일로 변환, publish 한 후 github page 로 push.

hugo - github 는 잘 알려진 내용이니 ox-hugo - hugo 부분만 정리한다.


## 왜 ox-hugo 를 써야 할까? {#왜-ox-hugo-를-써야-할까}

ox-hugo 는 org 문서를 hugo 에 최적화된 markdown 문서로 변환해 주는 org exporter 이다.

hugo 에서 org 문서 형식을 지원 하는데도 ox-hugo 를 사용해야 하는 이유가 궁금했는데 <https://zzamboni.org/post/my-blogging-setup-with-emacs-org-mode-ox-hugo-hugo-gitlab-and-netlify/> 글을 보고 조금은 이해가 되었다. 가장 큰 이유는 org full support 여부이고, 두 번째는 좀 더 org 문서 스타일로 사용할 수 있다는 점이다.

원래 hugo는 [go-org](https://github.com/niklasfasching/go-org) 를 내장하고 있어 org 문서를 지원한다고는 하지만, go 로 구현된 변환기라 org 문서의 모든 형식을 완전히 지원하지 못한다.


## 컨텐츠 작성 {#컨텐츠-작성}

org 문서들은 별도의 저장소로 저장하고 있어 해당 디렉토리 아래에 hugo 라는 디렉토리를 만들고 여기에서 hugo 로 발행할 컨텐츠들을 작성한다.

ox-hugo 는 단일 org 파일을 md 파일로 변환할수도 있고, 하나의 org 문서 내 하위 섹션을 md 파일로도 변환할 수 있는데, 후자의 방법을 권장한다. 포스트 작성 시 hugo 컨텐츠의 front matter 에 해당하는 설정을 org 문서 내에 해 줘야 하는데, 후자의 방법을 사용하면 부모 섹션의 설정을 하위 섹션에서 그대로 상속받게 되어 동일한 설정을 여러번 반복해서 작성할 필요가 없다.

실제 사용 사례는 [Real World Examples](https://ox-hugo.scripter.co/doc/examples/) 을 참고한다.


## 사용법 {#사용법}

minor mode 인 `org-hugo-auto-export-mode` 를 사용하면 org 파일을 저장할 때마다 front matter 의 설정에 따라 md 파일로 저장되다. `hugo server` 실행하고 페이지 열어두면 저장할 때마다 자동으로 반영되는것을 확인할 수 있다.


## 참고 {#참고}

-   <https://gohugo.io>
-   <https://ox-hugo.scripter.co/>
-   <https://zzamboni.org/post/my-blogging-setup-with-emacs-org-mode-ox-hugo-hugo-gitlab-and-netlify/>
