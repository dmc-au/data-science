-- ZZEN9311 Assignment 1b
-- Schema for the mypics.net photo-sharing site
--
-- Written by David Cole


-- Domains

create domain URLValue as
	varchar(100) check (value like 'https://%');

create domain EmailValue as
	varchar(100) check (value like '%@%.%');

create domain GenderValue as
	varchar(6) check (value in ('male','female'));

create domain GroupModeValue as
	varchar(15) check (value in ('private','by-invitation','by-request'));

create domain VisibilityValue as
	varchar(15) check (value in ('private', 'friends', 'family', 'friends+family', 'public'));

create domain SafetyValue as
	varchar(15) check (value in ('safe', 'moderate', 'restricted'));

create domain FreqValue as
	integer check (value >= 1);

create domain RatingValue as
	integer check (value >= 1 and value <= 5);

create domain NameValue as varchar(50);

create domain LongNameValue as varchar(100);


-- Tables

create table People (
	person_id serial not null,
	family_name NameValue,
	given_names NameValue not null,
	displayed_name LongNameValue,
	email_address EmailValue,
	primary key (person_id)
);

create table Photos (
	photo_id serial not null,
	date_taken date,
	title NameValue not null,
	date_uploaded date not null,
	description text,
	technical_details text,
	safety_level SafetyValue not null,
	visibility VisibilityValue not null,
	file_size integer,
	owner serial not null,
	primary key (photo_id)
);

create table Users (
	user_id serial not null,
	person serial not null,
	website URLValue,
	date_registered date not null,
	gender GenderValue,
	birthday date,
	password text not null,
	portrait serial,
	primary key (user_id)
);

create table Friends ( -- How to enforce a non-empty friend-list?
	friend_id serial not null,
	title text not null,
	owner serial not null,
	primary key (friend_id)
);

create table People_in_Friends (
	friend_id serial not null,
	person_id serial not null,
	primary key (friend_id, person_id)
);

create table Groups (
	group_id serial not null,
	title text not null,
	mode GroupModeValue not null,
	owner serial not null,
	primary key (group_id)
);

create table Users_in_Groups (
	group_id serial not null,
	user_id serial not null,
	primary key (group_id, user_id)
);

create table Collections (
	collection_id serial not null,
	title NameValue not null,
	description text,
	key_photo serial not null,
	owner serial not null,
	primary key(collection_id)
);

create table Photos_in_Collections (
	collection_id serial not null,
	photo_id serial not null,
	order_number integer,
	primary key(collection_id, photo_id)
);

create table Group_Collections (
	collection_id serial not null,
	title NameValue not null,
	description text,
	key_photo serial not null,
	owner serial not null,
	primary key(collection_id)
);

create table Photos_in_Group_Collections (
	collection_id serial not null,
	photo_id serial not null,
	order_number integer,
	primary key(collection_id, photo_id)
);

create table Ratings (
	user_id serial not null,
	photo_id serial not null,
	rating RatingValue not null,
	when_rated date not null,
	primary key (user_id, photo_id)
);

create table Discussions (
	discussion_id serial not null,
	title NameValue,
	photo serial,
	group_id serial,
	primary key(discussion_id)
);

create table Comments (
	comment_id serial not null,
	when_posted date not null,
	content text not null,
	discussion serial not null,
	author serial not null,
	primary key(comment_id)
);

create table Tags (
	tag_id serial not null,
	user_id serial not null,
	name NameValue not null,
	photo serial not null,
	when_tagged date not null,
	freq FreqValue not null default 1,
	primary key(tag_id)
);

-- Alter table statements
alter table Photos
add foreign key (owner) references Users(user_id);

alter table Users
add foreign key (user_id) references People(person_id),
add foreign key (portrait) references Photos(photo_id);

alter table Friends
add foreign key (owner) references Users(user_id);

alter table People_in_Friends
add foreign key (friend_id) references Friends(friend_id),
add foreign key (person_id) references People(person_id);

alter table Groups
add foreign key (owner) references Users(user_id);

alter table Users_in_Groups
add foreign key (group_id) references Groups(group_id),
add foreign key (user_id) references Users(user_id);

alter table Collections
add foreign key (key_photo) references Photos(photo_id),
add foreign key (owner) references Users(user_id);

alter table Photos_in_Collections
add foreign key (collection_id) references Collections(collection_id),
add foreign key (photo_id) references Photos(photo_id);

alter table Group_Collections
add foreign key (key_photo) references Photos(photo_id),
add foreign key (owner) references Groups(group_id);

alter table Photos_in_Group_Collections
add foreign key (collection_id) references Group_Collections(collection_id),
add foreign key (photo_id) references Photos(photo_id);

alter table Ratings
add foreign key (user_id) references Users(user_id),
add foreign key (photo_id) references Photos(photo_id);

alter table Discussions
add foreign key (photo) references Photos(photo_id),
add foreign key (group_id) references Groups(group_id);

alter table Comments
add foreign key (discussion) references Discussions(discussion_id),
add foreign key (author) references Users(user_id);

alter table Tags
add foreign key (user_id) references Users(user_id),
add foreign key (photo) references Photos(photo_id);

