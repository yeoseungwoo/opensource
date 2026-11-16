#!/bin/bash
# ex3-0.sh : 환경변수 MYENV를 .bashrc에 등록/확인/해제
# 사용법: ./ex3-0.sh set | check | unset   (인자 없으면 전체 과정 시연)

BASHRC="$HOME/.bashrc"
LINE='export MYENV="Hello Shell"'

do_set() {
    if grep -q '^export MYENV=' "$BASHRC" 2>/dev/null; then
        echo "[set] 이미 .bashrc에 MYENV가 등록되어 있습니다."
    else
        echo "$LINE" >> "$BASHRC"
        echo "[set] .bashrc에 등록 완료 -> $LINE"
    fi
    echo "[set] .bashrc 마지막 줄: $(tail -n 1 "$BASHRC")"
}

do_check() {
    # 새 터미널(대화형 bash)을 띄워서 .bashrc가 읽힌 상태의 값을 확인
    echo "[check] 새 터미널에서  : MYENV = '$(bash -ic 'echo $MYENV' 2>/dev/null)'"
    # 새 터미널 안에서 다른 셸 파일(자식 프로세스)을 실행해도 유지되는지 확인
    TMP=$(mktemp /tmp/child_XXXX.sh)
    echo 'echo "$MYENV"' > "$TMP"
    echo "[check] 임의의 셸 파일: MYENV = '$(bash -ic "bash $TMP" 2>/dev/null)'"
    rm -f "$TMP"
}

do_unset() {
    sed -i '/^export MYENV=/d' "$BASHRC"   # .bashrc에서 제거
    unset MYENV                             # 현재 셸에서도 제거
    echo "[unset] .bashrc에서 MYENV 삭제 + unset MYENV 완료"
}

case "$1" in
    set)   do_set ;;
    check) do_check ;;
    unset) do_unset ;;
    *)
        echo "===== 1) 환경변수 등록 ====="; do_set
        echo "===== 2) 유지 확인 =====";     do_check
        echo "===== 3) 환경변수 해제 ====="; do_unset
        echo "===== 4) 해제 후 확인 =====";  do_check
        ;;
esac
