--dbversion=1
--progstring=Feature_SCGCoupon
--***********************************
--Comments: 
--- 1. เพิ่มตาราง  2 ตาราง เพื่อรองรับการใช้คูปองของ SCG -- 


create table BCCouponMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CouponCode Varchar(20) not null,
	CouponName Varchar(50),
	ARCode  Varchar(20),
	SiteID	Varchar(10),
	Coupon_thb Money default 0.0,
	Coupon_percen Money default 0.0,
	BeginDate DateTime,
	ExpireDate DateTime,
	CouponUpdate DateTime,
	IsCancel Smallint default 0
	Primary Key(CouponCode)
);

CREATE  INDEX IDX_CouponMaster_1 ON BCCouponMaster(ARCode);
CREATE  INDEX IDX_CouponMaster_2 ON BCCouponMaster(ARCode,CouponCode);

create table BCCouponUse_Log
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CouponCode Varchar(20),
	ARCode  Varchar(20) not null,
	DocNo Varchar(30), --Invoice document
	DocDate DateTime, --Invoice date
	WorkDate	DATETIME NOT NULL default getdate(), -- วันที่ทำงาน	
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME
	PRIMARY KEY(ROWORDER)
);


CREATE  INDEX BCCouponUse_Log_1 ON BCCouponUse_Log(ARCode,CouponCode);

----- 2. เพิ่ม Filed JOBID,COUPONNO 3 ตาราง -- 

alter table BCArinvoice add JOBID varchar(20),COUPONNO varchar(20);
alter table BCQuotation add JOBID varchar(20);
alter table BCSaleOrder add JOBID varchar(20);

------3. Update Table bcdbprop เพื่อให้ระบบไม่ฟ้อง Verify DataBase -----
--ถ้าไม่ Run คำสั่งชุดนี้ ตอนเข้า Champ จะฟ้องให้  Verify database --

Update bcdbprop set dbversion='332' where  progstring='BC5ACC';
