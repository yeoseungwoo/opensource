#!/bin/bash
# ex3-2.sh : y = (1/2) * x^2 계산 (실수 범위)
# 사용법: ./ex3-2.sh            -> 실행 후 값 입력
#         ./ex3-2.sh 1 2.5 -3   -> 인자로 바로 계산

if [ $# -gt 0 ]; then
    xs=("$@")
else
    read -p "x 값들을 공백으로 구분해 입력하세요 (2개 이상): " -a xs
fi

if [ ${#xs[@]} -lt 2 ]; then
    echo "오류: 2개 이상의 값을 입력해야 합니다."
    exit 1
fi

echo "---------------------------"
for x in "${xs[@]}"; do
    if ! [[ "$x" =~ ^-?[0-9]*\.?[0-9]+$ ]]; then
        echo "x = $x  -> 숫자가 아님 (건너뜀)"
        continue
    fi
    y=$(echo "scale=4; 0.5 * $x * $x" | bc -l)
    printf "x = %-8s  y = 1/2 * x^2 = %.4f\n" "$x" "$y"
done
