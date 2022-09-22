# SQL Query : 데이터 베이스에서 데이터를 가져오는 문법
# CRUD : create, read, update, delete
# DML : DATA : CRUD : 트랜젝션
#	- C(insert into)R(select from)U(update set)D(delete from)
# DDL : DATABASE, TABLE : CRUD
#	- C(create)R(show, desc)U(alter)D(drop)
# DCL : SYSTEM

# DML : READ : select from
# where, order by, limit

# world 데이터 베이스의 country 테이블에 있는 데이터 출력
select *
from world.country;

# 데이터 베이스 선택 후 테이블 데이터 조회
use world; # 데이터 베이스 선택
SELECT * FROM country;

# PEP8 : 파이썬 코딩 스타일 가이드
# SQL 대소문자 구분 X
select code, name, population
from country;

# as : alias : 컬럼명을 변경
select code, name as country_name, population
from country;

# 쿼리 실행 단축키 : MAC(cmd + shift + enter) : WINDOWS(ctrl + enter)




















