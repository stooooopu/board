-- 만약 dw라는 database가 존재하지 않는다면 이렇게 생성
-- 지금 이 CREATE에서는 대소문자 구분 안함
-- CREATE database IF NOT EXISTS DW DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
-- USE DW; 데이터베이스를 만들면 이걸 사용할 거라고 말하는거 

-- sql파일 여기서 table작성
-- CREATE TABLE IF NOT EXISTS : 이 테이블이 존재하지 않는다면 생성해라
-- DDL autocommit
CREATE TABLE IF NOT EXISTS students( -- 학생 테이블
	students_id INTEGER(4) AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT '학생 아이디',
    students_name VARCHAR(20) COMMENT '학생 이름',
    students_password VARCHAR(200) COMMENT '학생 비밀번호', -- 우리가 암호화해서 저장하기 때문에 글자수 제한을 크게 해야함
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '가입 날짜' -- insert할때 입력 안하면 디폴트로 현재시간을 넣어 주겠다
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS board -- 게시판 테이블
( 
    board_id INTEGER(4) AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT '게시판 아이디',
    students_id INTEGER(4) COMMENT '학생 아이디',
    title VARCHAR(50) COMMENT '제목',
    content VARCHAR(100) COMMENT '글 내용',
    update_at DATETIME COMMENT '수정 날짜',
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '작성 날짜',
    CONSTRAINT board_students_id_fk FOREIGN KEY (students_id) REFERENCES students(students_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- run할 때 이 파일을 실행시킬지 결정은 yaml에서 함
-- DDL을 스키마라고 함
-- 접속이력 테이블
CREATE TABLE IF NOT EXISTS board_logs
(
	log_id BIGINT(20) AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT '로그 아이디',
	ip VARCHAR(50) COMMENT '아이피',
	latitude VARCHAR(20) COMMENT '위도',
	longitude VARCHAR(20) COMMENT '경도',
	url VARCHAR(100) COMMENT '요청 url',
	http_method VARCHAR(10) COMMENT 'http method',
	create_at DATETIME COMMENT '접속 시간'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;