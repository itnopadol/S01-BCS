--DBVERSION=3
--PROGSTRING=SCGCouponDownload
--***********************************

Create Table SCGCouponDownloadLog
(
    RowOrder    BigInt Not Null Identity(0,1),
    ServerRowOrder BigInt,--row order SCGCouponMaster to reference between Server and Agent
    
    CouponCode Varchar(20) not null,
    CouponName Varchar(50),
    CommandMode Smallint Default 0,--1=insert 2=delete
    
    EventDateTime DateTime default GetDate(),--Datetime of apply change data to agent database
    Primary Key(RowOrder)
);

