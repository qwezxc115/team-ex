-- 트리플 데이터베이스 생성
CREATE DATABASE Triple;

USE Triple;

-- 사용자정보 테이블 만들기
CREATE table TP_User(
    userid VARCHAR(50) PRIMARY KEY,
    userpw VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    userPhone VARCHAR(15) NOT NULL,
    userEmail VARCHAR(254) NOT NULL,
    useradd VARCHAR(50) ,
    regdate TIMESTAMP DEFAULT NOW(),
    updateDate TIMESTAMP DEFAULT NOW(),
    enabled TINYINT(1) DEFAULT 1
);

SELECT * FROM TP_User;

INSERT INTO TP_User(userid, userpw, username, userPhone, userEmail)
VALUES ('user','1234','테스터','01012345678','test@gmail.com');