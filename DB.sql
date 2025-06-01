CREATE DATABASE jyj_project;
USE jyj_project;

# 회원 테이블 추가
CREATE TABLE `member`(
                         id INT(100) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반/7=관리자)',
                         loginId VARCHAR(100) NOT NULL UNIQUE,
                         loginPw VARCHAR(100) NOT NULL,
                         `name` VARCHAR(10) NOT NULL,
                         nickName VARCHAR(10) NOT NULL,
                         cellPhone VARCHAR(100) NOT NULL,
                         email VARCHAR(100) NOT NULL,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL,
                         delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부(0=존재/1=탈퇴)',
                         delDate DATETIME COMMENT '탈퇴날짜'
);

# admin 회원 데이터 추가
INSERT INTO `member`
SET regDate = NOW(),
    updateDate = NOW(),
    loginId = 'admin',
    loginPw = 'admin',
    `authLevel` = 7,
    `name` = 'admin',
    nickName = 'admin',
    cellPhone = '01012345678',
    email = 'admin@spring.com';

SELECT A.*, M.nickName,
       IFNULL(SUM(R.point), 0) AS 'avgReaction',
        IFNULL(SUM(IF(R.point > 0, R.point, 0)), 0) AS 'goodReaction',
        IFNULL(SUM(IF(R.point < 0, R.point, 0)) * -1, 0) AS 'badRreaction'
FROM article A
         JOIN `member` M
              ON A.memberId = M.id
         LEFT JOIN reactionPoint R
                   ON A.id = R.relId
WHERE A.id = 100
GROUP BY A.id
ORDER BY A.id DESC;

SELECT A.*, M.nickName, B.code AS extra_boardCode,
       IFNULL(SUM(R.point), 0) AS 'extra_sumReactionPoint'
FROM article A
         JOIN `member` M
              ON A.memberId = M.id
         JOIN board B
              ON A.boardId = B.id
         LEFT JOIN reactionPoint R
                   ON A.id = R.relId
WHERE B.id = 1
GROUP BY A.id
ORDER BY A.id DESC
    limit 0, 10;


SELECT COUNT(*)
FROM reactionPoint
WHERE relTypeCode = 'article'
  AND relId = 88
  AND memberId = 88
    insert into reactionPoint

INSERT INTO reactionPoint set
    regDate = now(),
    updateDate = now(),
    memberId = FLOOR(1 + RAND() * 8),
    relId = FLOOR(1 + RAND() * 104),
    relTypeCode = 'comment',
    `point` = if(RAND() < 0.5, -1, 1);


# 댓글별 좋아요 구하기
SELECT C.*, M.nickName as extra_writer,
       IFNULL(SUM(R.point), 0) AS 'extra_sumReaction',
        IFNULL(SUM(IF(R.point > 0, R.point, 0)), 0) AS 'extra_goodReactionPoint',
        IFNULL(SUM(IF(R.point < 0, R.point, 0)) * -1, 0) AS 'extra_goodReactionPoint'
FROM `comment` C
         JOIN `member` M
              ON C.memberId = M.id
         LEFT JOIN reactionPoint R
                   ON C.id = R.relId
where C.relId = 46
GROUP BY C.id
ORDER BY C.id DESC;


############################################################# 개인 프로젝트 ##################################################################################

create DATABASE project_25_05;
use project_25_05;

# 게시물 테이블
CREATE TABLE article(
                        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        regDate DATETIME NOT NULL,
                        updateDate DATETIME NOT NULL,
                        title VARCHAR(100) NOT NULL,
                        `body` TEXT NOT NULL,
                        memberId int UNSIGNED NOT NULL,
                        boardId tinyint UNSIGNED NOT NULL,
                        hits INT UNSIGNED NOT NULL DEFAULT 0
);

# 회원 테이블
CREATE TABLE `member`(
                         id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         regDate DATETIME NOT NULL,
                         updateDate datetime not null,
                         loginId VARCHAR(20) NOT NULL UNIQUE,
                         loginPw VARCHAR(20) NOT NULL,
                         `authLevel` tinyint UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반/7=관리자)',
                         `name` VARCHAR(20) NOT NULL,
                         nickName VARCHAR(20) NOT NULL,
                         cellPhone VARCHAR(254) NOT NULL,
                         email VARCHAR(100) NOT NULL, # 이메일은 이론상 254자까지 가능
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부(0=존재/1=탈퇴)',
                         delDate DATETIME COMMENT '탈퇴날짜'
);

# 직무 카테고리 테이블
create table jobCat (
                        id int unsigned not null primary key auto_increment,
                        `name` varchar(50) not null,
                        regDate DATETIME NOT NULL,
                        updateDate DATETIME NOT NULL
);

# 직무 코드 테이블
CREATE TABLE jobCode (
                         id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         `name` varchar(50) not null,
                         jobCatId int UNSIGNED not null,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL
);

# 자격증 테이블
CREATE TABLE certificate (
                             id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             `name` varchar(50) not null,
                             isNational boolean,
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL
);

# 자격증 시험 테이블
CREATE TABLE exam (
                      id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                      certId int UNSIGNED not null,
                      examDate date not null,
                      regDate DATETIME NOT NULL,
                      updateDate DATETIME NOT NULL
);

# 자격증 문제 테이블
CREATE TABLE questions (
                           id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           certId INT UNSIGNED NOT NULL,
                           examId int UNSIGNED not null,
                           questNum smallint UNSIGNED not null,
                           `body` text not null,
                           regDate DATETIME NOT NULL,
                           updateDate DATETIME NOT NULL
);

# 자격증 보기 테이블
CREATE TABLE choices (
                         id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         questId INT UNSIGNED NOT NULL,
                         label tinyint UNSIGNED not null,
                         `body` text not null,
                         isCorrect boolean not null,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL
);

# 자격증 과목 테이블
CREATE TABLE certSubject (
                             id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             certId INT UNSIGNED NOT NULL,
                             `name` varchar(50),
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL
);


# 자격증 언급 테이블
CREATE TABLE certMention (
                             id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             jobCodeId int unsigned not null,
                             certId INT unsigned NOT NULL,
                             gno int unsigned not null,
                             `source` varchar(20) not null default "jobkorea",
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL
);


# 자격증-직무 관계 테이블
CREATE TABLE jobCertRel (
                            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                            jobCodeId int unsigned not null,
                            certId INT UNSIGNED NOT NULL,
                            regDate DATETIME NOT NULL,
                            updateDate DATETIME NOT NULL
);


# 댓글 테이블
CREATE TABLE `comment` (
                           id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           memberId INT UNSIGNED NOT NULL,
                           relTypeCode varchar(20) not null,
                           relId int unsigned not null,
                           regDate DATETIME NOT NULL,
                           updateDate DATETIME NOT NULL
);


# 리액션 테이블
CREATE TABLE reaction (
                          id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          relTypeCode varchar(20) not null comment '관련 데이터 타입 코드',
                          relId int unsigned not null cOMMENT '관련 데이터 id',
                          memberId INT UNSIGNED NOT NULL,
                          `point` tinyint(1) not null comment '1 = 좋아요, 0 = 좋아요 취소',
                          regDate DATETIME NOT NULL,
                          updateDate DATETIME NOT NULL
);


# 게시판 테이블
CREATE TABLE board (
                       id tinyint UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                       `code` varchar(20) not null,
                       `name` varchar(20) not null,
                       regDate DATETIME NOT NULL,
                       updateDate DATETIME NOT NULL,
                       delStatus tinyint(1) not null default 0 comment '0 = 존재, 1 = 삭제',
                       delDate datetime
);

# 회원 자격증 테이블
CREATE TABLE memberCert (
                            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                            memberId int unsigned not null,
                            certId int unsigned not null,
                            startDate datetime comment '취득일',
                            endDate datetime comment '만료일',
                            regDate DATETIME NOT NULL,
                            updateDate DATETIME NOT NULL
);
