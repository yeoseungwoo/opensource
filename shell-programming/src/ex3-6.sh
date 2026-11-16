#!/bin/bash
# ex3-6.sh : 폴더 확인/생성 -> 파일 5개 생성 -> 압축 -> 새 폴더에 압축 해제
# 사용법: ./ex3-6.sh 폴더이름

dir=${1:-}
if [ -z "$dir" ]; then
    read -p "폴더 이름을 입력하세요: " dir
fi

if [ -d "$dir" ]; then
    echo "'$dir' 폴더가 이미 있습니다."
else
    mkdir "$dir"
    echo "'$dir' 폴더가 없어서 새로 생성했습니다."
fi

cd "$dir" || exit 1
for i in 0 1 2 3 4; do
    echo "this is file$i" > "file$i.txt"
done
echo "--- 파일 5개 생성 ---"
ls

echo "--- 압축: $dir.tar.gz ---"
tar -czvf "$dir.tar.gz" file*.txt

mkdir -p "$dir"
echo "--- 새 폴더 '$dir/$dir' 에 압축 해제 ---"
tar -xzvf "$dir.tar.gz" -C "$dir"

echo "--- 결과 ---"
ls -R
