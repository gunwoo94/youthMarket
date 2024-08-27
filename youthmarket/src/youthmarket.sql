
select * from member;
select * from sell;

--아이디 및 권한 생성 -- 
create user youthmarket identified by g1234;
grant dba to youthmarket;

--관리자 -- 

CREATE TABLE ADMIN (
    ADMIN_ID        VARCHAR2(20)  NOT NULL,
    ADMIN_PASSWORD  VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_ADMIN PRIMARY KEY (ADMIN_ID)
);

select * from ADMIN;
select * from 
--공지 사항 , 게시판 -- 

CREATE TABLE NOTICE (
    NOTICE_NO      NUMBER          NOT NULL ,
    NOTICE_TYPE    VARCHAR2(10)    NOT NULL,
    NOTICE_TITLE   VARCHAR2(200)   NOT NULL ,
    NOTICE_WRITER  VARCHAR2(15)    NOT NULL ,
    NOTICE_IMG     VARCHAR2(500)   NULL     ,
    NOTICE_HIT     NUMBER          NULL     ,
    CREATE_DATE    DATE         DEFAULT SYSDATE ,
   
    CONSTRAINT PK_NOTICE PRIMARY KEY (NOTICE_NO),
 
);
SELECT S.SELL_NO, S.SELL_STATUS, S.SELL_TITLE, CG.CATEGORY_NAME, S.PRICE
FROM SELL S
JOIN CATEGORY CG ON S.CATEGORY_NO = CG.CATEGORY_NO
WHERE S.SELL_NO = 1;  


-- 회원 정보 -- 
drop table member cascade constraints;
select * from member;
CREATE TABLE MEMBER (
    USER_NO       NUMBER         NOT NULL,
    USER_ID            VARCHAR2(20)   NOT NULL,
    USER_PASSWORD      VARCHAR2(100)  NOT NULL,
    USER_NAME     VARCHAR2(100),
    PHONE         VARCHAR2(30),
    BIRTH         VARCHAR2(30),
    EMAIL         VARCHAR2(100),
    COUNT         NUMBER         NOT NULL,
    CREATE_DATE   DATE           NOT NULL,
    STATUS        CHAR(1) DEFAULT 'Y',
    heartCount    NUMBER(10),
    BLACKLIST     CHAR(1) DEFAULT 'N',
    account       varchar2(20),
	reportCount   number(10), 
	filename      varchar2(100),
    CONSTRAINT PK_MEMBER PRIMARY KEY (USER_NO)
);
select * from member where user_id='k1';

--카테 고리 --

CREATE TABLE CATEGORY (
    CATEGORY_NO    NUMBER        NOT NULL,
    CATEGORY_NAME  VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_CATEGORY PRIMARY KEY (CATEGORY_NO)
);

INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (1, '인기순');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (10, '디지털기기');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (20, '생활가전');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (30, '유아용품');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (40, '패션');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (50, '도서');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (60, '반려동물용품');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (70, '스포츠');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (80, '뷰티');
INSERT INTO CATEGORY (CATEGORY_NO, CATEGORY_NAME) VALUES (90, '교환권');

-- 판매 게시글 --
drop table sell cascade constraint;
CREATE TABLE SELL (
    SELL_NO      NUMBER        NOT NULL , 
    SELL_TITLE   VARCHAR2(100) NOT NULL ,
    SELL_CONTENT VARCHAR2(400) NOT NULL ,
    IMAGE_SELL   VARCHAR2(100) NULL    ,
    COUNT        NUMBER        NOT NULL ,
    PRICE        NUMBER        NOT NULL ,
    SELL_STATUS  CHAR(1)       DEFAULT 'Y',
    CREATE_DATE  DATE          DEFAULT SYSDATE ,
    UPDATE_DATE  DATE          DEFAULT SYSDATE ,
    STATUS       CHAR(1)       DEFAULT 'Y',
    HEART_NUM    NUMBER        NULL,
    USER_NO      NUMBER        NOT NULL,
    CATEGORY_NO  NUMBER        NOT NULL,
    CONSTRAINT PK_SELL PRIMARY KEY (SELL_NO),
        CONSTRAINT FK_MEMBER_TO_SELL FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_CATEGORY_TO_SELL FOREIGN KEY (CATEGORY_NO) REFERENCES CATEGORY(CATEGORY_NO)
);


--게시글 첨부파일 --

CREATE TABLE SFILE (
    SFILE_NO     NUMBER        NOT NULL,
    ORIGIN_NAME  VARCHAR2(300) NOT NULL,
    CHANGE_NAME  VARCHAR2(300) NOT NULL,
    UPLOAG_DATE  DATE          NOT NULL,
    FILE_PATH    VARCHAR2(1000) NULL,
    FILE_TYPE    VARCHAR2(1)   NOT NULL,
    STATUS       VARCHAR2(1)   DEFAULT 'Y',
    SELL_NO      NUMBER        NOT NULL ,
    CONSTRAINT PK_SFILE PRIMARY KEY (SFILE_NO),
    CONSTRAINT FK_SELL_TO_SFILE FOREIGN KEY (SELL_NO) REFERENCES SELL(SELL_NO)   
);


--구매 내역 --

CREATE TABLE PURCHASE (
    PUB_NO        NUMBER        NOT NULL,
    CREATE_DATE   DATE         	DEFAULT SYSDATE,
    PRICE         NUMBER        NULL,
    ORDER_NO      VARCHAR2(200) NULL,
    DEPO_STATUS   CHAR(1)       DEFAULT 'Y' ,
    SELL_NO       NUMBER        NOT NULL,
    USER_NO       NUMBER        NOT NULL,
    CONSTRAINT PK_PURCHASE PRIMARY KEY (PUB_NO),
    CONSTRAINT FK_SELL_TO_PURCHASE FOREIGN KEY (SELL_NO) REFERENCES SELL(SELL_NO),
  	CONSTRAINT FK_MEMBER_TO_PURCHASE FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO) 
);


-- 리뷰 --

CREATE TABLE REVIEW (
    REV_NO       NUMBER        NOT NULL ,
    REV_CONTENT  VARCHAR2(100) NOT NULL,
    REV_SCORE    NUMBER        NOT NULL ,
    CREATE_DATE  DATE          DEFAULT SYSDATE,
    STATUS       CHAR(1)       DEFAULT 'Y' ,
    SELL_NO     NUMBER        NOT NULL ,
    USER_NO     NUMBER        NOT NULL ,
    CONSTRAINT PK_REVIEW PRIMARY KEY (REV_NO),
    CONSTRAINT FK_SELL_TO_REVIEW FOREIGN KEY (SELL_NO) REFERENCES SELL(SELL_NO),
    CONSTRAINT FK_MEMBER_TO_REVIEW FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO)
);


--팔로우 --
CREATE TABLE FOLLOW (
    FL_ID        NUMBER NOT NULL,
    CREATE_DATE  DATE   DEFAULT SYSDATE,
    FW_ID        NUMBER NOT NULL,
    CONSTRAINT PK_FOLLOW PRIMARY KEY (FL_ID),
    CONSTRAINT FK_MEMBER_TO_FOLLOW_1 FOREIGN KEY (FL_ID) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_MEMBER_TO_FOLLOWING FOREIGN KEY (FW_ID) REFERENCES MEMBER(USER_NO)
    
);

--찜 --

CREATE TABLE HEART (
    SELL_NO      NUMBER NOT NULL ,
    USER_NO      NUMBER NOT NULL ,
    CREATE_HEART DATE DEFAULT SYSDATE ,
    HEART_NO     NUMBER NULL ,
    CONSTRAINT PK_HEART PRIMARY KEY (SELL_NO, USER_NO),
    CONSTRAINT FK_SELL_TO_HEART FOREIGN KEY (SELL_NO) REFERENCES SELL(SELL_NO),
    CONSTRAINT FK_MEMBER_TO_HEART FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO)
);

--최근 본 상품 -- 

CREATE TABLE RECENT (
    RECENT_NO   NUMBER NOT NULL ,
    CRATE_DATE  DATE     DEFAULT SYSDATE,
    STATUS      CHAR(1)   DEFAULT 'Y',
    USER_NO    NUMBER  NOT NULL,
    SELL_NO     NUMBER  NOT NULL,
    CONSTRAINT PK_RECENT PRIMARY KEY (RECENT_NO),
    CONSTRAINT FK_MEMBER_TO_RECENT FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_SELL_TO_RECENT FOREIGN KEY (SELL_NO) REFERENCES SELL(SELL_NO)
);


--계좌 번호 --

CREATE TABLE ACCOUNT (
    ACCOUNT_ID   NUMBER NOT NULL ,
    ACCOUNT      NUMBER NOT NULL ,
    BANK         VARCHAR2(40) NULL ,
    USER_NO      NUMBER NOT NULL ,
    CONSTRAINT PK_ACCOUNT PRIMARY KEY (ACCOUNT_ID),
    CONSTRAINT FK_MEMBER_TO_ACCOUNT FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO)
);



-- 차단 -- 
CREATE TABLE BLOCK (
    BLOCK_NUM    NUMBER NOT NULL COMMENT '차단 목록 고유번호',
    BLOCKER_NO   NUMBER NOT NULL COMMENT '회원 고유 식별번호',
    BLOCKED_NO   NUMBER NOT NULL COMMENT '회원 고유 식별번호',
    CONSTRAINT PK_BLOCK PRIMARY KEY (BLOCK_NUM),
    CONSTRAINT FK_MEMBER_TO_BLOCKERNUM FOREIGN KEY (BLOCK_NUM) REFERENCES MEMBER(USER_NO),
    
);


--채팅방 -- 
CREATE TABLE CHAT_ROOM (
    CHATROOM_NO NUMBER NOT NULL ,
    CREATE_DATE DATE  DEFAULT SYSDATE ,
    STATUS      CHAR(1)  DEFAULT 'Y' ,
    SELL_NO     NUMBER  NOT NULL ,
    USER_NO     NUMBER  NOT NULL ,
    CONSTRAINT PK_CHAT_ROOM PRIMARY KEY (CHATROOM_NO),
    CONSTRAINT FK_MEMBER_TO_CHAT_ROOM FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_SELL_TO_CHAT_ROOM FOREIGN KEY (SELL_NO) REFERENCES SELL(SELL_NO)
);

--채팅 메세지 --

CREATE TABLE CHAT_MESSEGE (
    MESSEGE_NO       NUMBER        NOT NULL  ,
    MESSAGE_CONTENT  VARCHAR2(4000) NOT NULL ,
    CREATE_DATE      DATE           DEFAULT SYSDATE ,
    READ_STATUS      CHAR(1)        DEFAULT 'M' ,
    CHATROOM_NO     NUMBER        NOT NULL ,
    USER_NO         NUMBER        NOT NULL,
    CONSTRAINT PK_CHAT_MESSEGE PRIMARY KEY (MESSEGE_NO),
    CONSTRAINT FK_MEMBER_TO_CHAT_MESSEGE FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_CAHT_ROOM_TO_GHAT_MESSEGE FOREIGN KEY (CHATROOM_NO) REFERENCES CHAT_ROOM(CHATROOM_NO)
);


--채팅방 JOIN --

CREATE TABLE CHAT_ROOM_JOIN (
    CHATROOM_NO NUMBER NOT NULL ,
    USER_NO     NUMBER NOT NULL ,
    CONSTRAINT PK_CHAT_ROOM_JOIN PRIMARY KEY (CHATROOM_NO, USER_NO),
    CONSTRAINT FK_CHAT_ROOM_TO_CHAT_ROOM_JOIN FOREIGN KEY (CHATROOM_NO) REFERENCES CHAT_ROOM(CHATROOM_NO),
    CONSTRAINT FK_MEMBER_TO_CHAT_ROOM_JOIN FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO)
);

--채팅방 첨부파일 테이블 -- 

CREATE TABLE CFILE (
    CFILE_NO      NUMBER        NOT NULL,
    CFILE_NAME    VARCHAR2(200) NOT NULL,
    CHANEGE_NAME  VARCHAR2(300) NOT NULL,
    CREATE_DATE   DATE              DEFAULT SYSDATE,
    FILE_PATH     VARCHAR2(500) NULL    ,
    STATUS        CHAR(1)       DEFAULT 'Y' ,
    USER_NO       NUMBER        NOT NULL ,
    CHATROOM_NO  NUMBER        NOT NULL ,
    CONSTRAINT PK_CFILE PRIMARY KEY (CFILE_NO),
    CONSTRAINT FK_MEMBER_TO_CFILE FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_CHAT_ROOM_TO_CFILE FOREIGN KEY (CHATROOM_NO) REFERENCES CHAT_ROOM(CHATROOM_NO)
    
);

-- 신고 하기 
CREATE TABLE REPORT (
    REPORT_NO      NUMBER        NOT NULL ,
    REPORT_CONENT  VARCHAR2(4000) NOT NULL,
    CREATE_DATE    DATE          DEFAULT SYSDATE ,
    STATUS         CHAR(1)         DEFAULT 'Y' ,
    REPORTER_NO    NUMBER        NOT NULL ,
    REPORTED_NO    NUMBER        NOT NULL ,
    CONSTRAINT PK_REPORT PRIMARY KEY (REPORT_NO),
    CONSTRAINT FK_MEMBER_TO_REPORTER FOREIGN KEY (REPORTER_NO) REFERENCES MEMBER(USER_NO),
    CONSTRAINT FK_MEMBER_TO_REPORTED_1 FOREIGN KEY (REPORTED_NO) REFERENCES MEMBER(USER_NO)
    
);


