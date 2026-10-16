"""FlagStep 동적 flag 생성기

사용자ID와 레벨 번호로 사용자마다 다른 flag를 만든다.
flag = FLAG{ HMAC-SHA256(SECRET_KEY, "사용자ID:레벨")[:16] }
"""
import hmac
import hashlib

SECRET_KEY = b"change-this-secret-key"


def make_flag(user_id: str, level: int) -> str:
    msg = f"{user_id}:{level}".encode()
    digest = hmac.new(SECRET_KEY, msg, hashlib.sha256).hexdigest()
    return "FLAG{" + digest[:16] + "}"


if __name__ == "__main__":
    print(make_flag("20261707", 0))
