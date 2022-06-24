SELECT * FROM GH_Message;
DESC GH_Message;

DELETE FROM GH_Message;

DROP TABLE GH_Message;

CREATE TABLE GH_Message (
   mno INT PRIMARY KEY AUTO_INCREMENT,
    writer varchar(50) ,
    reader varchar(50) ,
    content varchar(256) ,
   regdate TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (writer) REFERENCES GH_User(userid)
);

SELECT * from market;

select * from market_file;