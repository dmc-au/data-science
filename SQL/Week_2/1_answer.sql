
CREATE TABLE Person
(
	familyName      varchar(30),
	givenName       varchar(30),
	initial         char(1),
	streetNumber    integer,
	streetName      varchar(40),
	suburb          varchar(40),
	birthday        date,
	PRIMARY KEY     (familyName,givenName,initial)
);

-- 
-- The choice of a three-part name is tricky. 
-- The family-name and given-name parts are pretty much 
-- as described above. However, the initial creates a problem. 
-- It is part of the key, and so the above definition requires 
-- it to be provided, even though not everyone is going to 
-- have a middle initial. It ought to remain part of the 
-- key, however, so that we can distinguish between people 
-- called John A. Smith and John B. Smith. Since no part 
-- of the key is allowed to be NULL, we need to adopt some 
-- convention for people with no initials; a plausible 
-- approach would to use a single space character (i.e. ' '). 
-- If we need to deal with addresses like 1a Smith Street, 
-- then we'd need to change the number attribute to a string 
-- type. Since all DBMSs have a date type, along with 
-- functions for extracting the components, we may as well 
-- collapse the components of the birthday attribute into a 
-- single field of date type.

