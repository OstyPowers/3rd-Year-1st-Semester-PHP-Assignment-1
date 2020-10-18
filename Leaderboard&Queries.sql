drop database if exists Leaderboard;
create database Leaderboard;
use Leaderboard;

drop table if exists UserDetails;
create table Userdetails (
	userId smallint not null,
    firstName varchar(20) not null,
    lastName varchar(25) not null,
    email nvarchar(30) not null,
    country varchar(60),
    age int(2),
    primary key (userId)
) engine = InnoDB;

drop table if exists StoreSystem;
create table StoreSystem (
	username varchar(20) not null,
    userId smallint not null,
    password varchar(30) not null,
    primary key (username)
) engine = InnoDB;

drop table if exists Score;
create table Score (
	scoreId varchar(10) not null,
    points int(6) not null,
    dateSubmit datetime not null,
    username varchar(20) not null,
    primary key (scoreId)
) engine = InnoDB;

drop table if exists Display;
create table Display (
	rank int(3) not null,
    scoreId varchar(10) not null,
    primary key (rank)
) engine = InnoDB;

alter table StoreSystem add constraint fk_StoreSystem_UserDetails foreign key (userId)
references UserDetails(userId);

alter table Score add constraint fk_Score_StoreSystem foreign key (username)
references StoreSystem(username);

alter table Display add constraint fk_Display_Score foreign key(scoreId)
references Score(scoreId); 

insert UserDetails ( userId, firstName, lastName, email, country, age) values ('132', 'John', 'Davis', 'johndavis@gmail.com', 'Germany', 15);
insert UserDetails ( userId, firstName, lastName, email, country, age) values ('133', 'Marcus', 'Lance', 'Marc_lan@gmail.com', 'Mexico', 28);
insert UserDetails ( userId, firstName, lastName, email, country, age) values ('134', 'Mike', 'Andrews', 'MikeAnd@gmail.com', 'USA', 30);
insert UserDetails ( userId, firstName, lastName, email, country, age) values ('135', 'Andrew', 'Hill', 'aHill@gmail.com', 'Italy', 18);
insert UserDetails ( userId, firstName, lastName, email, country, age) values ('136', 'Daniel', 'van Hoof', 'DanDan@gmail.com', 'NZ', 22);

insert StoreSystem ( username, userId, password) values ('JDavis', '132', 'guest1');
insert StoreSystem ( username, userId, password) values ('Marco', '133', 'guest2');
insert StoreSystem ( username, userId, password) values ('Mike11', '134', 'guest3');
insert StoreSystem ( username, userId, password) values ('AHill', '135', 'guest4');
insert StoreSystem ( username, userId, password) values ('DanJ23', '136', 'guest5');

insert Score ( scoreId, points, dateSubmit, username) values ('abc1', 1500,  '2020-08-04 08:10:00', 'JDavis');
insert Score ( scoreId, points, dateSubmit, username) values ('abc2', 1425,  '2020-08-04 09:10:00', 'Marco');
insert Score ( scoreId, points, dateSubmit, username) values ('abc3', 950,  '2020-08-03 10:10:00', 'Mike11');
insert Score ( scoreId, points, dateSubmit, username) values ('abc4', 640,  '2020-08-02 11:10:00', 'Ahill');
insert Score ( scoreId, points, dateSubmit, username) values ('abc5', 375,  '2020-08-01 12:10:00', 'DanJ23');

insert Display ( rank, scoreId) values (1, 'abc1'); 
insert Display ( rank, scoreId) values (2, 'abc2'); 
insert Display ( rank, scoreId) values (3, 'abc3'); 
insert Display ( rank, scoreId) values (4, 'abc4'); 
insert Display ( rank, scoreId) values (5, 'abc5'); 

-- testing to see if data has been inserted into tables
select * from UserDetails;
select * from StoreSystem;
select * from Score;
select * from Display;

-- simple query
select concat(firstName,' ', lastName) as Fullname, country as Country,age as Age, username as Username
from UserDetails, StoreSystem
where UserDetails.userId = StoreSystem.userId
order by age;

-- complex query
select concat(firstName, ' ', lastName) as Fullname, country as Country, StoreSystem.username as Username, Score.points as Points
from UserDetails
inner join StoreSystem on StoreSystem.userId = UserDetails.userId 
inner join Score on Score.username = StoreSystem.username
where dateSubmit like '2020-08%'
order by dateSubmit;

-- awesomely complex query
create or replace view LeaderboardWeeklybyAge as
select concat(firstName,' ', lastName) as Fullname, age as Age, StoreSystem.username as Username, Score.points as Points, Display.rank as 'Rank'
from UserDetails
inner join StoreSystem on StoreSystem.userId = UserDetails.userId
inner join Score on Score.username = StoreSystem.username
inner join Display on Display.scoreId = Score.scoreId
where dateSubmit between '2020-08-01' and '2020-08-07'
order by Display.rank;

-- testing view
select * from LeaderboardWeeklybyAge;



    