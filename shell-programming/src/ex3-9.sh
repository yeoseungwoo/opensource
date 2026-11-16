#!/bin/bash
# ex3-9.sh : DB.txt에서 이름(또는 정보 일부)으로 팀원 검색
# 사용법: ./ex3-9.sh 검색어

DB="DB.txt"

if [ $# -lt 1 ]; then
    read -p "검색할 이름: " key
else
    key=$1
fi

if [ ! -f "$DB" ]; then
    echo "$DB 파일이 없습니다. ex3-8.sh로 먼저 등록하세요."
    exit 1
fi

result=$(grep -i -- "$key" "$DB")
if [ -n "$result" ]; then
    echo "$result"
else
    echo "'$key' 에 해당하는 팀원이 없습니다."
fi
