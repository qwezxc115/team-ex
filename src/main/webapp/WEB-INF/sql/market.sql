SELECT * FROM GH_User;
SELECT * FROM GH_auth;

DESC market;
DESC wishlist;
DESC market_file;

SELECT * FROM market;
SELECT * FROM wishlist;
SELECT * FROM market_file;

DELETE FROM GH_User;

DROP TABLE market;
DROP TABLE market_file;
DROP TABLE wishlist;

-- 사용자정보 테이블 만들기
CREATE TABLE market(
    mno INT PRIMARY KEY AUTO_INCREMENT, -- 상품번호 
    mwriter VARCHAR(50) NOT NULL, -- 작성자
    mtitle VARCHAR(255) NOT NULL, -- 상품제목
    mprice INT NOT NULL, -- 상품가격
    mdetail VARCHAR(2000) NOT NULL, -- 상세설명
    mstate VARCHAR(50) NOT NULL, -- 상품 상태 
    msold VARCHAR(10) NOT NULL, -- 판매 분류
    mregdate TIMESTAMP DEFAULT NOW(), -- 상품 등록일
    maddress VARCHAR(50), -- 주소        
    FOREIGN KEY (mwriter) REFERENCES GH_User(userid) ON DELETE CASCADE
);

INSERT INTO market 
(mwriter, mtitle, mprice, mdetail, mstate, msold, maddress)
VALUES ('test1', 'test', 100000, '2만원에 급처', '새상품', '판매', '서울대입구');

INSERT INTO market_file
(mno, filename)
VALUES ('10', '123.jpg');

-- 이미지파일 업로드
CREATE TABLE market_file( 
id INT PRIMARY KEY AUTO_INCREMENT, -- 파일 아이디 식별자
mno INT NOT NULL, -- 상품번호 (글번호)
fileName VARCHAR(256), -- 파일이름
FOREIGN KEY (mno) REFERENCES market(mno) ON DELETE CASCADE-- 상품번호
);


-- 찜목록 
CREATE TABLE wishlist(
	wno INT PRIMARY KEY AUTO_INCREMENT,
	mwriter VARCHAR(50) NOT NULL,
    mno INT NOT NULL,
    FOREIGN KEY (mwriter) REFERENCES GH_User(userid),
    FOREIGN KEY (mno) REFERENCES market(mno)
);






