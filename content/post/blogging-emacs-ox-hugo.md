+++
title = "blogging, emacs, ox-hugo, hugo, github"
author = ["Steve Yu"]
publishDate = 2021-10-23T21:00:00+09:00
tags = ["emacs", "hugo"]
draft = false
+++

블로깅을 시작하겠다고 hugo 셋팅하고 간단하게 github 에다 테스트 같은 포스트 하나 올려놓고 방치해 놨었는데 이제 진짜 해보려 한다. 블로깅 환경은 hugo, emacs, ox-hugo, github page 이다. 흐름은 emacs 에서 org 문서 형태로 포스트 작성하고 ox-hugo 를 이용해 hugo markdown 파일로 변환한 후, 미리 작성된 스크립트로 publish 하게 된다. hugo - github 연동은 잘 알려진 내용이니 ox-hugo - hugo 부분만 간단히 정리한다.


## github action {#github-action}

<span class="timestamp-wrapper"><span class="timestamp">[2022-05-01 Sun] </span></span> 추가

최근에 JAMstack 이라는 용어가 눈에 띄어 찾아 보다 여기가 생각나서 github action 으로 편하게 사용할 수 있는 방법이 있음을 알게 되었다.

<https://gohugo.io/hosting-and-deployment/hosting-on-github/> 참고. github action 설정 파일만 추가하면 된다.

github page 저장소와 소스 저장소가 분리되어 있어 정리하는 과정이 있긴 했지만, 큰 수고 없이 좀 더 편하게 deploy 할 수 있게 되었다.

이전에 분리했던 이유는 아마도 퍼블리쉬 전 소스를 private 으로 관리하고자 하는 의도였을거 같은데 딱히 그럴 필요도 없고 실제로도 private 도 아니었다.


## 왜 ox-hugo 를 써야 할까? {#왜-ox-hugo-를-써야-할까}

ox-hugo 는 org 문서를 hugo 에 최적화된 markdown 문서로 변환해 주는 org exporter 이다. hugo 에서 org 문서 형식을 지원 하는데도 ox-hugo 를 사용해야 하는 이유가 궁금했는데 [이 글](https://zzamboni.org/post/my-blogging-setup-with-emacs-org-mode-ox-hugo-hugo-gitlab-and-netlify/)을 보고 조금은 이해가 되었다. 가장 큰 이유는 org full support 여부이고, 두 번째는 좀 더 org 문서 스타일로 사용할 수 있다는 점이다. 원래 hugo는 [go-org](https://github.com/niklasfasching/go-org) 를 내장하고 있어 org 문서를 지원한다고는 하지만, go 로 구현된 변환기라 org 문서의 모든 형식을 완전히 지원하지 못한다.


## 내용 작성 {#내용-작성}

org 문서에 `HUGO_BASE_DIR`, `HUGO_SECTION` 속성을 지정해야 하는데, 이 속성값에 따라 md 파일이 생성된다. 본 블로그는 hugo 사이트 디렉토리 아래에 org 디렉토리를 두고 base dir 을 `..` 로 설정하였다.

ox-hugo 는 단일 org 파일을 md 파일로 변환할수도 있고, 하나의 org 문서 내 하위 섹션을 md 파일로도 변환할 수 있는데, 후자의 방법을 권장한다. 포스트 작성 시 hugo 컨텐츠의 front matter 에 해당하는 설정을 org 문서 내에 해 줘야 하는데, 후자의 방법을 사용하면 부모 섹션의 설정을 하위 섹션에서 그대로 상속받게 되어 동일한 설정을 여러번 반복해서 작성할 필요가 없다.

실제 사용 사례는 [Real World Examples](https://ox-hugo.scripter.co/doc/examples/) 을 참고한다.


## 사용법 {#사용법}

minor mode 인 `org-hugo-auto-export-mode` 를 사용하면 org 파일을 저장할 때마다 front matter 의 설정에 따라 md 파일로 저장되다. `hugo server` 실행하고 페이지 열어두면 저장할 때마다 자동으로 반영되는것을 확인할 수 있다.


## 참고 {#참고}

-   <https://gohugo.io>
-   <https://ox-hugo.scripter.co/>
-   <https://zzamboni.org/post/my-blogging-setup-with-emacs-org-mode-ox-hugo-hugo-gitlab-and-netlify/>
