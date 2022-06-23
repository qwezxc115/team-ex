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

-- cs의 1:1 이용자 질문 테이블 생성
-- one to one의 o사용
CREATE TABLE oto(
   qono INT PRIMARY KEY AUTO_INCREMENT,
    otitle VARCHAR(50) NOT NULL,
    userid  VARCHAR(50),
    odetail VARCHAR(900) NOT NULL,
    oregdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

-- cs의 1:1 관리자 답변 테이블 생성
 CREATE TABLE otoanswer(
   aono INT PRIMARY KEY AUTO_INCREMENT,
   qono INT NOT NULL,
   content VARCHAR(900) Not null,
   userid  VARCHAR(50),
   regdate  TIMESTAMP DEFAULT NOW() NOT NULL,    
    FOREIGN KEY (qono) REFERENCES oto(qono) ON DELETE CASCADE,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

-- 1:1 게시판 파일테이블
CREATE TABLE otofile (
   id INT PRIMARY KEY AUTO_INCREMENT,
   qono INT,
   fileName VARCHAR(200),
   FOREIGN KEY (qono) REFERENCES oto(qono) ON DELETE CASCADE
);