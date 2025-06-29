+++
title = "Emacs & macOS & 한글"
author = ["ysk"]
date = 2025-06-29T10:41:00+09:00
tags = ["emacs"]
draft = false
+++

## 문제 {#문제}

Windows에 비하면 macOS에서 emacs를 사용하는데는 거의 문제가 없다고 생각한다. 요즘은 거의 문서/노트 작성할 때만 사용하다 보니 더욱 더 그럴지도 모르겠다. 예전에는 emacs로 모든 것을 해겠다고 이것 저것 설정들을 직접 해보기도 했지만, 지금은 그냥 [doomeamcs](https://github.com/doomemacs/doomemacs) + [org](https://orgmode.org/) + [denote](https://protesilaos.com/emacs/denote) 로 엄청 만족하고 있다.

하지만 처음부터 그래왔고 지금도 신경쓰이는 것은 한글 이슈 그 중 폰트와 입력기의 문제였다.

텍스트 에디터 특성상 가변 폰트보다는 고정 폰트가 가독성이 좋다 생각하는데, 고정 폰트를 사용하더라도 한글과 영문자, 심볼들이 같이 쓰이는 경우 각 문자가 동일 간격으로 보이지 않아 테이블이나 코드의 세로 정렬이 제대로 되지 않는 문제가 있다. 유명한 프로그래밍 고정폭 폰트들에는 한글 글리프가 포함되어 있지 않다보니(아마도?) emacs가 한글을 다른 폰트로 대체하여 영문자와 동일한 고정 사이즈로 출력되지 않는 것으로 생각된다.

emacs에서는 특정 문자 범위에 따라 폰트 스타일을 다르게 지정할 수 있어, 이 방법도 사용해 봤는데 자연스럽지 않았다. 한글과 영어 개별 문자가 차지하는 공간 크기가 서로 달라 서로 다른 폰트 스케일을 지정해야 했는데, 확대/축소 시 그대로 유지되지 않은 문제가 있고, 한글이 영문자 2자의 공간을 차지하게 만들려고 스케일을 키우다 보니 섞여 있을때 한글이 좀 바보 같아 보인다.

입력기의 문제도 아주 번거로운데 emacs가 자체 입력기를 구현하다 보니 서로 다른 입력 모드일 때 단축키가 제대로 동작하지 않고 글자 입력도 이상해지는 문제가 있다. 둘을 맞추려면 입력 변환부터 동기화 해야 하는데, 시스템의 한영 변환 단축키가 emacs 까지 입력으로 들어가지 않아 여기부터 불가능 하다. 이건 macOS의 문제로 Windows 나 Linux 에서는 어떤지 잘 모르겠다.

그러다 보니 emacs에서 한영 전환 단축키를 시스템과 다르게 설정해야 하고, 매번 포커스가 emacs로 들어갈 때 마다 한영 상태를 확인해야 하는 번거로움이 있을수 밖에 없었다.

이렇게 10년 이상을 꾸역 꾸역 사용해 왔는데, 최근 (아마도 24년 하반기, 이 글은 한참 후에 쓰는거라) 드디어 방법을 찾아낸거 같다.


## 폰트 {#폰트}

[Sarasa Gothic Mono](https://picaq.github.io/sarasa/)가 지금까지의 답이다. Sarasa 폰트는 [Iosevka](http://be5invis.github.io/Iosevka) 폰트를 기반으로 CJK 그리프를 추가한 폰트로 알고 있다. Iosevka 폰트는 다른 폰트들에 비해 좁은폭 폰트인데, 한글은 보통 영문자 2개 간격이라 한글과 같이 사용하기에 잘 어울린다. 일반 넓은 폰트들은 한글과 같이 사용하려면 폭을 맞추기 위해 한글이 렌더링될 때 크기를 키워야 하는 문제가 있는데 이 폰트는 그럴 필요가 없어 아주 자연스럽다.

doomemacs에서의 설정은 아래와 같이 간결하다.

```emacs-lisp
(setq doom-font (font-spec :family "Sarasa Mono K" :size 13 :weight 'medium))
```


## 입력기 {#입력기}

시스템 입력기 전환 단축키 입력을 emacs에서 받지 못하는 문제는 [hammerspoon](https://www.hammerspoon.org/)을 이용해 해결하였다. 한영전환키를 입력 받았을 때 활성 애플리케이션이 emacs이면 시스템은 무시하고 emacs로 `C-\` 키 입력을 전달하도록 설정 하였다. 또한 [InputSourceSwitch](https://www.hammerspoon.org/Spoons/InputSourceSwitch.html) spoon 으로 emacs 전환 시 항상 영문 키보드로 전환하도록 설정하였다.

hammerspoon init.lua 파일은 [gist](https://gist.github.com/suguni/d7a4c9ac25b25aa962cf0145e5cb6d0b)와 같다.


### 이슈 {#이슈}

사용전 Privacy &amp; Security -&gt; Input Monitoring 에 Hammersppon 을 추가해야 eventtap 이벤트를 정상적으로 받을 수 있는 것으로 보인다.
[여기](https://www.reddit.com/r/hammerspoon/comments/13ac1ya/hammerspoon_script_randomly_stops_working/)에 따르면 갑자기 동작하지 않는 경우가 생기는데 local 변수가 GC 에 의해 수거되어 사라지는 현상일꺼라는 얘기가 있다. 일단은 전역 변수로 수정하고 문제 없이 잘 사용하고 있는데 정확한 해결책인지는 확실치 않다.


### 참고 {#참고}

-   [macOS에서 한영전환키를 Emacs에서도 사용하기 (Hammerspoon)](https://seorenn.github.io/article/macos-emacs-korean-inputmethod-hotkey-hammerspoon.html), 먹통이 되어 다른 방법을 찾고 있다고 하는데, 위 이슈 외에는 특별한 문제 없이 잘 사용하고 있다. 감사!
-   [InputSourceSwitch spoon](https://www.hammerspoon.org/Spoons/InputSourceSwitch.html)
