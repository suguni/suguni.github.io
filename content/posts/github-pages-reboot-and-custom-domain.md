+++
title = "GitHub pages reboot 그리고 custom domain"
author = ["ysk"]
date = 2025-04-06T09:23:00+09:00
tags = ["tool"]
draft = false
+++

## 진행 {#진행}

갑자기 도메인 `dec22.kr` 을 구매하게 되었고, 일단은 GitHub pages 에 연결해야 겠다는 생각에 설정을 시작하였다.

Cafe24 에서 구매했는데, 특별히 좋아서라기 보다는 GoDaddy 는 가격이 살짝 비싸면서 국내 카드로 결제가 안되어 패스, 가비아는 예전 아이디가 정지되어 로그인도 안되는데 동일 아이디로는 계정을 못만든다고 해서 패스.

전반적인 Github pages 설정은 [문서](https://docs.github.com/ko/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)를 참고하였다.

먼저 Cafe24 에서 A 레코드 지정한다. 문서에 `A 레코드를 만들도록 apex 도메인을 GitHub Pages에 대한 IP 주소로 지정합니다.` 라고 되어 있어 dec22.kr 을 github page IP 로 연결하는 것으로 이해된다. 문서에는 4개가 있지만 cafe24 에서는 dec22.kr 는 하나만 연결할 수 있고, 추가 하려면 서브 도메인을 입력해야 한다. 비워두거나 `@` 를 입력할 수 없어, 일단 첫번째 IP 로 연결한다. 당장은 문제가 없다.

기존에 만들어 둔 github pages 저장소가 있어, 해당 저장소 설정에서 custom domain 을 dec22.kr 로 등록하고 `Enfoce HTTPS` 까지 체크한다. Custom domain 입력하고 save 눌러도 바로 `Enfoce HTTPS` 를 체크할 수 없었는데, 조금 기다리고 페이지 다시 열기를 몇 번 하다 보면 체크할 수 있었다.

마지막으로 page 를 publish 하고 브라우저에서 <https://dec22.kr> 열면 나의 GitHub page 가 열린다.

페이지는 hugo 를 이용해 만들었는데, 오랜만에 열고 빌드하려니 에러가 발생한다. 어떻게 고쳐야 할지 모르겠어서 content 디렉토리만 두고 다 정리한 다음에 [Quick Start](https://gohugo.io/getting-started/quick-start/) 부터 다시 했다. 그리고 [Host on GitHub Pages](https://gohugo.io/host-and-deploy/host-on-github-pages/) 내용 보고 GitHub action workflow 도 다시 설정했다.


## 삽질들 {#삽질들}


### https &amp; 인증서 {#https-and-인증서}

https 로 연결하려고 SSL 인증서를 구매했다. _GitHub pages 로만 연결하려면 인증서 구매할 필요 없다._  GitHub 에서 "Let's Encrypt" 를 통해 별도 인증서 없이도 HTTPS 를 사용할 수 있게 해 준다. 내가 구매한 인증서는 등록할 수 도 없다.


### 404 {#404}

도메인을 변경하면 페이지 접속이 안되는데 (`404`), 페이지에는  `Your site is live at https://dec22.kr/` 라고 되어 있더라도 _항상 새로 페이지를 publish 해야_ 한다.


### `Certificate Request Error: Certificate provisioning will retry automatically in a short period, please be patient` {#certificate-request-error-certificate-provisioning-will-retry-automatically-in-a-short-period-please-be-patient}

위 메시지가 출력되고 페이지 접속도 안되어 한참을 씨름했다.  [이 글](https://github.com/orgs/community/discussions/66447#discussioncomment-8320434)에 따르면 Let's Encrypt 의 API rate limit 때문인 것으로 보인다. <https://tools.letsdebug.net/cert-search> 에서 도메인을 검색해 보면 정말 limit ( `5 of 5 weekly certificates` ) 에 걸린거 같았고, 적힌 문구(`The next time this certificate can be issued is 12 Apr 2025 11:41:20 UTC`)에 따르면 일주일 후 다시 가능해 지는것 같다.

처음에는 이것 때문에 설정 안된다고 (계속 404) 생각했으나, 지금 생각으론 도메인 변경하고 _페이지를 새로 publish 하지 않아서_ 였던 것으로 보인다.


### 서브 도메인 {#서브-도메인}

apex A 레코드만 등록하고 도메인을 dec22.kr 로 설정하면 (최초 설정), 모든 서브 도메인은 dec22.kr 로 포워드 되고 주소창에도 dec22.kr 로 나온다.

서브 도메인 `blog.dec22.kr` 으로 등록하면 해당 도메인으로 포워드 없이 바로 연결된다. 다른 서브 도메인 `www` 등은 dec22.kr 로 연결되고, 추가적인 DNS 설정 없이도 바로 동작한다. 좀 이상하지만 이 설정으로 사용할 예정이다.


### Private 저장소 {#private-저장소}

블로그를 publish 하기 전에 소스는 private 으로 하고 싶어서 _저상소를 private 으로 전환했더니 page 제공이 안된다._ Github Pro 버전에서만 가능하다고 한다. [문서](https://docs.github.com/ko/pages/getting-started-with-github-pages/creating-a-github-pages-site#creating-your-site) 에는 `GitHub Pages sites are publicly available on the internet, even if the repository for the site is private (if your plan or organization allows it)` 으로 plan 이 허용하면 이라고 되어 있다.


### Apex 도메인, CNAME, A record {#apex-도메인-cname-a-record}

무슨 의미인지 잘 모르겠다. 일단 위데로 하니 되었다. 뭔가 더 필요하면 그 때 찾아보는 것으로 한다.
