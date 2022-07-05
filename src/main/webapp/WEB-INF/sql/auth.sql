-- 관리자 권한 테이블
USE Triple;

CREATE TABLE TP_auth(
    id INT PRIMARY KEY AUTO_INCREMENT,
    userid VARCHAR(50) NOT NULL,
    auth VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES TP_User(userid) ON DELETE CASCADE
);

SELECT * FROM TP_auth;

INSERT INTO TP_auth(userid, auth)
VALUES ('test12', 'ROLE_ADMIN');

-- 외래키 제약 무시
SET foreign_key_checks =0;

-- 외래키 제약 설정
SET foreign_key_checks =1;