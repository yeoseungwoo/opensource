#!/bin/bash
# ex3-7.sh : 폴더에 파일 5개 이상 생성 -> 파일 이름대로 하위 폴더 생성 -> 각 폴더에 해당 파일 링크
# 사용법: ./ex3-7.sh 폴더이름 [파일개수(기본 5)]

dir=${1:-}
cnt=${2:-5}
if [ -z "$dir" ]; then
    read -p "폴더 이름을 입력하세요: " dir
fi
if [ "$cnt" -lt 5 ]; then cnt=5; fi

mkdir -p "$dir"
cd "$dir" || exit 1

for ((i = 0; i < cnt; i++)); do
    f="file$i"
    echo "this is $f" > "$f.txt"     # 파일 생성
    mkdir -p "$f"                     # 파일 이름의 하위 폴더 생성
    ln -sf "../$f.txt" "$f/$f.txt"    # 하위 폴더에 심볼릭 링크
done

echo "--- $dir 폴더 내용 ---"
ls
echo "--- 각 하위 폴더의 링크 ---"
for ((i = 0; i < cnt; i++)); do
    ls -l "file$i/" | tail -n +2
done
echo "--- 링크로 읽은 내용 (file0/file0.txt) ---"
cat file0/file0.txt
