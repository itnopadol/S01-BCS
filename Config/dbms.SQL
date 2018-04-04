--dbversion=100
--progstring=bc5acc
--***********************************
create table dbUpdate
(
	LastUpdate SMALLINT CONSTRAINT PK_MYRES PRIMARY KEY 
);

create table UserDesktop
(
	UserCode  VARCHAR(20),
	ShortcutName VARCHAR(50),
	MyCommand	INT,
	ObRect VARCHAR(20),
	Description VARCHAR(255),
	ShellCommand VARCHAR(100),
	IconFile VARCHAR(200),
	ShortText VARCHAR(50)
);

create unique index PK_UserDesktop on UserDesktop
(UserCode,ShortcutName) WITH PRIMARY;

create table DBCONNECTION
(
	SERVER_DSN VARCHAR(40),
	DATABASE_NAME	VARCHAR(40) CONSTRAINT PK_DBCONNECT PRIMARY KEY ,
	COMPANY_NAME	VARCHAR(100),
	PROVIDER	VARCHAR(40),
	aliasname varchar(50),
	defaultdb smallint,
	defuser varchar(50),
	defpassword varchar(50)
);

create table MYRESOURCE
(
	KeyCode VARCHAR(40) CONSTRAINT PK_MYRES PRIMARY KEY ,
	MenuID	DOUBLE,
	ThaiRes VARCHAR(50),
	EngRes VARCHAR(50),
	UserRes1 VARCHAR(50),
	UserRes2 VARCHAR(50),
 	UserRes3 VARCHAR(50),
	CreatorName VARCHAR(20)
);

create index MYRESOURCE_ID on MYRESOURCE ( MenuID );

create table TipsHelp
(
	HelpKey	VARCHAR(40) ,
	ControlID DOUBLE,
	FieldName VARCHAR(30),
	FieldName_Eng VARCHAR(30),
	Description VARCHAR(255),
	Description_Eng VARCHAR(255)
);

create unique index PK_TipsHelp on TipsHelp
(HelpKey,ControlID) WITH PRIMARY;

create table UserShortcut
(
	UserCode VARCHAR(10),
	CommandID DOUBLE,
	Name	VARCHAR(40),
	ItemNo SMALLINT
);

create unique index PK_Shortcut on UserShortcut
(UserCode,ItemNo) WITH PRIMARY;

create table BCUSER
(
	CODE	VARCHAR(40) CONSTRAINT PK_USERCODE PRIMARY KEY ,
	UserNo SMALLINT,
	Name	VARCHAR(50),
	Comment VARCHAR(100),
	BCOption1	SMALLINT,
	BCOption2	SMALLINT,
	BCOption3	SMALLINT,
	BCOption4	SMALLINT,
	BCOption5	SMALLINT,
	BCOption6	SMALLINT,
	BCOption7	SMALLINT,
	BCOption8	SMALLINT,
	BCOption9	SMALLINT,
	BCOption10	SMALLINT,
	BCOption11	SMALLINT,
	BCOption12	SMALLINT,
	BCOption13	SMALLINT,
	BCOption14	SMALLINT,
	BCOption15	SMALLINT,
	BCOption16	SMALLINT, 
	BCOption17	SMALLINT,
	BCOption18	SMALLINT,
	BCOption19	SMALLINT,
	BCOption20	SMALLINT,
	BCOption21	SMALLINT, 
	BCOption22	SMALLINT, 
	ChqInRemind SMALLINT, 
	ChqOutRemind SMALLINT, 
	ARBillRemind SMALLINT, 
	APBillRemind SMALLINT, 
	DEBTPASSWORD VARCHAR(30),
	dbUserType VARCHAR(100),
	UserActive	SMALLINT,
	PicFileName	VARCHAR(100),
	UseRobotSale	SMALLINT,
	EditRobotSale	SMALLINT,
	IsReceiveCash	SMALLINT,
	IsBillCash		SMALLINT,
	IsBillCredit	 	SMALLINT,
	IsApprovePrice	SMALLINT,
	DataBaseName	VARCHAR(255),
	IsEditDocDate	SMALLINT,
	IsUserEditTax	SMALLINT,
	IsShowProfitLoss SMALLINT,
	iseditcreditday SMALLINT
);

create index USER_NO on BCUSER ( UserNo );

create table BCReportWriter
(
	RepName	VARCHAR(150) CONSTRAINT PK_REPWRT PRIMARY KEY ,
	UserRemark	VARCHAR(255),
	SQLScript	VARCHAR(255),
	FieldBreak	VARCHAR(255),
	FieldSummery VARCHAR(255)
);

create table BCReportWrtVar
(
	RepName	VARCHAR(150),
	VarName	VARCHAR(50),
	DBType	SMALLINT,
	VarRemark VARCHAR(100)
);

create table DDEDATA
(
	Alias	VARCHAR(20) CONSTRAINT PK_DDEDATA  PRIMARY KEY ,
	DefaulDB	  SMALLINT,
	ServerName	VARCHAR(50),
	DataBaseName	 VARCHAR(100),
	UserID		VARCHAR(30),
	Password		VARCHAR(30),
	MyDescription	VARCHAR(255)
);
create table DDEVAR
(
	VarCode		VARCHAR(50) CONSTRAINT PK_DDEVAR PRIMARY KEY,
	VarField		VARCHAR(50)
);
create table DDECOMMAND
(
	Topic		VARCHAR(50) CONSTRAINT PK_DDECOMMAND PRIMARY KEY,
	CommandText1	VARCHAR(255),
	CommandText2	VARCHAR(255),
	CommandText3	VARCHAR(255)
);
create table DDEDATA
(
	Alias	VARCHAR(20) CONSTRAINT PK_DDEDATA  PRIMARY KEY ,
	DefaulDB	  SMALLINT,
	ServerName	VARCHAR(50),
	DataBaseName	 VARCHAR(100),
	UserID		VARCHAR(30),
	Password		VARCHAR(30),
	MyDescription	VARCHAR(255)
);
create table DDEVAR
(
	VarCode		VARCHAR(50) CONSTRAINT PK_DDEVAR PRIMARY KEY,
	VarField		VARCHAR(50)
);
create table DDECOMMAND
(
	Topic		VARCHAR(50) CONSTRAINT PK_DDECOMMAND PRIMARY KEY,
	CommandText1	VARCHAR(255),
	CommandText2	VARCHAR(255),
	CommandText3	VARCHAR(255)
);

create table UserAuthorization
(
	Code		VARCHAR(40),
	MenuID	INT,
	IsMake	SMALLINT,
	IsDelete	SMALLINT,
	IsInsert	SMALLINT,
	IsEdit	SMALLINT,
	DataBaseName	VARCHAR(255)
);

create table BCUSER2
(
	CODE	VARCHAR(40) ,
	UserNo SMALLINT,
	Name	VARCHAR(50),
	Comment VARCHAR(100),
	BCOption1	SMALLINT,
	BCOption2	SMALLINT,
	BCOption3	SMALLINT,
	BCOption4	SMALLINT,
	BCOption5	SMALLINT,
	BCOption6	SMALLINT,
	BCOption7	SMALLINT,
	BCOption8	SMALLINT,
	BCOption9	SMALLINT,
	BCOption10	SMALLINT,
	BCOption11	SMALLINT,
	BCOption12	SMALLINT,
	BCOption13	SMALLINT,
	BCOption14	SMALLINT,
	BCOption15	SMALLINT,
	BCOption16	SMALLINT, 
	BCOption17	SMALLINT,
	BCOption18	SMALLINT,
	BCOption19	SMALLINT,
	BCOption20	SMALLINT,
	BCOption21	SMALLINT, 
	BCOption22	SMALLINT, 
	ChqInRemind SMALLINT, 
	ChqOutRemind SMALLINT, 
	ARBillRemind SMALLINT, 
	APBillRemind SMALLINT, 
	DEBTPASSWORD VARCHAR(30),
	dbUserType VARCHAR(100),
	UserActive	SMALLINT,
	PicFileName	VARCHAR(100),
	UseRobotSale	SMALLINT,
	EditRobotSale	SMALLINT,
	IsReceiveCash	SMALLINT,
	IsBillCash		SMALLINT,
	IsBillCredit	 SMALLINT,
	IsApprovePrice	SMALLINT,
	DatabaseName VARCHAR(255),
	IsEditDocDate	SMALLINT,
	IsUserEditTax	SMALLINT,
	IsShowProfitLoss SMALLINT,
	iseditcreditday SMALLINT
);
