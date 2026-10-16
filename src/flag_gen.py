"""FlagStep 동적 flag 생성기

사용자ID와 레벨 번호로 사용자마다 다른 flag를 만든다.
flag = FLAG{ HMAC-SHA256(SECRET_KEY, "사용자ID:레벨")[:16] }

사용법:
  python flag_gen.py make  <사용자ID> <레벨>
  python flag_gen.py check <사용자ID> <레벨> <flag>
"""
import hmac
import hashlib
import os
import sys

# 비밀키는 코드에 쓰지 않고 환경변수에서 읽는다
SECRET_KEY = os.environ.get("FLAGSTEP_SECRET", "dev-only-secret").encode()


def make_flag(user_id: str, level: int) -> str:
    msg = f"{user_id}:{level}".encode()
    digest = hmac.new(SECRET_KEY, msg, hashlib.sha256).hexdigest()
    return "FLAG{" + digest[:16] + "}"


def check_flag(user_id: str, level: int, submitted: str) -> bool:
    """제출한 flag가 맞는지 확인 (타이밍 공격 방지를 위해 compare_digest 사용)"""
    return hmac.compare_digest(make_flag(user_id, level), submitted.strip())


def main(argv):
    if len(argv) == 4 and argv[1] == "make":
        print(make_flag(argv[2], int(argv[3])))
    elif len(argv) == 5 and argv[1] == "check":
        ok = check_flag(argv[2], int(argv[3]), argv[4])
        print("정답! 다음 레벨이 열렸습니다." if ok else "틀렸습니다.")
    else:
        print(__doc__)


if __name__ == "__main__":
    main(sys.argv)
