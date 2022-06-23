
SELECT * FROM order_detail;
SELECT * FROM cart;
SELECT * FROM S_product;

DESC S_product;
DELETE FROM S_product;
DROP TABLE S_product;
ALTER TABLE S_product DROP keyword;


CREATE TABLE wish( 
    wno INT PRIMARY KEY AUTO_INCREMENT, -- 찜 넘버
    userid VARCHAR(50) NOT NULL, -- 소비자
    pno INT NOT NULL, -- 상품번호 (글번호)
    adddate TIMESTAMP DEFAULT NOW(), -- 찜 담은 날짜
    FOREIGN KEY (pno) REFERENCES S_product(pno) ON DELETE CASCADE, -- 상품번호
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE -- 고객정보
);

-- 스토어 상품 테이블 
CREATE TABLE S_product(
	pno INT PRIMARY KEY AUTO_INCREMENT,
    category varchar(15) NOT NULL, -- 카테고리
	userid VARCHAR(50) NOT NULL, -- 작성자
    title VARCHAR(255) NOT NULL, -- 상품제목
	price INT NOT NULL, -- 상품가격
    delivery varchar(15) NOT NULL, -- 배송
    detail VARCHAR(2000), -- 상세설명
    regdate TIMESTAMP DEFAULT NOW(), -- 상품 등록일
	updatedate TIMESTAMP DEFAULT NOW(), -- 상품 업데이트일     
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

INSERT INTO S_product (category, userid, title, price, delivery, detail)
VALUES ('C', 'test1', '조명', '100000', '무료배송', '침대를 팝니다');

INSERT INTO S_product_file (pno, filename)
VALUES ('6', '중고01.jpg');


-- 이미지파일 업로드
CREATE TABLE S_product_file( 
	id INT PRIMARY KEY AUTO_INCREMENT, -- 파일 아이디 식별자
	pno INT NOT NULL, -- 상품번호 (글번호)
	fileName VARCHAR(256), -- 파일이름
	FOREIGN KEY (pno) REFERENCES S_product(pno) ON DELETE CASCADE-- 상품번호
);


CREATE TABLE cart( 
	cno INT PRIMARY KEY AUTO_INCREMENT, -- 카트 상품 넘버
    userid VARCHAR(50) NOT NULL, -- 소비자
	pno INT NOT NULL, -- 상품번호 (글번호)
	cartstock int NOT NULL, -- 주문 수량
    adddate TIMESTAMP DEFAULT NOW(), -- 장바구니에 담은 날짜
	FOREIGN KEY (pno) REFERENCES S_product(pno) ON DELETE CASCADE, -- 상품번호
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE -- 고객정보
);

INSERT INTO cart (userid, pno, cartstock)
VALUES ('test1', '6', '3');


-- 주문 정보 
CREATE TABLE order_detail(
    ono INT PRIMARY KEY AUTO_INCREMENT, -- 주문 상세 고유번호
    pno INT NOT NULL, -- 상품 번호
    cno INT , -- 장바구니 번호
    userid VARCHAR(50) NOT NULL, -- 주문자
    cartstock INT NOT NULL, -- 장바구니 수량
    orderdate TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (pno) REFERENCES S_product(pno) ON DELETE CASCADE, -- 제품에서 바로 할때
    FOREIGN KEY (cno) REFERENCES cart(cno) ON DELETE CASCADE, -- 장바구니 번호 
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);


 SELECT 
           s.pno pno,
           s.category category,
           s.userid userid,
           s.title title,
           s.price price,
           s.stock stock,
	       s.delivery delivery,
           s.detail detail,
           s.keyword keyword,
           s.regdate regdate,
           s.updatedate updatedate,
           sf.fileName fileName
	    	
	     FROM S_product s LEFT JOIN S_product_file sf ON s.pno = sf.pno
         WHERE s.category = '가구'
	     ORDER BY pno DESC;

-- 유저 정보와 관련있는 테이블
CREATE TABLE userorder_info(     
    ono INT PRIMARY KEY AUTO_INCREMENT,
    userid VARCHAR(50) NOT NULL, -- 주문자
    userAddr1 VARCHAR(50) NOT NULL, -- 우편번호
    userAddr2 VARCHAR(50) NOT NULL, -- 기본주소
    userAddr3 VARCHAR(30) NOT NULL, -- 상세주소
    orderphone VARCHAR(15) NOT NULL, -- 연락처
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE -- 고객정보
);

	 INSERT INTO order_info
	  (userid, orderRec, userAddr1, userAddr2, userAddr3, orderphone, amount)
	 VALUES
	  ('test1', '성재경', '12345', '서울시', '101호', '01094557896', '10');

-- 주문 정보 
CREATE TABLE order_detailsub(
    dno INT PRIMARY KEY AUTO_INCREMENT, -- 주문 상세 고유번호
    orderno INT NOT NULL, -- 주문번호
    pno INT NOT NULL, -- 상품 번호
    cno INT NOT NULL, -- 장바구니 번호
    cartcount INT NOT NULL, -- 장바구니 수량
    FOREIGN KEY (pno) REFERENCES S_product(pno) ON DELETE CASCADE, -- 제품에서 바로 할때
    FOREIGN KEY (cno) REFERENCES cart(cno) ON DELETE CASCADE -- 장바구니 번호 
);

Select * from order_info;
DESC order_info;

Drop table order_detail;

Drop table userorder_info;

DELETE FROM order_detail;