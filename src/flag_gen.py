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


def check_flag(user_id: str, level: int, submitted: str) -> bool:
    """제출한 flag가 맞는지 확인 (타이밍 공격 방지를 위해 compare_digest 사용)"""
    return hmac.compare_digest(make_flag(user_id, level), submitted.strip())


if __name__ == "__main__":
    f = make_flag("20261707", 0)
    print(f, check_flag("20261707", 0, f), check_flag("20261708", 0, f))
