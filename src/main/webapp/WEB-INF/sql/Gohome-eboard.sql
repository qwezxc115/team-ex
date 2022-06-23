-- 업체게시판 테이블 만들기 
CREATE table E_board(
	eno INT PRIMARY KEY AUTO_INCREMENT,
    	 title VARCHAR(255) NOT NULL,
     	content VARCHAR(2000) NOT NULL,
	writer VARCHAR(50) NOT NULL,
	addRegion VARCHAR(15),
    	 addCi VARCHAR(15),
    	 addGu VARCHAR(15),
    	 regdate TIMESTAMP DEFAULT NOW(),
    	 updatedate TIMESTAMP DEFAULT NOW(),
     	FOREIGN KEY (writer) REFERENCES GH_User(userid) ON DELETE CASCADE);


--  업체게시판  파일 테이블 
CREATE TABLE E_board_file (

	id INT PRIMARY KEY AUTO_INCREMENT,
	eno INT REFERENCES E_board(eno),
	fileName VARCHAR(200) not null,
	FOREIGN KEY (eno) REFERENCES E_board(eno) ON DELETE CASCADE

);

SELECT * FROM E_board;
SELECT * FROM E_board_file;


-- 업체 예약 																						
CREATE TABLE E_rezmsg (
	rno INT PRIMARY KEY AUTO_INCREMENT,
    eno INT REFERENCES E_board(eno),
    reader varchar(50),
    rezdate varchar(50),
    reztime varchar(50),
	writer varchar(50),																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																				
    content varchar(256) ,
    regdate TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (eno) REFERENCES E_board(eno),
    FOREIGN KEY (writer) REFERENCES GH_User(userid) ON DELETE CASCADE
);