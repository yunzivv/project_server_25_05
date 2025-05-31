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