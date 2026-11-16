#!/bin/bash
# ex3-1.sh : 두 정수를 인자로 받아 사칙연산 수행
# 사용법: ./ex3-1.sh 정수1 정수2

echo "스크립트 이름(\$0) : $0"
echo "인자 개수(\$#)     : $#"
echo "전체 인자(\$@)     : $@"

if [ $# -ne 2 ]; then
    echo "사용법: $0 <정수1> <정수2>"
    exit 1
fi

for n in "$1" "$2"; do
    if ! [[ "$n" =~ ^-?[0-9]+$ ]]; then
        echo "오류: '$n' 은(는) 정수가 아닙니다."
        exit 1
    fi
done

a=$1
b=$2
echo "-----------------------------"
echo "$a + $b = $((a + b))"
echo "$a - $b = $((a - b))"
echo "$a * $b = $((a * b))"
if [ "$b" -eq 0 ]; then
    echo "$a / $b = 0으로 나눌 수 없습니다."
else
    echo "$a / $b = $((a / b)) (나머지 $((a % b)))"
fi
