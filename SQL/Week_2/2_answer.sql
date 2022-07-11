
-- NOTE that these schemas include representations of
-- the relationships between various sub-classes of Person

-- Using ER-style mapping for subclasses of Person

create table Person (
	ssn         integer,
	name        varchar(50) not null,
	address     varchar(100),
	primary key (ssn)
);

-- subclasses are overlapping; a Person could thus be
-- in any combination of the Doctor, Patient or Pharmacist tables

create table Doctor (
	ssn         integer,
	yearsExp    integer,
	primary key (ssn),
	foreign key (ssn) references Person(ssn)
);

create table Specialties (
	doctor      integer,
	specialty   varchar(20) check
	              (specialty in ('Feet','Ears','Throat')),
	primary key (doctor, specialty),
	foreign key (doctor) references Doctor(ssn)
);

create table Patient (
	ssn         integer,
	birthdate   date,
	primaryPhys integer not null, -- total participation
	primary key (ssn),
	foreign key (ssn) references Person(ssn),
	foreign key (primaryPhys) references Doctor(ssn)
);

create table Pharmacist (
	ssn         integer,
	phName      varchar(30),
	phAddress   varchar(100),
	qual        varchar(30),
	primary key (ssn),
	foreign key (ssn) references Person(ssn)
--	foreign key (phName,phAddress) is added later
);


-- Using single-table-style mapping for subclasses of Person

create table Person (
	ssn         integer,
	name        varchar(50) not null,
	address     varchar(100),
	-- an Person can belong to any combination of subclasses
	isPatient   boolean,
	isDoctor    boolean,
	isPharmacist boolean,
	-- patient-specific attributes
	primaryPhys integer, -- total participation handled below
	birthdate   date,
	-- doctor-specific attributes
	-- ... none ... Specialities are in separate table
	-- pharmacist-specific attributes
	phName      varchar(30),
	phAddress   varchar(100),
	qual        varchar(30),
	primary key (ssn),
	foreign key (primaryPhys) references Person(ssn),
--	foreign key (phName,phAddress) is added later
--	constraint  ClassAttributeCheck ...
--	-- trying to write a boolean expression that determines
--	-- that there is an appropriate combination of subclass
--	-- flags (isX) and attribute values is extremely tedious,
--	-- so we don't even bother to try
);

