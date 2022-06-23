-- 커뮤니티 자유 게시판

CREATE table C_board(
	 bno INT PRIMARY KEY AUTO_INCREMENT,
	 title VARCHAR(255) NOT NULL,
	 content VARCHAR(2000) NOT NULL,
	 writer VARCHAR(50) NOT NULL,
   	 regdate TIMESTAMP DEFAULT NOW(),
   	 updatedate TIMESTAMP DEFAULT NOW(),
	 cbcategory varchar(15),
   	 FOREIGN KEY (writer) REFERENCES GH_User(userid) ON DELETE CASCADE
);


-- 커뮤니티 자유게시판 첨부파일  
CREATE TABLE C_board_file (
	id INT PRIMARY KEY AUTO_INCREMENT,
	bno INT REFERENCES C_board(bno),
	fileName VARCHAR(200) not null,
	FOREIGN KEY (bno) REFERENCES C_board(bno) ON DELETE CASCADE
);
-- 자유게시판 댓글 테이블 
CREATE TABLE cb_reply (
	rno INT PRIMARY KEY AUTO_INCREMENT,
    bno INT NOT NULL,
    reply VARCHAR(512) NOT NULL,
    replyer VARCHAR(50) NOT NULL,
    replyDate TIMESTAMP DEFAULT now(),
    updateDate TIMESTAMP DEFAULT now(),
    FOREIGN KEY (bno) REFERENCES C_board(bno)
);


SELECT * FROM C_board;
SELECT * FROM C_board_file;
SELECT * FROM cb_reply;