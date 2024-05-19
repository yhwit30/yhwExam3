DROP DATABASE IF EXISTS `yhwExam`;
CREATE DATABASE `yhwExam`;
USE `yhwExam`;


CREATE TABLE `article` (
	`id`	INT(10)	NOT NULL,
	`regDate`	DATETIME	NULL	COMMENT '작성날짜',
	`updateDate`	DATETIME	NULL	COMMENT '수정날짜',
	`title`	CHAR(100)	NULL	COMMENT '제목',
	`body`	TEXT	NULL	COMMENT '내용'
);


## 주키 추가
ALTER TABLE `article` MODIFY `id`  INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);


# answer 테이블 생성
CREATE TABLE qna(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `key` CHAR(255) NOT NULL,
    answer CHAR(255) NOT NULL
);


INSERT INTO qna
SET `key` = '지역',
answer = '지역에 관련된 데이터를 검색하려면, 키워드 항목에 원하는 지역을 입력 후 검색을 누르세요';
INSERT INTO qna
SET `key` = '코스',
answer = '원하는 관광코스는 해시태그에서 선택할 수 있습니다';
INSERT INTO qna
SET `key` = '검색',
answer = '관광지를 검색하려면, 지역과 해시태그를 선택하고 검색을 누르세요';


SELECT * FROM qna
WHERE `key` LIKE '%검색%';

#tour_api : %2BczOQiKpEnorU9I8TbELu0DP9c3DNrENiO4%2Fn2%2Fz5h4ecmec6LdcOy2WXWcHP%2F2TCPAQmHpPoCmhv%2FvFogSagQ%3D%3D

#openweather_api : 2d1119c77c14a77fee290dd58e72b536

