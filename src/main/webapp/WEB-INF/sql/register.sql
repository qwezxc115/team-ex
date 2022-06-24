-- Gohome 데이터베이스 만들기 
CREATE DATABASE Gohome;

use Gohome;

SELECT * FROM GH_User;

-- 사용자정보 테이블 만들기
CREATE table GH_User(
    userid VARCHAR(50) PRIMARY KEY,
    userpw VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    userPhone VARCHAR(15) NOT NULL,
    userEmail VARCHAR(254) NOT NULL,
    useradd VARCHAR(50) ,
    CompanyRegistrationNumber VARCHAR(15) NULL, 
    regdate TIMESTAMP DEFAULT NOW(),
    updateDate TIMESTAMP DEFAULT NOW(),
    enabled TINYINT(1) DEFAULT 1
);
-- 0819 추가
ALTER TABLE GH_User ADD userpoint INT DEFAULT 1000000;
ALTER TABLE GH_User ADD spendpoint INT ;



-- 권한 테이블 만들기 
CREATE TABLE GH_auth(
    id INT PRIMARY KEY AUTO_INCREMENT,
    userid VARCHAR(50) NOT NULL,
    auth VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);


-- 컬럼 타입(값) 수정 
-- alter table [테이블명] add [컬럼명] [타입] [옵션]; 
ALTER TABLE GH_User ADD CompanyRegistrationNumber VARCHAR(15);
-- ALTER TABLE GH_User ADD CompanyRegistrationNumber VARCHAR(15) NUll; 


-- 컬럼명 변경 및 타입 변경
-- alter table [테이블명] change [컬럼명] [변경할컬럼명] varchar(값);
ALTER TABLE GH_User CHANGE userphone userPhone VARCHAR(15);
ALTER TABLE GH_User CHANGE userem userEmail VARCHAR(254);



-- 컬럼 타입(값) 수정 
ALTER TABLE GH_User 
MODIFY COLUMN userem VARCHAR(254) NOT NULL;
DESC GH_User;

SELECT * FROM GH_User;

INSERT INTO GH_auth(userid, auth)
VALUES ('test12', 'ROLE_ADMIN');

INSERT INTO GH_User(userid, userpw, username, userPhone, userEmail)
VALUES ('admin','qwe123','재경','01012340000','wwwcozytest1@gmail.com');

UPDATE GH_User SET userpoint = '1000000' WHERE userid = 'test1';

DELETE FROM GH_auth WHERE userid='test12';
DELETE FROM GH_User WHERE userid='test12';
