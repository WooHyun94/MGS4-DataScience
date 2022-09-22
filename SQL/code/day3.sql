# DML : DATA : C(insert into)R(select from)U(update set)D(delete from)
# DDL : DATABASE, TABLE : C(create)R(show, desc)U(alter)D(drop)

# 테이블 생성 : 필드명, 데이터타입, 제약조건
# 데이터 타입
# - number(int, float), string(char, varchar, text), datetime(datetime, timestamp)
# 제약조건
# - not null, unique, primary key, default, auto_increment
# - foregin key : on update, on delete

# functions : round(), concat(), count(), distinct(), date_format()

# group by : 특정컬럼(중복결합), 다른컬럼(결합함수)
# 결합함수 : sum(), min(), max(), avg(), count()
use world;
# country 테이블에서 대륙별 대륙이름과 총인구수를 출력
# 인구수가 5억 이상인 대륙이름과 대륙의 총인구수를 출력 
# having : 쿼리 실행 후에 조건에 따라 데이터를 필터링
select continent, sum(population) as population
from country
group by continent
having population >= 50000 * 10000;

# sakila 데이터 베이스에서 년월별 매출 결과 출력 : 날짜데이터변환 > group by
# group by, date_format()
use sakila;
select date_format(payment_date, "%H") as monthly
	   , sum(amount) as amount
from payment
group by monthly
order by amount desc;

# JOIN : 특정 컬럼을 기준으로 2개의 테이블을 결합하는 방법
# inner, left, right, outer
drop database mgs;
create database mgs;
use mgs;

# 테이블 생성
create table user(
	user_id int primary key auto_increment
    , name varchar(20)
);
create table addr(
	user_id int
    , aname varchar(10)
);

# 데이터 추가
insert into user(name)
values ("a"), ("b"), ("c");
select * from user;

insert into addr(user_id, aname)
values (1, "seoul"), (2, "pusan"), (4, "daegu"), (5, "seoul");
select * from addr;

# inner join
select user.user_id, user.name, addr.aname
from user
join addr
on user.user_id = addr.user_id;

# left join
select user.user_id, user.name, addr.aname
from user
left join addr
on user.user_id = addr.user_id;

# right join
select addr.user_id, user.name, addr.aname
from user
right join addr
on user.user_id = addr.user_id;

# inner join : join 안쓰고 ,로 join
select user.user_id, user.name, addr.aname
from user, addr
where user.user_id = addr.user_id;

use world;

# 국가코드, 국가이름, 도시이름, 국가인구수, 도시인구수 출력
# 도시화율(도시인구수/국가인구수) 출력
# 국가의 인구수 1000만명 이상인 국가만 출력
# 도시화율이 높은 5개의 국가의 도시를 출력 : order by > limit
select country.code, country.name as country_name, city.name as city_name
	   , country.population, city.population
       , round(city.population / country.population * 100, 2) as city_ratio
from country
join city
on country.code = city.countrycode
having country.population >= 1000 * 10000
order by city_ratio desc
limit 5;

# union : 두개의 쿼리를 실행한 결과를 붙여서 출력 : 중복제거
use mgs;
select name from user
union
select aname from addr;

select user.user_id, user.name, addr.aname
from user
left join addr
on user.user_id = addr.user_id
union
select addr.user_id, user.name, addr.aname
from user
right join addr
on user.user_id = addr.user_id;

# Sub Query : 쿼리 안에 쿼리 작성
# select, from, where
use world;

# select : 전체 국가수, 전체 도시수를 1개의 row로 출력
select (select count(*) from country) as country_count
	   , (select count(*) from city) as city_count;

# from : 900만 이상의 도시인구를 가진 도시의 국가코드, 국가이름, 도시이름, 도시인구수 출력
# join(239*4097) > having(condition)
select country.code, country.name, city.name, city.population
from country
join city
on country.code = city.countrycode
having city.population >= 900 * 10000;

# sub query
# where(condition) > join(239*6)
select country.code, country.name, city.name, city.population
from country
join (select * from city where population >= 900 * 10000) as city
on country.code = city.countrycode;

# where : 한국(KOR)의 국가 인구수 보다 많은 국가의 국가코드, 국가이름, 인구수 출력
select code, name, population
from country
where code = "KOR";

# 46844000
select code, name, population
from country
where population >= 46844000;

# sub query
select code, name, population
from country
where population >= (
	select population
	from country
	where code = "KOR"
);

# Index : 데이터의 검색속도를 빠르게 하는 방법
# 단점 : 저장공간 10% 더 사용 : insert, update, delete 속도가 느려짐
# 장점 : 검색 속도가 빨라짐
use employees;
select count(*) from salaries;

# show index
show index from salaries;

# no index : speed query : 0.8 sec
select * from salaries where to_date < "1986-01-01";

# set index
create index tdate on salaries (to_date);

# show index
show index from salaries;

# is index : speed query : 0.041 sec
select * from salaries where to_date < "1986-01-01";

# drop index
drop index tdate on salaries;

# show index
show index from salaries;

# explain : 실행계획 : 쿼리를 실행하기 전에 쿼리가 어떻게 실행될지 미리확인
explain
select * from salaries where to_date < "1986-01-01";

# set index
create index tdate on salaries (to_date);

explain
select * from salaries where to_date < "1986-01-01";

# index 사용시 주의사항 : where에서 많이 사용되는 필드를 인덱스로 설정

use world;
select * from country where population >= 4000*10000;

# group by, having, join, union, index
# trigger, backup, jupyter notebook 

# trigger : 특정 테이블을 감시하고 있다가 설정한 조건이 감지되면 지정해 놓은 쿼리 실행
# 예) user 테이블에 update, delete 쿼리를 감시하다가 update, delete 쿼리가 실행되면,
# backup 테이블에 수정, 삭제되는 데이터를 insert 실행
# 1일 단위로 데이터를 백업할때 사용
use mgs;
show tables;
drop table addr;
drop table user;

# 테이블 생성
create table chat(
	chat_id int primary key auto_increment
    , msg varchar(100) not null
);

create table chatBackup(
	backup_id int primary key auto_increment
    , chat_id int not null
    , msgBackup varchar(100) not null
    , backupDate timestamp default current_timestamp
);

# 트리거 확인
show triggers;

-- delimiter |
-- 	create trigger backup
-- 	before delete on chat
-- 	for each row begin
-- 		insert into chatBackup(chat_id, msgBackup)
-- 		values (old.chat_id, old.msg);
-- end |

show triggers;

# 데이터 추가
truncate chat;
truncate chatBackup;
insert into chat(msg)
values ("hello"), ("hi"), ("my name is andy!");
select * from chat;

# 데이터 삭제
delete from chat
where msg like "h%"
limit 5;

select * from chatBackup;

# restore : 복원
insert into chat
select chat_id, msgBackup as msg
from chatBackup;

# chatBackup 초기화
truncate chatBackup;

# BACKUP




















































