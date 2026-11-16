#!/bin/bash
# ex3-5.sh : 시스템 상태 확인 메뉴 (각 기능은 내부 함수로 구현)
# 실행 시 입력 인자는 내부 함수 안의 리눅스 명령어 옵션으로 전달됨
# 사용법: ./ex3-5.sh [옵션...]   예) ./ex3-5.sh -h   (free -h, df -h 등에 전달)

OPTS=("$@")   # 스크립트 입력 인자 -> 함수로 넘길 옵션

user_info() {
    echo "[사용자 정보]"
    echo "  사용자 : $(whoami)"
    echo "  id     : $(id)"
    echo "  홈     : $HOME"
    echo "  셸     : $SHELL"
    echo "  접속자 :"; who | sed 's/^/    /'
}

cpu_gpu_usage() {
    if command -v nvidia-smi > /dev/null 2>&1; then
        echo "[GPU 사용률] nvidia-smi"
        nvidia-smi --query-gpu=name,utilization.gpu,memory.used,memory.total --format=csv
    else
        echo "[CPU 사용률] (GPU 없음 -> top 사용)"
        top -bn1 | head -n 5
    fi
}

mem_usage() {
    echo "[메모리 사용량] free $*"
    free "$@"
}

disk_usage() {
    echo "[디스크 사용량] df $*"
    df "$@" /
    echo "[현재 폴더 용량] du -sh ."
    du -sh .
}

list_files() {
    echo "함수 안으로 들어 왔음 (ls $*)"
    ls "$@"
}

echo "프로그램을 시작합니다. (전달된 옵션: ${OPTS[*]:-없음})"
while true; do
    echo "=========================="
    echo "1) 사용자 정보"
    echo "2) GPU 또는 CPU 사용률 확인"
    echo "3) 메모리 사용량 확인"
    echo "4) 디스크 사용량 확인"
    echo "5) ls 실행 (옵션 전달)"
    echo "6) 종료"
    echo "=========================="
    read -p "메뉴 선택: " m
    case "$m" in
        1) user_info ;;
        2) cpu_gpu_usage ;;
        3) mem_usage "${OPTS[@]}" ;;
        4) disk_usage "${OPTS[@]}" ;;
        5) list_files "${OPTS[@]}" ;;
        6) echo "프로그램을 종료합니다."; break ;;
        *) echo "1~6 중에서 선택하세요." ;;
    esac
done
