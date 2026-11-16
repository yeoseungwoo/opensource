#!/bin/bash
# ex3-3.sh : 점수 -> A/B 등급 변환 (90 이상 A, 미만 B)
# 2개 이상 과목의 점수를 받아 과목별 등급과 평균 등급 출력

grade() {
    if [ "$1" -ge 90 ]; then echo "A"; else echo "B"; fi
}

read -p "과목 수를 입력하세요 (2 이상): " n
if ! [[ "$n" =~ ^[0-9]+$ ]] || [ "$n" -lt 2 ]; then
    echo "오류: 과목 수는 2 이상의 정수여야 합니다."
    exit 1
fi

sum=0
names=()
scores=()
for ((i = 1; i <= n; i++)); do
    read -p "[$i] 과목 이름: " name
    while true; do
        read -p "[$i] $name 점수(0~100): " s
        if [[ "$s" =~ ^[0-9]+$ ]] && [ "$s" -le 100 ]; then
            break
        fi
        echo "    0~100 사이의 정수를 입력하세요."
    done
    names+=("$name")
    scores+=("$s")
    sum=$((sum + s))
done

echo "=============================="
for ((i = 0; i < n; i++)); do
    printf "%-10s %3d점 -> %s\n" "${names[$i]}" "${scores[$i]}" "$(grade "${scores[$i]}")"
done
avg=$(echo "scale=2; $sum / $n" | bc)
avg_int=$((sum / n))
echo "------------------------------"
echo "평균 점수: $avg -> 평균 등급: $(grade $avg_int)"
