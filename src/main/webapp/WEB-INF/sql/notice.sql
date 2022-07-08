-- 공지사항 테이블 생성
-- notice의 n사용
USE Triple;

CREATE TABLE notice(
   nno INT PRIMARY KEY AUTO_INCREMENT,
    ntitle VARCHAR(50) NOT NULL,
    userid  VARCHAR(50) NOT NULL,
    ndetail VARCHAR(900) NOT NULL,
    nregdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    FOREIGN KEY (userid) REFERENCES TP_User(userid) ON DELETE CASCADE
);

SELECT * FROM notice;