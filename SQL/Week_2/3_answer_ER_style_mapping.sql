
-- SQL Schema: using ER-style mapping of subclasses


create domain TaxFileNum as char(11)
		check (value ~ '^[0-9]{3}-[0-9]{3}-[0-9]{3}$');
create domain ISBNumber as char(15)
		check (value ~ '^[A-Z][0-9]{3}-[0-9]{4}-[0-9]{5}$');
create domain ABNumber as integer check (value > 100000);

create table Publisher (
	abn         ABNumber,
	name        varchar(60),
	address     varchar(100),
	primary key (abn)
);

create table Person (
	tfn         TaxFileNum,
	name        varchar(50),
	address     varchar(100),
	primary key (tfn)
);

create table Author (
	person      TaxFileNum,
	penname     varchar(50),
	primary key (person),
	foreign key (person) references Person(tfn)
);

create table Editor (
	person      TaxFileNum,
	publisher   ABNumber not null,
	primary key (person),
	foreign key (person) references Person(tfn),
	foreign key (publisher) references Publisher(abn)
);

create table Book (
	isbn        ISBNumber,
	title       varchar(100),
	edition     integer check (edition > 0),
	editor      TaxFileNum not null,
	publisher   ABNumber not null,
	primary key (isbn),
	foreign key (editor) references Editor(person),
	foreign key (publisher) references Publisher(abn)
);

create table Writes (
	author      TaxFileNum,
	book        ISBNumber,
	primary key (author,book),
	foreign key (author) references Author(person),
	foreign key (book) references Book(isbn)
);

