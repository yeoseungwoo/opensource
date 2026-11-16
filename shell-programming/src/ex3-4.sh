#!/bin/bash
# ex3-4.sh : 성적 관리 메뉴 (5 입력 전까지 반복)

names=()
scores=()

# 점수 -> 4.5 만점 학점 / 등급
to_gpa() {
    local s=$1
    if   [ "$s" -ge 95 ]; then echo "4.5 A+"
    elif [ "$s" -ge 90 ]; then echo "4.0 A0"
    elif [ "$s" -ge 85 ]; then echo "3.5 B+"
    elif [ "$s" -ge 80 ]; then echo "3.0 B0"
    elif [ "$s" -ge 75 ]; then echo "2.5 C+"
    elif [ "$s" -ge 70 ]; then echo "2.0 C0"
    elif [ "$s" -ge 65 ]; then echo "1.5 D+"
    elif [ "$s" -ge 60 ]; then echo "1.0 D0"
    else                       echo "0.0 F"
    fi
}

add_score() {
    read -p "과목 이름: " name
    read -p "점수(0~100): " s
    if [[ "$s" =~ ^[0-9]+$ ]] && [ "$s" -le 100 ]; then
        names+=("$name")
        scores+=("$s")
        echo "-> '$name' ${s}점 추가 완료"
    else
        echo "-> 0~100 사이의 정수만 입력할 수 있습니다."
    fi
}

show_all() {
    if [ ${#scores[@]} -eq 0 ]; then echo "-> 입력된 성적이 없습니다."; return; fi
    for i in "${!scores[@]}"; do
        printf "  %d. %-10s %3d점\n" $((i + 1)) "${names[$i]}" "${scores[$i]}"
    done
}

average() {
    local sum=0
    for s in "${scores[@]}"; do sum=$((sum + s)); done
    echo "scale=2; $sum / ${#scores[@]}" | bc
}

show_avg() {
    if [ ${#scores[@]} -eq 0 ]; then echo "-> 입력된 성적이 없습니다."; return; fi
    echo "-> 평균 점수: $(average)점"
}

show_gpa() {
    if [ ${#scores[@]} -eq 0 ]; then echo "-> 입력된 성적이 없습니다."; return; fi
    local total=0
    for i in "${!scores[@]}"; do
        read p g <<< "$(to_gpa "${scores[$i]}")"
        printf "  %-10s %3d점 -> %-2s (%s)\n" "${names[$i]}" "${scores[$i]}" "$g" "$p"
        total=$(echo "$total + $p" | bc)
    done
    gpa=$(echo "scale=2; $total / ${#scores[@]}" | bc)
    echo "-> 평균 등급(GPA): $gpa / 4.5"
}

while true; do
    echo "==================="
    echo "1) 과목 성적 추가"
    echo "2) 입력된 모든 점수 보기"
    echo "3) 평균 점수 확인"
    echo "4) 평균 등급 (GPA) 변환"
    echo "5) 종료"
    echo "==================="
    read -p "메뉴 선택: " menu
    case "$menu" in
        1) add_score ;;
        2) show_all ;;
        3) show_avg ;;
        4) show_gpa ;;
        5) echo "프로그램을 종료합니다."; break ;;
        *) echo "-> 1~5 중에서 선택하세요." ;;
    esac
done
