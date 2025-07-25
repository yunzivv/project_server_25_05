############################################################# 개인 프로젝트 ##################################################################################
DROP DATABASE IF EXISTS project_25_05;
CREATE DATABASE project_25_05;
USE project_25_05;

# 게시물 테이블
CREATE TABLE article(
                        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        regDate DATETIME NOT NULL,
                        updateDate DATETIME NOT NULL,
                        title VARCHAR(100) NOT NULL,
                        `body` LONGTEXT NOT NULL,
                        memberId INT UNSIGNED NOT NULL,
                        boardId INT UNSIGNED NOT NULL,
                        certId INT UNSIGNED,
                        hits INT UNSIGNED NOT NULL DEFAULT 0
);

# 게시판 테이블
CREATE TABLE board (
                       id TINYINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                       `code` VARCHAR(20) NOT NULL,
                       `name` VARCHAR(20) NOT NULL,
                       regDate DATETIME NOT NULL,
                       updateDate DATETIME NOT NULL,
                       delStatus TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0 = 존재, 1 = 삭제',
                       delDate DATETIME
);


# 댓글 테이블
CREATE TABLE `comment` (
                           id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           memberId INT UNSIGNED NOT NULL,
                           relTypeCode VARCHAR(20) NOT NULL,
                           relId INT UNSIGNED NOT NULL,
                           `body` TEXT NOT NULL,
                           regDate DATETIME NOT NULL,
                           updateDate DATETIME NOT NULL
);


# 좋아요 테이블
CREATE TABLE reaction (
                          id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          relTypeCode VARCHAR(20) NOT NULL COMMENT '관련 데이터 타입 코드',
                          relId INT UNSIGNED NOT NULL COMMENT '관련 데이터 id',
                          memberId INT UNSIGNED NOT NULL,
                          `point` TINYINT(1) NOT NULL COMMENT '1 = 좋아요, 0 = 좋아요 취소',
                          regDate DATETIME NOT NULL,
                          updateDate DATETIME NOT NULL
);

# 자격증 시험 테이블
CREATE TABLE exam (
                      id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                      certId INT UNSIGNED NOT NULL,
                      category CHAR(10) NOT NULL,
                      examDate DATE NOT NULL,
                      regDate DATETIME NOT NULL,
                      updateDate DATETIME NOT NULL
);

# 시험 문제 테이블
CREATE TABLE questions (
                           id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           certId INT UNSIGNED,
                           examId INT UNSIGNED,
                           subjectId INT UNSIGNED,
                           questNum SMALLINT UNSIGNED NOT NULL,
                           `body` TEXT,
                           hasImage BOOLEAN DEFAULT FALSE,
                           imgUrl VARCHAR(255),
                           regDate DATETIME NOT NULL,
                           updateDate DATETIME NOT NULL,

                           INDEX idx_exam_subject (examId, subjectId)
);


# 시험 선택지 테이블
CREATE TABLE choices (
                         id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         questId INT UNSIGNED NOT NULL,
                         label TINYINT UNSIGNED NOT NULL,
                         `body` TEXT NOT NULL,
                         isCorrect BOOLEAN NOT NULL,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL
);


# 자격증 테이블
CREATE TABLE certificate (
                             id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             `name` VARCHAR(50) NOT NULL,
                             certGrade INT UNSIGNED,
                             isNational TINYINT COMMENT '0=국가공인민간자격 1 = 국가기술자격, -1 = 민간자격',
                             agency VARCHAR(100),
                             parentId INT UNSIGNED,
                             href VARCHAR(500),
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL
);


# 자격증 과목 테이블
CREATE TABLE certSubject (
                             id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             certId INT UNSIGNED NOT NULL,
                             subjectNum SMALLINT UNSIGNED,
                             `name` VARCHAR(50),
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL
);

# 직무 카테고리 테이블
CREATE TABLE jobCat (
                        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `name` VARCHAR(50) NOT NULL,
                        regDate DATETIME NOT NULL,
                        updateDate DATETIME NOT NULL
);

# 직무 테이블
CREATE TABLE jobCode (
                         id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         jobCatId INT UNSIGNED NOT NULL,
                         jobCatName VARCHAR(50) NOT NULL,
                         `code` INT UNSIGNED NOT NULL,
                         `name` VARCHAR(50) NOT NULL,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL
);


# 자격증 언급 테이블
CREATE TABLE certMention (
                             id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             jobCatId INT UNSIGNED NOT NULL,
                             jobCodeId INT UNSIGNED NOT NULL,
                             certId INT UNSIGNED NOT NULL,
                             gno INT UNSIGNED NOT NULL,
                             `source` VARCHAR(20) NOT NULL DEFAULT "jobkorea",
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL
);


# 회원 테이블
CREATE TABLE `member`(
                         id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL,
                         loginId VARCHAR(20) NOT NULL UNIQUE,
                         loginPw VARCHAR(100) NOT NULL,
                         `authLevel` TINYINT UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반/7=관리자)',
                         `name` VARCHAR(20) NOT NULL,
                         nickName VARCHAR(20) NOT NULL,
                         birthday DATE NOT NULL,
                         cellPhone VARCHAR(254) NOT NULL,
                         email VARCHAR(100) NOT NULL, # 이메일은 이론상 254자까지 가능
                         delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부(0=존재/1=탈퇴)',
                         delDate DATETIME COMMENT '탈퇴날짜'
);

# 멤버 삽입
INSERT INTO `member`
SET regDate = NOW(),
    updateDate = NOW(),
    loginId = 'admin',
    loginPw = 'admin',
    `authLevel` = 7,
    `name` = 'admin',
    birthday = '2020-10-10',
    nickName = 'admin',
    cellPhone = '01012345678',
    email = 'admin@spring.com';

# 멤버 삽입
INSERT INTO `member`
SET regDate = NOW(),
    updateDate = NOW(),
    loginId = CONCAT('id', '1'),
    loginPw = CONCAT('pw', '1'),
    birthday = '2020-10-10',
    `name` = CONCAT('이름', '1'),
    nickName = CONCAT('닉네임', '1'),
    cellPhone = CONCAT('010123456', SUBSTRING(RAND() *1000 FROM 1 FOR 2)),
    email = CONCAT('member1', '@gmail.com');


# 회원 자격증 테이블
CREATE TABLE memberCert (
                            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                            memberId INT UNSIGNED NOT NULL,
                            certId INT UNSIGNED,
                            certName VARCHAR(100) NOT NULL,
                            startDate DATE COMMENT '취득일',
                            endDate DATE COMMENT '만료일',
                            regDate DATETIME NOT NULL,
                            updateDate DATETIME NOT NULL,
                            certificateNumber VARCHAR(100) COMMENT '자격번호',
                            alert BOOLEAN NOT NULL DEFAULT ture COMMENT '알림 설정'
);

# 회원 시험 기록 테이블
CREATE TABLE memberExam (
                            id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                            memberId INT UNSIGNED NOT NULL,
                            certId INT UNSIGNED NOT NULL,
                            examId INT UNSIGNED,
                            elapsedTime TIME NOT NULL,
                            totalQuest INT UNSIGNED NOT NULL,
                            correctQuest INT UNSIGNED NOT NULL,
                            regDate DATETIME NOT NULL,
                            updateDate DATETIME NOT NULL
);



# 게시판 테이블 데이터 추가
INSERT INTO board SET
                      `code` = 'notice',
                      `name` = '공지사항',
                      regdate = NOW(),
                      updatedate = NOW();

INSERT INTO board SET
                      `code` = 'review',
                      `name` = '시험후기',
                      regdate = NOW(),
                      updatedate = NOW();

INSERT INTO board SET
                      `code` = 'library',
                      `name` = '자료실',
                      regdate = NOW(),
                      updatedate = NOW();

INSERT INTO board SET
                      `code` = 'QnA',
                      `name` = '질문과 답변',
                      regdate = NOW(),
                      updatedate = NOW();

INSERT INTO board SET
                      `code` = 'free',
                      `name` = '자유게시판',
                      regdate = NOW(),
                      updatedate = NOW();

