#!/bin/bash
# ex3-8.sh : 팀원 이름과 생일/전화번호를 DB.txt에 기록
# 사용법: ./ex3-8.sh 이름 정보        -> DB.txt에 추가
#         ./ex3-8.sh -n 이름 정보     -> DB.txt를 처음부터 다시 작성

DB="DB.txt"

if [ "$1" = "-n" ]; then
    mode="new"
    shift
fi

if [ $# -lt 2 ]; then
    echo "사용법: $0 [-n] <이름> <생일 또는 전화번호>"
    exit 1
fi

name=$1
shift
info="$*"

if [ "$mode" = "new" ]; then
    echo "$name $info" > "$DB"
    echo "DB.txt를 새로 작성했습니다: $name $info"
else
    echo "$name $info" >> "$DB"
    echo "DB.txt에 추가했습니다: $name $info"
fi
