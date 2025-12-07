+++
title = "advent of code 2025"
author = ["ysk"]
date = 2025-12-06T15:48:00+09:00
tags = ["programming"]
draft = false
+++

## Intro {#intro}

<https://adventofcode.com/2025/>

<https://github.com/suguni/advent-of-code/tree/main/advent_rs/src/y2025>

올해는 12 문제다. 이번에는 모두 풀 수 있을것인가?


## Day 7 {#day-7}

슬슬 단순하게 접근하면 시간이 너무 오래 걸리는 문제가 나오는거 같다.

Part Two. 빔이 흐르는 단계별로 빔 위치까지 진행되는 경로를 처음부터 누적하여 저장하는 방식으로 풀었다.
모든 빔의 흐름을 벡터로 저장해 두는 방법은 프로그램이 완료되지 않아 포기.


## Day 6 {#day-6}

nom 으로 한참을 파서구현하다 포기하고 표준함수만 사용하여 구현.

상대적으로 계산 로직은 단순하고, 입력을 어떻게 파싱해 계산하기 편리한 자료구조로 만들것인지가 관건인 문제임.

두번째 문제까지 풀어 답 제출한 후, 첫번째 문제에서 구현한 파싱 함수를 두번째 문제의 계산 함수에서 바로 사용할 수 있도록 변경하여 최종 [푸쉬](https://github.com/suguni/advent-of-code/blob/main/advent_rs/src/y2025/d6.rs).

여전히 문제 난이도는 높지 않음.
