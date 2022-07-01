-- cs의 공지사항 테이블 생성
-- notice의 n사용
CREATE TABLE notice(
   nno INT PRIMARY KEY AUTO_INCREMENT,
    ntitle VARCHAR(50) NOT NULL,
    userid  VARCHAR(50) NOT NULL,
    ndetail VARCHAR(900) NOT NULL,
    nregdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);
SELECT * FROM notice;

-- cs의 공지사항 파일테이블 생성
CREATE TABLE notice_file(
   nfno INT PRIMARY KEY AUTO_INCREMENT,
    nno INT NOT NULL,
    fileName VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (nno) REFERENCES notice (nno) ON DELETE CASCADE
);