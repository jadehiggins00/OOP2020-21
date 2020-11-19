DROP TABLE artist CASCADE CONSTRAINTS;
DROP TABLE artStyle CASCADE CONSTRAINTS PURGE;
DROP TABLE artType CASCADE CONSTRAINTS PURGE;
DROP TABLE artwork CASCADE CONSTRAINTS PURGE;
DROP TABLE customer CASCADE CONSTRAINTS PURGE;

CREATE TABLE artist (
    
    artID NUMBER(7),
    artName VARCHAR(30),
    artAge NUMBER(3),
    CONSTRAINT artist_PK PRIMARY KEY(artID)
);

CREATE TABLE artStyle (

    aStyleID NUMBER(7),
    aStyledesc VARCHAR(30)NOT NULL,
    CONSTRAINT astyle_PK PRIMARY KEY (aStyleID)

);


CREATE TABLE artType (

    aTypeID NUMBER(7),
    aTypedesc VARCHAR(30),
    CONSTRAINT atype_PK PRIMARY KEY (aTypeID)

);

CREATE TABLE artwork (

    artworkID NUMBER(7),
    title VARCHAR(30)NOT NULL,
    price NUMBER(9,2),
    CONSTRAINT artwork_PK PRIMARY KEY (artworkID)

);


CREATE TABLE customer (

    custID NUMBER(7),
    custName VARCHAR(30) NOT NULL,
    custAddress VARCHAR(30),
    amountSpent NUMBER(9,2),
    CONSTRAINT cust_PK PRIMARY KEY (custID)

);
