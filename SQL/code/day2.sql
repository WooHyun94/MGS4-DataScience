# SQL Query
# DML : DATA : CRUD
# DDL : DATABASE, TABLE : CRUD
# DCL : SYSTEM

# DDL : READ
# show databases : show tables

# DML : READ : select from
# select code, name from country
# as : alias : change column name
# operator : 산술, 비교, 논리

# where : 특정 조건으로 데이터를 검색할때 사용
# where > 산술, 비교, 논리 연산자 사용 가능
use world;
select code, population
from country
where population >= 10000 * 10000;

# 국가의 인구수가 8천만 ~ 1억인 국가의 국가코드, 국가이름, 인구수 출력
select code, name, population
from country
where (population >= 8000*10000) and (population <= 10000*10000);

# between and
select code, name, population
from country
where population between 8000*10000 and 10000*10000;

# in, not in
# asia, africa 대륙의 국가코드, 국가이름, 대륙이름 출력
select code, name, continent
from country
where (continent = "asia") or (continent = "africa");

# asia, africa를 제외한 국가 출력
select code, name, continent
from country
where continent not in ("asia", "africa");

# like : 특정 문자열 포함된 데이터 출력 : df.str.contains("keyword")
# 국가코드가 K로 시작하는 국가의 국가코드, 국가이름 출력
# % : 아무 문자 0개 이상
select code, name
from country
where code like "%K%";

# order by : asc, desc
# asc 생략가능 
# 국가의 인구수가 많은 순으로 정렬해서 국가코드, 인구수 출력
select code, population
from country
order by population desc;

# limit : 조회하는 데이터의 수를 제한해서 출력
# 인구수가 많은 5개의 국가를 출력 : 인구수 내림차순 > 상위 5개만 출력
select code, population
from country
order by population desc
limit 5;

# 인구수 상위 5위 ~ 7위까지 출력 : 상위 4개 스킵 > 3개 데이터 출력
# limit <skip>, <limit>
select code, population
from country
order by population desc
limit 4, 3;

# DML : READ : select, from, where, order by, limit
# operator : 산술, 비교, 논리
# where : between and, in, not in, like

# DDL : CREATE : create
# Table : 필드명, 데이터타입, 제약조건

# 데이터타입
# 숫자 : int, float
# 문자열 : char, varchar, text
# 날짜시간 : date, time, datetime, timestamp, year

# 제약조건
desc city;
# not null : null 값 저장 X
# unique : 중복값 저장 X
# primary key : not null, unique 제약조건을 동시에 가짐
# 	테이블당 하나를 가짐 : row를 구별해주는 역할
# default : 데이터가 넘어오지 않으면 저장되는 데이터 설정
# auto_increment : 자동으로 1씩 증가시켜서 데이터 저장
# foreign key : 데이터의 무결성을 지킴

# DDL : CREATE : create
# 데이터베이스 생성
create database test_pdj;

# 테이블 생성 : 필드, 데이터타입, 제약조건
select database();
use test_pdj;
drop table user;

create table user(
	user_id int primary key auto_increment
    , name varchar(20) not null
    , email varchar(30) unique not null
    , age int default 30
    , rdate timestamp default current_timestamp
);

desc user;

# DDL : UPDATE : alter
# 데이터 베이스 인코딩 방식 수정
show variables like "character_set_database";
# dataframe to excel : encoding="utf-8-sig"
alter database test_pdj character set = utf8mb4;
show variables like "character_set_database";

# 테이블 속성값 수정
# ADD(필드추가), MODIFY(필드수정:데이터타입,제약조건), DROP(필드삭제)
desc user;

# 필드 추가 : add
alter table user add content text not null;

# 필드 수정 : modify column
alter table user modify column content varchar(100) not null default "no data";

show tables;
select database();

# 필드 삭제 : drop
alter table user drop content;
desc user;

# DDL : DELETE : drop
create database tmp;
use tmp;
create table test(
	test_id int
);
show tables;

# 테이블 삭제
drop table test;
show tables;

# 데이터베이스 삭제
show databases;
drop database tmp;

# DML : READ : select from where order by limit
# DDL : CREATE : create database, create table(field name, dt, con)
# DDL : READ : show, desc
# DDL : UPDATE : alter
# DDL : DELETE : drop

# DML : READ
# DDL : CREATE, READ, UPDATE, DELETE

# DML : CREATE : insert into
use test_pdj;
show tables;
desc user;

insert into user(name, email, age)
values ("andy", "andy@gmail.com", 23)
, ("jhon", "jhon@gmail.com", 42)
, ("peter", "peter@naver.com", 37)
, ("alice", "alice@naver.com", 17)
, ("anchel", "anchel@naver.com", 35);

select * from user;
desc user;

insert into user(name, email)
values ("po", "po@gmail.com");
select * from user;

insert into user(name, email)
values ("po2", "po@gmail.com");
select * from user;

# select 로 출력된 결과 테이블에 저장 
create table backup(
	user_id int
    , name varchar(20)
);

desc backup;
select * from backup;

insert into backup
select user_id, name 
from user
where age >= 30;

select * from backup;

# DML : UPDATE : update set
select * from user;

# 29세 이하는 나이를 20세로 변경 
update user
set age = 20
where age < 30
limit 5;
select * from user;

update user
set name="jin", email="jin@gmail.com"
where name="po"
limit 1;
select * from user;

show processlist;
kill 13;

# DML : DELETE : delete from
# user의 나이가 30세 미만의 데이터 삭제
select * from user;
delete from user
where age < 30 
limit 2;

# DML : DATA : C(insert into)R(select from)U(update set)D(delete from)
# DDL : DATABASE, TABLE : C(create)R(show, desc)U(alter)D(drop)

# foreign key : 외래키
# 데이터의 무결성을 지키기 위해서 사용
# unique, primary key 제약조건이 있어야 설정 가능

# 테이블 생성
create table customer(
	user_id int primary key auto_increment
    , name varchar(20) not null
);

drop table income;
create table income(
	user_id int not null
    , amount int not null
);

insert into customer(name)
values ("a"), ("b"), ("c");
select * from customer;

insert into income(user_id, amount)
values (1, 100), (3, 200), (1, 200);
select * from income;

# fk 설정 안한상태에서 데이터 추가
insert into income(user_id, amount)
values (4, 400);
select * from income;

# income 테이블 초기화
truncate income; # 스키마는 남고 데이터만 삭제
select * from income;

alter table income
add constraint user_fk
foreign key (user_id)
references customer (user_id);
desc income;

insert into income(user_id, amount)
values (1, 100), (3, 200), (1, 200);
select * from income;

# fk 설정후 데이터 추가
insert into income(user_id, amount)
values (4, 400);

# 참조된 필드의 데이터 삭제
select * from customer;
delete from customer
where user_id = 3
limit 1;

# 테이블 삭제 되지 않음
drop table customer;

# fk 설정 : on update, on delete
# cascade : 동기화
# set null : null 데이터로 변경
# no action : 변경 X
# set default : default 값으로 변경
# restrict : 에러 발생 : 수정, 삭제 불가

# on update : cascade
# on delete : set null
drop table income;
create table income(
	user_id int
    , amount int not null
    , foreign key (user_id) references customer(user_id)
    on update cascade on delete set null
);

insert into income(user_id, amount)
values (1, 100), (3, 200), (1, 200);
select * from income;

update customer
set user_id = 4
where user_id = 3
limit 1;
select * from customer;
select * from income;

delete from customer
where user_id = 4
limit 1;
select * from customer;
select * from income;

# functions : round, concat, count, distinct, date_format
select round(12.345, 2);

# concat : 국가이름(국가코드) 가 출력되는 컬럼을 생성
use world;
select code, name, concat(name, "(", code, ")") as name_code
from country;

# count : row 데이터의 갯수 출력
select count(*) from country;
select count(code) from country;

# distinct : 중복데이터 제거
# 전체 대륙의 종류의 갯수를 출력 : 중복되는 대륙 제거(distinct()) > 데이터의 갯수 출력(count())
select count(distinct(continent)) as continent_count
from country;

# date_format : 날짜시간 데이터의 모양을 변경 : 년월일 시분초 > 년월
use sakila;
select * from payment;
# 매출이 발생한 년월을 출력 : 매출 데이터를 년월 데이터로 변경(date_format) > 중복데이터 제거(distinct)
select distinct(date_format(payment_date, "%Y-%m"))
from payment;

# group by : 특정컬럼(중복결합), 다른컬럼(결함함수) > 데이터 출력
# 결합함수 : min, max, avg, sum, count ...
# 어떤 스태프가 더 많은 매출을 올렸을까?
select staff_id, sum(amount), count(amount), sum(amount) / count(amount)
from payment
group by staff_id;

























