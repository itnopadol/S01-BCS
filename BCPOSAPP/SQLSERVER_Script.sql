--dbversion=323
--progstring=bc5acc
--***********************************
--Comments: Last update Jeab14:54 06/09/2010

DROP TABLE ReportStatus;
DROP TABLE ProcessItemReport;
DROP TABLE ProcessStock;
DROP TABLE ProcessStatus;
DROP TABLE ProcessStatus2;
DROP TABLE ProcessStatus3;
DROP TABLE FunctionStock;
DROP TABLE FunctionStockResult;
DROP TABLE ProcessDoc;
DROP TABLE processconnection;
DROP TABLE BCIC2Report;
DROP TABLE BCIC2Report2;
DROP TABLE BCIC2Report3;
DROP TABLE BCIC2Report4;

create table BCAutoProcHistory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20)  NOT NULL,
	MyType smallint default 0, -- ตาม MyType ของรายการย่อย
	Status smallint default 0, -- 1=Processing
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

create table BCAutoProcHist2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20)  NOT NULL,
	Status smallint default 0, -- 1=Processing
	PersonType smallint default 0, -- 0=ar 1=ap
	PersonCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

create table BCDevReportList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ReportName	VARCHAR(50)  NOT NULL,
	ReportFile	VARCHAR(50),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ReportName)
);

create table BCUserLogBook -- การทำงาน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	WorkMode SMALLINT DEFAULT 0, -- 0=ทำงานตามเมนู 1=ทำงานอื่นๆ
	WorkType SMALLINT DEFAULT 0, -- 0=เพิ่มข้อมูล 1=แก้ไขข้อมูล 3=ลบข้อมูล 4=พิมพ์รายงาน 5=อื่นๆ
	MenuID	FLOAT DEFAULT 0.0, -- เมนูที่ใช้งาน
	WorkDate	DATETIME NOT NULL, -- วันที่ทำงาน
	ComputerName	VARCHAR(50), -- ชื่อเครื่อง COM ที่ใช้งาน
	DocDate	DATETIME , --วันที่ของเอกสาร
	DocNo	VARCHAR(25), -- เอกสารที่ใช้
	UserID	VARCHAR(20),
	ShortWord VARCHAR(255),
	DetailCount	SMALLINT DEFAULT 0,  -- จำนวนรายการย่อยในบิล
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);
ALTER TABLE BCUserLogBook ALTER COLUMN ShortWord varchar(255);
ALTER TABLE BCUserLogBook ALTER COLUMN DocNo varchar(25);

create table BCChangeLogbook -- การทำงาน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	WorkDate	DATETIME NOT NULL default getdate(), -- วันที่ทำงาน
	ComputerName	VARCHAR(50), -- ชื่อเครื่อง COM ที่ใช้งาน
	TransKey	VARCHAR(255) NOT NULL,
	DocNo	VARCHAR(25), -- เอกสารที่ใช้
	UserID	VARCHAR(20),
	--FullText VARCHAR(Max),
	FullText VARCHAR(4096),
    PRIMARY KEY(ROWORDER)
);

create table BCBuyPriceCondit -- ใบเปรียบเทียบราคา
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	DocNo	VARCHAR(20) NOT NULL,
	RefNo VARCHAR(20), -- เลขที่อ้างอิง
	DocDate	DATETIME NOT NULL,
	MyDescription	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsExport smallint default 0,
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME
    PRIMARY KEY(DocNo)
);

create table BCByPriceCondSub -- ใบเปรียบเทียบราคา รายการย่อย
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	MyDescription	VARCHAR(255), -- หมายเหตุอื่นๆ
	DepartCode	VARCHAR(10),
	StkRequestNo	VARCHAR(20), -- เลขที่ใบเสนอซื้อ
	SelectAP SMALLINT DEFAULT 0, -- 0=ไม่เลือก 1=เลือก
	ItemCode	VARCHAR(25),
	UnitCode	VARCHAR(10),
	ApCode	VARCHAR(20),
	CreatePoFlag	SMALLINT DEFAULT 0, -- 0=ปกติ 1=หมดแล้ว
	Qty	MONEY DEFAULT 0.0, -- ยอดทั้งหมด
	BuyQty	MONEY DEFAULT 0.0, -- ยอดที่จะซื้อ
	BuyPrice MONEY DEFAULT 0.0, --ราคาที่จะซื้อ
	DiscountWord VARCHAR(30),	
	CreditDay	SMALLINT DEFAULT 0, -- จำนวนวันเครดิตจ่ายเงิน
	TrasportDay	SMALLINT DEFAULT 0, -- ส่งของภายใน
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	TransportCondit VARCHAR(255),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 SMALLMONEY DEFAULT 0.0,
	PackingRate2 SMALLMONEY DEFAULT 0.0,
	BehindIndex	SMALLINT DEFAULT 1,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

create table BCSysTRFormat -- Table หลักของรูปแบบรายวัน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	TransKey	VARCHAR(255) NOT NULL,
	MainTable VARCHAR(20), -- Table หลักของรายวันที่ใช้ในการบันทึกข้อมูล
	JoinTable	VARCHAR(255), -- Table ที่นำมา Jion กัน
	FilterBy	VARCHAR(255),
	SortBy	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TransTitle	VARCHAR(255),
	FindRect	VARCHAR(50),
	DocFormat	VARCHAR(50),
	SlipFomName VARCHAR(50),
	WTaxFomName	VARCHAR(50),
	SearchStyle	SMALLINT default 0,
	DisplayStyle	SMALLINT default 0,
	IsSearchFirst SMALLINT default 0,
	PrintFrmInText	SMALLINT DEFAULT 0,
	PrintLimit		SMALLINT DEFAULT 1,
	TaxFormat	VARCHAR(50) -- Format ของใบกำกับภาษี
    PRIMARY KEY(TransKey)
);

create table BCSysTRFind -- Table ที่เก็บรูปแบบของหน้าจอค้นหา
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	TransKey	VARCHAR(255) NOT NULL,
	FieldName	VARCHAR(255), -- ชื่อ Field ที่ใช้
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ColText	VARCHAR(255), -- ชื่อ Column
	SortBy	VARCHAR(255), -- ดรียงตาม
	ColWidth	SMALLINT DEFAULT 0,
	ColAlign	SMALLINT DEFAULT 0,
	ColColor 	MONEY DEFAULT 0, -- สีของ Column
	LineNumber	SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_TRFSYS_TK	ON BCSysTRFind(TransKey);
CREATE  INDEX IDX_TRFSYS_FN	ON BCSysTRFind(FieldName);
ALTER TABLE BCSYSTRFIND ALTER COLUMN FieldName varchar(255);
ALTER TABLE BCSYSTRFIND ALTER COLUMN ColText varchar(255);
ALTER TABLE BCSYSTRFIND ALTER COLUMN SortBy varchar(255);

create table BCSysTRFom -- Table Fom ที่ใช้ในหน้าจอนี้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	TransKey	VARCHAR(255) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	FormFileName	VARCHAR(255)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_TRFOSYS_TK	ON BCSysTRFom(TransKey);

create table BCSysTRDocG	-- Table Fom ที่ใช้ในหน้าจอนี้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	TransKey	VARCHAR(255) NOT NULL,
	GoupCode	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	GoupDesc	VARCHAR(50),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	LineNumber	SMALLINT DEFAULT 0,
	IsTaxGoup	SMALLINT DEFAULT 0  -- ใช้เป็น Running ของภาษี  Jeab 2003-06-24
    PRIMARY KEY(TransKey,GoupCode,IsTaxGoup)
);
CREATE  INDEX IDX_TRDOCG_TK	ON BCSysTRDocG(TransKey);

create table BCRoute
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);


create table BCItemCategory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);


create table BCMap
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	FileName	VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCARGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCARDebtGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	PaymentBy VARCHAR(20) NOT NULL, -- เก็บเงินที่
	Name	VARCHAR(50) NOT NULL
    PRIMARY KEY(CODE)
);

CREATE  INDEX IDX_ADBPAY ON BCARDebtGroup(PaymentBy);

create table BCTransport --รหัสเส้นทางการขนส่ง
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCConditPay   --เงื่อนไขการชำระเงิน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	Code VARCHAR(10) NOT NULL, --รหัสเงื่อนไข
	Name		VARCHAR(255), --ระยะเวลา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(Code)
);

create table BCConditPaySub   --เงื่อนไขการชำระเงิน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	MasterCode	VARCHAR(10) NOT NULL, --รหัสเงื่อนไข
	LineNumber 	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Remark VARCHAR(255),  -- ระยะเวลา
	StartDay SMALLINT ,
	StopDay SMALLINT ,
	Condition VARCHAR(50),  -- ระยะเวลา
	Priority SMALLINT DEFAULT 1
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_CONPS_MS ON BCConditPaySub(MasterCode);
CREATE  INDEX IDX_CONPS_LINE ON BCConditPaySub(LineNumber);


create table BCAllocate
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(CODE)
);


create table BCAPBankBook -- เลขบัญขีธนาคารตามเจ้าหนี้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ApCode	VARCHAR(20)  NOT NULL,
	BookNo	VARCHAR(30) NOT NULL,
	Name	VARCHAR(255),
	BankCode	VARCHAR(50),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BranchCode	VARCHAR(10),
	ProductType smallint default 0 --0=book transfer,1=Direct credit,2=Media clearing
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_APCODE ON BCAPBankBook(ApCode);
CREATE  INDEX IDX_APBK_BCODE ON BCAPBankBook(BookNo);
CREATE  INDEX IDX_APBK_APBNO ON BCAPBankBook(ApCode,BookNo);

create table BCItemBrand
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCApGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCApType 
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCCustType 
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCDepartment
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCGeneric
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Code VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(Code)
);

create table BCItemGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCIssueType
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCItemFormat
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCItemType
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCShelf
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	WHCode	VARCHAR(10)-- คลังสินค้า	

	PRIMARY KEY(ROWORDER)
);
create index IDX_BCSHCD on BCShelf(code);

create table BCWarehouse
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	MapPicFileName	VARCHAR(255),
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);
create index IDX_BCWHRWO on BCWarehouse(roworder);

create table BCSaleArea
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCProject
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCSale
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Address	VARCHAR(255),
	Telephone	VARCHAR(30),
	PictureFileName	VARCHAR(50),
	UserPassword VARCHAR(20), --
	UserID VARCHAR(40), -- User ID
	EmailAddress	VARCHAR(255), -- E-mail Address
	POApprove	SMALLINT DEFAULT 0,
	QuoApprove	SMALLINT DEFAULT 0,
	SOApprove	SMALLINT DEFAULT 0,
	InformPrice	SMALLINT DEFAULT 0, -- รับเมล์แจ้งการปรับราคา
	ActiveStatus SMALLINT DEFAULT 1, -- 0 =  เลิกใช้งาน, 1 = ใช่งานอยู่
	DepartCode	VARCHAR(10), -- แผนก 2003-01-20
	ApproveCredit	SMALLINT DEFAULT 0, -- 0=อนุมัติวงเงินไม่ได้, 1=อนุมัติวงเงินได้
	UserGroup VARCHAR(10),
	Salemembers VARCHAR(250),
	UserGroupList VARCHAR(255),--user group form document condition
	notpurchaseitem varchar(250), --condition
	RateCom	MONEY DEFAULT 0.0,
	-------------------------POS
	PWORD	 VARCHAR(50),  
	CPWORD	 VARCHAR(50), -- รหัสผ่านในการแก้ราคา
	CANCELONSALE	SMALLINT DEFAULT 0, -- 0 = unable to cancel  on sale doc. 1 = be able to cancel on slae doc.
	CHANGEPRICE	SMALLINT DEFAULT 0, -- 0 = แก้ราคาไม่ได้  1 = แก้ราคาได
	NONPWDCHNGPRC  SMALLINT DEFAULT 0 -- 0 = จำเป็นต้องมี password  1=ไม่จำเป็นต้องมี password
	---------------------------POS

    PRIMARY KEY(CODE)
);


create table BCItemUnit
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50),
	WaveFile	VARCHAR(50),
	UserGroup VARCHAR(255),
	NumFormat varchar(50)
    PRIMARY KEY(CODE)
);


create table BCConfigurations
(
	CompanyName	VARCHAR(255) NOT NULL,
	CompanyNameEng VARCHAR(255),
	ManagerName VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ManagerNameEng VARCHAR(255),
	Address	VARCHAR(255),
	AddressEng VARCHAR(255),
	Telephone	VARCHAR(255),
	Fax	VARCHAR(255),
	DeficitStatus SMALLINT	DEFAULT 1,
	YearType	SMALLINT	DEFAULT 0,
	TaxNumber	VARCHAR(30),
	DefaultTaxType	SMALLINT	DEFAULT 0,
	DefaultTaxRate	MONEY DEFAULT 7.0,
	DebtOverWarning	SMALLINT DEFAULT 0,
	SODebtWarning	SMALLINT DEFAULT 0, -- 0=ไม่เตือน 1=เตือน ที่ใบสั่งขาย
	BillDebtWarning	SMALLINT DEFAULT 0, -- 0=ไม่เตือน 1=เตือน ที่ใบขาย
	StockStatus	SMALLINT DEFAULT 0,
	PriceWarning	SMALLINT DEFAULT 0,
	PriceCostRatio	VARCHAR(30),
	ItemSetStatus	SMALLINT DEFAULT 0,
	BeginQty	MONEY DEFAULT 0.0,
	QtyPoint	SMALLINT DEFAULT 2,
	CostPoint	SMALLINT DEFAULT 4,
	PricePoint	SMALLINT DEFAULT 2,
	AmountPoint	SMALLINT DEFAULT 2,
	StockRemain	SMALLINT DEFAULT 0,
	DetailDiscount	SMALLINT DEFAULT 0,
	BillDiscount	SMALLINT DEFAULT 0,
	MultiCurrency	SMALLINT DEFAULT 0,
	DiscPromotion	SMALLINT DEFAULT 0,
	PricePromotion	SMALLINT DEFAULT 0,
	PostGLStatus	SMALLINT DEFAULT 0,
	GLBalanceCheck	SMALLINT DEFAULT 0,
	BillConfirm	SMALLINT DEFAULT 0,
	DefaultItemName	SMALLINT DEFAULT 0,
	DefaultArName	SMALLINT DEFAULT 0,
	DefaultApName	SMALLINT DEFAULT 0,
	DefaultAccName	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,
	ZeroTaxRate	SMALLINT DEFAULT 0,
	UseLotStatus SMALLINT DEFAULT 0, -- ใช้ Lot หรือไม่ 0=ไม่ใช้ 1=ใช้
	LotStatus	SMALLINT DEFAULT 0, -- 0=ตามโปรแกรม 1=กำหนดเอง
	ServiceItem	SMALLINT DEFAULT 0, --- มีการขายสินค้าบริการ
	SpecialItem SMALLINT DEFAULT 0, --- มีการขายสินค้าพิเศษ เช่น บุหรี่
	SerialItem SMALLINT DEFAULT 0,  -- มีสินค้า Serial Item หรือไม่
	UseExpCost	SMALLINT DEFAULT 0, -- 0=ไม่ใช้ต้นทุนแฝง 1=ใช้
	DiscountMethod SMALLINT DEFAULT 0, -- 0=ลดยอดรวม 1=ลดราคา/หน่วย
	BillDetailDesc SMALLINT DEFAULT 0, -- 0=แบบปกติ (V2) 1=ตั้งกลุ่มออกบิลได้
	BuyItemSupplier SMALLINT DEFAULT 0, -- เลือกสินค้าตาม Supplier 0=ไม่ใช้ 1=ใช้ตาม Supplier
	OppositeUnit	SMALLINT DEFAULT 0,
	ChqCondition	VARCHAR(50),
	PaybillRemark	VARCHAR(50),
	InvoiceOnStart	SMALLINT DEFAULT 0,
	ChqOnStart	SMALLINT DEFAULT 0,
	StockLowOnStart	SMALLINT DEFAULT 0,
	StkDeficitWarn	SMALLINT DEFAULT 0,
	StkRemainOut	SMALLINT DEFAULT 0,
	StkRemainIn	SMALLINT DEFAULT 0,
	LogBookUse	SMALLINT DEFAULT 0,
	Usechangelogbook	SMALLINT DEFAULT 0,
	Consignment	SMALLINT DEFAULT 0,
	PrintSlip	SMALLINT DEFAULT 0,
	PrintBill	SMALLINT DEFAULT 0,
	AutoBillDocGroup SMALLINT DEFAULT 0, -- 1=Running เอกสารตามกลุ่มอัตโนมัติ
	DefItemBillType	SMALLINT DEFAULT 0,
	DefBuyBillType	SMALLINT DEFAULT 0,
	DisplayPicture	SMALLINT DEFAULT 0,
	CurrencySymbol	SMALLINT DEFAULT 0,
	HCurrencySymbol	VARCHAR(2) DEFAULT '฿',
	HCurrencyCode VARCHAR(10) DEFAULT 'HBA',
	CashBalance MONEY DEFAULT 0.0, -- ยอดเงินสดยกมา
	PayBillDuplicate SMALLINT DEFAULT 0, -- 1=วางบิลซ้ำได้
	DepartSeparate	 SMALLINT DEFAULT 0,
	ProjectSeparate	 SMALLINT DEFAULT 0,
	AllocateSeparate 	SMALLINT DEFAULT 0,
	JobSeparate 	SMALLINT DEFAULT 0,
	PartSeparate 	SMALLINT DEFAULT 0,
	SideSeparate 	SMALLINT DEFAULT 0,
	IsExDescription 	SMALLINT DEFAULT 0,
	BranchSeparate 	SMALLINT DEFAULT 0,
	InventoryMethod 	SMALLINT DEFAULT 0, -- 0=Periodic 1= perpetual
	ExcessStatus	SMALLINT DEFAULT 0, -- 0=ไม่มีเงินเกิน 1= ใช้ระบบเงินเกิน
	OtherIncome SMALLINT DEFAULT 0, -- 0=ไม่มีค่าใช้จ่าย/รายได้อื่นๆในใบเสร็จ 1= มีค่าใช้จ่าย/รายได้อื่นๆในใบเสร็จ
	SONoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	SONoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	SONoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	SONoEditDiscount SMALLINT DEFAULT 0, -- 1=แก้ไขส่วนลดไม่ได้
	BILLNoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	BILLNoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	BILLNoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	BILLNoEditDiscount SMALLINT DEFAULT 0, -- 1=แก้ไขส่วนลดไม่ได้
	BUYNoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	BUYNoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	BUYNoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	BUYNoEditDiscount SMALLINT DEFAULT 0, -- 1=แก้ไขส่วนลดไม่ได้
	GRNoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	GRNoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	GRNoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	AutoPostGL 	SMALLINT DEFAULT 0, -- 1= autoPostGL
	AutoServerProc SMALLINT DEFAULT 0, -- 1= ใช้ระบบ Auto Process ที่ Server
	PosRepSeparate SMALLINT DEFAULT 0,
	IsBoxDuplicate SMALLINT DEFAULT 0, -- MessageBox เช็ค เอกสารซ้ำ
	IsJob SMALLINT DEFAULT 0, -- ใช้ JOB
	CreditLimitFlag SMALLINT DEFAULT 0, -- 0=คืนวงเงินเมื่อรับชำระหนี้  1=คืนวงเงินเมื่อเช็คผ่าน
	SerialItemPerLine SMALLINT DEFAULT 3,  -- จำนวน Serial ในการพิมพ์ 1 บรรทัด
	PrintSerialInvoice SMALLINT DEFAULT 1,  -- 0=not Print 1=Print
	IsEditItemName SMALLINT DEFAULT 0, -- 1= แก้ไขชื่อสินค้าหน้าบิลได้
	FSCurSum1	MONEY DEFAULT 0.0, -- ยอดสะสมค่าใช้จ่ายในการขายและบริการ
	FSCurSum2	MONEY DEFAULT 0.0, -- ยอดสะสมต้นทุนการผลิต
	FSCurSum3	MONEY DEFAULT 0.0, -- ยอดสะสมต้นทุนขายสินค้า
	FSCurSum4	MONEY DEFAULT 0.0, -- กำไรสะสมปลายงวด
	DayCallCust SMALLINT DEFAULT 0, -- จำนวนวัน ที่ต้องโทรตามลูกค้า
	IsPrintSumPage SMALLINT DEFAULT 0, -- 0 = พิมพ์ sum รายการต่อหน้า , 1= ไม่พิมพ์
	IsPrintCancel SMALLINT DEFAULT 0, -- 0 = ไม่พิมพ์รายการที่ยกเลิก , 1= พิมพ์รายการที่ยกเลิก
	IsUseWarehouse SMALLINT DEFAULT 0, -- 0 = ่ใช้ระบบคลังสินค้า , 1= ไม่ใช้ระบบคลังสินค้า
	MailSMTP VARCHAR(255), -- Option ส่งเมล์ -> SMTP
	MailPOP3 VARCHAR(255),-- Option ส่งเมล์ -> POP3
	MailFrom VARCHAR(255),  -- Option ส่งเมล์ -> Send Form
	IsReceiveMoney SMALLINT DEFAULT 0, -- 0 = ไม่ใช้ระบบFix Ueser รับเงิน  , 1= ใช้ระบบFix Ueser รับเงิน
	IsSetWorkDate SMALLINT DEFAULT 0, -- ไม่ต้องการ Set วันที่ทำงานทุกครั้งที่เปิดโปรแกรม 0=ไม่ Set ,1=Set
	IsUserGroup SMALLINT DEFAULT 0, -- 1= ใช้ระบบรหัสสินค้าตามกลุ่มพนักงาน 
	IsCustGroup SMALLINT DEFAULT 0, -- 1= ใช้ระบบรหัสสินค้าตามกลุ่มลูกค้า
	SaleBaseOnSO SMALLINT DEFAULT 0, --1=Create Sale invoice must be lost from SO ,0=Anything
	FormDateStyle SMALLINT DEFAULT 0, -- Jum Use
	FormNumericStyle SMALLINT DEFAULT 0, -- Jum Use
	IsItemRemainQty SMALLINT DEFAULT 0, -- 1= แสดงยอดจำนวนคำคงเหลือของสินค้าตามที่เก็บด้วย -- Jeab 20030507 --
	IsShowSetDetail SMALLINT DEFAULT 0, --1 = แสดงรายละเอียดสินค้าชุด aom 24-06-2003
	IsShowSetPrice SMALLINT DEFAULT 0, --1 = แสดงรายละเอียดสินค้าชุดและราคาขายสินค้า aom 24-06-2003
	BuyPriceWarning	SMALLINT DEFAULT 0, -- 1= เตือนราคาซื้อสูงกว่าราคาขาย
	SalePriceLevel SMALLINT DEFAULT 0, -- ระดับราคาขายที่เตือน
	IsLastBuyPrice SMALLINT DEFAULT 0, -- เตือนราคาซื้อสูงกว่าราคาซื้อล่าสุด
	IsProcessThread SMALLINT DEFAULT 1,--1=run process in thread  default value , 0 basic mode
	IsReportThread SMALLINT DEFAULT 1, --1=run report in thread  default value , 0 basic mode
	CostType SMALLINT DEFAULT 0,-- 0 = ต้นทุนไม่รวมคลัง , 1 = ต้นทุนรวมคลัง
	ShowItemSetPrice SMALLINT DEFAULT 0,
	IsSkipAddItemSuplier SMALLINT DEFAULT 0, --1=Don't automatic add supplier code to bcitemsuplier,default 0
	LastProcess	DATETIME,
	IsCheckService SMALLINT DEFAULT 1,--1=check bcswinservice every 5 minute 0 = disable 
	IsBehindIndex SMALLINT DEFAULT 0, -- 0=เรียงตามประเภทรายวัน , 1=เรียงตามการบันทึก -- ต้องการคำนวณสินค้าเรียงตามประเภทรายวันหรือเรียงตามการบันทึก
	IsMethodCutPO SMALLINT DEFAULT 0, -- 0 = ตัดรายการสั่งซ็้อสินค้ารวมบรรทัด, 1= ตัดรายการสั่งซื้อสินค้าแยกบรรทัด
	IsTaxType SMALLINT DEFAULT 0,
	IsNoStockReword SMALLINT DEFAULT 0, -- 1= ไม่ใช่ระบบเช็คสต๊อกย้อนหลัง
	IsCreateGLTrans SMALLINT DEFAULT 1,  -- 1=(default value) automatic create gl transaction 0=disable 
	DefaultCostType SMALLINT DEFAULT 0, -- 0 เฉลี่ย 1 FIFO 2 standard
	IsGetLastDiscount SMALLINT DEFAULT 1,
	IsDepositCash SMALLINT DEFAULT 0, -- เงินมัดจำใช้ได้กรณีเป็นบิลเงินสดเท่านั้น
	IsWarnDeposit SMALLINT DEFAULT 0, -- เตือนให้มีการนำเงินมัดจำมาหัก กรณีซื้อ,ขายสินค้า
	IsHello SMALLINT DEFAULT 0,
	IsHardLock SMALLINT DEFAULT 0,
	IsVersion SMALLINT DEFAULT 0, -- 0 = SME, 1 = Exproess, 2 = Pro
	IsLotDuplicate SMALLINT DEFAULT 0, -- 0 = ไม่ต้องการเตือน Lot ซ้ำ, 1= ต้องการเตือน Lot ซ้ำ
	IsCode VARCHAR(10),
	IsSumPo smallint default 0,
	IsNotEditdoc smallint default 0,--jum CHAMP use only 0=Can edit document 1=Can not edit ole documents
	IsChkSOQtyWH smallint default 0, --Aom not use for CHAMP เช็คยอดคงเหลือตามคลังเมื่อทำใบสั่งขาย/สั่งจอง
	IsSmallChange smallint default 0, -- ใช้ระบบเงินทอน
	PromotionMode SMALLINT DEFAULT 0, --Use extention promotion settine on system managment-->option 2 No 62
	IsStockAmountType SMALLINT DEFAULT 0, --0=ปกติ,1=ถ้ายอดคงเหลือเป็น 0 ให้ปรับต้นทุนและมูลค่า=0
	IsReturnType SMALLINT DEFAULT 0, --ในกรณีรับคืนสินค้าแบบไม่อ้าง invoice 0=ต้นทุนรับคืนจากมูลค่ารับคืน,1=ต้นทุนรับคืนจากต้นทุนล่าสุด
	ItemAmountPoint smallint default 2, --ทศนิยมของมูลค่าสินค้า
	--for item set type 1 Aom
	SOItemSetDetail smallint default 0, --ใบสั่งขาย 0=ไม่แสดงรายการย่อยสินค้า,1=แสดงรายการย่อยสินค้า
	SRItemSetDetail smallint default 0, --ใบสั่งจอง 0=ไม่แสดงรายการย่อยสินค้า,1=แสดงรายการย่อยสินค้า
	BillItemSetDetail smallint default 0, --ใบสั่งจอง 0=ไม่แสดงรายการย่อยสินค้า,1=แสดงรายการย่อยสินค้า
	TRReqItemSetDetail smallint default 0, --ใบขอโอน 0=ไม่แสดงรายการย่อยสินค้า,1=แสดงรายการย่อยสินค้า
	TRItemSetDetail smallint default 0, --ใบโอน 0=ไม่แสดงรายการย่อยสินค้า,1=แสดงรายการย่อยสินค้า
	IsShowPriceStkTR smallint default 0, --1=สามารถบันทึกและแก้ไขราคาขายสินค้าในใบขอโอนและใบโอนสินค้าระหว่างคลัง
	IsShowPricePR smallint default 0, --แสดงราคาและมูลค่าสินค้าในบันทึกใบเสนอซื้อและบันทึกใบอนุมัติเสนอซื้อ
	SelectPrintSerial smallint default 0, -- 0 ไม่เลือกพิมพ์ Serial , 1 = สามารถเลือกพิมพ์ Serial ได้
	SumBillByItem smallint default 0, -- 0=ไม่รวมสินค้าในบิลขาย,1=รวมสินค้าที่มีรหัส,หน่วยนับ,ราคา,คลัง,ที่เก็บ เหมือนกัน ในบิลขาย
	CheckGLRefNo smallint default 0, -- 0=ไม่เช็คเอกสารอ้างอิง ,1=เช็คเอกสารอ้างอิงที่บันทึกในข้อมูลรายวัน GL ถ้าซ้ำให้แจ้งเตือน
	IsShowItemNew smallint default 0, -- 1= เตือนรายการสินค้าใหม่ที่เกิดขึ้นต่อวัน
	IsArDefaultWH smallint default 0, -- 1= ใช้ระบบคลังเริ่มต้นตามลูกค้า
	AvgTaxRate money default 0.0, --อัตราภาษีซื้อเฉลี่ย
	UseAvgTax smallint default 0, --0=ไม่ใช้ระบบภาษีซื้อเฉลี่ย 1=ใช้ระบบภาษีซื้อเฉลี่ย	
	RegisterNo varchar(50),
	IsUseCreditSO smallint default 0, -- 1= ใช้ระบบตรวจสอบวงเงินคงเหลือกับยอดคงค้างของเอกสารใบสั่งขาย/สั่งจอง
	IsConfirmPO smallint default 0, -- ใบสั่งซื้อต้องผ่านการอนุมัติเท่านั้น
	IsDueDateSO smallint default 0,
	diffamount money default 0.0,
	ServiceExpire datetime,
	SOSRDefType smallint default 0,
	IsShowPricSet2 SMALLINT DEFAULT 0, -- แสดงราคาขายเฉพาะสินค้าชุดแบบที่ 2 แต่ไม่แสดงราคาตัวสินค้าย่อย
	IsCheckStockMin SMALLINT DEFAULT 0, -- เตือนเมื่อสต๊อกคงเหลือของระบบเหลือน้อยกว่าจุดต่ำสุดที่กำหนดไว้ในรายละเอียดสินค้า
	IsWoarnTaxNo SMALLINT DEFAULT 0, -- 1=เตือนให้ระบุเลขที่ใบกำกับภาษี เมื่อใส่อัตราภาษีมากกว่าศูนย์
	WarningLowerStdPrice  SMALLINT DEFAULT 0,
	WarnTaxNoEmpty smallint default 0 --1=เตือนเมื่อไม่ใส่เลขที่ใบกำกับภาษี (ยกเว้นกรณีตัดเงินมัดจำ)
	PRIMARY KEY(CompanyName)
);
--create index IDX_ISCODE ON bcconfigurations(iscode);

------------------ Config of POS ----------------------------
create table BCConfigurations2
(
	CompanyName	VARCHAR(255) NOT NULL,
	CompanyNameEng VARCHAR(255),
	ManagerName VARCHAR(255),
	ManagerNameEng VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Address	VARCHAR(255),
	AddressEng VARCHAR(255),
	Telephone	VARCHAR(255),
	Fax	VARCHAR(255),
	DeficitStatus SMALLINT	DEFAULT 1,
	YearType	SMALLINT	DEFAULT 0,
	TaxNumber	VARCHAR(30),
	DefaultTaxType	SMALLINT	DEFAULT 0,
	DefaultTaxRate	MONEY DEFAULT 7.0,
	DebtOverWarning	SMALLINT DEFAULT 0,
	SODebtWarning	SMALLINT DEFAULT 0, -- 0=ไม่เตือน 1=เตือน ที่ใบสั่งขาย
	BillDebtWarning	SMALLINT DEFAULT 0, -- 0=ไม่เตือน 1=เตือน ที่ใบขาย
	StockStatus	SMALLINT DEFAULT 0,
	PriceWarning	SMALLINT DEFAULT 0,
	PriceCostRatio	VARCHAR(30),
	ItemSetStatus	SMALLINT DEFAULT 0,
	BeginQty	MONEY DEFAULT 0.0,
	QtyPoint	SMALLINT DEFAULT 2,
	CostPoint	SMALLINT DEFAULT 4,
	PricePoint	SMALLINT DEFAULT 2,
	AmountPoint	SMALLINT DEFAULT 2,
	StockRemain	SMALLINT DEFAULT 0,
	DetailDiscount	SMALLINT DEFAULT 0,
	BillDiscount	SMALLINT DEFAULT 0,
	MultiCurrency	SMALLINT DEFAULT 0,
	DiscPromotion	SMALLINT DEFAULT 0,
	PricePromotion	SMALLINT DEFAULT 0,
	PostGLStatus	SMALLINT DEFAULT 0,
	GLBalanceCheck	SMALLINT DEFAULT 0,
	BillConfirm	SMALLINT DEFAULT 0,
	DefaultItemName	SMALLINT DEFAULT 0,
	DefaultArName	SMALLINT DEFAULT 0,
	DefaultApName	SMALLINT DEFAULT 0,
	DefaultAccName	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,
	ZeroTaxRate	SMALLINT DEFAULT 0,
	UseLotStatus SMALLINT DEFAULT 0, -- ใช้ Lot หรือไม่ 0=ไม่ใช้ 1=ใช้
	LotStatus	SMALLINT DEFAULT 0, -- 0=ตามโปรแกรม 1=กำหนดเอง
	ServiceItem	SMALLINT DEFAULT 0, --- มีการขายสินค้าบริการ
	SpecialItem SMALLINT DEFAULT 0, --- มีการขายสินค้าพิเศษ เช่น บุหรี่
	SerialItem SMALLINT DEFAULT 0,  -- มีสินค้า Serial Item หรือไม่
	UseExpCost	SMALLINT DEFAULT 0, -- 0=ไม่ใช้ต้นทุนแฝง 1=ใช้
	DiscountMethod SMALLINT DEFAULT 0, -- 0=ลดยอดรวม 1=ลดราคา/หน่วย
	BillDetailDesc SMALLINT DEFAULT 0, -- 0=แบบปกติ (V2) 1=ตั้งกลุ่มออกบิลได้
	BuyItemSupplier SMALLINT DEFAULT 0, -- เลือกสินค้าตาม Supplier 0=ไม่ใช้ 1=ใช้ตาม Supplier
	OppositeUnit	SMALLINT DEFAULT 0,
	ChqCondition	VARCHAR(50),
	PaybillRemark	VARCHAR(50),
	InvoiceOnStart	SMALLINT DEFAULT 0,
	ChqOnStart	SMALLINT DEFAULT 0,
	StockLowOnStart	SMALLINT DEFAULT 0,
	StkDeficitWarn	SMALLINT DEFAULT 0,
	StkRemainOut	SMALLINT DEFAULT 0,
	StkRemainIn	SMALLINT DEFAULT 0,
	LogBookUse	SMALLINT DEFAULT 0,
	Consignment	SMALLINT DEFAULT 0,
	PrintSlip	SMALLINT DEFAULT 0,
	PrintBill	SMALLINT DEFAULT 0,
	AutoBillDocGroup SMALLINT DEFAULT 0, -- 1=Running เอกสารตามกลุ่มอัตโนมัติ
	DefItemBillType	SMALLINT DEFAULT 0,
	DefBuyBillType	SMALLINT DEFAULT 0,
	DisplayPicture	SMALLINT DEFAULT 0,
	CurrencySymbol	SMALLINT DEFAULT 0,
	HCurrencySymbol	VARCHAR(2) DEFAULT '฿',
	HCurrencyCode VARCHAR(10) DEFAULT 'HBA',
	CashBalance MONEY DEFAULT 0.0, -- ยอดเงินสดยกมา
	PayBillDuplicate SMALLINT DEFAULT 0, -- 1=วางบิลซ้ำได้
	DepartSeparate	 SMALLINT DEFAULT 0,
	ProjectSeparate	 SMALLINT DEFAULT 0,
	AllocateSeparate 	SMALLINT DEFAULT 0,
	JobSeparate 	SMALLINT DEFAULT 0,
	PartSeparate 	SMALLINT DEFAULT 0,
	SideSeparate 	SMALLINT DEFAULT 0,
	IsExDescription 	SMALLINT DEFAULT 0,
	BranchSeparate 	SMALLINT DEFAULT 0,
	InventoryMethod 	SMALLINT DEFAULT 0, -- 0=Periodic 1= perpetual
	ExcessStatus	SMALLINT DEFAULT 0, -- 0=ไม่มีเงินเกิน 1= ใช้ระบบเงินเกิน
	OtherIncome SMALLINT DEFAULT 0, -- 0=ไม่มีค่าใช้จ่าย/รายได้อื่นๆในใบเสร็จ 1= มีค่าใช้จ่าย/รายได้อื่นๆในใบเสร็จ
	SONoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	SONoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	SONoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	SONoEditDiscount SMALLINT DEFAULT 0, -- 1=แก้ไขส่วนลดไม่ได้
	BILLNoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	BILLNoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	BILLNoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	BILLNoEditDiscount SMALLINT DEFAULT 0, -- 1=แก้ไขส่วนลดไม่ได้
	BUYNoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	BUYNoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	BUYNoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	BUYNoEditDiscount SMALLINT DEFAULT 0, -- 1=แก้ไขส่วนลดไม่ได้
	GRNoAddnew SMALLINT DEFAULT 0, -- 1=เพิ่มรายการใหม่ไม่ได้
	GRNoEditQty	SMALLINT DEFAULT 0, -- 1=แก้ไขจำนวนไม่ได้
	GRNoEditPrice SMALLINT DEFAULT 0, -- 1=แก้ไขราคาไม่ได้
	AutoPostGL 	SMALLINT DEFAULT 0, -- 1= autoPostGL
	AutoServerProc SMALLINT DEFAULT 0, -- 1= ใช้ระบบ Auto Process ที่ Server
	PosRepSeparate SMALLINT DEFAULT 0,
	IsBoxDuplicate SMALLINT DEFAULT 0, -- MessageBox เช็ค เอกสารซ้ำ
	IsJob SMALLINT DEFAULT 0, -- ใช้ JOB
	CreditLimitFlag SMALLINT DEFAULT 0, -- 0=คืนวงเงินเมื่อรับชำระหนี้  1=คืนวงเงินเมื่อเช็คผ่าน
	SerialItemPerLine SMALLINT DEFAULT 3,  -- จำนวน Serial ในการพิมพ์ 1 บรรทัด
	PrintSerialInvoice SMALLINT DEFAULT 1,  -- 0=not Print 1=Print
	IsEditItemName SMALLINT DEFAULT 0, -- 1= แก้ไขชื่อสินค้าหน้าบิลได้
	FSCurSum1	MONEY DEFAULT 0.0, -- ยอดสะสมค่าใช้จ่ายในการขายและบริการ
	FSCurSum2	MONEY DEFAULT 0.0, -- ยอดสะสมต้นทุนการผลิต
	FSCurSum3	MONEY DEFAULT 0.0, -- ยอดสะสมต้นทุนขายสินค้า
	FSCurSum4	MONEY DEFAULT 0.0, -- กำไรสะสมปลายงวด
	DayCallCust SMALLINT DEFAULT 0, -- จำนวนวัน ที่ต้องโทรตามลูกค้า
	IsPrintSumPage SMALLINT DEFAULT 0, -- 0 = พิมพ์ sum รายการต่อหน้า , 1= ไม่พิมพ์
	IsPrintCancel SMALLINT DEFAULT 0, -- 0 = ไม่พิมพ์รายการที่ยกเลิก , 1= พิมพ์รายการที่ยกเลิก
	IsUseWarehouse SMALLINT DEFAULT 0, -- 0 = ่ใช้ระบบคลังสินค้า , 1= ไม่ใช้ระบบคลังสินค้า
	MailSMTP VARCHAR(255), -- Option ส่งเมล์ -> SMTP
	MailPOP3 VARCHAR(255),-- Option ส่งเมล์ -> POP3
	MailFrom VARCHAR(255),  -- Option ส่งเมล์ -> Send Form
	IsReceiveMoney SMALLINT DEFAULT 0, -- 0 = ไม่ใช้ระบบFix Ueser รับเงิน  , 1= ใช้ระบบFix Ueser รับเงิน
	IsSetWorkDate SMALLINT DEFAULT 0, -- ไม่ต้องการ Set วันที่ทำงานทุกครั้งที่เปิดโปรแกรม 0=ไม่ Set ,1=Set
	IsUserGroup SMALLINT DEFAULT 0, -- 1= ใช้ระบบรหัสสินค้าตามกลุ่มพนักงาน 
	IsCustGroup SMALLINT DEFAULT 0, -- 1= ใช้ระบบรหัสสินค้าตามกลุ่มลูกค้า
	SaleBaseOnSO SMALLINT DEFAULT 0, --1=Create Sale invoice must be lost from SO ,0=Anything
	FormDateStyle SMALLINT DEFAULT 0, -- Jum Use
	FormNumericStyle SMALLINT DEFAULT 0, -- Jum Use
	IsItemRemainQty SMALLINT DEFAULT 0, -- 1= แสดงยอดจำนวนคำคงเหลือของสินค้าตามที่เก็บด้วย -- Jeab 20030507 --
	IsShowSetDetail SMALLINT DEFAULT 0, --1 = แสดงรายละเอียดสินค้าชุด aom 24-06-2003
	IsShowSetPrice SMALLINT DEFAULT 0, --1 = แสดงรายละเอียดสินค้าชุดและราคาขายสินค้า aom 24-06-2003
	BuyPriceWarning	SMALLINT DEFAULT 0, -- 1= เตือนราคาซื้อสูงกว่าราคาขาย
	SalePriceLevel SMALLINT DEFAULT 0, -- ระดับราคาขายที่เตือน
	IsLastBuyPrice SMALLINT DEFAULT 0, -- เตือนราคาซื้อสูงกว่าราคาซื้อล่าสุด
	IsProcessThread SMALLINT DEFAULT 1,--1=run process in thread  default value , 0 basic mode
	IsReportThread SMALLINT DEFAULT 1, --1=run report in thread  default value , 0 basic mode
	CostType SMALLINT DEFAULT 0,-- 0 = ต้นทุนไม่รวมคลัง , 1 = ต้นทุนรวมคลัง
	ShowItemSetPrice SMALLINT DEFAULT 0,
	IsSkipAddItemSuplier SMALLINT DEFAULT 0, --1=Don't automatic add supplier code to bcitemsuplier,default 0
	LastProcess	DATETIME,
	IsCheckService SMALLINT DEFAULT 1,--1=check bcswinservice every 5 minute 0 = disable 
    IsBehindIndex SMALLINT DEFAULT 0, -- 0=เรียงตามประเภทรายวัน , 1=เรียงตามการบันทึก -- ต้องการคำนวณสินค้าเรียงตามประเภทรายวันหรือเรียงตามการบันทึก
	IsMethodCutPO SMALLINT DEFAULT 0, -- 0 = ตัดรายการสั่งซ็้อสินค้ารวมบรรทัด, 1= ตัดรายการสั่งซื้อสินค้าแยกบรรทัด
	IsTaxType SMALLINT DEFAULT 0,
	IsNoStockReword SMALLINT DEFAULT 0, -- 1= ไม่ใช่ระบบเช็คสต๊อกย้อนหลัง
	IsCreateGLTrans SMALLINT DEFAULT 1,  -- 1=(default value) automatic create gl transaction 0=disable 
	DefaultCostType SMALLINT DEFAULT 0, -- 0 เฉลี่ย 1 FIFO 2 standard
	IsGetLastDiscount SMALLINT DEFAULT 1,
	IsDepositCash SMALLINT DEFAULT 0, -- เงินมัดจำใช้ได้กรณีเป็นบิลเงินสดเท่านั้น
	IsWarnDeposit SMALLINT DEFAULT 0, -- เตือนให้มีการนำเงินมัดจำมาหัก กรณีซื้อ,ขายสินค้า
	IsHello SMALLINT DEFAULT 0,
	IsHardLock SMALLINT DEFAULT 0,
	IsVersion SMALLINT DEFAULT 0, -- 0 = SME, 1 = Exproess, 2 = Pro
	IsLotDuplicate SMALLINT DEFAULT 0, -- 0 = ไม่ต้องการเตือน Lot ซ้ำ, 1= ต้องการเตือน Lot ซ้ำ
	IsCode VARCHAR(10)
    PRIMARY KEY(CompanyName)
);

create table BCMailConfig
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	UserName	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	EmailAddress	VARCHAR(255) NOT NULL,
	POApprove	SMALLINT DEFAULT 0,
	QuoApprove	SMALLINT DEFAULT 0,
	SOApprove	SMALLINT DEFAULT 0
	PRIMARY KEY(UserName,EmailAddress)
);

create table BCARDebtTable
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ArCode	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	PeriodNo	SMALLINT DEFAULT 0 NOT NULL,
	CurrencyCode	VARCHAr(10) NOT NULL,
	DebtAmount	MONEY DEFAULT 0.0,
	ChqOnHand	MONEY DEFAULT 0.0,
	CreditOnHand	MONEY DEFAULT 0.0,
	ChqReturn	MONEY DEFAULT 0.0
    PRIMARY KEY(ArCode,PeriodNo,CurrencyCode)
);
create table BCTrnasportLine	--เส้นทางการขนส่ง
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(20) NOT NULL, --รหัสเส้นทางขนส่ง
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StartTransport	VARCHAR(255), --จุดเริ่มต้นขนส่ง
	StopTransport	VARCHAR(255) --ปลายทางขนส่ง
    PRIMARY KEY(Code)
);

create table BCAR
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(20) NOT NULL,
	Name1	VARCHAR(255) NOT NULL,
	Name2	VARCHAR(255),
	DefDeliveryAddr VARCHAR(10),
	DefContactCode	VARCHAR(10),
	DefTransport	VARCHAR(10),
	BillAddress	VARCHAR(255),
	WorkAddress	VARCHAR(255),
	Telephone	VARCHAR(50),
	Fax	VARCHAR(50),
	AccountCode	VARCHAR(20),
	IDCardNo VARCHAR(30), -- เลขที่บัตรประชาชน
	LastContactDate	DATETIME,
	LastPayDate	DATETIME,
	SaleCode	VARCHAR(10),	
	ParentCode VARCHAR(20), -- เจ้านาย
	BillCredit SMALLINT DEFAULT 0, -- เครดิตตามบิล
	TransportCredit SMALLINT DEFAULT 0, -- เครดิตตามขนส่ง
	CreditStatus SMALLINT DEFAULT 0, -- 0 = นับวันที่ครับกำหนดจาก SO, 1 = นับวันที่ครับกำหนดจาก BL
	DetailDiscount	VARCHAR(35),
	Discount	VARCHAR(35),
	CashDiscount	VARCHAR(35), -- ส่วนลดเงินบาท ท้ายบิล
	DebtLimit1	MONEY DEFAULT 0.0,	-- ยอดวงเงินที่อนุมัติ
	DebtLimit2	MONEY DEFAULT 0.0,	-- ยอดวงเงินสูงสุด
	DebtLimitBal MONEY DEFAULT 0.0,	-- ยอดวงเงินคงเหลือ CHM ตอนแรก=DebtLimit1
	DebtAmount	MONEY DEFAULT 0.0, -- Home Currency
	ChqOnHand	MONEY DEFAULT 0.0, -- Home Currency
	CreditOnHand	MONEY DEFAULT 0.0, -- Home Currency
	ChqReturn	MONEY DEFAULT 0.0, -- Home Currency
	ExcessAmount	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับสะสมนำไปหักครั้งต่อไป
	IsMakeTrans SMALLINT DEFAULT 0, -- 0=ออกบิลได้ 1=ออกบิลไม่ได้
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน 2=อัตรา 0
	DefaultTaxRate	MONEY DEFAULT 7.0,
	TaxNo	VARCHAR(20),
	PaymentRemark	VARCHAR(50),
	StatementRemark	VARCHAR(50),
	PicFileName	VARCHAR(50),
	TypeCode	VARCHAR(10),
	GroupCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	HomePage	VARCHAR(255),
	EmailAddress	VARCHAR(40),
	GroupOfDebt	VARCHAR(10),
	PersonType	SMALLINT DEFAULT 0,	-- 0=บุคลลธรรมดา 1=นิติบุคคล
	AuthorizeAmount MONEY	DEFAULT 0.0, -- ทุนจดทะเบียน
	DocPicRefFile1	VARCHAR(255),	-- เอกสารอ้างอิง 1
	DocPicRefFile2	VARCHAR(255), -- เอกสารอ้างอิง 2
	BirthDay	DATETIME,	-- วันเกิด
	CustAge	SMALLINT DEFAULT 0,	-- อายุลูกหนี้
	CustStatus	SMALLINT DEFAULT 0,	-- 0=ลูกค้า 1=ลูกหนี้
	CustCreditType	SMALLINT DEFAULT 0,	-- 0=เงินสด 1=เงินเชื่อ 2=ตามบิล
	ReceiveByDay		VARCHAR(30),	--จ่ายเงินตามวัน เช่น จันทร์-ศุกร์
	ReceiveByDate	VARCHAR(30),	--จ่ายเงินตามวันที่ เช่น ทุกวันที่ 15 ของเดือน
	ReceiveByWeek	SMALLINT DEFAULT 0,	--จ่ายเงินตามสัปดาห์ที่ เช่น ทุกสัปดาที่ 4
	PayBillByDay		VARCHAR(30),	--วางบิลตามวัน เช่น จันทร์-ศุกร์
	PayBillByDate	VARCHAR(30),	--วางบิลตามวันที่ เช่น ทุกวันที่ 15 ของเดือน
	PayBillByWeek	SMALLINT DEFAULT 0,	--วางบิลตามสัปดาห์ที่ เช่น ทุกสัปดาที่ 4
	RouteStep1	VARCHAR(10),
	RouteStep2	VARCHAR(10),
	RouteStep3	VARCHAR(10),
	RouteStep4	VARCHAR(10),
	RouteStep5	VARCHAR(10),
	RouteStep6	VARCHAR(10),
	RouteStep7	VARCHAR(10),
	RouteStep8	VARCHAR(10),
	RouteStep9	VARCHAR(10),
	RouteStep10	VARCHAR(10),
	PriceLevel	SMALLINT DEFAULT 0, -- ระดับราคาขาย 1-8
	ActiveStatus	SMALLINT DEFAULT 1,
	MapCode	VARCHAR(10),	-- รหัสแผนที่ที่ตั้งบริษัทลูกค้า
	MapPosition_X	SMALLINT	DEFAULT  0,
	MapPosition_Y	SMALLINT	DEFAULT 0,
	ItemDescGroup	SMALLINT	DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	CreditMenCode	VARCHAR(10),  --พนักงานสินเชื่อ
	CreditMenCode2	VARCHAR(10),  --พนักงานสินเชื่อ
	CreditMenCode3	VARCHAR(10),  --พนักงานสินเชื่อ
	PressMenCode	VARCHAR(10), --พนักงานเร่งรัด
	PressMenCode2	VARCHAR(10), --พนักงานเร่งรัด
	PressMenCode3	VARCHAR(10), --พนักงานเร่งรัด
	KeepMoneyMenCode	VARCHAR(10),  --พนักงานเก็บเงิน
	KeepMoneyMenCode2	VARCHAR(10),  --พนักงานเก็บเงิน
	KeepMoneyMenCode3	VARCHAR(10),  --พนักงานเก็บเงิน
	CondPayCode	VARCHAR(10),  --เงื่อนไขการชำระเงิน
	UseGroupMoney	SMALLINT	DEFAULT  0, --ลูกหนี้หลายรายใช้วงเงินร่วมกันได้ (บริษัทในเครือ)	
	GroupCreditCode		VARCHAR(10), --รหัสกลุ่มวงเงิน	
	HomeCurCode VARCHAR(10), --รหัสสกุลเงินหลัก Aom 28-04-2003
	EarnestAmount	MONEY DEFAULT 0.0, -- ยอดเงินล่วงหน้า
--for address by aom
	billcompanyname VARCHAR(255),
	billisdefault SMALLINT DEFAULT 0,
	billrestype VARCHAR(255),
	billno varchar(10),
	billmoo varchar(10),
	billvillage VARCHAR(255),
	billbuilding VARCHAR(255),
	billfloor varchar(10),
	billroom varchar(10),
	billsoi VARCHAR(255),
	billroad VARCHAR(255),
	billsubdist VARCHAR(255),
	billdistrict VARCHAR(255),
	billprovince VARCHAR(255),
	billcountry VARCHAR(255),
	billzipcode varchar(10),
	billissubdist smallint default 0, -- by jum
	billisdistrict smallint default 0, --by jum
	homecompanyname VARCHAR(255),
	homeisdefault SMALLINT DEFAULT 0,
	homerestype VARCHAR(255),
	homeno varchar(10),
	homemoo varchar(10),
	homevillage VARCHAR(255),
	homebuilding VARCHAR(255),
	homefloor varchar(10),
	homeroom varchar(10),
	homesoi VARCHAR(255),
	homeroad VARCHAR(255),
	homesubdist VARCHAR(255),
	homedistrict VARCHAR(255),
	homeprovince VARCHAR(255),
	homecountry VARCHAR(255),
	homezipcode varchar(10),
	homeissubdist smallint default 0, -- by jum
	homeisdistrict smallint default 0, --by jum
	checkoverdueCRLimit smallint default 0,--0=check 1=not check
	overdueCreditLimit smallint default 0,-- 0= unilimit by jum
	--for EVS project
	DiscountWord VARCHAR(255),
	DefaultWTaxCash MONEY DEFAULT 3.0, -- Jeab 2005-09-13 ให้บริการจากการขายบัตรเงินสด
	DefSaleWHCode VARCHAR(10),
	DepartCode	VARCHAR(10),
-- ************** POS **********
	MEMBERID VARCHAR(20),
	BEGINDATE	DATETIME,
	EXPIREDATE	DATETIME,
	REMEMBER SMALLINT DEFAULT 0, -- ต่ออายุสมาชิก=1
	SUMOFMARK1 INT DEFAULT 0, -- ยอดแต้มสะสมคงเหลือ
	SUMOFMARK2 INT DEFAULT 0, -- ยอดแต้มสะสมคงเหลือ
	SUMOFAMOUNT1	MONEY DEFAULT 0.0, -- ยอดเงินสะสม
	SUMOFAMOUNT2	MONEY DEFAULT 0.0, -- ยอดเงินสะสม
	REFFILENAME1	VARCHAR(100),	-- เอกสารอ้างอิง 1
	REFFILENAME2	VARCHAR(100), -- เอกสารอ้างอิง 2	
	CREDITAMOUNTTYPE MONEY DEFAULT 0, --  ประเภทการรับเงินเครดิต  0 = ตามค่าเริ่มต้น , 1= คิดค่าชาร์จ,2=ไม่คิด
-- ************** POS **********
	IsExport smallint default 0,
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME,
	LinkWordFile VARCHAR(255)
    PRIMARY KEY(CODE)
);

CREATE  INDEX IDX_ARNAME ON BCAR(NAME1);
CREATE  INDEX IDX_ARACT	ON BCAR(ActiveStatus);

create table BCARPeriodState -- ยอดหนี้ในแต่ละ Period แสดงเป็น Home Currency
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ArCode	VARCHAR(20) NOT NULL,
	PeriodNo	SMALLINT DEFAULT 0,
	BeginAmount	MONEY DEFAULT 0.0, -- ยอดยกมา
	DebtAmount	MONEY DEFAULT 0.0, -- ยอดตั้งลูกหนี้
	CNAmount	MONEY DEFAULT 0.0, -- ยอดลดหนี้
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DebitAmount	MONEY DEFAULT 0.0, -- ยอดเพิ่หนี้
	ReceiptAmount	MONEY DEFAULT 0.0, -- ยอดตัดชำระหนี้
	EndAmount	MONEY DEFAULT 0.0, -- ยอดยกไป
	ExchangeProfit	MONEY DEFAULT 0.0, -- กำไรขาดทุนประจำงวด
	advanceamt		MONEY DEFAULT 0.0,
	advanceretamt	MONEY DEFAULT 0.0,
	advanceuseamt	MONEY DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ARPSAr ON BCARPeriodState(ArCode);
CREATE  INDEX IDX_ARPSPNo ON BCARPeriodState(PeriodNo);
CREATE  INDEX IDX_ARPSARPNo ON BCARPeriodState(ArCode,PeriodNo); --Jum 14:24 24/7/2549

create table BCARINVBALANCE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	IsExport smallint default 0,
	ArCode	VARCHAR(20) NOT NULL,
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	PayBillDate	DATETIME,
	SaleCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PayBillStatus	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	NetDebtAmount	MONEY DEFAULT 0.0,
	BillBalance	MONEY DEFAULT 0.0,
	BillType	SMALLINT DEFAULT 0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	BillTemporary MONEY DEFAULT 0.0, -- ยอดทำใบเสร็จชั่วคราว 2003-11-27
	MethodePaybill	VARCHAR(10), --วิธีการชำระเงิน
	MethodePaybill2	  VARCHAR(255) --วิธีการชำระเงิน 2
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_ARINVBDATE ON BCARINVBALANCE(DOCDATE);
--CREATE  INDEX IDX_ARINVBDOCNO ON BCARINVBALANCE(DOCNO);
CREATE  INDEX IDX_ARINVBARCD ON BCARINVBALANCE(ARCODE);
CREATE  INDEX IDX_ARINVBARDEP ON BCARINVBALANCE(DEPARTCODE);
CREATE  INDEX IDX_ARINVBSALE ON BCARINVBALANCE(SALECODE);
CREATE  INDEX IDX_ARINVBBS	ON BCARINVBALANCE(PayBillStatus);
CREATE  INDEX IDX_ARINVBBT ON BCARINVBALANCE(BillType);
CREATE  INDEX IDX_ARINVBBal ON BCARINVBALANCE(BillBalance);
CREATE  INDEX IDX_ARINVBDUE ON BCARINVBALANCE(DueDate);

create table BCAROtherDebt -- บันทึกลูกหนี้อื่นๆ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	IsExport smallint default 0,
	ArCode	VARCHAR(20) NOT NULL,
	GLBookCode	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	SumofDebit	MONEY DEFAULT 0.0,
	SumofCredit	MONEY DEFAULT 0.0,
	DepartCode	VARCHAR(10) ,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	PayBillDate	DATETIME,
	SaleCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	PayBillStatus	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	NetDebtAmount	MONEY DEFAULT 0.0,
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	BillTemporary MONEY DEFAULT 0.0, -- ยอดทำใบเสร็จชั่วคราว 2003-11-27
	MethodePaybill	VARCHAR(10), --วิธีการชำระเงิน
	MethodePaybill2	  VARCHAR(255) --วิธีการชำระเงิน 2	
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_AODBS	ON BCAROtherDebt(PayBillStatus);
CREATE  INDEX IDX_AODBal ON BCAROtherDebt(BillBalance);
CREATE  INDEX IDX_AODAR	ON BCAROtherDebt(ArCode);
--CREATE  INDEX IDX_AODOCNO	ON BCAROtherDebt(DOCNO);
CREATE  INDEX IDX_AODDUE ON BCAROtherDebt(DueDate);
CREATE  INDEX IDX_AODOCDATE ON BCAROtherDebt(DocDate);
CREATE  INDEX IDX_AODPNTC ON BCAROtherDebt(printcount);

create table BCARINVOICE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	TaxNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ArCode	VARCHAR(20) NOT NULL,
	PassBillTo VARCHAR(20) ,
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DeliveryDay	SMALLINT DEFAULT 0, -- ส่งของภายใน
	DeliveryDate	DATETIME, -- วันที่ลงของให้ลูกค้า
	DueDate	DATETIME,
	PayBillDate	DATETIME,
	SaleCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	InvoiceMyDesc	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	BillGroup	VARCHAR(10),
	RefDocNo	VARCHAR(20), -- เลขที่เอกสารอ้างอิง
	CrAuthorizeMan VARCHAR(20),
	DeliveryAddr VARCHAR(10),
	ContactCode	VARCHAR(10),
	TransportCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	DepositIncTax SMALLINT DEFAULT 1, -- เงินมัดจำ 1 = มีภาษี 0= ไม่มี Tax
	SumOfDeposit1	MONEY DEFAULT 0.0, -- สำหรับตัดยอดของบิล
	SumOfDeposit2	MONEY DEFAULT 0.0, -- สำหรับ post GL แต่ต้องถอด Vat ถ้าเป็นรวมใน
	SumOfWTax	MONEY DEFAULT 0.0,
	NetDebtAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetDebtAmount * ExchangRate  -- Jeab 2003-04-21
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting SMALLINT DEFAULT 0,--1=start posting GL 0=other
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsCreditNote	SMALLINT DEFAULT 0, -- 0=ยังไม่ลดหนี้ 1=ลดหนี้แล้ว
	IsDebitNote	SMALLINT DEFAULT 0, -- 0=ยังไม่เพิ่มหนี้ 1=เพิ่มหนี้แล้ว
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=auto 1=manual
	PayBillStatus	SMALLINT DEFAULT 0, -- 1 วางบิลอยู่
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ExchangeProfit	MONEY DEFAULT 0.0,
	CustTypeCode	VARCHAR(10),
	CustGroupCode	VARCHAR(10),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	Remark1	VARCHAR(30),
	Remark2	VARCHAR(30),
	Remark3	VARCHAR(30),
	Remark4	VARCHAR(30),
	Remark5	VARCHAR(30),
	IsReceiveMoney	SMALLINT DEFAULT 0, -- Flag 0 = คนออกบิลอย่างเดียว , 1 = คนรับเงินอย่างเดียว
	IsConditionSend SMALLINT DEFAULT 0, -- เงื่อนไขการรับสินค้า 0 = รับเอง, 1 = ส่งให้
	TotalTransport	MONEY DEFAULT 0.0, -- ค่าขนส่ง
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	---LENSO Modify Project
	GrossWeight	MONEY DEFAULT 0.0, -- น้ำหนักรวมสินค้า+น้ำหนักภาชนะ
	PrintCount SMALLINT DEFAULT 0, -- Count Print saleorder -- Jeab-20030923 
	SORefNo	VARCHAR(255), -- Total SO reference -- Jeab 19-04-2003 -- A& 
	DORefNo	VARCHAR(255), -- Total DO reference -- Jeab 19-04-2003 
	HoldingStatus SMALLINT DEFAULT 0, -- 0=ไม่ Holding 1= Holding -- Jeab 20030506-----
	TimeTransport		VARCHAR(10),	-- เวลาข่นส่ง
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	RefType SMALLINT DEFAULT 0, -- 0=billing,2=sale order,3=quatation
	BillTemporary MONEY DEFAULT 0.0, -- ยอดทำใบเสร็จชั่วคราว 2003-11-27
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	--- MERIDIAN Modify
	Netweight	MONEY DEFAULT 0.0, -- น้ำหนักรวมสินค้า
	NumOfPallet	MONEY DEFAULT 0.0, -- จำนวนภาชนะ
	--for EVS project
	InvoiceType VARCHAR(10),
	QtyAmount MONEY DEFAULT 0.0,
	QtyDefault SMALLINT DEFAULT 1,
	QtyCopy SMALLINT DEFAULT 1,
	MergeItem SMALLINT DEFAULT 1,
	Newline SMALLINT DEFAULT 1,
	PriceCopy SMALLINT DEFAULT 0,
	WHCopy SMALLINT DEFAULT 0,
	CalcTaxFlag SMALLINT DEFAULT 0,
	MethodePaybill	VARCHAR(10), --วิธีการชำระเงิน
	MethodePaybill2	  VARCHAR(255), --วิธีการชำระเงิน 2	
	promotioncode VARCHAR(20),
	SumOfWTaxCash	MONEY DEFAULT 0.0,	-- Jeab 2005-09-12
	SumBaseWTaxCash	MONEY DEFAULT 0.0,	-- Jeab 2005-09-12
	IsPackingList	SMALLINT DEFAULT 0, -- 1 = Set Packing
	------------ NORITAKE Modify -------------
	VesselOr VARCHAR(255),
	ETADate DATETIME,
	ETDDate DATETIME,
	FromVia VARCHAR(255),
	ToVia VARCHAR(255),
	MarkAndNos VARCHAR(255),
	DeliverTo VARCHAR(255),
	CountryOrigin VARCHAR(255),
	PayDateRemark VARCHAR(255),
	BookNo	VARCHAR(30), -- เลขที่บัญชี
	OtherPayment VARCHAR(255),
	FreightAmount MONEY DEFAULT 0.0, -- ค่าขนส่ง
	InsuranceAmount MONEY DEFAULT 0.0, -- ค่าประกัน
	FobAmount MONEY DEFAULT 0.0, -- NetDebtAmount -(FreightAmount+InsuranceAmount)
	MyDescPort VARCHAR(255),
	ProformaNo VARCHAR(20), -- Noritake
	IssuingBank VARCHAR(500), -- Noritake
	LCNo VARCHAR(50), -- Noritake
	LCDate VARCHAR(20), -- Noritake
	FormUnit VARCHAR(10), -- Noritake
	FootNote VARCHAR(1000), -- Noritake
-- ************** POS ---
	ISMULTITAXABB	SMALLINT DEFAULT 0, -- 0=บิลเดียวรับเงินเลย 1=ยังไม่เอาไปใช้รวมบิล 2=เอาไปใช้รวมยอดบิลแล้ว
	TAXABBNO_1 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TAXABBNO_2 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TAXABBNO_3 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TAXABBNO_4 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TAXABBNO_5 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TAXABBAMOUNT1  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ	
	TAXABBAMOUNT2  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ		
	TAXABBAMOUNT3  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ		
	TAXABBAMOUNT4  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ		
	TAXABBAMOUNT5  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ								
	APPROVEDCODE	VARCHAR(10),   -- รหัสผู้อนุมัติ ขายเชื่อติดเครดิต
	APPROVEDDATE	DATETIME,  -- วันที่อนุมัต ขายเชื่อติดเครดิติ
	CANCELDESC	VARCHAR(100),	-- หมายเหตุการยกเลิก
	ARNAME VARCHAR(200), -- สำหรับ POS
	ARADDRESS	VARCHAR(255), -- สำหรับ POS
	CASHIERCODE	VARCHAR(10),
	SHIFTCODE		VARCHAR(10), -- กะที่
	MACHINENO	VARCHAR(10), -- เลขที่เครื่อง
	MACHINECODE	VARCHAR(30), -- เลขประจำเครื่อง
	POSSTATUS SMALLINT DEFAULT 0, -- 0=ไม่ใช่ 1=ใบกำกับอย่างย่อ 2=ใบกำกับอย่างเต็มที่เอามาจากอย่างย่อ 3 ออกเป็นใบกำกับอย่างเต็มเลย
	BILLTIME	VARCHAR(15), -- เวลาของ POS
	CREDITTYPE	VARCHAR(10),
	CREDITBRANCH VARCHAR(40),
	CREDITDUEDATE	DATETIME,
	CREDITNO	VARCHAR(20), -- เลขที่บัตรเครดิต
	COFIRMNO	VARCHAR(20), --  เลขทีอนุมัติ
	CHARGEWORD	VARCHAR(30), -- % ที่ CHARE
	CREDITBASEAMOUNT MONEY DEFAULT 0.0, -- ยอดเงินบัตรเครดิตที่คิดค่า CHARGE
	CREDITVAT	MONEY DEFAULT 0.0, -- ยอด charge * vat
	CREDITSUMVAT MONEY DEFAULT 0.0, -- ยอด charge * vat + ยอดบัตร
	GRANDTOTAL MONEY DEFAULT 0.0, -- ยอดเงินที่จะได้รับจริง NETAMOUNT+CHARGEAMOUNT
	COUPONGAMOUNT	MONEY DEFAULT 0.0, -- ยอดจ่ายเป็นคูปอง
	COUPONGDESC	VARCHAR(100),	-- หมายเหตุคูปอง เช่นจำนวน
	CHANGEAMOUNT MONEY DEFAULT 0.0, --ยอดเงินทอน
	OTHERAMOUNT	MONEY DEFAULT 0.0, -- ยอดรับอื่นๆ เช่น AEON, EASYBUY, ... ไม่รวม CHARGE
	OTHERFEE	MONEY DEFAULT 0.0, -- ค่าธรรมเนียมการรับอื่นๆ
	SUMMARKCOUNT1	SMALLINT DEFAULT 0, -- แต้มสะสมราคาปกติ
	SUMMARKCOUNT2	SMALLINT DEFAULT 0, -- แต้มสะสมราคาพิเศษ
	SUMMARKVALUE1	MONEY DEFAULT 0.0, -- มูลค่าสะสมราคาปกติ
	SUMMARKVALUE2	MONEY DEFAULT 0.0, -- มูลค่าสะสมราคาพิเศษ
	DIFFAMOUNT MONEY DEFAULT 0.0, --ผลต่างจากการ ปัดเศษ
	ISREWARD	SMALLINT DEFAULT 0, -- 0=ยังไม่แลกของสมนาคุณ 1=แลกของสมนาคุณแล้ว
	POSCREDIT SMALLINT DEFAULT 0, -- 0 ขายสดในระบบ pos  1 ขายเชื่อในระบบ pos
	BranchCode VARCHAR(10),
-- ************** POS ---

--For AIS
	Cust_RefCoupon VARCHAR(50),
	Cust_MobilePhone VARCHAR(50),
	Cust_MemberCard VARCHAR(50),
	Cust_Sex	SMALLINT DEFAULT 0,--0=Male 1=Female
	Cust_Age	SMALLINT DEFAULT 0,
	ReceiveItemType Varchar(10) NULL,

	-- ***********  สำหรับเครื่องรูดบัตรเครดิต EDC ******************
	EDCBatchNo  VARCHAR(6) ,    -- Batch no 
	EDCCardHolder VARCHAR(22) , -- Credit card Holder Name
	EDCCardExpr  VARCHAR(4),  -- Creditcard Expire
	EDCTID	VARCHAR(8),  -- Terminal ID  (รหัสเครื่อง รูด)
	EDCSystemTrc  VARCHAR(6),  -- System trace
	EDCNII	VARCHAR(4),    -- System Reference Code
	EDCNetAmount MONEY DEFAULT 0.0
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_ARINVDATE ON BCARINVOICE(DOCDATE);
CREATE  INDEX IDX_ARINVARCD ON BCARINVOICE(ARCODE);
--CREATE  INDEX IDX_ARINVDOCNO ON BCARINVOICE(DOCNO);
CREATE  INDEX IDX_ARINVARDEP ON BCARINVOICE(DEPARTCODE);
CREATE  INDEX IDX_ARINVSALE ON BCARINVOICE(SALECODE);
CREATE  INDEX IDX_ARINVBAL ON BCARINVOICE(BillBalance);
CREATE  INDEX IDX_ARINVDUE ON BCARINVOICE(DueDate);
CREATE  INDEX IDX_ARINVBS	ON BCARINVOICE(PayBillStatus);
CREATE  INDEX IDX_ARINVBT	ON BCARINVOICE(BillType);
CREATE  INDEX IDX_ARINVREC	ON BCARINVOICE(RecurName);
CREATE  INDEX IDX_ARINVROW	ON BCARINVOICE(ROWORDER);
CREATE  INDEX IDX_ARINVHAMT	ON BCARINVOICE(HomeAmount);
CREATE INDEX IDX_ARINVPNTC ON BCARINVOICE(PrintCount);

-- ประเภทรายวัน (0 = ยอดยกมา, 1=รับสินค้าสำเร็จรูป,2=ซื้อ, 3=เพิ่มเจ้าหนี้,4=ขาย, 5=รับคืน,6,เพิ่มลูกหนี้, 7=ส่งคืน, 8=เบิกใช้,  9=รับคืนจาการเบิก,10=ปรับปรุง+ 11=ปรับปรุง-,12=โอนเข้า,13=โอนออก) 20=ส่งคืนสินค้าสำเร็จรูป

create table BCARINVOICESUB
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 4,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocNo	VARCHAR(20),
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	CNQty	MONEY DEFAULT 0.0,
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนขายทั้งสิ้น ไม่ใช่ต้นทุนขายต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	BalanceAmount	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	OppositePrice2	MONEY DEFAULT 0.0, -- ราคาต่อหน่วยที่ 2 (เส้น)
	SORefNo	VARCHAR(20),
	PORefNo	VARCHAR(20), --Order reference number
	StockType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	LineNumber	SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ของสินค้าที่อ้างอิงมาจากเอกสารอื่น
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	BarCode	VARCHAR(20),
	CustTypeCode	VARCHAR(10),
	CustGroupCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
-- ************* POS ------------
	MACHINENO	VARCHAR(10), -- เลขที่เครื่อง
	MACHINECODE	VARCHAR(30), -- เลขประจำเครื่อง
	BILLTIME	VARCHAR(15),
	CASHIERCODE	VARCHAR(10),
	SHIFTCODE		VARCHAR(10), -- กะที่
	POSSTATUS SMALLINT DEFAULT 0, -- 0=ไม่ใช่ 1=ใบกำกับอย่างย่อ 2=ใบกำกับอย่างเต็ม
	PRICESTATUS SMALLINT DEFAULT 0, -- 0=ราคาปกติ 1=ราคาโปรโมชั่น
	PROMOSTATUS SMALLINT DEFAULT 0,--แสดงโปรโมชั่น ทำตัว P ตัว N ของคุณเจือ
	OLDPRICE	MONEY DEFAULT 0.0,--ราคาสินค้าเดิมก่อนการแก้ไข
	USERCODE	VARCHAR(10),--รหัสผู้แก้ราคา
	USERMODIFY	SMALLINT DEFAULT 0, --0 = ไม่แก้ราคา 1 =แก้ราคา
	POSCREDIT SMALLINT DEFAULT 0, -- 0 ขายสดในระบบ pos  1 ขายเชื่อในระบบ pos
	ReceiveItemType Varchar(10) NULL,  -- ประเภทการรับ
-- ************* POS ------------
	PremiumStatus SMALLINT DEFAULT 0, -- 0 = ไม่ใช่ของแถม ,1 = เป็นของแถม
	--Auto Packing Section by นก
	FixUnitCost	MONEY DEFAULT 0.0,
	FixUnitQty		MONEY DEFAULT 0.0,
	IsConditionSend SMALLINT DEFAULT 0,-- เงื่อนไขการรับสินค้า 0 = รับเอง, 1 = ส่งให้
	TransportAmount	MONEY DEFAULT 0.0, -- ค่าขนส่ง
	AVERAGECOST MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for item set by aom 15-07-2003
	itemsetcode VARCHAR(25),
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25		
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	RefType SMALLINT DEFAULT 0, -- 0=billing,2=sale order,3=quatation
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
--for evs project
	PriceCode varchar(10),
	InvoiceType varchar(10),
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0,
	DORefNo	VARCHAR(20),
	DeliveryStatus SMALLINT DEFAULT 0, -- 0 = ไม่อ้างอิงใบสั่งจ่าย  , 1= อ้างอิงใบสั่งจ่าย
	ItemNameDesc varchar(255),
	promotioncode VARCHAR(20),
	masteritemcode	VARCHAR(25),
	BTDisc MONEY DEFAULT 0.0,
	DiscCashCard SMALLINT DEFAULT 0, -- ใช่ส่วนลดบัตรเงินสด	
	WTaxAmount	MONEY DEFAULT 0.0,
	BaseWTax	MONEY DEFAULT 0.0,
	IsPackingList	SMALLINT DEFAULT 0, -- 1 = Set Packing
	Netweight	MONEY DEFAULT 0.0, -- น้ำหนักของสินค้า
	GrossWeight	MONEY DEFAULT 0.0, -- น้ำหนักของสินค้า+น้ำหนักภาชนะ
	Measurement	VARCHAR(255),
	MeasureWide	MONEY DEFAULT 0.0,
	MeasureLong	MONEY DEFAULT 0.0,
	MeasureHigh	MONEY DEFAULT 0.0,
	BranchCode VARCHAR(10),
	FactorPrice MONEY DEFAULT 0.0, --Price in factor Unit, แม่ทองสุข		
	RetailPrice	 MONEY DEFAULT 0.0,
	RetailAmount	 MONEY DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ARINVSDATE ON BCARINVOICESUB(DOCDATE);
CREATE  INDEX IDX_ARINVSDOCNO ON BCARINVOICESUB(DOCNO);
CREATE  INDEX IDX_ARINVSARCD ON BCARINVOICESUB(ARCODE);
CREATE  INDEX IDX_ARINVSARDEP ON BCARINVOICESUB(DEPARTCODE);
CREATE  INDEX IDX_ARINVSSALE ON BCARINVOICESUB(SALECODE);
CREATE  INDEX IDX_ARINVSIND ON BCARINVOICESUB(BehindIndex);
CREATE  INDEX IDX_ARINVSTYPE ON BCARINVOICESUB(MYTYPE);
CREATE  INDEX IDX_ARINVSITEM ON BCARINVOICESUB(ITEMCODE);
CREATE  INDEX IDX_ARINVSWH ON BCARINVOICESUB(WHCODE);
CREATE  INDEX IDX_ARINVSSHLF ON BCARINVOICESUB(SHELFCODE);
CREATE  INDEX IDX_ARINVSBND ON BCARINVOICESUB(BRANDCODE);
CREATE  INDEX IDX_ARINVSGRP ON BCARINVOICESUB(GROUPCODE);
CREATE  INDEX IDX_ARINVSTYPEC ON BCARINVOICESUB(TYPECODE);
CREATE  INDEX IDX_ARINVSFRM ON BCARINVOICESUB(FORMATCODE);
CREATE  INDEX IDX_ARINVSTS ON BCARINVOICESUB(TransState);
CREATE  INDEX IDX_ARINVSERVICE ON BCARINVOICESUB(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_ARINVISPROCESS ON BCARINVOICESUB(ItemCode,IsProcess);
CREATE  INDEX IDX_ARINVISHAMT ON BCARINVOICESUB(HomeAmount);
CREATE  INDEX IDX_ARINVISPAK1 ON BCARINVOICESUB(PackingRate1);
CREATE  INDEX IDX_ARINVISPAK2 ON BCARINVOICESUB(PackingRate2);
CREATE  INDEX IDX_ARINVISISPC ON BCARINVOICESUB(IsProcess);
CREATE  INDEX IDX_SERV_ARINVSUB ON BCArInvoiceSub(SORefNo,IsCancel,DeliveryStatus,ItemCode,ROWORDER,DocNo,Qty,PackingRate1,PackingRate2,RefLineNumber);

create table BCITEMSUBSTITUTE	-- สินค้าทดแทน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SUBSTITUTECode VARCHAR(25),
	MyDescription	VARCHAR(25),
	UnitCode	VARCHAR(10)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITMSTTCD ON BCITEMSUBSTITUTE(ItemCode);
CREATE  INDEX IDX_ITMSTTTC ON BCITEMSUBSTITUTE(SUBSTITUTECode);
CREATE  INDEX IDX_ITM_UNIT_STTTC ON BCITEMSUBSTITUTE(SUBSTITUTECode,UnitCode);

create table BCITEMMATCH	-- สินค้าคู่และไม่คู่
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	MasterCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MatchCode	VARCHAR(25),
	MyDescription	VARCHAR(25),
	Qty	MONEY	DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	MatchStatus	SMALLINT	DEFAULT 0	-- 0=Math	1=Not Math
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITMMMT	ON BCITEMMATCH(MasterCode);
CREATE  INDEX IDX_ITMMMC	ON BCITEMMATCH(MatchCode);
CREATE  INDEX IDX_ITMMMC2 ON BCITEMMATCH(MatchCode,UnitCode);

create table BCSTKInspect -- รายการตรวจนับ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
	cancelcode    varchar(30),
    canceldatetime    datetime,
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255), -- หมายเหตุในการออกใบตรวจนับ
	ResultDesc	VARCHAR(255), -- หมายเหตุผลการตรวจนับ
	InspectBy	SMALLINT DEFAULT 0,	-- 0=สินค้า,คลัง 1=คลัง,สินค้า
	IsConfirm	SMALLINT DEFAULT 0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsExport smallint default 0,
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME	
    PRIMARY KEY(DocNo)
);

create table BCSTKInspectSub -- รายการย่อยตรวจนับ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	InspectBy	SMALLINT DEFAULT 0,	-- 0=สินค้า,คลัง 1=คลัง,สินค้า
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UnitCode	VARCHAR(10),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	AdjustStatus	SMALLINT DEFAULT 0, -- 0=ยังไม่ปรับปรุง 1=ปรับปรุงแล้ว
	StkQty	MONEY	DEFAULT 0.0, -- ยอดสินค้าคงเหลือปัจจุบัน
	InspectQty MONEY	DEFAULT 0.0, -- ยอดที่ตรวจนับได้
	InspectDesc	VARCHAR(255), -- หมายเหตุผลการตรวจนับ
	DiffQty	MONEY	DEFAULT 0.0,  -- ผลต่างจากการตรวจนับ
	BarCode	VARCHAR(20),
	LineNumber	SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKINSCODE ON BCSTKInspectSub(ItemCode);
CREATE  INDEX IDX_STKINSWH ON BCSTKInspectSub(WHCode);
CREATE  INDEX IDX_STKINSWH2 ON BCSTKInspectSub(ItemCode,UnitCode,WHCode,ShelfCode);

create table BCSTKAdjust -- ปรับปรุงสต็อก
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    cancelcode    varchar(30),
    canceldatetime    datetime,
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InspectNo	VARCHAR(20), -- เลขที่ใบตรวจนับ
	MyDescription	VARCHAR(255), -- หมายเหตุในการออกใบตรวจนับ
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other	
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=auto 1=manual
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	SumAmount	MONEY	DEFAULT 0.0, -- มูลค่าสินค้าที่เป็นบวก (Stock Over)
	SumAmount2	MONEY	DEFAULT 0.0, -- มูลค่าสินค้าที่เป็นลบ (Stock Loss)
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	TaxAmount	MONEY	DEFAULT 0.0, -- ภาษี
	TotalAmount 	MONEY	DEFAULT 0.0, -- ยอดรวมภาษี
	SumOfExceptTax 	MONEY	DEFAULT 0.0, -- ยอดยกเว้นภาษี
	OutputTaxStatus SMALLINT DEFAULT 0, -- 0=ไม่มี 1=มีภาษีขาย
	AdjustType	SMALLINT DEFAULT 0, -- 0=สินค้าเกินบัญชี 1=สินค้าขาดบัญชี 2=สินค้าขาดบัญชีไม่เหลือซาก
	PackingStatus	SMALLINT DEFAULT 0, -- 0 = มาจากปรับปรุงสต๊อก , 1 = มาจากการแตก Packing
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	SumOfCost	MONEY	DEFAULT 0.0, --- 23-11-2002 ---
	SumOfCost2	MONEY DEFAULT 0.0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	IsPos		SMALLINT DEFAULT 0, 
	DepartCode	VARCHAR(10)
    PRIMARY KEY(DocNo)
);
CREATE  INDEX IDX_STKINSDDATE ON BCSTKAdjust(DocDate);
CREATE  INDEX IDX_STKINSGLFORMAT ON BCSTKAdjust(GLFormat);
CREATE INDEX IDX_STKINSPNTC ON BCSTKAdjust(PrintCount);

create table BCSTKAdjustSub -- ปรับปรุงสต็อก
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 10, -- 10 = ปรับปรุง +, 11=ปรับปรุง-
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InspectNo	VARCHAR(20), -- เลขที่ใบตรวจนับ
	InspectRow	INT , -- RowOrder ของรายการย่อยตรวจนับ
	ItemCode	VARCHAR(25),
	UnitCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	AdjMark	SMALLINT DEFAULT 0,	-- 0=ปรับปรุง+ 1=ปรับปรุง-
	Qty	MONEY	DEFAULT 0.0, -- ยอดปรัปปรุง
	AdjCost	MONEY	DEFAULT 0.0, -- ยอดต้นทุนปรัปปรุง
	Amount	MONEY	DEFAULT 0.0, -- มูลค่าต้นทุน
	SumOfCost	MONEY	DEFAULT 0.0,
	SumOfCost2	MONEY DEFAULT 0.0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	Price MONEY	DEFAULT 0.0, -- ราคา/หน่วย
	LineNumber	SMALLINT DEFAULT 0,
	PackingStatus	SMALLINT DEFAULT 0, -- 0 = มาจากปรับปรุงสต๊อก , 1 = มาจากการแตก Packing
	NetAmount MONEY	DEFAULT 0.0, -- มูลค่าสินค้า
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก	
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก	
	AVERAGECOST MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
	BarCode	VARCHAR(20),
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLMONEY DEFAULT 0,
	IsPos		SMALLINT DEFAULT 0, 
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKADSDOCNO ON BCSTKAdjustSub(DocNo);
CREATE  INDEX IDX_STKADSCODE ON BCSTKAdjustSub(ItemCode);
CREATE  INDEX IDX_STKADSWH ON BCSTKAdjustSub(WHCode);
CREATE  INDEX IDX_STKADSMT ON BCSTKAdjustSub(MyType);
CREATE  INDEX IDX_STKADSMI ON BCSTKAdjustSub(BehindIndex);
CREATE  INDEX IDX_STKADSALL1 ON BCSTKAdjustSub(ItemCode,UnitCode,WhCode,ShelfCode);
CREATE  INDEX IDX_STKADSALL2 ON BCSTKAdjustSub(DocNo,ItemCode,UnitCode,WhCode,ShelfCode);
CREATE  INDEX IDX_STKADSALL3 ON BCSTKAdjustSub(DocNo,Linenumber);
CREATE  INDEX IDX_STKADSSERVICE ON BCSTKAdjustSub(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_STKADSPAK1 ON BCSTKAdjustSub(PackingRate1);
CREATE  INDEX IDX_STKADSPAK2 ON BCSTKAdjustSub(PackingRate2);
CREATE  INDEX IDX_STKADSISPC ON BCSTKAdjustSub(IsProcess);

create table BCITEMComponents -- รายการประกอบของสินค้าชุด
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ParentCode	VARCHAR(25), -- รหัสสินค้าชุด
	ItemCode	VARCHAR(25), -- รหัสประกอบ
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Qty	MONEY	DEFAULT 0.0, --จำนวน
	Price	MONEY	DEFAULT 0.0, --ราคา
	Amount	MONEY	DEFAULT 0.0, -- มูลค่า
	Price1	MONEY	DEFAULT 0.0,
	Amount1	MONEY	DEFAULT 0.0,
	Price2	MONEY	DEFAULT 0.0,
	Amount2	MONEY	DEFAULT 0.0,
	Price3	MONEY	DEFAULT 0.0,
	Amount3	MONEY	DEFAULT 0.0,
	Price4	MONEY	DEFAULT 0.0,
	Amount4	MONEY	DEFAULT 0.0,
	Price5	MONEY	DEFAULT 0.0,
	Amount5	MONEY	DEFAULT 0.0,
	Price6	MONEY	DEFAULT 0.0,
	Amount6	MONEY	DEFAULT 0.0,
	Price7	MONEY	DEFAULT 0.0,
	Amount7	MONEY	DEFAULT 0.0,
	Price8	MONEY	DEFAULT 0.0,
	Amount8	MONEY	DEFAULT 0.0,
	UnitCode	VARCHAR(10), --หน่วยนับ
	SaleType smallint default 0,
	TaxType smallint default 0,	
	TempQty	MONEY	DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITMCPPRC	ON BCITEMComponents(ParentCode);
CREATE  INDEX IDX_ITMCPITEM	ON BCITEMComponents(ItemCode);

create table BCStkPeriodBal -- ยอด Stock ในแต่ละงวดบัญชี คำนวณเก็บไว้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PeriodNo	SMALLINT DEFAULT 0, -- หมายเลข Period ตาม GL
	IsReProcess	SMALLINT DEFAULT 0, -- 0=ไม่ 1= จะต้องReProcess
	ItemCode	VARCHAR(25), -- รหัสสินค้า
	UnitCode	VARCHAR(10), -- หน่วยนับ Stock
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BeginQty	MONEY	DEFAULT 0.0, -- ยอดยกมาต้นงวด
	BeginAmount	MONEY	DEFAULT 0.0,
	SaleQty	MONEY	DEFAULT 0.0, -- ยอดตัดขาย
	SaleAmount	MONEY	DEFAULT 0.0,
	BuyQty	MONEY	DEFAULT 0.0, -- ยอดซื้อ
	BuyAmount	MONEY	DEFAULT 0.0,
	StkRetQty	MONEY	DEFAULT 0.0, -- ยอดส่งคืนสินค้า
	StkRetAmount	MONEY	DEFAULT 0.0,
	CNQty	MONEY	DEFAULT 0.0, -- ยอดรับคืนสินค้า
	CNAmount	MONEY	DEFAULT 0.0,
	Db1Qty	MONEY	DEFAULT 0.0, -- ยอดเพิ่มหนี้ลูกหนี้
	Db1Amount	MONEY	DEFAULT 0.0,
	Db2Qty	MONEY	DEFAULT 0.0, -- ยอดเพิ่มหนี้เจ้าหนี้
	Db2Amount	MONEY	DEFAULT 0.0,
	IssueQty	MONEY	DEFAULT 0.0, -- ยอดเบิก
	IssueAmount	MONEY	DEFAULT 0.0,
	IssueRetQty	MONEY	DEFAULT 0.0, -- ยอดรับคืนเบิก
	IssueRetAmount	MONEY	DEFAULT 0.0,
	FGQty MONEY	DEFAULT 0.0, -- ยอดรับสำเร็จรูป
	FGAmount MONEY	DEFAULT 0.0,
	InQty MONEY	DEFAULT 0.0, -- ยอดรับเข้าอื่นๆ
	InAmount MONEY	DEFAULT 0.0,
	OutQty MONEY	DEFAULT 0.0, -- ยอดจ่ายออกอื่นๆ
	OutAmount MONEY	DEFAULT 0.0,
	EndQty MONEY	DEFAULT 0.0, -- ยอดยกไป
	EndAmount MONEY	DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKBALPNo ON BCStkPeriodBal(PeriodNo);
CREATE  INDEX IDX_STKBALIC ON  BCStkPeriodBal(ItemCode);
CREATE  INDEX IDX_STKBALIC1 ON  BCStkPeriodBal(ItemCode,Unitcode);
CREATE  INDEX IDX_STKBALIC2 ON  BCStkPeriodBal(PeriodNo,ItemCode);
CREATE  INDEX IDX_STKBALIC3 ON  BCStkPeriodBal(ItemCode,PeriodNo);

create table BCStkWHPeriodBal -- ยอด Stock ในแต่ละงวดบัญชี ของคลัง คำนวณเก็บไว้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PeriodNo	SMALLINT DEFAULT 0, -- หมายเลข Period ตาม GL
	ItemCode	VARCHAR(25), -- รหัสสินค้า
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	WHCode	VARCHAR(10), -- คลัง
	ShelfCode	VARCHAR(10), -- คลัง
	UnitCode	VARCHAR(10), -- หน่วยนับ Stock
	BeginQty MONEY	DEFAULT 0.0,
	BeginAmount	MONEY	DEFAULT 0.0,
	Qty	MONEY	DEFAULT 0.0, -- ยอดคงเหลือประจำงวด
	Amount	MONEY	DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKWBALPNo ON BCStkWHPeriodBal(PeriodNo);
CREATE  INDEX IDX_STKWBALIC ON  BCStkWHPeriodBal(ItemCode);
CREATE  INDEX IDX_STKWBALWH ON  BCStkWHPeriodBal(WHCode);
CREATE  INDEX IDX_STKWBALSH ON  BCStkWHPeriodBal(ShelfCode);
CREATE  INDEX IDX_STKWBALUN ON  BCStkWHPeriodBal(UnitCode);
CREATE  INDEX IDX_STKWBALPNo1 ON BCStkWHPeriodBal(ItemCode,UnitCode,WHCode,ShelfCode,PeriodNo);


create table BCITEMBILLDESC
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BillDesc	VARCHAR(255),
	LineNumber	SMALLINT DEFAULT 0,
	DescGroup	SMALLINT DEFAULT 0 -- แบ่งตามลูกค้า หรือเจ้าหนี้
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITBILLD_CODE ON BCITEMBILLDESC(ItemCode);

create table BCSUPPLIERPROMO -- ตารางของแถมจากเจ้าหนี้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ApCode	VARCHAR(20),
	ItemCode VARCHAR(25), -- รหัสสินค้าหลัก
	ItemPromo	VARCHAR(25), -- รหัสสินค้าที่แถม
	UnitCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Qty	MONEY	DEFAULT 0.0, 
	ProStartDate	DATETIME,
	ProStopDate	DATETIME,
	LineNumber	SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_SPPROMO_AP ON BCSUPPLIERPROMO(ApCode);
CREATE  INDEX IDX_SPPROMO_ITM ON BCSUPPLIERPROMO(ItemCode);
CREATE  INDEX IDX_SPPROMO_UNIT ON BCSUPPLIERPROMO(UnitCode);


create table BCItemRenovate -- ใบรับซ่อม
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL, -- เลขที่ใบรับซ่อม
	DocDate	DATETIME NOT NULL, -- วันที่รับซ่อม
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ArCode	VARCHAR(20) NOT NULL, -- รหัสลูกค้า
	ItemCode VARCHAR(25) NOT NULL, -- รหัสสินค้า
	InvoiceNo	VARCHAR(20), -- เลขที่ใบขาย
	MyDescription1 VARCHAR(255), -- หมายเหตุการรับซ่อม
	MyDescription2 VARCHAR(255), -- การรับซ่อม
	FinishDate	DATETIME, -- วันที่กำหนดเสร็จ
	SendDate DATETIME -- วันที่กำหนดส่งมอบ
    PRIMARY KEY(DocNo)
);

create table BCItemStatus -- สถานะสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCITEM
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(25) NOT NULL,
	Name1	VARCHAR(255),
	Name2	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ShortName VARCHAR(255), -- สำหรับ POS
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	ColorCode	VARCHAR(255),	-- สี
	MyGrade	VARCHAR(40),	-- เกรด
	MyClass	VARCHAR(255), -- รุ่น
	GenericCode	VARCHAR(10),
	UnitType	SMALLINT DEFAULT 0, -- หลายหน่วยนับหรือไม่ 0=หน่วยนับเดียว 1=หลายหน่วย 2=หน่วยนับขนาน
	DefStkUnitCode	VARCHAR(10),
	DefSaleUnitCode	VARCHAR(10),
	DefBuyUnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10), -- หน่วยที่ 1 (คิดราคาขาย)
	OppositeUnit2	VARCHAR(10), -- หน่วยที่ 2 (นับ Stock)
	Opposite1Price	MONEY DEFAULT 0.0, -- ราคาขาย
	OppositeRate	MONEY DEFAULT 0.0, -- อัตราส่วนของหน่วยที่ 1 ต่อหน่วยที่ 2
	MySize	VARCHAR(255), -- ขนาด
	Weight	MONEY DEFAULT 0.0, -- น้ำหนัก
	Wide	MONEY DEFAULT 0.0, -- กว้าง
	Long	MONEY DEFAULT 0.0, -- ยาว
	High	MONEY DEFAULT 0.0, -- สูง	
	LastUpdate	DATETIME,
	StockType	SMALLINT DEFAULT 0, --ชนิดของสินค้า 0=สินค้าทั่วไป 1=สินค้าบริการ 2=สินค้าที่มี Serial 3=สินค้าสำหรับเช่า 4=สินค้าสำหรับฝากขาย 5=สินค้าชุด 6=สินค้าพิเศษ 
	StockProcess SMALLINT DEFAULT 0, -- การประมวลผล 0=ตามระบบรวม 1=ห้ามติดลบ
	VenderCode	VARCHAR(20), -- รับฝากขายจากใคร
	DepositCondit VARCHAR(35), -- % ที่รับวางเงินมัดจำตามยอดของบิล
	DeliveryCharge VARCHAR(35), -- ค่าขนส่ง % หรือบาท
	InstallCharge VARCHAR(35), -- ค่าติดตั้ง % หรือบาท
	ReturnRemark VARCHAR(255), -- หมายเหุตการรับคืนสินค้า
	ReturnStatus SMALLINT DEFAULT 0, -- 0=รับคืนทุกกรณี 1=รับคืนทุกกรณี
	ReturnCharge VARCHAR(30), -- ส่วนลดที่ต้องหัก เมื่อรับคืน
	ItemStatus VARCHAR(10), -- รหัสสถานะสินค้า
	NewItemStatus	SMALLINT DEFAULT 0,  -- 0=สินค้าใหม่ 1=สินค้าเก่า
	RenovateStatus	SMALLINT DEFAULT 0,  -- 0=รับซ่อมฟรี 1=รับซ่อมคิดค่อใช้จ่าย 3=ไม่รับซ่อม
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	PromotionType SMALLINT DEFAULT 0, -- 0=ไม่คิด 1=แบบซื้อ A+B แถม C 2=แบบเป็นลำดับขั้น 3=แบบตามจำนวน
	WTaxRate MONEY DEFAULT 0.0, -- อัตราภาษีหัก ณ ที่จ่าย
	WaveFile	VARCHAR(50),
	CostType	SMALLINT DEFAULT 0,
	OrderPoint	MONEY DEFAULT 0.0,
	StockMin	MONEY DEFAULT 0.0,
	StockMax	MONEY DEFAULT 0.0,
	StockQty	MONEY DEFAULT 0.0,
	AverageCost	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	CostOfArea	MONEY DEFAULT 0.0,
	StockQtyStandard	MONEY DEFAULT 0.0,
	LastBuyPrice	MONEY DEFAULT 0.0,
	StandardCost	MONEY DEFAULT 0.0,
	PicFileName1	VARCHAR(255),
	PicFileName2	VARCHAR(255),
	PicFileName3	VARCHAR(255),
	PicFileName4	VARCHAR(255),
	SpecFileName	VARCHAR(255),
	AviFileName	VARCHAR(255),
	AccGroupCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	DefBuyWHCode	VARCHAR(10),
	DefBuyShelf	VARCHAR(15),
	DefSaleWHCode	VARCHAR(10),
	DefSaleShelf	VARCHAR(15),
	DefBadWHCode	VARCHAR(10),
	DefBadShelf	VARCHAR(15),
	DefFGWHCode	VARCHAR(10),
	DefFGShelf	VARCHAR(15),
	DefRepairWHCode	VARCHAR(10),
	DefRepairShelf	VARCHAR(15),
	DefRawWHCode	VARCHAR(10),
	DefRawShelf	VARCHAR(15),
	Formula1	VARCHAR(10),
	Formula2	VARCHAR(10),
	Formula3	VARCHAR(10),
	Discount	VARCHAR(35),
	ReserveQty	MONEY DEFAULT 0.0,
	RemainOutQty	MONEY DEFAULT 0.0,
	RemainInQty	MONEY DEFAULT 0.0,
	BasePrice	MONEY DEFAULT 0.0, -- ฐานคิดภาษีสินค้าพิเศษ
	ActiveStatus	SMALLINT DEFAULT 1,-- 0 = เลิกขาย, 1= ขาย
	CanMakePO	SMALLINT DEFAULT 0, --0 = เลิกซื้อ,1= เลิกซื้อ
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	SalePrice1		MONEY DEFAULT 0.0, -- กำหนดราคาขาย 
	SalePrice2		MONEY DEFAULT 0.0, -- กำหนดราคาขาย 
	SalePrice3		MONEY DEFAULT 0.0, -- กำหนดราคาขาย 
	SalePrice4	MONEY DEFAULT 0.0,
	SalePrice5	MONEY DEFAULT 0.0,
	SalePrice6	MONEY DEFAULT 0.0,
	SalePrice7	MONEY DEFAULT 0.0,
	SalePrice8	MONEY DEFAULT 0.0,
	PriceVatOut1	MONEY DEFAULT 0.0,
	PriceVatOut2	MONEY DEFAULT 0.0,
	PriceVatOut3	MONEY DEFAULT 0.0,
	PriceVatOut4	MONEY DEFAULT 0.0,
	PriceVatOut5	MONEY DEFAULT 0.0,
	PriceVatOut6	MONEY DEFAULT 0.0,
	PriceVatOut7	MONEY DEFAULT 0.0,
	PriceVatOut8	MONEY DEFAULT 0.0,
	--Auto Packing Section by นก
	DefFixUnitCode	VARCHAR(10),
	DefFixUnitCost	MONEY DEFAULT 0.0,
	FixQty		MONEY DEFAULT 0.0,
	FixCost		MONEY DEFAULT 0.0,
	SalePriceNV1	MONEY DEFAULT 0.0,
	SalePriceNV2	MONEY DEFAULT 0.0,
	SalePriceNV3	MONEY DEFAULT 0.0,
	ProcessStatus	SMALLINT DEFAULT 0,
	IsGift	SMALLINT DEFAULT 0,
	PromoMember		SMALLINT DEFAULT 0,
	PromoType	SMALLINT DEFAULT 0,
	AverageCostReal		MONEY DEFAULT 0.0,
	OverReceive	MONEY DEFAULT 0.0, -- ยอดที่รับได้ไม่เกิน
	------Lenso Modify Project-----
	ContainerCapacity	MONEY DEFAULT 0.0,
	ContainerWeight	MONEY DEFAULT 0.0,
	CapacityUnit	VARCHAR(20),
	LastBuyPriceHome	MONEY DEFAULT 0.0,--Last buy price in local currency
	LastBuyCurrencyCode	VARCHAR(10),
	LastAvgCost	MONEY DEFAULT 0.0, --Last average cost
	UserGroup VARCHAR(255),
	stockqty1 MONEY DEFAULT 0.0,
	stockqty2 MONEY DEFAULT 0.0,
	StockQtyWord VARCHAR(255), -- P'Jead use -- Description Unit
	CustGroup VARCHAR(255),
	PublisherCode VARCHAR(10),
	WriterCode VARCHAR(100),
	PrintOrdinal SMALLINT DEFAULT 1,
	PrintYear SMALLINT,
	LastSaleDate	DATETIME, -- วันที่ขายล่าสุด
	LastBuyDate	DATETIME, -- วันที่ซื้อล่าสุด
	LastSalePrice	MONEY DEFAULT 0.0, -- ราคาขายล่าสุด
	LastSalePriceHome	MONEY DEFAULT 0.0, -- ราคาขายล่าสุด * Exchange Rate
	LastSaleCurrencyCode	VARCHAR(10), -- สกุลเงินที่ขายล่าสุด
	-------------------------end A-FOSS script----------------
	Specification	Varchar(255),	--คุณสมบัติ	 
	ManufactoryCode	Varchar(10),	--รหัสผู้ผลิต (เพิ่ม table ด้วย***)
	AFT_remark	VARCHAR(255),	--ใช้เฉพาะใน A-FOSS
	UnitWeight	Money	DEFAULT 0.0,	--ใช้เฉพาะใน A-FOSS
	WeightUnitCode	Varchar(10),	--หน่วยนับของ unitWeight
	LeadTime		varchar(60),	--ใช้เฉพาะใน A-FOSS
	OfferedBy		VARCHAR(255),		--ใช้เฉพาะใน A-FOSS
	OfferedDate	Datetime,
	HS_SMX_remark	VARCHAR(255),
	Description	Varchar(255),
	ItemBarCode Varchar(255),
--for evs project
	PriceCode varchar(10),
	Classfication VARCHAR(10),
	DiscCashCard SMALLINT DEFAULT 0, -- ใช่ส่วนลดบัตรเงินสด
	IsChangeQty smallint default 0 -- กรณ๊ที่เป็นสินค้าชุดแบบที่ 2 สามารถแก้ไขจำนวนก่อน Load รายการทำรายวัน
    PRIMARY KEY(CODE)
);

CREATE  INDEX IDX_ITEM_NAME ON BCITEM(NAME1);
CREATE  INDEX IDX_ITEM_STKTP	ON  BCITEM(StockType);
CREATE  INDEX IDX_ITEM_CSTTP	ON  BCITEM(CostType);
CREATE  INDEX IDX_ITEM_ACT	ON  BCITEM(ActiveStatus);

create table BCFormula
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	MyDescription	VARCHAR(255),
	IsConfirm	SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME
    PRIMARY KEY(CODE)
);

create table BCFormulaSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	UnitCode	VARCHAR(10),
	LineNumber	SMALLINT DEFAULT 0,
	Qty	MONEY DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_FMS_CODE ON  BCFormulaSub(CODE);
CREATE  INDEX IDX_FMS_ICODE ON  BCFormulaSub(ItemCode);
CREATE  INDEX IDX_FMS_CODE1 ON  BCFormulaSub(ItemCode,Code,UnitCode);


-- ทะเบียนผู้จำหน่ายสินค้า
create table BCItemSupplier
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25) NOT NULL,
	ApCode	VARCHAR(20) NOT NULL,
	TransportTime	SMALLINT DEFAULT 0,
	PaymentCase	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BuyPrice	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	FightCase	VARCHAR(255),
	LastBuyPrice	MONEY DEFAULT 0.0,
	LastBuyDate	DATETIME,
	LastBuyUnitCode	VARCHAR(10),
	PriorityIndex SMALLINT DEFAULT 0, --ลำดับความสำคัญ
	ProStartDate	DATETIME,
	ProStopDate	DATETIME,
	ProBuyPrice	MONEY DEFAULT 0.0,
	ItemCodeSupplier	VARCHAR(25), -- รหัสสินค้าตาม Supplier
	ItemNameSupplier	VARCHAR(255)-- ชื่อสินค้าตาม Supplier
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITMSPCODE ON BCItemSupplier(ItemCode);
CREATE  INDEX IDX_ITMSPAP ON BCItemSupplier(APCODE);
CREATE  INDEX IDX_ITMSPCODE1 ON BCItemSupplier(ApCode,ItemCode,UnitCode);

create table BCItemAccGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50),
	ItemAccount	VARCHAR(20),
	CostAccount	VARCHAR(20),
	RevenueAccount	VARCHAR(20)
    PRIMARY KEY(CODE)
);


-- ยอดคงเหลือแยกตามคลังสินค้า		
create table BCStkWarehouse
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	UnitCode	VARCHAR(10),
	Qty	MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ReserveQty	MONEY DEFAULT 0.0,
	RemainInQty	MONEY DEFAULT 0.0,
	RemainOutQty	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	ItemPriority	SMALLINT DEFAULT 0, -- ลำดับความสำคัญ
	ReadyQtyAll MONEY DEFAULT 0.0, -- ยอดที่ขายได้
	ReserveQtyAll MONEY DEFAULT 0.0, -- 
	RemainQtyAll MONEY DEFAULT 0.0, -- 
	RemainOutQtyAll	MONEY DEFAULT 0.0,
	averagecost MONEY DEFAULT 0.0,
	DocDate	DATETIME
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_WHSTKITEM ON BCStkWarehouse(ItemCode);
CREATE  INDEX IDX_WHSTKWH ON BCStkWarehouse(WHCode);
CREATE  INDEX IDX_WHSTKSHF ON BCStkWarehouse(ShelfCode);
CREATE  INDEX IDX_WHSTKUNIT ON BCStkWarehouse(UnitCode);
CREATE  INDEX IDX_WHSTKITEM1 ON BCStkWarehouse(ItemCode,UnitCode,WhCode,ShelfCode);
CREATE  INDEX IDX_WHSTKWH2 ON BCStkWarehouse(ITEMCODE,WHCode);
			
create table BCLotOut
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	BillLineNumber	SMALLINT DEFAULT 0,
	TransPeriod SMALLINT DEFAULT 0, -- ข้อมูลเกิดใน Period ที่
	LotNumber	VARCHAR(50),
	TransType	SMALLINT DEFAULT 0, -- ตาม MyType ของรายวันที่ตัด
	LotQty	MONEY DEFAULT 0.0,
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),	
	Cost	MONEY DEFAULT 0.0, -- ต้นทุนต่อหน่วย
	CostOfLot	MONEY DEFAULT 0.0 -- ยอดมูลค่า ไม่ใช่ยอดต่อหน่วย
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_LTOITEM ON BCLotOut(ItemCode);
CREATE  INDEX IDX_LTOLINE ON BCLotOut(BillLineNumber);
CREATE  INDEX IDX_LTOTTYP ON BCLotOut(TransType);
CREATE  INDEX IDX_LTOITEM1 ON BCLotOut(Docno);
CREATE  INDEX IDX_LTOITEM2 ON BCLotOut(Lotnumber);
CREATE  INDEX IDX_LTOITEM3 ON BCLotOut(ItemCode,LotNumber);
			
create table BCLotMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25) NOT NULL,
	LotNumber	VARCHAR(50) NOT NULL,
	WHCode	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ShelfCode	VARCHAR(15) NOT NULL,
	BillLineNumber	SMALLINT DEFAULT 0,
	TransType	SMALLINT DEFAULT 0, -- ตาม MyType ของรายวันที่เพิ่ม
	TransPeriod SMALLINT DEFAULT 0, -- ข้อมูลเกิดใน Period ที่
	DocNo	VARCHAR(50) NOT NULL,
	DocDate	DATETIME,
	ExpireDate	DATETIME,
	ProduceDate	DATETIME, -- วันที่ผลิต
	AgeDay SMALLINT DEFAULT 0, -- อายุ(วัน)
	MyDescription	VARCHAR(255),
	Qty	MONEY DEFAULT 0.0, -- ยอดรับครั้งแรก
	Cost	MONEY DEFAULT 0.0, -- ต้นทุนครั้งแรก
	Amount	MONEY DEFAULT 0.0 NOT NULL, -- มูลค่าครั้งแรก
	BalAmount	MONEY DEFAULT 0.0, -- ยอดมูลค่าคงเหลือปัจุบัน
	BalQty	MONEY DEFAULT 0.0, -- ยอดจำนวนคงเหลือปัจุบัน
	BalCost	MONEY DEFAULT 0.0, -- ต้นทุนคงเหลือปัจุบัน Jeab 1/11/2545
	BalQtyPeriod1 MONEY DEFAULT 0.0,
	BalQtyPeriod2 MONEY DEFAULT 0.0,
	BalQtyPeriod3 MONEY DEFAULT 0.0,
	BalQtyPeriod4 MONEY DEFAULT 0.0,
	BalQtyPeriod5 MONEY DEFAULT 0.0,
	BalQtyPeriod6 MONEY DEFAULT 0.0,
	BalQtyPeriod7 MONEY DEFAULT 0.0,
	BalQtyPeriod8 MONEY DEFAULT 0.0,
	BalQtyPeriod9 MONEY DEFAULT 0.0,
	BalQtyPeriod10 MONEY DEFAULT 0.0,
	BalQtyPeriod11 MONEY DEFAULT 0.0,
	BalQtyPeriod12 MONEY DEFAULT 0.0,
	BalQtyPeriod13 MONEY DEFAULT 0.0,
	BalQtyPeriod14 MONEY DEFAULT 0.0,
	BalQtyPeriod15 MONEY DEFAULT 0.0,
	BalQtyPeriod16 MONEY DEFAULT 0.0,
	BalQtyPeriod17 MONEY DEFAULT 0.0,
	BalQtyPeriod18 MONEY DEFAULT 0.0,
	BalQtyPeriod19 MONEY DEFAULT 0.0,
	BalQtyPeriod20 MONEY DEFAULT 0.0,
	BalQtyPeriod21 MONEY DEFAULT 0.0,
	BalQtyPeriod22 MONEY DEFAULT 0.0,
	BalQtyPeriod23 MONEY DEFAULT 0.0,
	BalQtyPeriod24 MONEY DEFAULT 0.0,
	BalQtyPeriod25 MONEY DEFAULT 0.0,
	reflot varchar(50), -- Jum use
	BehindIndex smallint default 0,
	RowIndex smallint default 0 
    PRIMARY KEY(RowOrder)
);

CREATE  INDEX IDX_LTMLINE ON BCLotMaster(RowOrder,ItemCode,WHCode,LotNumber);
CREATE  INDEX IDX_LTMITEM ON BCLotMaster(ItemCode);
CREATE  INDEX IDX_LTMITEM2 ON BCLotMaster(ItemCode,WHCode,LotNumber);

--CREATE  INDEX IDX_LTMLINE ON BCLotMaster(BillLineNumber);
--CREATE  INDEX IDX_LTMITEM ON BCLotMaster(ItemCode);
--CREATE  INDEX IDX_LTMTTYP ON BCLotMaster(TransType);
			
-- การเบิกใช้สินค้า	
create table BCStkIssue
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	IssueType	VARCHAR(10),
	DayOfUse	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	MyDescription	VARCHAR(255),
	PersonCode	VARCHAR(10),
	ArCode VARCHAR(20),
	SumOfAmount	MONEY DEFAULT 0.0,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	BillRetStatus SMALLINT DEFAULT 0, -- 1=หมดแล้ว
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ISPOS SMALLINT DEFAULT 0,
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,	
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	isReward smallint default 0,
	memberPoint MONEY DEFAULT 0.00	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_STKISS_REC ON BCStkIssue(RecurName);
CREATE  INDEX IDX_STKISS_DATE ON BCStkIssue(DocDate);
CREATE  INDEX IDX_STKISS_REC1 ON BCStkIssue(Docno,ArCode);
CREATE INDEX IDX_STKISS_PNTC ON BCStkIssue(PrintCount);

create table BCStkIssueSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 8, -- เบิก
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	IssueType	VARCHAR(10),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	Personcode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	RefNo	VARCHAR(20), -- เลขที่ใบขอเบิก
	Qty	MONEY DEFAULT 0.0,
	RetQty	MONEY DEFAULT 0.0,
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0, -- ราคาขาย/หน่วย
	Amount	MONEY DEFAULT 0.0, -- มูลค่าสินค้า
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT,
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST MONEY DEFAULT 0.0,
	RefLineNumber SMALLINT DEFAULT 0, --jum 15-02-2003
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
--support color,size,style
	ISPOS SMALLINT DEFAULT 0,
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0,
	ItemSetCode varchar(25)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKISDATE ON BCStkIssueSub(DOCDATE);
CREATE  INDEX IDX_STKISITEM ON BCStkIssueSub(ItemCode);
CREATE  INDEX IDX_STKISWH ON BCStkIssueSub(WHCode);
CREATE  INDEX IDX_STKISSHF ON BCStkIssueSub(ShelfCode);
CREATE  INDEX IDX_STKISTYPE ON BCStkIssueSub(MyType);
CREATE  INDEX IDX_STKISIND ON BCStkIssueSub(BehindIndex);
CREATE  INDEX IDX_STKISTS ON BCStkIssueSub(TransState);
CREATE  INDEX IDX_STKISIST ON BCStkIssueSub(IssueType);
CREATE  INDEX IDX_STKISSUE1 ON BCStkIssueSub(ItemCode,UnitCode,Whcode,ShelfCode,Linenumber);
CREATE  INDEX IDX_STKISSUE2 ON BCStkIssueSub(Linenumber);
CREATE  INDEX IDX_STKISSUESERVICE ON BCStkIssueSub(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_STKISPAK1 ON BCStkIssueSub(PackingRate1);
CREATE  INDEX IDX_STKISPAK2 ON BCStkIssueSub(PackingRate2);
CREATE  INDEX IDX_STKISISPC ON BCStkIssueSub(IsProcess);

create table BCStkIssue2 -- ใบขอเบิก
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ArCode VARCHAR(20),
	IssueType	VARCHAR(10),
	DayOfUse	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	MyDescription	VARCHAR(255),
	PersonCode	VARCHAR(10),
	SumOfAmount	MONEY DEFAULT 0.0,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยังไม่หมด 1=ตัดหมดแล้ว
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsImport SMALLINT DEFAULT 0 -- 1= ข้อมูลที่ Import เข้ามา
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_STKISS2_REC ON BCStkIssue2(RecurName);
CREATE  INDEX IDX_STKISS2_DATE ON BCStkIssue2(DocDate);
CREATE  INDEX IDX_STKISSUE2_AR ON BCStkIssue2(ArCode);
CREATE  INDEX IDX_STKISSUE2_PNTC ON BCStkIssue2(printcount);


create table BCStkIssueSub2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IssueType	VARCHAR(10),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CancelCode VARCHAR(10),
	CancelDateT DATETIME,	
	Personcode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	IssQty	MONEY DEFAULT 0.0,--Not use change to remain qty
	RemainQty MONEY DEFAULT 0.0,
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0, -- ราคาขาย/หน่วย
	Amount	MONEY DEFAULT 0.0, -- มูลค่าสินค้า
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ColorCode	VARCHAR(10),
	SizeCode	VARCHAR(10),
	StyleCode	VARCHAR(10),
	LineNumber	SMALLINT,
	ItemSetCode varchar(25)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKIS2DATE ON BCStkIssueSub2(DOCDATE);
CREATE  INDEX IDX_STKIS2ITEM ON BCStkIssueSub2(ItemCode);
CREATE  INDEX IDX_STKIS2WH ON BCStkIssueSub2(WHCode);
CREATE  INDEX IDX_STKIS2SHF ON BCStkIssueSub2(ShelfCode);
CREATE  INDEX IDX_STKIS2TS ON BCStkIssueSub2(TransState);
CREATE  INDEX IDX_STKIS2IST ON BCStkIssueSub2(IssueType);
CREATE  INDEX IDX_STKISSUE21 ON BCStkIssueSub2(ItemCode,UnitCode,Whcode,ShelfCode,Linenumber);
CREATE  INDEX IDX_STKISSUE22 ON BCStkIssueSub2(Linenumber);

			
-- การรับคืนจากเบิกใช้สินค้า
create table BCStkIssueRet
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	IssueRefNo	VARCHAR(20),
	DepartCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PersonCode	VARCHAR(10),
	SumOfAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ISPOS 	SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_STKISRDATE ON BCStkIssueRet(DocDate);
CREATE  INDEX IDX_STKISRDEP ON BCStkIssueRet(DepartCode);
CREATE  INDEX IDX_STKISRPER ON BCStkIssueRet(PersonCode);
CREATE  INDEX IDX_STKISRREC ON BCStkIssueRet(RecurName);
CREATE INDEX IDX_STKISPNTC ON BCStkIssueRet(PrintCount);

create table BCStkIssRetSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 9,
	DocNo	VARCHAR(20),
	IssueRefNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	Personcode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0, -- ราคาขาย/หน่วย
	Amount	MONEY DEFAULT 0.0, -- มูลค่าสินค้า
	HomeAmount	MONEY	DEFAULT 0.0, -- ยอดรับเงินเป็นเงินบาท
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BarCode	VARCHAR(20),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT,
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	RefLinenumber SMALLINT,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
--support color,size,style
	ISPOS 	SMALLINT DEFAULT 0,
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	ReturnCost MONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKISRSDATE ON BCStkIssRetSub(DOCDATE);
CREATE  INDEX IDX_STKISRSITEM ON BCStkIssRetSub(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_STKISRSWH ON BCStkIssRetSub(WHCode);
CREATE  INDEX IDX_STKISRSSHF ON BCStkIssRetSub(ShelfCode);
CREATE  INDEX IDX_STKISRSTYPE ON BCStkIssRetSub(MyType);
CREATE  INDEX IDX_STKISRSIND ON BCStkIssRetSub(BehindIndex);
CREATE  INDEX IDX_STKISRSTS ON BCStkIssRetSub(TransState);
CREATE  INDEX IDX_STKISRS1 ON BCStkIssRetSub(ItemCode,UnitCode,Whcode,ShelfCode,Linenumber);
CREATE  INDEX IDX_STKISRS2 ON BCStkIssRetSub(Linenumber);
CREATE  INDEX IDX_STKISRPAK1 ON BCStkIssRetSub(PackingRate1);
CREATE  INDEX IDX_STKISRPAK2 ON BCStkIssRetSub(PackingRate2);
CREATE  INDEX IDX_STKISRSPC ON BCStkIssRetSub(IsProcess);
			
create table BCStkBalance
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	IsConfirm	SMALLINT DEFAULT 0,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumOfAmount	MONEY DEFAULT 0.0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME
    PRIMARY KEY(DocNo)
);
CREATE  INDEX IDX_STKBAL1 ON BCStkBalance(DOCDATE);
CREATE  INDEX IDX_STKPNTC ON BCStkBalance(printcount);

create table BCStkBalanceSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 0,
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	Cost	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	BarCode	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT,
	--Auto Packing Section by นก
	FixUnitCost	MONEY DEFAULT 0.0,
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
	SumOfCost	MONEY DEFAULT 0.0, --aom 2003-05-22
	SumOfCost2	MONEY DEFAULT 0.0,
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	CategoryCode VARCHAR(10),
	GroupCode VARCHAR(10),
	BrandCode VARCHAR(10),
	TypeCode VARCHAR(10),
	FormatCode VARCHAR(10),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITMBDATE ON BCStkBalanceSub(DOCDATE);
CREATE  INDEX IDX_ITMBITEM ON BCStkBalanceSub(ItemCode);
CREATE  INDEX IDX_ITMBWH ON BCStkBalanceSub(WHCode);
CREATE  INDEX IDX_ITMBSHF ON BCStkBalanceSub(ShelfCode);
CREATE  INDEX IDX_ITMBTYPE ON BCStkBalanceSub(MyType);
CREATE  INDEX IDX_ITMBIND ON BCStkBalanceSub(BehindIndex);
CREATE  INDEX IDX_ITMBTS	ON BCStkBalanceSub(TransState);
CREATE  INDEX IDX_ITMBS1 ON BCStkBalanceSub(ItemCode,UnitCode,Whcode,ShelfCode,Linenumber);
CREATE  INDEX IDX_ITMBS2 ON BCStkBalanceSub(Linenumber);
CREATE  INDEX IDX_ITMBS3 ON BCStkBalanceSub(Docno,ItemCode);
CREATE  INDEX IDX_ITMBSERVICE ON BCStkBalanceSub(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_ITMBPAK1 ON BCStkBalanceSub(PackingRate1);
CREATE  INDEX IDX_ITMBPAK2 ON BCStkBalanceSub(PackingRate2);
CREATE  INDEX IDX_ITMBISPC ON BCStkBalanceSub(IsProcess);

-- Finish Goods
create table BCFinishGoods
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	PersonCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumOfAmount	MONEY DEFAULT 0.0,
	IsConfirm	SMALLINT DEFAULT 0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	SumOfCost	MONEY DEFAULT 0.0, --aom 2003-05-22
	SumOfCost2	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ISPOS SMALLINT DEFAULT 0,
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_FG_REC ON BCFinishGoods(RecurName);
CREATE  INDEX IDX_FG_DATE ON BCFinishGoods(DocDate);
CREATE  INDEX IDX_FG_PNTC ON BCFinishGoods(printcount);

create table BCFinishGoodsSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 1, 
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	Personcode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	Cost	MONEY DEFAULT 0.0,
	SumOfCost	MONEY DEFAULT 0.0,
	SumOfCost2	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT,
	--Auto Packing Section by นก
	FixUnitCost	MONEY DEFAULT 0.0,
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
--support color,size,style
	ISPOS SMALLINT DEFAULT 0,
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25	
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_FGSNO ON BCFinishGoodsSub(DocNo);
CREATE  INDEX IDX_FGSDATE ON BCFinishGoodsSub(DOCDATE);
CREATE  INDEX IDX_FGSITEM ON BCFinishGoodsSub(ItemCode);
CREATE  INDEX IDX_FGSWH ON BCFinishGoodsSub(WHCode);
CREATE  INDEX IDX_FGSSHF ON BCFinishGoodsSub(ShelfCode);
CREATE  INDEX IDX_FGSTYPE ON BCFinishGoodsSub(MyType);	
CREATE  INDEX IDX_FGSIND ON BCFinishGoodsSub(BehindIndex);
CREATE  INDEX IDX_FGSTS ON BCFinishGoodsSub(TransState);	
CREATE  INDEX IDX_FGSSERVICE ON BCFinishGoodsSub(ItemCode,DocDate,LotNumber,BehindIndex);	
CREATE  INDEX IDX_FGSPAK1 ON BCFinishGoodsSub(PackingRate1);	
CREATE  INDEX IDX_FGSPAK2 ON BCFinishGoodsSub(PackingRate2);	
CREATE  INDEX IDX_FGSISPC ON BCFinishGoodsSub(IsProcess);

--*****
create table BCStkTransfer
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	IsConfirm	SMALLINT DEFAULT 0,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumOfQty	MONEY DEFAULT 0.0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	RecurName	VARCHAR(40),
	ISPOS SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME,
	SumOfAmount money default 0.0
    PRIMARY KEY(DocNo)
);
CREATE  INDEX IDX_STKTR1 ON BCStkTransfer(DocDate);
CREATE  INDEX IDX_STKTR2 ON BCStkTransfer(printcount);

create table BCStkTransfSub3 -- สำหรับใช้ในรายงาน โดยจะแบ่ง record ของการโอนออกจากกัน เป็น โอนออก 1 Rec โอนเข้า 1 Rec
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 12, -- 12=โอนเข้า,13=โอนออก
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0, -- ราคาขายสินค้า
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0, -- มูลค่าตามราคาขาย
	RefNo	VARCHAR(20), -- เลขที่ใบขอโอน
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	fromwhcode varchar(10),-- Jum use
	fromshelfcode varchar(10), -- Jum use
	reftrlinenum smallint,
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsCancel	SMALLINT DEFAULT 0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKTRS3_1 ON BCStkTransfSub3(ItemCode,UnitCode,Whcode,ShelfCode);
CREATE  INDEX IDX_STKTRS3_2 ON BCStkTransfSub3(ItemCode,UnitCode);
CREATE  INDEX IDX_STKTRS_NOITEM ON BCStkTransfSub3(Docno,ItemCode);
CREATE  INDEX IDX_STKTRS_DOCNO ON BCStkTransfSub3(Docno);
CREATE  INDEX IDX_STKTRS_ITEM ON BCStkTransfSub3(ItemCode);
CREATE  INDEX IDX_STKTRS_SERVICE ON BCStkTransfSub3(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_STKTRSPAK1 ON BCStkTransfSub3(PackingRate1);
CREATE  INDEX IDX_STKTRSPAK2 ON BCStkTransfSub3(PackingRate2);
CREATE  INDEX IDX_STKTRSISPC ON BCStkTransfSub3(IsProcess);
CREATE  INDEX IDX_SERV_STKTRFSUB3 ON BCStkTransfSub3(IsCancel,ItemCode,MyType,ROWORDER,IsLockCost,MyDescription,AVERAGECOST,PackingRate1,PackingRate2,reftrlinenum,DocNo,DocDate,WHCode,ShelfCode,Qty,UnitCode);

create table BCStkTransfSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	FromWH	VARCHAR(10),
	FromShelf	VARCHAR(15),
	ToWH	VARCHAR(10),
	ToShelf	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0, -- ราคาขายสินค้า
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0, -- มูลค่าตามราคาขาย
	RefNo	VARCHAR(20), -- เลขที่ใบขอโอน
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT,
	RefLineNumber	SMALLINT,
	LotOutNumber	VARCHAR(50), -- Jeab 2003-04-26 Lot กำหนดเอง
	LotInNumber	VARCHAR(50),-- Jeab 2003-04-26 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
--support color,size,style
	ISPOS SMALLINT DEFAULT 0,
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	BehindIndex	SMALLINT DEFAULT 1
    PRIMARY KEY(ROWORDER)
);
			
CREATE  INDEX IDX_STKTSDATE ON BCStkTransfSub(DOCDATE);
CREATE  INDEX IDX_STKTSITEM ON BCStkTransfSub(ItemCode);
CREATE  INDEX IDX_STKTSWHT ON BCStkTransfSub(ToWH);
CREATE  INDEX IDX_STKTSWHF ON BCStkTransfSub(FromWH);
CREATE  INDEX IDX_STKTSTSHF ON BCStkTransfSub(ToShelf);
CREATE  INDEX IDX_STKTSFSHF ON BCStkTransfSub(FromShelf);
CREATE  INDEX IDX_STKTSUNITITEM ON BCStkTransfSub(ItemCode,UnitCode,FromWh,FromShelf,Linenumber);
CREATE  INDEX IDX_STKTSLINE ON BCStkTransfSub(Linenumber);
CREATE  INDEX IDX_STKTSNOITEM ON BCStkTransfSub(Docno,ItemCode);
CREATE  INDEX IDX_STKTSDOCNO ON BCStkTransfSub(Docno);


create table BCStkTransfer2 -- ใบขอโอนสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	IsConfirm	SMALLINT DEFAULT 0,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumOfQty	MONEY DEFAULT 0.0,
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยังไม่หมด 1=ตัดหมดแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME,
	SumOfAmount money default 0.0
    PRIMARY KEY(DocNo)
);

create table BCStkTransfSub2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CancelCode VARCHAR(10),
	CancelDateT DATETIME,	
	FromWH	VARCHAR(10),
	FromShelf	VARCHAR(15),
	ToWH	VARCHAR(10),
	ToShelf	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0, -- ราคาขายสินค้า
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0, -- มูลค่าตามราคาขาย
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT,
	--support color,size,style
	Colorcode VARCHAR(10),
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10)	
    PRIMARY KEY(ROWORDER)
);
			
CREATE  INDEX IDX_STKSTDATE ON BCStkTransfSub2(DOCDATE);
CREATE  INDEX IDX_STKSTITEM ON BCStkTransfSub2(ItemCode);
CREATE  INDEX IDX_STKSTWHT ON BCStkTransfSub2(ToWH);
CREATE  INDEX IDX_STKSTWHF ON BCStkTransfSub2(FromWH);
CREATE  INDEX IDX_STKSTSHFT ON BCStkTransfSub2(ToShelf);
CREATE  INDEX IDX_STKSTSHFF ON BCStkTransfSub2(FromShelf);
CREATE  INDEX IDX_STKSTUNITITEM ON BCStkTransfSub2(ItemCode,UnitCode,FromWh,FromShelf,Linenumber);
CREATE  INDEX IDX_STKSTLINE ON BCStkTransfSub2(Linenumber);
CREATE  INDEX IDX_STKSTNOITEM ON BCStkTransfSub2(Docno,ItemCode);
CREATE  INDEX IDX_STKSTDOCNO ON BCStkTransfSub2(Docno);

create table BCBarCodeMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Barcode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BarcodeName	VARCHAR(255), -- ชื่อ Barcode
	ItemCode	VARCHAR(25),
	Remark	VARCHAR(255),
	ActiveStatus	SMALLINT DEFAULT 1,
	UnitCode	VARCHAR(10),
-- ************* POS ------------
	WHCODE 	VARCHAR(10),
	SHELFCODE 	VARCHAR(10),
	PRESCALENUM VARCHAR(10) -- หลักต้นในเครื่องชั่งน้ำหนัก
-- ************* POS ------------	
    PRIMARY KEY(ROWORDER)
);

CREATE  UNIQUE INDEX IDX_BARCODE ON BCBarCodeMaster(Barcode);
CREATE  INDEX IDX_BARITEM ON BCBarCodeMaster(ItemCode);
			
create table BCStkPacking
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	Rate	MONEY DEFAULT 1.0,
	UnitCode	VARCHAR(10),
	Qty	MONEY DEFAULT 0.0, -- ยอดคงเหลือปัจจุบัน
	BalQtyPeriod1 MONEY DEFAULT 0.0, -- ยอดตาม Period
	BalQtyPeriod2 MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BalQtyPeriod3 MONEY DEFAULT 0.0,
	BalQtyPeriod4 MONEY DEFAULT 0.0,
	BalQtyPeriod5 MONEY DEFAULT 0.0,
	BalQtyPeriod6 MONEY DEFAULT 0.0,
	BalQtyPeriod7 MONEY DEFAULT 0.0,
	BalQtyPeriod8 MONEY DEFAULT 0.0,
	BalQtyPeriod9 MONEY DEFAULT 0.0,
	BalQtyPeriod10 MONEY DEFAULT 0.0,
	BalQtyPeriod11 MONEY DEFAULT 0.0,
	BalQtyPeriod12 MONEY DEFAULT 0.0,
	BalQtyPeriod13 MONEY DEFAULT 0.0, -- เผื่อไว้
	BalQtyPeriod14 MONEY DEFAULT 0.0,
	BalQtyPeriod15 MONEY DEFAULT 0.0,
	BalQtyPeriod16 MONEY DEFAULT 0.0,
	BalQtyPeriod17 MONEY DEFAULT 0.0,
	BalQtyPeriod18 MONEY DEFAULT 0.0,
	BalQtyPeriod19 MONEY DEFAULT 0.0,
	BalQtyPeriod20 MONEY DEFAULT 0.0,
	BalQtyPeriod21 MONEY DEFAULT 0.0,
	BalQtyPeriod22 MONEY DEFAULT 0.0,
	BalQtyPeriod23 MONEY DEFAULT 0.0,
	BalQtyPeriod24 MONEY DEFAULT 0.0,
	BalQtyPeriod25 MONEY DEFAULT 0.0,
	--Auto Packing by นก
	Rate1 	MONEY DEFAULT 0.0,
	Rate2 	MONEY DEFAULT 0.0,
	Running  	SMALLINT DEFAULT 0,
	Runner	SMALLINT DEFAULT 0,
	UseFlag 	SMALLINT DEFAULT 1,	
	UseForm 	SMALLINT DEFAULT 0, -- 0 = ไม่ใช่ในการออก Form, 1= ใช้ในการออก Form
	Wide	MONEY DEFAULT 0.0, -- กว้าง
	Long	MONEY DEFAULT 0.0, -- ยาว
	High	MONEY DEFAULT 0.0 -- สูง
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PACKITEM ON BCStkPacking(ItemCode);
CREATE  INDEX IDX_PACKUNIT ON BCStkPacking(UNITCODE);
	
create table BCPromoPrice
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	UnitCode VARCHAR(10),
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FromQty	MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ToQty	MONEY DEFAULT 0.0,
	SalePrice	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	FromDate	DATETIME,
	ToDate	DATETIME,
	FromARGroup	VARCHAR(10),
	ToARGroup	VARCHAR(10),
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_PROMOUNIT ON BCPromoPrice(ItemCode,UnitCode);
CREATE  INDEX IDX_PROITEM ON BCPromoPrice(ItemCode);
CREATE  INDEX IDX_PROFQTY ON BCPromoPrice(FromQty);
CREATE  INDEX IDX_PROTQTY ON BCPromoPrice(ToQty);
CREATE  INDEX IDX_PROFDATE ON BCPromoPrice(FromDate);
CREATE  INDEX IDX_PROTDATE ON BCPromoPrice(ToDate);
CREATE  INDEX IDX_PROUNIT ON BCPromoPrice(UnitCode);
CREATE  INDEX IDX_PROFARG ON BCPromoPrice(FromARGroup);
CREATE  INDEX IDX_PROTARG ON BCPromoPrice(ToARGroup);


create table BCPriceList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	UnitCode VARCHAR(10),
	Remark	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FromQty	MONEY DEFAULT 0.0,
	ToQty	MONEY DEFAULT 0.0,
	StartDate DATETIME, -- จากวันที่
	StopDate DATETIME, -- ถึงวันที่
	SaleType SMALLINT DEFAULT 0, -- ประเภทการขาย
	TransportType SMALLINT DEFAULT 0, -- เงื่อนการขนส่ง
	SalePrice1	MONEY DEFAULT 0.0,
	SalePrice2	MONEY DEFAULT 0.0,
	SalePrice3	MONEY DEFAULT 0.0,
	SalePrice4	MONEY DEFAULT 0.0,
	SalePrice5	MONEY DEFAULT 0.0,
	SalePrice6	MONEY DEFAULT 0.0,
	SalePrice7	MONEY DEFAULT 0.0,
	SalePrice8	MONEY DEFAULT 0.0,
	SalePrice9	MONEY DEFAULT 0.0,
	SalePrice10	MONEY DEFAULT 0.0,
	SalePrice11	MONEY DEFAULT 0.0,
	SalePrice12	MONEY DEFAULT 0.0,
	SalePrice13	MONEY DEFAULT 0.0,
	SalePrice14	MONEY DEFAULT 0.0,
	SalePrice15	MONEY DEFAULT 0.0,
	SalePrice16	MONEY DEFAULT 0.0,
	SalePrice17	MONEY DEFAULT 0.0,
	SalePrice18	MONEY DEFAULT 0.0,
	SalePrice19	MONEY DEFAULT 0.0,
	SalePrice20	MONEY DEFAULT 0.0,
	LowPrice	MONEY DEFAULT 0.0, --- Jeab 04/11/2002 --- ราคาขายขั้นต่ำ ---
	LineNumber SMALLINT DEFAULT 0,
	RetailPrice	MONEY DEFAULT 0.0, -- ราคาขายปลีก
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PRLITEM ON BCPriceList(ItemCode);
CREATE  INDEX IDX_PRLFQTY ON BCPriceList(FromQty);
CREATE  INDEX IDX_PRLTQTY ON BCPriceList(ToQty);
CREATE  INDEX IDX_PRLUNIT ON BCPriceList(UnitCode);
CREATE  INDEX IDX_PRL1    ON BCPriceList(ItemCode,UnitCode);

create table BCPriceList2 -- โครงสร้างราคาสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	UnitCode VARCHAR(10), -- หน่วยนับ
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StartQty MONEY DEFAULT 0.0, -- จากจำนวน
	StopQty MONEY DEFAULT 0.0,-- ถึงจำนวน
	StartDate DATETIME, -- จากวันที่
	StopDate DATETIME, -- ถึงวันที่
	SaleType SMALLINT DEFAULT 0, -- ประเภทการขาย
	TransportType SMALLINT DEFAULT 0, -- เงื่อนการขนส่ง
	SalePrice1	VARCHAR(50),
	SalePrice2	VARCHAR(50),
	SalePrice3	VARCHAR(50),
	SalePrice4	VARCHAR(50),
	SalePrice5	VARCHAR(50),
	SalePrice6	VARCHAR(50),
	SalePrice7	VARCHAR(50),
	SalePrice8	VARCHAR(50),
	SalePrice9	MONEY DEFAULT 0.0,
	SalePrice10	MONEY DEFAULT 0.0,
	SalePrice11	MONEY DEFAULT 0.0,
	SalePrice12	MONEY DEFAULT 0.0,
	SalePrice13	MONEY DEFAULT 0.0,
	SalePrice14	MONEY DEFAULT 0.0,
	SalePrice15	MONEY DEFAULT 0.0,
	SalePrice16	MONEY DEFAULT 0.0,
	SalePrice17	MONEY DEFAULT 0.0,
	SalePrice18	MONEY DEFAULT 0.0,
	SalePrice19	MONEY DEFAULT 0.0,
	SalePrice20	MONEY DEFAULT 0.0,	
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	LineNumber SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_PRLTITEM ON BCPriceList2(ItemCode);
CREATE  INDEX IDX_PRLTFQTY ON BCPriceList2(StartQty);
CREATE  INDEX IDX_PRLTTQTY ON BCPriceList2(StopQty);
CREATE  INDEX IDX_PRLTUNIT ON BCPriceList2(UnitCode);
CREATE  INDEX IDX_PRLTITEMUNIT    ON BCPriceList2(ItemCode,UnitCode);

----- Modify BKP 1990 ------
CREATE TABLE BKPPRICELIST
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ITEMCODE	VARCHAR(25),
	ARCODE		VARCHAR(20),
	UNITCODE 	VARCHAR(10),
	REMARK		VARCHAR(100),
	FROMQTY	MONEY DEFAULT 0.0,
	TOQTY		MONEY DEFAULT 0.0,
	INCVATPRICE	MONEY DEFAULT 0.0,
	EXCVATPRICE	MONEY DEFAULT 0.0,
	LINENUMBER SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_BKPPRLITEM ON BKPPRICELIST(ITEMCODE);
CREATE  INDEX IDX_BKPPRLAR ON BKPPRICELIST(ARCODE);
CREATE  INDEX IDX_BKPPRLUNIT ON BKPPRICELIST(UNITCODE);
CREATE  INDEX IDX_BKPPRLFQTY ON BKPPRICELIST(FROMQTY);
CREATE  INDEX IDX_BKPPRLTQTY ON BKPPRICELIST(TOQTY);
		
create table BCSerialPrintForm -- kher
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SaveFrom SMALLINT DEFAULT 0, -- MyType
	SerialText VARCHAR(255),
	ItemLineNumber SMALLINT DEFAULT 0,
	LineNumber SMALLINT DEFAULT 0,
	StartCtrlNo	VARCHAR(35),
	StopCtrlNo	VARCHAR(35)
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_SPFDOCNO ON BCSerialPrintForm(DocNo);
CREATE  INDEX IDX_SPFITEM  ON BCSerialPrintForm(ItemCode);

create table BCSerialTrans
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CtrlNo	VARCHAR(35),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	DocNo	VARCHAR(20),
	ShelfCode	VARCHAR(15),
	WHCode	VARCHAR(10),
	SerialNo	VARCHAR(35),
	SaveFrom SMALLINT DEFAULT 0, -- MyType
	ItemLineNumber SMALLINT DEFAULT 0,
	LineNumber SMALLINT DEFAULT 0,
	BehindIndex	SMALLINT DEFAULT 1
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_SERT_CTRL ON BCSerialTrans(CtrlNo);
CREATE  INDEX IDX_SERT_ITEM ON BCSerialTrans(ItemCode);
CREATE  INDEX IDX_SERT_SF ON BCSerialTrans(SaveFrom);
CREATE  INDEX IDX_SERT_ILINE ON BCSerialTrans(ItemLineNumber);
CREATE  INDEX IDX_SERT_LINE ON BCSerialTrans(LineNumber);
CREATE  INDEX IDX_SERT_1    ON BCSerialTrans(DocNo);
CREATE  INDEX IDX_SERT_2    ON BCSerialTrans(ItemCode,WHCode,SHelfCode);

create table BCSerialMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	CtrlNo	VARCHAR(35) NOT NULL,
	Model	VARCHAR(35),
	CaseNo	VARCHAR(35),
	IsExport smallint default 0,
	CasePosition	VARCHAR(35),
	ItemCode	VARCHAR(25),
	ItemColor	VARCHAR(30),
	ItemRemark	VARCHAR(255),
	StopInsureDate	DATETIME,
	ReceiveDate	DATETIME,
	ReceiveMan	VARCHAR(10),
	ReceiveDocNo	VARCHAR(20),
	ApCode	VARCHAR(20),
 	SaleDate	DATETIME,
	SaleMan	VARCHAR(10),
	SaleDocNo	VARCHAR(20),
	CNSaleCode	VARCHAR(10),
	CNDocNo		VARCHAR(20),
	ArCode	VARCHAR(20),
	ItemStatus	SMALLINT DEFAULT 0, -- 0=ใหม่ 1=เก่า 2=ไฟแนนท์
	SerialNo	VARCHAR(35),
	SerialPosition	VARCHAR(35),
	PictureName	VARCHAR(255),
	RegisterNo	VARCHAR(35),
	RegisDate DATETIME,
	Price	MONEY DEFAULT 0.0,
	StockStatus	SMALLINT DEFAULT 0, -- 0=อยู่ในสต็อก  1=เบิกใช้ 2=ขาย
	ShelfCode	VARCHAR(15),
	WHCode	VARCHAR(10),
	ActiveStatus	SMALLINT DEFAULT 1,
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	LastEditDateT	DATETIME
    PRIMARY KEY(CtrlNo)
);

CREATE  INDEX IDX_SERITEM ON BCSerialMaster(ItemCode);
CREATE  INDEX IDX_SER2 ON BCSerialMaster(ApCode);
CREATE  INDEX IDX_SER3 ON BCSerialMaster(ArCode);
CREATE  INDEX IDX_SER4 ON BCSerialMaster(ItemCode,SerialNo);
CREATE  INDEX IDX_SER5 ON BCSerialMaster(ItemCode,CtrlNo);
CREATE  INDEX IDX_SER6 ON BCSerialMaster(ItemCode,RegisterNo);
CREATE  INDEX IDX_SER7 ON BCSerialMaster(ItemCode,WHCode);

create table BCDeliveryAddr
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ArCode	VARCHAR(20) NOT NULL,
	Code	VARCHAR(10) NOT NULL,
	Address	VARCHAR(255),
	Telephone	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Contact	VARCHAR(10),
	Transport	VARCHAR(10),
	DefaultStatus	SMALLINT,
	MyDescription	VARCHAR(255),
	TransportRemark VARCHAR(255),
	MapCode	VARCHAR(10),
	MapPosition_X	SMALLINT	DEFAULT  0,
	MapPosition_Y	SMALLINT	DEFAULT 0,
--for address by aom
	companyname VARCHAR(255),
	deliisdefault SMALLINT DEFAULT 0,
	delirestype VARCHAR(255),
	delino varchar(10),
	delimoo varchar(10),
	delivillage VARCHAR(255),
	delibuilding VARCHAR(255),
	delifloor varchar(10),
	deliroom varchar(10),
	delisoi VARCHAR(255),
	deliroad VARCHAR(255),
	delisubdist VARCHAR(255),
	delidistrict VARCHAR(255),
	deliprovince VARCHAR(255),
	delicountry VARCHAR(255),
	delizipcode varchar(10),
	provincecode varchar(10)
    PRIMARY KEY(ArCode,Code)
);

CREATE  INDEX IDX_DVA_AR ON BCDeliveryAddr(ArCode);
CREATE  INDEX IDX_DVA_CODE ON BCDeliveryAddr(Code);

create table BCRecMoney
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PayAmount	MONEY	DEFAULT 0.0,
	HomeAmount	MONEY	DEFAULT 0.0, -- ยอดรับเงินเป็นเงินบาท
	ChqTotalAmount	MONEY	DEFAULT 0.0,
	PaymentType	SMALLINT DEFAULT 0, --0=เงินสด 1=บัตร 2=เช็ค 3=เงินโอน 4=เงินสดย่อย 5=เงินเกินพัก 6=เงินเกินหัก 7=รายได้อื่นๆ 8=ค่าใช้จ่ายอื่นๆ
	SaveFrom SMALLINT DEFAULT 0,
	PayChqState	SMALLINT DEFAULT 0, -- 0=เช็คใบใหม่ 1=ตัดจากเช็คใบเดิม 
	CreditType VARCHAR(10), -- ประเภทบัติเครดิต  
	ChargeAmount MONEY	DEFAULT 0.0, --เครดิต charge
	ChargeWord VARCHAR(40), 
	ConfirmNo VARCHAR(30), -- เลขที่อนุมัติ
	LineNumber SMALLINT DEFAULT 0,
	RefNo	VARCHAR(30),
	BankCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	BankBranchCode	VARCHAR(10),
	TransBankDate DATETIME,
	MyDescription	VARCHAR(255),
	RefDate	DATETIME,
	ChangeAmount MONEY DEFAULT 0.0 -- ยอดเงินทอน เฉพาะเงินสด
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_RECM_DATE ON BCRecMoney(DocDate);
CREATE  INDEX IDX_RECM_AR ON BCRecMoney(ArCode);
CREATE  INDEX IDX_RECM_PTY ON BCRecMoney(PaymentType);

create table BCInvCreditNote
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CreditNoteNo	VARCHAR(20), -- เลขที่ใบลดหนี้
	ReturnMoney	SMALLINT	DEFAULT 0, -- 0=ไม่ 1=รับคืนเงินสด
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่ตัดยอด 1=ตัดยอดทันที
	InvoiceNo	VARCHAR(20),	-- เลขที่ Invoice ที่จะลด
	InvoiceDisc	VARCHAR(40),	-- ส่วนลดเดิม
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	OldAmount MONEY DEFAULT 0.0, -- ยอดเดิม
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	DiscountAmount MONEY DEFAULT 0.0, -- ยอดที่ลด
	DiffAmount	MONEY DEFAULT 0.0,	-- ยอดผลต่าง,ยอดที่จะลด เป็นรวมใน
	ZeroTaxAmount	MONEY DEFAULT 0.0, -- รวมยอดภาษีอัตรา 0
	ExceptTaxAmount	MONEY DEFAULT 0.0, --รวมยอดยกเว้นภาษี
	TrueAmount	MONEY DEFAULT 0.0,	-- ยอดที่ถูกต้อง OldAmount -DiffAmount-ZeroTaxAmount-ExceptTaxAmount
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * DiffAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * DiffAmount
	ExchangeProfit	MONEY DEFAULT 0.0,  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	BillType	SMALLINT DEFAULT 0, -- 0=ใบส่งของ 1=เอกสารยกมา 2=ตั้งลูกหนี้อื่นๆ 3=ใบรับเงินมัดจำ
	Custgroupcode varchar(10),
	InvoiceMyDesc	VARCHAR(255)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_INVCN_DATE ON BCInvCreditNote(DocDate);
CREATE  INDEX IDX_INVCN_AR ON BCInvCreditNote(ArCode);
CREATE  INDEX IDX_INVCN_NO ON BCInvCreditNote(CreditNoteNo);
CREATE  INDEX IDX_INVCN_INV ON BCInvCreditNote(InvoiceNo);
CREATE  INDEX IDX_INVCN1 ON BCInvCreditNote(InvoiceNo,ArCode);
CREATE  INDEX IDX_INVCN2 ON BCInvCreditNote(CreditNoteNo,ArCode);

create table BCCNMaster -- สาเหตุการลดหนี้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(255) NOT NULL,
	DocType smallint NOT NULL,--default document type
	Remark VARCHAR(255) 
    PRIMARY KEY(CODE)
);

create table BCCreditNote
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	TaxDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	DueDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	CashierCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	SumOldAmount	MONEY DEFAULT 0.0, -- รวมใบกำกับเดิม (เป็นเงินบาทตาม Rate ใหม่)
	SumTrueAmount	MONEY DEFAULT 0.0, -- รวมยอดที่ถูกต้อง (เป็นเงินบาท)
	SumofDiffAmount	MONEY DEFAULT 0.0, -- รวมผลต่าง เป็นรวมใน / ยอดลดหนี้
	DiscountWord VARCHAR(30), -- ส่วนลดรับคืน
	DiscountAmount MONEY DEFAULT 0.0,  -- ส่วนลดรับคืน
	SumofBeforeTax	MONEY DEFAULT 0.0,  -- ยอดก่อนภาษี
	SumOfTaxAmount	MONEY DEFAULT 0.0, -- ยอดภาษี
	SumOfTotalTax	MONEY DEFAULT 0.0,  -- ยอดรวมภาษี
	SumOfZeroTax MONEY DEFAULT 0.0,
	SumOfExceptTax	MONEY DEFAULT 0.0, -- ยอดยกเว้นภาษี
	SumOfWTax	MONEY DEFAULT 0.0,
	NetDebtAmount	MONEY DEFAULT 0.0, -- ยอดสุทธิ SumOfTotalTax + SumOfExceptTax
	SumExchangeProfit	MONEY DEFAULT 0.0,  -- รวมกำไร(ขาดทุน)
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other	
	DebtLimitState SMALLINT DEFAULT 0, -- 1=คืนวงเงิน 0=ไม่คืนวงเงิน
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	ReturnMoney	SMALLINT	DEFAULT 0, -- ไม่กระทบต่อยอดลูกหนี้ 0=ไม่ 1=รับคืนเงินสด
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่ลดยอดใบกำกับเดิม 1=ลดยอดใบกำกับเดิม
	ReturnCash	SMALLINT	DEFAULT 0, -- 0=ไม่ลดหนี้เงินสด 1=ลดหนี้เงินสด
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน เฉพาะเงินสด
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย
	PayBillStatus	SMALLINT	DEFAULT 0,
	IsCNDeposit	SMALLINT DEFAULT 0, -- 1= ใบลดหนี้รับเงินมัดจำ
	IsPos SMALLINT DEFAULT 0, -- 0=ทั่วไป 1=POS
	PosDocNo VARCHAR(20), -- เลขที่ POS ที่อ้างอิงถึง
	CauseCode VARCHAR(10), -- สาเหตุการลดหนี้
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	CustGroupCode	VARCHAR(10),
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	BillTemporary MONEY DEFAULT 0.0, -- ยอดทำใบเสร็จชั่วคราว 2003-11-27
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	--for EVS project
	InvoiceType VARCHAR(10),
	QtyAmount MONEY DEFAULT 0.0,
	QtyDefault SMALLINT DEFAULT 1,
	QtyCopy SMALLINT DEFAULT 1,
	MergeItem SMALLINT DEFAULT 1,
	Newline SMALLINT DEFAULT 1,
	PriceCopy SMALLINT DEFAULT 0,
	WHCopy SMALLINT DEFAULT 0,
	CalcTaxFlag SMALLINT DEFAULT 0,
	MethodePaybill	VARCHAR(10), --วิธีการชำระเงิน
	MethodePaybill2	  VARCHAR(255), --วิธีการชำระเงิน 2	
	SaleAreaCode varchar(10),
-- ************* POS ------------
	SHORTNAME VARCHAR(100), -- สำหรับ POS
	ISGIFT	SMALLINT DEFAULT 0,-- 0 = สินค้าปกติ, 1 = ของแถม
	PROMOMEMBER SMALLINT DEFAULT 0, -- 0=ไม่ลดให้สมาชิก 1=ลดให้สมาชิก
	PROMOTYPE	SMALLINT DEFAULT 0,
	COUPONCODE VARCHAR(10), -- รหัสคูปองรับคืน
	COUPONAMOUNT	MONEY DEFAULT 0.0 , -- มูลค่าคูปองรับคืน
	POSSTATUS	SMALLINT DEFAULT 0,
	ARNAME		VARCHAR(200),
	ARADDRESS	VARCHAR(255),
-- ************* POS ------------
	BranchCode VARCHAR(10)	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_CN_DATE ON BCCreditNote(DocDate);
CREATE  INDEX IDX_CN_AR ON BCCreditNote(ArCode);
CREATE  INDEX IDX_CN_PBS ON BCCreditNote(PayBillStatus);
CREATE  INDEX IDX_CN_BAL ON BCCreditNote(BillBalance);
CREATE  INDEX IDX_CN_ROW ON BCCreditNote(ROWORDER);
CREATE  INDEX IDX_CN_ARDATE ON BCCreditNote(ArCode,DocDate);
CREATE  INDEX IDX_CN_ARNO ON BCCreditNote(ArCode,DocNo);
CREATE INDEX IDX_CN_PNTC ON BCCreditNote(PrintCount);

create table BCCreditNoteSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 5,
	DocNo	VARCHAR(20),
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	CashierCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	DiscQty	MONEY DEFAULT 0.0,
	TempQty	MONEY DEFAULT 0.0, -- ยอดส่งคืนตามที่ Key ไม่มีผลอะไร
	BillQty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนทั้งสิ้น ไม่ใช่ต้นทุนต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	InvoiceNo	VARCHAR(20),
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	IsPos SMALLINT DEFAULT 0, -- 0=ทั่วไป 1=POS
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	StockProcess SMALLINT DEFAULT 0, -- 0 = Update Stock and cost 1= Update cost only 2= ไม่ Update Stock
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ของสินค้าที่อ้างอิงมาจากเอกสารอื่น
	BarCode	VARCHAR(20),
-- ************* POS ------------	
	ReturnCode 	VARCHAR(10),-- รหัสหมายเหตุการคืนสินค้า
	Salediscword	VARCHAR(30),
	Salediscamount	MONEY DEFAULT 0.0,
	Oldamount	MONEY DEFAULT 0.0, -- (ราคาขาย-ส่วนลดขาย)*จำนวนรับคืน
-- ************* POS ------------	
	IsPromotion SMALLINT DEFAULT 0,
	PremiumStatus SMALLINT DEFAULT 0, -- 0 = ไม่ใช่ของแถม ,1 = เป็นของแถม 
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255),-- Jeab 2003-04-26 Lot กำหนดเอง
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย	
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	Custgroupcode	varchar(10),
--for evs project
	PriceCode varchar(10),
	InvoiceType varchar(10),
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0,
	BranchCode VARCHAR(10),
	ItemSetCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CNCost money default 0.0,
	RetailPrice	 MONEY DEFAULT 0.0,
	RetailAmount	 MONEY DEFAULT 0.0	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CNOTESUB_DOCDATE ON BCCreditNoteSub(DOCDATE);
CREATE  INDEX IDX_CNOTESUB_DOCNO ON BCCreditNoteSub(DocNo);
CREATE  INDEX IDX_CNOTESUB_ITEM ON BCCreditNoteSub(ItemCode);
CREATE  INDEX IDX_CNOTESUB_SWH ON BCCreditNoteSub(WHCode);
CREATE  INDEX IDX_CNOTESUB_SHF ON BCCreditNoteSub(ShelfCode);
CREATE  INDEX IDX_CNOTESUB_IND ON BCCreditNoteSub(BehindIndex);
CREATE  INDEX IDX_CNOTESUB_TYPE ON BCCreditNoteSub(MyType);
CREATE  INDEX IDX_CNOTESUB_TS ON BCCreditNoteSub(TransState);
CREATE  INDEX IDX_CNOTESUB_AR ON BCCreditNoteSub(ArCode);
CREATE  INDEX IDX_CNOTESUB_ONE ON BCCreditNoteSub(ItemCode,UnitCode,WHCode,ShelfCode);
CREATE  INDEX IDX_CNOTESUB_TWO ON BCCreditNoteSub(LineNumber);
CREATE  INDEX IDX_CNOTESUB_THREE ON BCCreditNoteSub(SaleCode);
CREATE  INDEX IDX_CNOTESUB_FOUR ON BCCreditNoteSub(ArCode,DocNo);
CREATE  INDEX IDX_CNOTESUB_SERVICE ON BCCreditNoteSub(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_CNOTEISPROCESS ON BCCreditNoteSub(ItemCode,IsProcess);
CREATE  INDEX IDX_CNOTEPAK1 ON BCCreditNoteSub(PackingRate1);
CREATE  INDEX IDX_CNOTEPAK2 ON BCCreditNoteSub(PackingRate2);
CREATE  INDEX IDX_CNOTEISPC ON BCCreditNoteSub(IsProcess);
			
create table BCInvDebitNote1
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DebitNoteNo	VARCHAR(20), -- เลขที่ใบเพิ่มหนี้
	InvoiceNo	VARCHAR(20),	-- เลขที่ Invoice ที่จะลด
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่เพิ่มทันที 1=เพิ่มทันที
	InvoiceDisc	VARCHAR(40),	-- ส่วนลดเดิม
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	OldAmount MONEY DEFAULT 0.0, -- ยอดเดิม
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	DiscountAmount MONEY DEFAULT 0.0, -- ยอดที่ลด
	DiffAmount	MONEY DEFAULT 0.0,	-- ยอดผลต่าง,ยอดที่จะลด เป็นรวมใน
	ZeroTaxAmount	MONEY DEFAULT 0.0, -- รวมยอดภาษีอัตรา 0
	ExceptTaxAmount	MONEY DEFAULT 0.0, --รวมยอดยกเว้นภาษี
	TrueAmount	MONEY DEFAULT 0.0,	-- ยอดที่ถูกต้อง OldAmount -DiffAmount-ZeroTaxAmount-ExceptTaxAmount
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * DiffAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * DiffAmount
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ExchangeProfit	MONEY DEFAULT 0.0,  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
	Custgroupcode	varchar(10)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_INVDB1_DATE ON BCInvDebitNote1(DocDate);
CREATE  INDEX IDX_INVDB1_AR ON BCInvDebitNote1(ArCode);
CREATE  INDEX IDX_INVDB1_NO ON BCInvDebitNote1(DebitNoteNo);
CREATE  INDEX IDX_INVDB1_INV ON BCInvDebitNote1(InvoiceNo);
CREATE  INDEX IDX_INVDB11  ON BCInvDebitNote1(ArCode,DebitNoteNo);
			
create table BCDebitNote1
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	SumOldAmount	MONEY DEFAULT 0.0, -- รวมใบกำกับเดิม (เป็นเงินบาทตาม Rate ใหม่)
	SumTrueAmount	MONEY DEFAULT 0.0, -- รวมยอดที่ถูกต้อง (เป็นเงินบาท)
	SumofDiffAmount	MONEY DEFAULT 0.0, -- รวมผลต่าง เป็นรวมใน 
	SumofBeforeTax	MONEY DEFAULT 0.0,  -- ยอดก่อนภาษี
	SumOfTaxAmount	MONEY DEFAULT 0.0, -- ยอดภาษี
	SumOfTotalTax	MONEY DEFAULT 0.0,  -- ยอดรวมภาษี
	SumOfExceptTax	MONEY DEFAULT 0.0, -- ยอดยกเว้นภาษี
	SumOfZeroTax MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	DiscountWord VARCHAR(30), -- ส่วนลด
	DiscountAmount MONEY DEFAULT 0.0,  -- ส่วนลด
	NetDebtAmount	MONEY DEFAULT 0.0, -- ยอดสุทธิ SumOfTotalTax + SumOfExceptTax
	SumExchangeProfit	MONEY DEFAULT 0.0,  -- รวมกำไร(ขาดทุน)
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่เพิ่มทันที 1=เพิ่มทันที
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย
	CauseCode VARCHAR(10), -- สาเหตุการเพิ่มหนี้
	PayBillStatus	SMALLINT	DEFAULT 0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	BillTemporary MONEY DEFAULT 0.0, -- ยอดทำใบเสร็จชั่วคราว 2003-11-27
	Custgroupcode	varchar(10),
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	MethodePaybill	VARCHAR(10), --วิธีการชำระเงิน
	MethodePaybill2	  VARCHAR(255) --วิธีการชำระเงิน 2	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_DB1_DATE ON BCDebitNote1(DocDate);
CREATE  INDEX IDX_DB1_AR ON BCDebitNote1(ArCode);
CREATE  INDEX IDX_DB1_PBS ON BCDebitNote1(PayBillStatus);
CREATE  INDEX IDX_DB1_BAL ON BCDebitNote1(BillBalance);
CREATE  INDEX IDX_DB1_ROW	ON BCDebitNote1(ROWORDER);
CREATE  INDEX IDX_DB1_1 ON BCDebitNote1(ArCode,DocNo);
CREATE INDEX IDX_DB1_PNTC ON BCDebitNote1(PrintCount);

create table BCDebitNoteSub1
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 6,
	DocNo	VARCHAR(20),
	TaxNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	DiscQty	MONEY DEFAULT 0.0,
	TempQty	MONEY DEFAULT 0.0, -- ยอดส่งคืนตามที่ Key ไม่มีผลอะไร
	BillQty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	SumOfCost	MONEY DEFAULT 0.0, -- ต้นทุนขายทั้งสิ้น ไม่ใช่ต้นทุนขายต่อหน่วย
	SumOfCost2	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	InvoiceNo	VARCHAR(20),
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	StockProcess SMALLINT DEFAULT 0, -- 0 = Update Stock and cost 1= Update cost only 2= ไม่ Update Stock
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ของสินค้าที่อ้างอิงมาจากเอกสารอื่น
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	PremiumStatus SMALLINT DEFAULT 0, -- 0 = ไม่ใช่ของแถม ,1 = เป็นของแถม 
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย		
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	Custgroupcode	varchar(10),
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_DB1SNO ON BCDebitNoteSub1(DocNo);
CREATE  INDEX IDX_DB1SDATE ON BCDebitNoteSub1(DOCDATE);
CREATE  INDEX IDX_DB1SITEM ON BCDebitNoteSub1(ItemCode);
CREATE  INDEX IDX_DB1SWH ON BCDebitNoteSub1(WHCode);
CREATE  INDEX IDX_DB1SSHF ON BCDebitNoteSub1(ShelfCode);
CREATE  INDEX IDX_DB1STYPE ON BCDebitNoteSub1(MyType);
CREATE  INDEX IDX_DB1SIND ON BCDebitNoteSub1(BehindIndex);
CREATE  INDEX IDX_DB1STS ON BCDebitNoteSub1(TransState);
CREATE  INDEX IDX_DB1SAR ON BCDebitNoteSub1(ArCode);
CREATE  INDEX IDX_DB11 ON BCDebitNoteSub1(ItemCode,UnitCode,WHCode,ShelfCode);
CREATE  INDEX IDX_DB12 ON BCDebitNoteSub1(LineNumber);
CREATE  INDEX IDX_DB13 ON BCDebitNoteSub1(ArCode,DocNo);
CREATE  INDEX IDX_DB_SERVICE ON BCDebitNoteSub1(ItemCode,DocDate,LotNumber,BehindIndex);						
CREATE  INDEX IDX_DBPAK1 ON BCDebitNoteSub1(PackingRate1);
CREATE  INDEX IDX_DBPAK2 ON BCDebitNoteSub1(PackingRate2);
CREATE  INDEX IDX_DBISPC ON BCDebitNoteSub1(IsProcess);

create table BCSaleOrder
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BillType	SMALLINT DEFAULT 0, -- Add 01/12/2002
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	DeliveryDay	SMALLINT DEFAULT 0, -- ส่งของภายใน
	DeliveryDate	DATETIME, -- วันที่ลงของให้ลูกค้า		
	SaleCode	VARCHAR(10),
	DeliveryAddr VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	RefDocNo	VARCHAR(20), -- เลขที่เอกสารอ้างอิง
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยังไม่หมด 1=ตัดหมดแล้ว
	DeliveryStatus	SMALLINT DEFAULT 0, -- ดึงไปทำใบสั่งจ่ายสินค้า 0=ยังไม่ดึง 1=ดึงไปทำแล้ว
	SOStatus	SMALLINT DEFAULT 0, -- 0=สั่งขาย 1=สั่งจอง
	HoldingStatus SMALLINT DEFAULT 0, -- 0=ไม่ Holding 1= Holding
	CrAuthorizeMan VARCHAR(20),
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsConditionSend SMALLINT DEFAULT 0,-- เงื่อนไขการรับสินค้า 0 = รับเอง, 1 = ส่งให้
	OwnReceive VARCHAR(255),
	CarLicense VARCHAR(30),
	ApproveCode	VARCHAR(10),--รหัสผู้อนุมัติ
	ApproveDateTime	DATETIME,--วันที่อนุม้ติ
	IsUseRobotSale SMALLINT DEFAULT 0, -- ใช้ Robot ในการพิมพ์ใบจัด Auto 0 = ไม่ใช้,1 = ใช้
	TotalTransport	MONEY DEFAULT 0.0, -- ค่าขนส่ง
	SumOtherValue	MONEY DEFAULT 0.0, -- รวมค่าอื่น
	READYFORPAY SMALLINT DEFAULT 0, 	--1=เอาไปทำใบจ่ายได้
	TimeTransport		VARCHAR(10),	-- เวลาข่นส่ง
	CarType		VARCHAR(10), -- ประเภทรถ
	CondPayCode	VARCHAR(10),  --เงื่อนไขการชำระเงิน
	PrintCount SMALLINT DEFAULT 0, -- Count Print saleorder -- Jeab-20030923 
	PORefNo	VARCHAR(20),
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	MethodePaybill	VARCHAR(10), --วิธีการชำระเงิน
	MethodePaybill2	  VARCHAR(255), --วิธีการชำระเงิน 2	
	promotioncode VARCHAR(20),
	IsPackingList	SMALLINT DEFAULT 0, -- 1 = Set Packing
	------------ NORITAKE Modify -------------
	VesselOr VARCHAR(255),
	ETADate DATETIME,
	ETDDate DATETIME,
	ETADateRemark VARCHAR(255),
	ETDDateRemark VARCHAR(255),		
	FromVia VARCHAR(255),
	ToVia VARCHAR(255),
	MarkAndNos VARCHAR(255),
	DeliverTo VARCHAR(255),
	CountryOrigin VARCHAR(255),
	PayDateRemark VARCHAR(255),
	BookNo	VARCHAR(30), -- เลขที่บัญชี
	IssuingBank VARCHAR(255),
	OtherPayment VARCHAR(255),
	FreightAmount MONEY DEFAULT 0.0, -- ค่าขนส่ง
	InsuranceAmount MONEY DEFAULT 0.0, -- ค่าประกัน
	FobAmount MONEY DEFAULT 0.0, -- NetDebtAmount -(FreightAmount+InsuranceAmount)
	MyDescPort VARCHAR(255),
	Incoterms VARCHAR(255),
	ProductCategory VARCHAR(10),
	AdvisingBank VARCHAR(10),
	FootNote VARCHAR(1000),
	InfavorOf VARCHAR(1000),
	ProformaNo VARCHAR(20)-- Noritake
    PRIMARY KEY(DocNo)
);
	 		
CREATE  INDEX IDX_SO_DATE ON BCSaleOrder(DocDate);
CREATE  INDEX IDX_SO_AR ON BCSaleOrder(ArCode);
CREATE  INDEX IDX_SO_DUE ON BCSaleOrder(DueDate);
CREATE  INDEX IDX_SO_BS ON BCSaleOrder(BillStatus);
CREATE  INDEX IDX_SO_ROW	ON BCSaleOrder(ROWORDER);
CREATE INDEX IDX_SO_PNTC ON BCSaleOrder(PrintCount);

create table BCSaleOrderSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือหลังตัด
	DeliveryQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือหลังตัดสั่งจ่ายสินค้า
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositePrice2	MONEY DEFAULT 0.0, -- ราคาต่อหน่วยที่ 2 (เส้น)
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	StkReserveNo	VARCHAR(20),
	SOStatus	SMALLINT DEFAULT 0, -- 0=สั่งขาย 1=สั่งจอง
	HoldingStatus SMALLINT DEFAULT 0, -- 0=ไม่ Holding 1= Holding
	RefType	SMALLINT DEFAULT 0, -- 0=ใบสั่งจองสินค้า 1=ใบเสนอราคา
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0,
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	PremiumStatus SMALLINT DEFAULT 0, -- 0 = ไม่ใช่ของแถม ,1 = เป็นของแถม
	IsUseRobotSale SMALLINT DEFAULT 0, -- ใช้ Robot ในการพิมพ์ใบจัด Auto 0 = ไม่ใช้,1 = ใช้
	IsConditionSend SMALLINT DEFAULT 0,-- เงื่อนไขการรับสินค้า 0 = รับเอง, 1 = ส่งให้
	TransportAmount	MONEY DEFAULT 0.0, -- ค่าขนส่ง
	OtherValue	MONEY DEFAULT 0.0, -- ค่าอื่น
	REMAINPAYQTY	MONEY DEFAULT 0.0,
	ISPAYMENT SMALLINT DEFAULT 0, 	--1=เอาไปทำใบจ่ายได้	
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for item set by aom 15-07-2003
	itemsetcode VARCHAR(25),
	PORefNo VARCHAR(20),
	POLineNumber SMALLINT DEFAULT 0,
	POQty MONEY DEFAULT 0.0,
--for bcservice
	BehindIndex	SMALLINT DEFAULT 1,
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0,
	promotioncode VARCHAR(20),
	masteritemcode	VARCHAR(25),
	IsPackingList	SMALLINT DEFAULT 0, -- 1 = Set Packing
	Netweight	MONEY DEFAULT 0.0, -- น้ำหนักของสินค้า
	GrossWeight	MONEY DEFAULT 0.0, -- น้ำหนักของสินค้า+น้ำหนักภาชนะ	
	Measurement	VARCHAR(255),
	MeasureWide	MONEY DEFAULT 0.0,
	MeasureLong	MONEY DEFAULT 0.0,
	MeasureHigh	MONEY DEFAULT 0.0,
	FactorPrice MONEY DEFAULT 0.0, --Price in factor Unit, แม่ทองสุข		
	RetailPrice	 MONEY DEFAULT 0.0,
	RetailAmount	 MONEY DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_SOS_DATE ON BCSaleOrderSub(DocDate);
CREATE  INDEX IDX_SOS_NO ON BCSaleOrderSub(DocNo);
CREATE  INDEX IDX_SOS_AR ON BCSaleOrderSub(ArCode);
CREATE  INDEX IDX_SOS_SALE ON BCSaleOrderSub(SaleCode);
CREATE  INDEX IDX_SOS_RQTY	ON BCSaleOrderSub(RemainQty);
CREATE  INDEX IDX_SOS_TS ON BCSaleOrderSub(TransState);
CREATE  INDEX IDX_SOS_REF ON BCSaleOrderSub(StkReserveNo);
CREATE  INDEX IDX_SOS_SERVICE ON BCSaleOrderSub(ItemCode,DocDate,BehindIndex);
CREATE  INDEX IDX_SOSISPROCESS ON BCSaleOrderSub(ItemCode,IsProcess);
CREATE  INDEX IDX_SOSPAK1 ON BCSaleOrderSub(PackingRate1);
CREATE  INDEX IDX_SOSPAK2 ON BCSaleOrderSub(PackingRate2);
CREATE  INDEX IDX_SOSISPC ON BCSaleOrderSub(IsProcess);
CREATE  INDEX IDX_SERV_SAORDSUB ON BCSaleOrderSub(DocNo,ItemCode);
			
create table BCStkReserve
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	DeliveryDay	SMALLINT DEFAULT 0, -- ส่งของภายใน
	DeliveryDate	DATETIME, -- วันที่ลงของให้ลูกค้า			
	SaleCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0, -- 0=ตัดยังไม่หมด 1=ตัดหมดแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME
    PRIMARY KEY(DocNo)
);
	 		
CREATE  INDEX IDX_SR_DATE ON BCStkReserve(DocDate);
CREATE  INDEX IDX_SR_AR ON BCStkReserve(ArCode);
CREATE  INDEX IDX_SR_DUE ON BCStkReserve(DueDate);
CREATE  INDEX IDX_SR_BS ON BCStkReserve(BillStatus);
CREATE  INDEX IDX_SR_ROW	ON BCStkReserve(ROWORDER);
	 		
create table BCStkReserveSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือ
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	QuotationNo	VARCHAR(20),
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BarCode	VARCHAR(20)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_SRS_DATE ON BCStkReserveSub(DocDate);
CREATE  INDEX IDX_SRS_AR ON BCStkReserveSub(ArCode);
CREATE  INDEX IDX_SRS_SALE ON BCStkReserveSub(SaleCode);
CREATE  INDEX IDX_SRS_RQTY	ON BCStkReserveSub(RemainQty);
CREATE  INDEX IDX_SRS_TS ON BCStkReserveSub(TransState);
CREATE  INDEX IDX_SRS_REF ON BCStkReserveSub(QuotationNo);

create table BCQuotation
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	DeliveryDay	SMALLINT DEFAULT 0, --
	DeliveryDate	DATETIME, -- 
	Subject	VARCHAR(255),
	Enclosures	VARCHAR(255),
	Validity	SMALLINT DEFAULT 0,
	SaleCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription1	VARCHAR(255),
	MyDescription2	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0, -- 
	IsCancel	SMALLINT DEFAULT 0, -- 
	ExpireCredit SMALLINT DEFAULT 0, -- 
	CallCheckDate DATETIME, -- 
	ExpireDate DATETIME, --
	CustomerAssert	SMALLINT DEFAULT 0, --
	AssertStatus SMALLINT DEFAULT 0, -- 
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	TotalTransport	MONEY DEFAULT 0.0, --
	BillType	SMALLINT DEFAULT 0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030922
	IsImport SMALLINT DEFAULT 0, --
	UserGroup VARCHAR(10), -- 
	MethodePaybill	VARCHAR(10), --
	MethodePaybill2	  VARCHAR(255) 
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_QUO_DATE ON BCQuotation(DocDate);
CREATE  INDEX IDX_QUO_AR ON BCQuotation(ArCode);
CREATE  INDEX IDX_QUO_DUE ON BCQuotation(DueDate);
CREATE  INDEX IDX_QUO_BS ON BCQuotation(BillStatus);
CREATE  INDEX IDX_QUO_ROW	ON BCQuotation(ROWORDER);
CREATE  INDEX IDX_QUO_PNTC ON BCQuotation(printcount);
	 		
create table BCQuotationSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0, -- 
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 
	UnitCode	VARCHAR(10),
	OppositePrice2	MONEY DEFAULT 0.0, --
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	LineNumber SMALLINT DEFAULT 0,
	CategoryCode	VARCHAR(10),	--
	GroupCode	VARCHAR(10),	-- 
	BrandCode	VARCHAR(10), -- 
	TypeCode	VARCHAR(10),	--
	FormatCode	VARCHAR(10),	-- 
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	PremiumStatus SMALLINT DEFAULT 0, -- 
	QuoStatusCode VARCHAR(10), --
	IsConditionSend SMALLINT DEFAULT 0,-- 
	TransportAmount	MONEY DEFAULT 0.0, -- 
--support color,size,style
	Colorcode VARCHAR(10),
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for item set by aom 23-06-2004
	itemsetcode VARCHAR(25),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 SMALLMONEY DEFAULT 0.0,
	PackingRate2 SMALLMONEY DEFAULT 0.0,
	BehindIndex	SMALLINT DEFAULT 1,
	UserGroup VARCHAR(10)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_QUOS_DATE ON BCQuotationSub(DocDate);
CREATE  INDEX IDX_QUOS_AR ON BCQuotationSub(ArCode);
CREATE  INDEX IDX_QUOS_SALE ON BCQuotationSub(SaleCode);
CREATE  INDEX IDX_QUOS_RQTY	ON BCQuotationSub(RemainQty);
CREATE  INDEX IDX_QUOS_PAK1 ON BCQuotationSub(PackingRate1);
CREATE  INDEX IDX_QUOS_PAK2 ON BCQuotationSub(PackingRate2);

create table BCProformaInvoice
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	DeliveryDay	SMALLINT DEFAULT 0, --
	DeliveryDate	DATETIME, -- 
	Subject	VARCHAR(255),
	Enclosures	VARCHAR(255),
	Validity	SMALLINT DEFAULT 0,
	SaleCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription1	VARCHAR(255),
	MyDescription2	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0, -- 
	IsCancel	SMALLINT DEFAULT 0, -- 
	ExpireCredit SMALLINT DEFAULT 0, -- 
	CallCheckDate DATETIME, -- 
	ExpireDate DATETIME, --
	CustomerAssert	SMALLINT DEFAULT 0, --
	AssertStatus SMALLINT DEFAULT 0, -- 
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	TotalTransport	MONEY DEFAULT 0.0, --
	BillType	SMALLINT DEFAULT 0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030922
	IsImport SMALLINT DEFAULT 0, --
	UserGroup VARCHAR(10), -- 
	MethodePaybill	VARCHAR(10), --
	MethodePaybill2	  VARCHAR(255),
	------------ NORITAKE Modify -------------
	VesselOr VARCHAR(255),
	ETADate DATETIME,
	ETDDate DATETIME,
	FromVia VARCHAR(255),
	ToVia VARCHAR(255),
	MarkAndNos VARCHAR(255),
	DeliverTo VARCHAR(255),
	CountryOrigin VARCHAR(255),
	PayDateRemark VARCHAR(255),
	BookNo	VARCHAR(30), -- เลขที่บัญชี
	IssuingBank VARCHAR(255),
	OtherPayment VARCHAR(255),
	FreightAmount MONEY DEFAULT 0.0, -- ค่าขนส่ง
	InsuranceAmount MONEY DEFAULT 0.0, -- ค่าประกัน
	FobAmount MONEY DEFAULT 0.0, -- NetDebtAmount -(FreightAmount+InsuranceAmount)		 
	MyDescPort VARCHAR(255)	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_PROINV_DATE ON BCProformaInvoice(DocDate);
CREATE  INDEX IDX_PROINV_AR ON BCProformaInvoice(ArCode);
CREATE  INDEX IDX_PROINV_DUE ON BCProformaInvoice(DueDate);
CREATE  INDEX IDX_PROINV_BS ON BCProformaInvoice(BillStatus);
CREATE  INDEX IDX_PROINV_ROW	ON BCProformaInvoice(ROWORDER);
CREATE  INDEX IDX_PROINV_PNTC ON BCProformaInvoice(printcount);
	 		
create table BCProformaInvoiceSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0, -- 
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 
	UnitCode	VARCHAR(10),
	OppositePrice2	MONEY DEFAULT 0.0, --
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	LineNumber SMALLINT DEFAULT 0,
	CategoryCode	VARCHAR(10),	--
	GroupCode	VARCHAR(10),	-- 
	BrandCode	VARCHAR(10), -- 
	TypeCode	VARCHAR(10),	--
	FormatCode	VARCHAR(10),	-- 
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	PremiumStatus SMALLINT DEFAULT 0, -- 
	QuoStatusCode VARCHAR(10), --
	IsConditionSend SMALLINT DEFAULT 0,-- 
	TransportAmount	MONEY DEFAULT 0.0, -- 
--support color,size,style
	Colorcode VARCHAR(10),
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for item set by aom 23-06-2004
	itemsetcode VARCHAR(25),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 SMALLMONEY DEFAULT 0.0,
	PackingRate2 SMALLMONEY DEFAULT 0.0,
	BehindIndex	SMALLINT DEFAULT 1,
	UserGroup VARCHAR(10),
	Netweight	MONEY DEFAULT 0.0, -- น้ำหนักของสินค้า
	GrossWeight	MONEY DEFAULT 0.0, -- น้ำหนักของสินค้า+น้ำหนักภาชนะ	
	Measurement	VARCHAR(255),
	MeasureWide	MONEY DEFAULT 0.0,
	MeasureLong	MONEY DEFAULT 0.0,
	MeasureHigh	MONEY DEFAULT 0.0		
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PROINVS_DATE ON BCProformaInvoiceSub(DocDate);
CREATE  INDEX IDX_PROINVS_AR ON BCProformaInvoiceSub(ArCode);
CREATE  INDEX IDX_PROINVS_SALE ON BCProformaInvoiceSub(SaleCode);
CREATE  INDEX IDX_PROINVS_RQTY	ON BCProformaInvoiceSub(RemainQty);
CREATE  INDEX IDX_PROINVS_PAK1 ON BCProformaInvoiceSub(PackingRate1);
CREATE  INDEX IDX_PROINVS_PAK2 ON BCProformaInvoiceSub(PackingRate2);
	
create table BCARDepositUse -- การตัดเงินมัดจำ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DepositNo	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	Balance MONEY DEFAULT 0.0, -- ยอดคงเหลือ
	Amount	MONEY DEFAULT 0.0, -- ยอดที่ตัดรับตามที่ key
	DeposTaxType	SMALLINT DEFAULT 0,
	NetAmount MONEY DEFAULT 0.0, -- ยอดที่ตัดรับไม่รวม ภาษี (Auto calc) ในกรณีที่บิลขายเป็นรวมใน
	LineNumber SMALLINT DEFAULT 0,
	CurrencyCode	VARCHAR(10),
	DPExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม DPExchangeRate * NetAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * NetAmount	
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(DocNo,DepositNo)
);

CREATE  INDEX IDX_ARDU_NO ON BCARDepositUse(DocNo);
CREATE  INDEX IDX_ARDU_DNO ON BCARDepositUse(DepositNo);
CREATE  INDEX IDX_ARDU_DATE ON BCARDepositUse(DocDate);

create table BCAPDepositUse -- การตัดเงินมัดจำ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DepositNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	Balance MONEY DEFAULT 0.0, -- ยอดคงเหลือ
	Amount	MONEY DEFAULT 0.0, -- ยอดที่ตัดจ่ายตามที่ key
	DeposTaxType	SMALLINT DEFAULT 0,
	NetAmount MONEY DEFAULT 0.0, -- ยอดที่ตัดจ่ายไม่รวม ภาษี (Auto calc) ในกรณีที่บิลซื้อเป็นรวมใน
	CurrencyCode	VARCHAR(10),
	LineNumber SMALLINT DEFAULT 0,
	DPExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม DPExchangeRate * NetAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * NetAmount
	ExchangeProfit	MONEY DEFAULT 0.0,  -- กำไร(ขาดทุน) HomeAmount2-HomeAmount1
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DocNo,DepositNo)
);

CREATE  INDEX IDX_APDU_NO ON BCAPDepositUse(DocNo);
CREATE  INDEX IDX_APDU_DNO ON BCAPDepositUse(DepositNo);
CREATE  INDEX IDX_APDU_DATE ON BCAPDepositUse(DocDate);

create table BCARDeposit
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	TaxNo	VARCHAR(20),
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	SaleCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0, -- TotalAmount - SumOfWTax
	BillBalance	MONEY DEFAULT 0.0, -- ถ้าเป็นรวมใน=NetAmount ถ้าเป็นแยกนอก=NetAmount ถอด Tax
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน เฉพาะเงินสด
	RefNo	VARCHAR(20),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsReturnMoney SMALLINT DEFAULT 0, -- 1=ลดหนี้หรือคืนเงิน
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-2003092209
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_ARDEP_DATE ON BCARDeposit(DocDate);
CREATE  INDEX IDX_ARDEP_AR ON BCARDeposit(ArCode);
CREATE  INDEX IDX_ARDEP_BAL ON BCARDeposit(BillBalance);
CREATE  INDEX IDX_ARDEP_PNTC ON BCARDeposit(printcount);

create table BCPaybill
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SaleCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยัง 1=หมด
	DueDate	DATETIME,
	PayServiceOnly SMALLINT DEFAULT 0, -- 1=รับชำระค่าบริการอย่างเดียว
	PrintItemOfBill SMALLINT DEFAULT 0, -- 1=พิมพ์รายการสินค้า
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsConfirm	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	IsPrintAuto SMALLINT DEFAULT 0, -- พิมพ์อัตโนมัติ  1= พิมพ์แล้ว
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
--	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	BillTemporary MONEY DEFAULT 0.0, -- ยอดทำใบเสร็จชั่วคราว 2003-11-27
	--for EVS project
	DiscountWord VARCHAR(255),
	Discount MONEY DEFAULT 0.0,
	WithHoldTax MONEY DEFAULT 0.0,	
	DiscountAmount MONEY DEFAULT 0.0,
	Iscancel SMALLINT DEFAULT 0, --jum 
	BillsDiscount VARCHAR(25) --ส่วนลดท้ายบิลของทุกบิล  (Thai Inter Project by Nok 2006-09-13)
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_PB_DATE ON BCPaybill(DocDate);
CREATE  INDEX IDX_PB_AR ON BCPaybill(ArCode);
CREATE  INDEX IDX_PB_BS ON BCPaybill(BillStatus);
CREATE  INDEX IDX_PB_PNTC ON BCPaybill(printcount);
			
create table BCPaybillSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SaleCode	VARCHAR(10),
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	PayBalance MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BillType	SMALLINT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PBS_NO ON BCPaybillSub(DocNo);
CREATE  INDEX IDX_PBS_DATE ON BCPaybillSub(DocDate);
CREATE  INDEX IDX_PBS_AR ON BCPaybillSub(ArCode);
CREATE  INDEX IDX_PBS_PBAL ON BCPaybillSub(PayBalance);
CREATE  INDEX IDX_PBS_INVN ON BCPaybillSub(InvoiceNo);

create table BCReceipt1 -- ใบเสร็จรับเงิน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน เฉพาะเงินสด
	SumBankAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	SumHomeAmount1 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount1 In Sub) rate เดิม ตัดลูกหนี้
	SumHomeAmount2 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub) rate ใหม่
	DebtLimitReturn MONEY DEFAULT 0.0, -- ยอดทีคืนวงเงิน Default = SumHomeAmount1
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	IsConfirm	SMALLINT DEFAULT 0,
	PayServiceOnly SMALLINT DEFAULT 0, -- 1=รับชำระค่าบริการอย่างเดียว (อ้างได้เฉพาะ  type=3)
	PrintItemOfBill SMALLINT DEFAULT 0, -- 1=พิมพ์ใบเสร็จเหมือนใบส่งของ
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	SumOfEarnest MONEY DEFAULT 0.0 -- ยอดเงินล่วงหน้า
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_REP1_DATE ON BCReceipt1(DocDate);
CREATE  INDEX IDX_REP1_AR ON BCReceipt1(ArCode);
CREATE  INDEX IDX_REP1_PNTC ON BCReceipt1(printcount);

create table BCRecBillItemSub -- table สำหรับแสดงรายการสินค้าที่ถูกตัดในการรับชำระหนี้ค่าบริการ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	RecType	SMALLINT DEFAULT 0, -- 0= รับชำระหนี้ ,1 =ใบเสร็จชั่วคราว
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	ItemName	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	DocNo	VARCHAR(20), -- ใบเสร็จ
	DocDate	DATETIME, -- วันที่ใบเสร็จ
	InvoiceNo	VARCHAR(20),
	Qty	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0, -- post gl
	IncTaxAmount MONEY DEFAULT 0.0,
	RefLineNumber	SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);
			
create table BCReceiptSub1
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SaleCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	DebtLimitReturn MONEY DEFAULT 0.0, -- ยอดทีคืนวงเงิน Default = SumHomeAmount1
	DebtLimitRetDesc VARCHAR(255), -- หมายเหตุการคืนวงเงิน
	MyDescription	VARCHAR(255),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BillType	SMALLINT DEFAULT 0,  -- 0=ใบส่งของ 1=เอกสารยกมา 2=ใบลดหนี้ 3=ใบเพิ่มหนี้ 4=ลูกหนี้อื่นๆ 8= รับเงินล่วงหน้า
	RefNo	VARCHAR(20),
	RefType	SMALLINT DEFAULT 0, -- 0=ใบวางบิล 1=ใบเสร็จชั่วคราว
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_REPS1_NO ON BCReceiptSub1(DocNo);
CREATE  INDEX IDX_REPS1_DATE ON BCReceiptSub1(DocDate);
CREATE  INDEX IDX_REPS1_AR ON BCReceiptSub1(ArCode);
CREATE  INDEX IDX_REPS1_TS ON BCReceiptSub1(TransState);
CREATE  INDEX IDX_REPS1_INVNO ON BCReceiptSub1(InvoiceNo);


create table BCRecSubTemp
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	DebtLimitReturn MONEY DEFAULT 0.0, -- ยอดทีคืนวงเงิน Default = SumHomeAmount1
	DebtLimitRetDesc VARCHAR(255), -- หมายเหตุการคืนวงเงิน
	MyDescription	VARCHAR(255),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BillType	SMALLINT DEFAULT 0,  -- 0=ใบส่งของ 1=เอกสารยกมา 2=ใบลดหนี้ 3=ใบเพิ่มหนี้ 4=ลูกหนี้อื่นๆ
	RefNo	VARCHAR(20),
	RefType	SMALLINT DEFAULT 0, -- 0=ใบวางบิล 1=ใบเสร็จชั่วคราว
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_REPST_NO ON BCRecSubTemp(DocNo);
			
create table BCReceipt2 -- ใบเสร็จรับเงินชั่วคราว
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	PayServiceOnly SMALLINT DEFAULT 0, -- 1=รับชำระค่าบริการอย่างเดียว
	PrintItemOfBill SMALLINT DEFAULT 0, -- 1=พิมพ์รายการสินค้า
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	SumHomeAmount MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub)
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยัง 1=หมด
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME
    PRIMARY KEY(DocNo)
);
			
CREATE  INDEX IDX_REP2_DATE ON BCReceipt2(DocDate);
CREATE  INDEX IDX_REP2_AR ON BCReceipt2(ArCode);
CREATE  INDEX IDX_REP2_PNTC ON BCReceipt2(printcount);

create table BCReceiptSub2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PaybillNo	VARCHAR(20),
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0,  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
	LineNumber SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_REPS2_NO ON BCReceiptSub2(DocNo);
CREATE  INDEX IDX_REPS2_DATE ON BCReceiptSub2(DocDate);
CREATE  INDEX IDX_REPS2_AR ON BCReceiptSub2(ArCode);
CREATE  INDEX IDX_REPS2_TS ON BCReceiptSub2(TransState);
CREATE  INDEX IDX_REPS2_INVNO ON BCReceiptSub2(InvoiceNo);


create table BCReceipt3 -- ตัดยอดลูกหนี้สูญ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SaleCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	SumHomeAmount1 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount1 In Sub) rate เดิม ตัดลูกหนี้
	SumHomeAmount2 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub) rate ใหม่
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	IsConfirm	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923 
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_REP3_DATE ON BCReceipt3(DocDate);
CREATE  INDEX IDX_REP3_AR ON BCReceipt3(ArCode);
CREATE  INDEX IDX_REP3_PNTC ON BCReceipt3(printcount);
			
create table BCReceiptSub3
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BillType	SMALLINT DEFAULT 0,  -- 0=ใบส่งของ 1=เอกสารยกมา 2=ใบลดหนี้ 3=ใบเพิ่มหนี้ 4=ลูกหนี้อื่นๆ
	RefNo	VARCHAR(20),
	RefType	SMALLINT DEFAULT 0, -- 0=ใบวางบิล 1=ใบเสร็จชั่วคราว
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_REPS3_NO ON BCReceiptSub3(DocNo);
CREATE  INDEX IDX_REPS3_DATE ON BCReceiptSub3(DocDate);
CREATE  INDEX IDX_REPS3_AR ON BCReceiptSub3(ArCode);
CREATE  INDEX IDX_REPS3_TS ON BCReceiptSub3(TransState);
CREATE  INDEX IDX_REPS3_INVNO ON BCReceiptSub3(InvoiceNo);
		
create table BCAPDebtTable
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ApCode	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	PeriodNo	SMALLINT DEFAULT 0 NOT NULL,
	CurrencyCode	VARCHAr(10) NOT NULL,
	DebtAmount	MONEY DEFAULT 0.0,
	ChqOnHand	MONEY DEFAULT 0.0,
	ChqReturn	MONEY DEFAULT 0.0
    PRIMARY KEY(ApCode,PeriodNo,CurrencyCode)
);

create table BCAP
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(20) NOT NULL,
	Name1	VARCHAR(255) NOT NULL,
	Name2	VARCHAR(255),
	DefDeliveryAddr VARCHAR(10),
	DefContactCode	VARCHAR(10),
	Address	VARCHAR(255),
	TransportRemark	VARCHAR(255),
	DefTransport	VARCHAR(10),
	Telephone	VARCHAR(50),
	Fax	VARCHAR(50),
	AccountCode	VARCHAR(20),
	IDCardNo VARCHAR(30), -- เลขที่บัตรประชาชน
	BankAccNo VARCHAR(30), -- เลขที่บัญชีธนาคาร 2/12/2002 Jeab
	LastContactDate	DATETIME,
	LastPayDate	DATETIME,
	CreditDay	SMALLINT DEFAULT 0,
	DetailDiscount	VARCHAR(35),
	Discount	VARCHAR(35),
	CashDiscount VARCHAR(35),
	LeadTime	SMALLINT DEFAULT 0, -- ระยะเวลาขนส่ง
	DebtLimit	MONEY DEFAULT 0.0,
	DebtAmount	MONEY DEFAULT 0.0,
	ChqOnHand	MONEY DEFAULT 0.0,
	ChqReturn	MONEY DEFAULT 0.0,
	DefaultTaxRate	MONEY DEFAULT 7.0,
	TaxNo	VARCHAR(20),
	PaymentRemark	VARCHAR(255),
	StatementRemark	VARCHAR(255),
	PicFileName	VARCHAR(50),
	TypeCode	VARCHAR(10),
	EmailAddress	VARCHAR(40),
	GroupCode	VARCHAR(10),
	GroupOfDebt	VARCHAR(10),
	PersonType	SMALLINT,	-- 0=บุคลลธรรมดา 1=นิติบุคคล
	IsMakeTrans SMALLINT DEFAULT 0, -- 0=ออกบิลได้ 1=ออกบิลไม่ได้
	ActiveStatus	SMALLINT DEFAULT 1,
	MapCode	VARCHAR(10),	-- รหัสแผนที่ที่ตั้งบริษัทเจ้าหนี้
	MapPosition_X	SMALLINT	DEFAULT  0,
	MapPosition_Y	SMALLINT	DEFAULT 0,
	ItemDescGroup	SMALLINT	DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	UserGroup	VARCHAR(255),
	EarnestAmount	MONEY DEFAULT 0.0, -- ยอดเงินล่วงหน้า
	DefaultWTaxCash MONEY DEFAULT 3.0, -- Jeab 2005-09-13 ให้บริการจากการซื้อบัตรเงินสด	
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน 2=อัตรา 0
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(CODE)
);

CREATE  INDEX IDX_AP_ACT ON BCAP(ActiveStatus);

create table BCPayMoney
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PayAmount	MONEY	DEFAULT 0.0,
	HomeAmount	MONEY	DEFAULT 0.0, -- ยอดรับเงินเป็นเงินบาท
	ChqTotalAmount	MONEY	DEFAULT 0.0,
	PaymentType	SMALLINT DEFAULT 0,
	SaveFrom SMALLINT DEFAULT 0,
	PayChqState	SMALLINT DEFAULT 0, -- 0=เช็คใบใหม่ 1=ตัดจากเช็คใบเดิม
	LineNumber SMALLINT DEFAULT 0,
	RefNo	VARCHAR(30),
	BookNo	VARCHAR(30),
	BankCode	VARCHAR(10),
	BankBranchCode	VARCHAR(10),
	TransBankDate DATETIME,
	MyDescription	VARCHAR(255),
	ProjectCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	RefDate	DATETIME
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PAYM_DATE ON BCPayMoney(DocDate);
CREATE  INDEX IDX_PAYM_AP ON BCPayMoney(ApCode);
CREATE  INDEX IDX_PAYM_PTY ON BCPayMoney(PaymentType);

-- สำหรับใบเตรียมจ่าย
create table BCPayMoney2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	CurrencyCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PayAmount	MONEY	DEFAULT 0.0,
	HomeAmount	MONEY	DEFAULT 0.0, -- ยอดรับเงินเป็นเงินบาท
	ChqTotalAmount	MONEY	DEFAULT 0.0,
	PaymentType	SMALLINT DEFAULT 0,
	SaveFrom SMALLINT DEFAULT 0,
	PayChqState	SMALLINT DEFAULT 0, -- 0=เช็คใบใหม่ 1=ตัดจากเช็คใบเดิม
	LineNumber SMALLINT DEFAULT 0,
	RefNo	VARCHAR(30),
	BookNo	VARCHAR(30),
	BankCode	VARCHAR(10),
	BankBranchCode	VARCHAR(10),
	TransBankDate DATETIME,
	MyDescription	VARCHAR(255),
	ProjectCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	RefDate	DATETIME
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PAYM2_DATE ON BCPayMoney2(DocDate);
CREATE  INDEX IDX_PAYM2_AP ON BCPayMoney2(ApCode);
CREATE  INDEX IDX_PAYM2_PTY ON BCPayMoney2(PaymentType);

create table BCAPPeriodState -- ยอดหนี้ในแต่ละ Period แสดงเป็น Home Currency
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ApCode	VARCHAR(20) NOT NULL,
	PeriodNo	SMALLINT DEFAULT 0,
	BeginAmount	MONEY DEFAULT 0.0, -- ยอดยกมา
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DebtAmount	MONEY DEFAULT 0.0, -- ยอดตั้งเจ้าหนี้
	CNAmount	MONEY DEFAULT 0.0, -- ยอดลดหนี้
	DebitAmount	MONEY DEFAULT 0.0, -- ยอดเพิ่หนี้
	PaymentAmount	MONEY DEFAULT 0.0, -- ยอดตัดชำระหนี้
	EndAmount	MONEY DEFAULT 0.0, -- ยอดยกไป
	ExchangeProfit	MONEY DEFAULT 0.0, -- กำไรขาดทุนประจำงวด
	advanceamt		MONEY DEFAULT 0.0,
	advanceretamt	MONEY DEFAULT 0.0,
	advanceuseamt	MONEY DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_APPSAp ON BCAPPeriodState(ApCode);
CREATE  INDEX IDX_APPSPNo ON BCAPPeriodState(PeriodNo);
CREATE  INDEX IDX_APPSApPNo ON BCAPPeriodState(ApCode,PeriodNo); --Jum 14:24 24/7/2549

create table BCAPINVBALANCE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	ApCode	VARCHAR(20) NOT NULL,
	DepartCode	VARCHAR(10) ,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	StatementDate	DATETIME,
	StatementState	SMALLINT DEFAULT 0, -- 0=ยังไม่วางบิล 1=วางบิลอยู่
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	NetDebtAmount	MONEY DEFAULT 0.0,
	BillBalance	MONEY DEFAULT 0.0,
	BillType	SMALLINT DEFAULT 0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_APINVBDATE ON BCAPINVBALANCE(DOCDATE);
CREATE  INDEX IDX_APINVBDUE ON BCAPINVBALANCE(DUEDATE);
CREATE  INDEX IDX_APINVBARCD ON BCAPINVBALANCE(APCODE);
CREATE  INDEX IDX_APINVBDEP ON BCAPINVBALANCE(DEPARTCODE);
CREATE  INDEX IDX_APINVBBAL ON BCAPINVBALANCE(BillBalance);
CREATE  INDEX IDX_APINVBBS	ON BCAPINVBALANCE(StatementState);

create table BCAPOtherDebt -- บันทึกเจ้าหนี้อื่นๆ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	ApCode	VARCHAR(20) NOT NULL,
	GLBookCode	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	SumofDebit	MONEY DEFAULT 0.0,
	SumofCredit	MONEY DEFAULT 0.0,
	DepartCode	VARCHAR(10) ,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	PayBillDate	DATETIME,
	IsConfirm	SMALLINT DEFAULT 0,
	StatementState	SMALLINT DEFAULT 0, -- 0=ยังไม่วางบิล 1=วางบิลอยู่
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	NetDebtAmount	MONEY DEFAULT 0.0,
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	PrintCount SMALLINT DEFAULT 0, -- Count Print saleorder -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0,
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_APODBS	ON BCAPOtherDebt(StatementState);
CREATE  INDEX IDX_APODBal ON BCAPOtherDebt(BillBalance);
CREATE  INDEX IDX_APODAP	ON BCAPOtherDebt(ApCode);
CREATE  INDEX IDX_APODDUE ON BCAPOtherDebt(DueDate);
CREATE  INDEX IDX_APODPNTC ON BCAPOtherDebt(printcount);

create table BCGoodsRecCheck -- ใบตรวจรับสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
	DocNo	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME NOT NULL,
	ApCode	VARCHAR(20) NOT NULL,
	MyDescription	VARCHAR(255),
	ServiceRemark 	VARCHAR(255), -- การให้บริการ
	BillGroup	VARCHAR(10),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_GDRCDATE ON BCGoodsRecCheck(DOCDATE);
CREATE  INDEX IDX_GDRCARCD ON BCGoodsRecCheck(APCODE);
CREATE  INDEX IDX_GDRCROW	ON BCGoodsRecCheck(ROWORDER);

create table BCGoodsRecChkSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ApCode	VARCHAR(20),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0, -- ยอดที่รับ
	PerfectQty	MONEY DEFAULT 0.0, -- สมบูรณ์
	BadQty MONEY DEFAULT 0.0, -- ไม่ดี
	BrokenQty MONEY DEFAULT 0.0, -- แตก
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	PORefNo	VARCHAR(20),
	LineNumber	SMALLINT DEFAULT 0,
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	--support color,size,style
	Colorcode VARCHAR(10),
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10)		
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_GDRSDATE ON BCGoodsRecChkSub(DOCDATE);
CREATE  INDEX IDX_GDRSARCD ON BCGoodsRecChkSub(APCODE);
CREATE  INDEX IDX_GDRSITEM ON BCGoodsRecChkSub(ITEMCODE);

create table BCAPINVOICE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME NOT NULL,
	TaxType	SMALLINT DEFAULT 0,
	ApCode	VARCHAR(20) NOT NULL,
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	StatementDate	DATETIME,
	StatementState	SMALLINT DEFAULT 0, -- 0=ยังไม่วางบิล 1=วางบิลอยู่
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	BillGroup	VARCHAR(10),
	ContactCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	DepositIncTax SMALLINT DEFAULT 1, -- เงินมัดจำ 1 = มีภาษี 0= ไม่มี Tax
	SumOfDeposit1	MONEY DEFAULT 0.0, -- สำหรับตัดยอดของบิล
	SumOfDeposit2	MONEY DEFAULT 0.0, -- สำหรับ post GL แต่ต้องถอด Vat ถ้าเป็นรวมใน
	SumOfWTax	MONEY DEFAULT 0.0,
	NetDebtAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetDebtAmount * ExchangRate  -- Jeab 2003-04-21
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	GRBillStatus SMALLINT DEFAULT 0, -- 0=ปกติ 1=ตัดหมดแล้ว, 2= จะเกินกับบิล GR เท่านั้น กรณีมีการ  IR ก่อน GR เพื่อไม่ให้ GR ใบนั้นดึงไปทำ IR ได้อีก
	GRIRBillStatus SMALLINT DEFAULT 0, -- 0=ปกติ 1=เป็นใบ GR อย่างเดียว CHM 2=IR
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsCreditNote	SMALLINT DEFAULT 0, -- 0=ยังไม่ลดหนี้ 1=ลดหนี้แล้ว
	IsDebitNote	SMALLINT DEFAULT 0, -- 0=ยังไม่เพิ่มหนี้ 1=เพิ่มหนี้แล้ว
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ExchangeProfit	MONEY DEFAULT 0.0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	Remark1	VARCHAR(30),
	Remark2	VARCHAR(30),
	Remark3	VARCHAR(30),
	Remark4	VARCHAR(30),
	Remark5	VARCHAR(30),
	OwnerTransport VARCHAR(20), -- ผู้ขนส่ง/บริษัทขนส่ง
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	RefDocNo	VARCHAR(255), -- เอกสารที่อ้างอิงทั้งหมด
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	SumOfWTaxCash	MONEY DEFAULT 0.0,	-- Jeab 2005-09-12
	SumBaseWTaxCash	MONEY DEFAULT 0.0, -- Jeab 2005-09-12
	SumComWTaxCash	MONEY DEFAULT 0.0, -- Jeab 2005-09-12
	APInvoiceNo varchar(20),
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0,
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0,
	IsExport smallint default 0,
	wtaxrate varchar(10),
	sumofwtax_forshow money default 0.0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME			
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_APINVDATE ON BCAPINVOICE(DocDate);
CREATE  INDEX IDX_APINVDUE ON BCAPINVOICE(DueDate);
CREATE  INDEX IDX_APINVARCD ON BCAPINVOICE(ApCode);
CREATE  INDEX IDX_APINVDEP ON BCAPINVOICE(DepartCode);
CREATE  INDEX IDX_APINVBAL ON BCAPINVOICE(BillBalance);
CREATE  INDEX IDX_APINVPS	ON BCAPINVOICE(StatementState);
CREATE  INDEX IDX_APINVBT	ON BCAPINVOICE(BillType);
CREATE  INDEX IDX_APINVROW	ON BCAPINVOICE(ROWORDER);
CREATE  INDEX IDX_APINVPNTC	ON BCAPINVOICE(printcount);

create table BCAPINVOICESUB
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 2,
	DocNo	VARCHAR(20),
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	CNQty	MONEY DEFAULT 0.0,
	GRRemainQty MONEY DEFAULT 0.0, -- ยอดที่ยังไม่ทำ IR
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	BalanceAmount	MONEY DEFAULT 0.0,
	SumOfExpCost	MONEY DEFAULT 0.0, -- เป็นเงินบาท
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	PORefNo	VARCHAR(20),
	IRRefNo	VARCHAR(20), -- สำหรับ GR ที่มีการตั้งหนี้ก่อน
	StockType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT DEFAULT 0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	BarCode	VARCHAR(20),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	IsPromotion SMALLINT DEFAULT 0,
	PORefLinenum smallint default 0, -- jum use FIFO 	
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	StatusReceive SMALLINT DEFAULT 0, -- 0 = ปกติ, 1 = ของเกิน, 2 = ของแถม, 3 = ของสูญหาย, 4 = ของชำรุดจากขนส่ง, 5 = ขนส่งขาดส่ง , 6 = ชำรุดจากเจ้าหนี้
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
	SumOfCost	MONEY DEFAULT 0.0, --aom 2003-05-22
	SumOfCost2	MONEY DEFAULT 0.0,
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0,
	DiscCashCard SMALLINT DEFAULT 0, -- ใช่ส่วนลดบัตรเงินสด	
	WTaxAmount	MONEY DEFAULT 0.0,
	BaseWTax	MONEY DEFAULT 0.0,
	FactorPrice MONEY DEFAULT 0.0, --Price in factor Unit, แม่ทองสุข		
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_APINVSDATE ON BCAPINVOICESUB(DOCDATE);
CREATE  INDEX IDX_APINVSDOCNO ON BCAPINVOICESUB(DOCNO);
CREATE  INDEX IDX_APINVSARCD ON BCAPINVOICESUB(APCODE);
CREATE  INDEX IDX_APINVSARDEP ON BCAPINVOICESUB(DEPARTCODE);
CREATE  INDEX IDX_APINVSIND ON BCAPINVOICESUB(BehindIndex);
CREATE  INDEX IDX_APINVSTYPE ON BCAPINVOICESUB(MYTYPE);
CREATE  INDEX IDX_APINVSITEM ON BCAPINVOICESUB(ITEMCODE);
CREATE  INDEX IDX_APINVSWH ON BCAPINVOICESUB(WHCODE);
CREATE  INDEX IDX_APINVSSHLF ON BCAPINVOICESUB(SHELFCODE);
CREATE  INDEX IDX_APINVSBND ON BCAPINVOICESUB(BRANDCODE);
CREATE  INDEX IDX_APINVSGRP ON BCAPINVOICESUB(GROUPCODE);
CREATE  INDEX IDX_APINVSTYPEC ON BCAPINVOICESUB(TYPECODE);
CREATE  INDEX IDX_APINVSFRM ON BCAPINVOICESUB(FORMATCODE);
CREATE  INDEX IDX_APINVSTS ON BCAPINVOICESUB(TransState);
CREATE  INDEX IDX_APINVSERVICE ON BCAPINVOICESUB(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_APINVISPROCESS ON BCAPINVOICESUB(ItemCode,IsProcess);
CREATE  INDEX IDX_APINVPAK1 ON BCAPINVOICESUB(PackingRate1);
CREATE  INDEX IDX_APINVPAK2 ON BCAPINVOICESUB(PackingRate2);
CREATE  INDEX IDX_APINVISPC ON BCAPINVOICESUB(IsProcess);
CREATE  INDEX IDX_SERV_APINVSUB ON BCApInvoiceSub(PORefNo,IsCancel,ItemCode,ROWORDER,DocNo,Qty,PackingRate1,PackingRate2,PORefLinenum);
CREATE  INDEX IDX_SERV_APINVSUB2 ON BCApInvoiceSub(ItemCode,IsCancel,ROWORDER,LineNumber,DocNo,IsLockCost,MyDescription,averagecost,PackingRate1,PackingRate2,MyType,DocDate,WHCode,ShelfCode,Qty,UnitCode);

create table BCIRSUB -- รายการย่อยของใบ IR
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	CNQty	MONEY DEFAULT 0.0,
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	BalanceAmount	MONEY DEFAULT 0.0,
	SumOfExpCost	MONEY DEFAULT 0.0, -- เป็นเงินบาท
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	GRRefNo	VARCHAR(20), -- อ้างอิงใบ GR
	PORefNo	VARCHAR(20),
	StockType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber	SMALLINT DEFAULT 0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	BarCode	VARCHAR(20),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	IsPromotion SMALLINT DEFAULT 0,
	PORefLinenum smallint, -- Jum use
	GRRefLinenum smallint, -- Jum use	 
	ItemName	VARCHAR(255),
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	StatusReceive SMALLINT DEFAULT 0, -- 0 = ปกติ, 1 = ของเกิน, 2 = ของแถม, 3 = ของสูญหาย, 4 = ของชำรุดจากขนส่ง, 5 = ขนส่งขาดส่ง , 6 = ชำรุดจากเจ้าหนี้
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_IRSDATE ON BCIRSUB(DOCDATE);
CREATE  INDEX IDX_IRSCD ON BCIRSUB(APCODE);
CREATE  INDEX IDX_IRSDEP ON BCIRSUB(DEPARTCODE);
CREATE  INDEX IDX_IRSITEM ON BCIRSUB(ITEMCODE);
CREATE  INDEX IDX_IRSWH ON BCIRSUB(WHCODE);
CREATE  INDEX IDX_IRSSHLF ON BCIRSUB(SHELFCODE);
CREATE  INDEX IDX_IRSBND ON BCIRSUB(BRANDCODE);
CREATE  INDEX IDX_IRSGRP ON BCIRSUB(GROUPCODE);
CREATE  INDEX IDX_IRSSTYPEC ON BCIRSUB(TYPECODE);
CREATE  INDEX IDX_IRSFRM ON BCIRSUB(FORMATCODE);
CREATE  INDEX IDX_IRSTS ON BCIRSUB(TransState);

create table BCWeightCost
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	RefDocNo	VARCHAR(20), -- อ้างถึงเอกสารค่าใช้จ่าย
	ExpDescription	VARCHAR(255),
	WeightBy	SMALLINT DEFAULT 0, -- 0 = ตามปริมาณ  1=ตามมูลค่าสินค้า
	WeightAmount	MONEY DEFAULT 0.0, -- มูลค่าต้นทุนเงินบาท
	MakerName	VARCHAR(255),
	FromPo	VARCHAR(20),
	ToPO VARCHAR(20),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923 
	WeightCostType SMALLINT DEFAULT 0 -- 0 = ต้นทุนแฝงด้านบริหาร , 1 = ต้นทุนแฝงด้านบัญชี
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_WCOST_DATE ON BCWeightCost(DocDate);
--CREATE  INDEX IDX_WCOST_DOCNO ON BCWeightCost(DocNo);

create table BCWeightCostSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BuyDocNo	VARCHAR(20), -- บิลซื้อ
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ExpCostNo	VARCHAR(20), -- เลขที่เอกสารในการ WeightCost
	RefDocNo	VARCHAR(20), -- อ้างถึงเอกสารค่าใช้จ่าย
	ItemCode	VARCHAR(25),
	ItemQty	MONEY DEFAULT 0.0, -- ปริมาณของสินค้า
	ItemAmount	MONEY DEFAULT 0.0, -- มูลค่าของสินค้า
	BillLineNumber SMALLINT DEFAULT 0, -- บรรทัดสินค้าในบิลซื้อ
	ExpDescription	VARCHAR(255),
	LineNumber	SMALLINT DEFAULT 0,
	BillRowOrder INT DEFAULT 0,
	Amount	MONEY DEFAULT 0.0, -- มูลค่าต้นทุนเงินบาท
	WeightCostType SMALLINT DEFAULT 0 -- 0 = ต้นทุนแฝงด้านบริหาร , 1 = ต้นทุนแฝงด้านบัญชี
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_WCOSTS_NO ON BCWeightCostSub(BuyDocNo);
CREATE  INDEX IDX_WCOSTS_EXP ON BCWeightCostSub(ExpCostNo);
CREATE  INDEX IDX_WCOSTS_BL ON BCWeightCostSub(BillLineNumber);
CREATE  INDEX IDX_WCOSTS_IM ON BCWeightCostSub(ItemCode);
CREATE  INDEX IDX_WCOSTS1 ON BCWeightCostSub(DocDate);
CREATE  INDEX IDX_WCOSTS2 ON BCWeightCostSub(RefDocNo);
CREATE  INDEX IDX_WCOSTS3 ON BCWeightCostSub(BuyDocNo,ItemCode,LineNumber);
CREATE  INDEX IDX_WCOSTS4 ON BCWeightCostSub(DocDate,BuyDocNo);

create table BCInvStkRefund
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	StkRefundNo	VARCHAR(20), -- เลขที่ใบลดหนี้
	ReturnMoney	SMALLINT	DEFAULT 0, -- 0=ไม่ 1=รับคืนเงินสด
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่ตัดยอด 1=ตัดยอดทันที
	InvoiceNo	VARCHAR(20),	-- เลขที่ Invoice ที่จะลด
	InvoiceDisc	VARCHAR(40),	-- ส่วนลดเดิม
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	OldAmount MONEY DEFAULT 0.0, -- ยอดเดิม
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	DiscountAmount MONEY DEFAULT 0.0, -- ยอดที่ลด
	DiffAmount	MONEY DEFAULT 0.0,	-- ยอดผลต่าง,ยอดที่จะลด เป็นรวมใน
	ZeroTaxAmount	MONEY DEFAULT 0.0, -- รวมยอดภาษีอัตรา 0
	ExceptTaxAmount	MONEY DEFAULT 0.0, --รวมยอดยกเว้นภาษี
	TrueAmount	MONEY DEFAULT 0.0,	-- ยอดที่ถูกต้อง OldAmount -DiffAmount-ZeroTaxAmount-ExceptTaxAmount
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * DiffAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * DiffAmount
	ExchangeProfit	MONEY DEFAULT 0.0,  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	BillType	SMALLINT DEFAULT 0, -- 0=ใบส่งของ 1=เอกสารยกมา 2=ตั้งลูกหนี้อื่นๆ
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_INVSTKR_DATE ON BCInvStkRefund(DocDate);
CREATE  INDEX IDX_INVSTKR_AP ON BCInvStkRefund(ApCode);
CREATE  INDEX IDX_INVSTKR_NO ON BCInvStkRefund(StkRefundNo);
CREATE  INDEX IDX_INVSTKR_INV ON BCInvStkRefund(InvoiceNo);
			
create table BCStkRefund
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DueDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	SumOldAmount	MONEY DEFAULT 0.0, -- รวมใบกำกับเดิม (เป็นเงินบาทตาม Rate ใหม่)
	SumTrueAmount	MONEY DEFAULT 0.0, -- รวมยอดที่ถูกต้อง (เป็นเงินบาท)
	SumofDiffAmount	MONEY DEFAULT 0.0, -- รวมผลต่าง เป็นรวมใน 
	DiscountWord VARCHAR(30), -- ส่วนลดรับคืน
	DiscountAmount MONEY DEFAULT 0.0,  -- ส่วนลดรับคืน
	SumofBeforeTax	MONEY DEFAULT 0.0,  -- ยอดก่อนภาษี
	SumOfTaxAmount	MONEY DEFAULT 0.0, -- ยอดภาษี
	SumOfTotalTax	MONEY DEFAULT 0.0,  -- ยอดรวมภาษี
	SumOfExceptTax	MONEY DEFAULT 0.0, -- ยอดยกเว้นภาษี
	SumOfZeroTax MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	NetDebtAmount	MONEY DEFAULT 0.0, -- ยอดสุทธิ SumOfTotalTax + SumOfExceptTax
	SumExchangeProfit	MONEY DEFAULT 0.0,  -- รวมกำไร(ขาดทุน)
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	ReturnMoney	SMALLINT	DEFAULT 0, -- รับคืนเงินสด
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่ตัดยอด 1=ตัดยอดทันที
	StatementState	SMALLINT DEFAULT 0, -- 0=ยังไม่วางบิล 1=วางบิลอยู่
	BillType	SMALLINT DEFAULT 0, -- 0=ส่งคืนสินค้า/ลดหนี้ 1=ลดหนี้อย่างเดียว(ลดหนี้ตาม IR) 2=ส่งคืนอย่างเดียว(ส่งคืนตาม GR)
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย
	CauseCode VARCHAR(10), -- สาเหตุการส่งคืน
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	IsCNDeposit	SMALLINT DEFAULT 0, -- 1= ใบลดหนี้รับเงินมัดจำ
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0,
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0		
    PRIMARY KEY(DocNo)
);
			
CREATE  INDEX IDX_STKR_DATE ON BCStkRefund(DocDate);
CREATE  INDEX IDX_STKR_AP ON BCStkRefund(ApCode);
CREATE  INDEX IDX_STKR_PBS ON BCStkRefund(StatementState);
CREATE  INDEX IDX_STKR_BAL ON BCStkRefund(BillBalance);
CREATE  INDEX IDX_STKR_ROW	ON BCStkRefund(ROWORDER);
CREATE  INDEX IDX_STKRF_1 ON BCStkRefund(DocNo,ApCode);
CREATE  INDEX IDX_STKRF_2 ON BCStkRefund(printcount);

create table BCStkRefundSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 7,
	DocNo	VARCHAR(20),
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	DiscQty	MONEY DEFAULT 0.0,
	TempQty	MONEY DEFAULT 0.0, -- ยอดส่งคืนตามที่ Key ไม่มีผลอะไร
	BillQty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	InvoiceNo	VARCHAR(20),
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	StockProcess SMALLINT DEFAULT 0, -- 0 = Update Stock and cost 1= Update cost only 2= ไม่ Update Stock
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ของสินค้าที่อ้างอิงมาจากเอกสารอื่น
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0,  --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	SumOfCost	MONEY DEFAULT 0.0, --aom 2003-05-22
	SumOfCost2	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	ItemName	VARCHAR(255),
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย	
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STKRSDATE ON BCStkRefundSub(DOCDATE);
CREATE  INDEX IDX_STKRSITEM ON BCStkRefundSub(ItemCode);
CREATE  INDEX IDX_STKRSWH ON BCStkRefundSub(WHCode);
CREATE  INDEX IDX_STKRSSHF ON BCStkRefundSub(ShelfCode);
CREATE  INDEX IDX_STKRSIND ON BCStkRefundSub(BehindIndex);
CREATE  INDEX IDX_STKRSTYPE ON BCStkRefundSub(MyType);
CREATE  INDEX IDX_STKRSTS ON BCStkRefundSub(TransState);
CREATE  INDEX IDX_STKRSAP ON BCStkRefundSub(ApCode);
CREATE  INDEX IDX_STKRS1 ON BCStkRefundSub(ItemCode,WHCode,ShelfCode,LineNumber);
CREATE  INDEX IDX_STKRS2 ON BCStkRefundSub(ItemCode,UnitCode);
CREATE  INDEX IDX_STKRS3 ON BCStkRefundSub(GroupCode);
CREATE  INDEX IDX_STKRS4 ON BCStkRefundSub(CategoryCode);
CREATE  INDEX IDX_STKRS5 ON BCStkRefundSub(BrandCode);
CREATE  INDEX IDX_STKRS6 ON BCStkRefundSub(TypeCode);
CREATE  INDEX IDX_STKRS7 ON BCStkRefundSub(FormatCode);
CREATE  INDEX IDX_STKRS8 ON BCStkRefundSub(DocNo,ApCode);
CREATE  INDEX IDX_STKRS_SERVICE ON BCStkRefundSub(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_STKRSISPROCESS ON BCStkRefundSub(ItemCode,IsProcess);
CREATE  INDEX IDX_STKRSPAK1 ON BCStkRefundSub(PAckingRate1);
CREATE  INDEX IDX_STKRSPAK2 ON BCStkRefundSub(PAckingRate2);
CREATE  INDEX IDX_STKRSISPC ON BCStkRefundSub(IsProcess);
						
create table BCInvDebitNote2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DebitNoteNo	VARCHAR(20), -- เลขที่ใบเพิ่มหนี้
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่เพิ่มทันที 1=เพิ่มทันที
	InvoiceNo	VARCHAR(20),	-- เลขที่ Invoice ที่จะลด
	InvoiceDisc	VARCHAR(40),	-- ส่วนลดเดิม
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	OldAmount MONEY DEFAULT 0.0, -- ยอดเดิม
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	DiscountAmount MONEY DEFAULT 0.0, -- ยอดที่ลด
	DiffAmount	MONEY DEFAULT 0.0,	-- ยอดผลต่าง,ยอดที่จะลด เป็นรวมใน
	ZeroTaxAmount	MONEY DEFAULT 0.0, -- รวมยอดภาษีอัตรา 0
	ExceptTaxAmount	MONEY DEFAULT 0.0, --รวมยอดยกเว้นภาษี
	TrueAmount	MONEY DEFAULT 0.0,	-- ยอดที่ถูกต้อง OldAmount -DiffAmount-ZeroTaxAmount-ExceptTaxAmount
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * DiffAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * DiffAmount
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_INVDB2_DATE ON BCInvDebitNote2(DocDate);
CREATE  INDEX IDX_INVDB2_AP ON BCInvDebitNote2(ApCode);
CREATE  INDEX IDX_INVDB2_NO ON BCInvDebitNote2(DebitNoteNo);
CREATE  INDEX IDX_INVDB2_INV ON BCInvDebitNote2(InvoiceNo);
CREATE  INDEX IDX_INVDB2_1 ON BCInvDebitNote2(InvoiceNo,ApCode);
CREATE  INDEX IDX_INVDB2_2 ON BCInvDebitNote2(DebitNoteNo,ApCode);
CREATE  INDEX IDX_INVDB2_3 ON BCInvDebitNote2(DOcDate,ApCode);
			
create table BCDebitNote2 --ใบเพิ่มหนี้(เจ้าหนี้)
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	SumOfItemAmount MONEY DEFAULT 0.0, -- รวมยอดของรายการสินค้า ตามสินค้าที่คิดภาษี
	SumOldAmount	MONEY DEFAULT 0.0, -- รวมใบกำกับเดิม (เป็นเงินบาทตาม Rate ใหม่)
	SumTrueAmount	MONEY DEFAULT 0.0, -- รวมยอดที่ถูกต้อง (เป็นเงินบาท)
	SumofDiffAmount	MONEY DEFAULT 0.0, -- รวมผลต่าง เป็นรวมใน 
	SumofBeforeTax	MONEY DEFAULT 0.0,  -- ยอดก่อนภาษี
	SumOfTaxAmount	MONEY DEFAULT 0.0, -- ยอดภาษี
	SumOfTotalTax	MONEY DEFAULT 0.0,  -- ยอดรวมภาษี
	SumOfExceptTax	MONEY DEFAULT 0.0, -- ยอดยกเว้นภาษี
	SumOfZeroTax MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	DiscountWord VARCHAR(30), -- ส่วนลด
	DiscountAmount MONEY DEFAULT 0.0,  -- ส่วนลด
	NetDebtAmount	MONEY DEFAULT 0.0, -- ยอดสุทธิ SumOfTotalTax + SumOfExceptTax
	SumExchangeProfit	MONEY DEFAULT 0.0,  -- รวมกำไร(ขาดทุน)
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	ReturnStatus	SMALLINT	DEFAULT 0, -- 0=ไม่เพิ่มทันที 1=เพิ่มทันที
	StatementState	SMALLINT DEFAULT 0, -- 0=ยังไม่วางบิล 1=วางบิลอยู่
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย
	CauseCode VARCHAR(10), -- สาเหตุการเพิ่มหนี้
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayBillAmount MONEY DEFAULT 0.0, -- มูลค่าวางบิล
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0,
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0		
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_DB2_DATE ON BCDebitNote2(DocDate);
CREATE  INDEX IDX_DB2_AP ON BCDebitNote2(ApCode);
CREATE  INDEX IDX_DB2_PBS ON BCDebitNote2(StatementState);
CREATE  INDEX IDX_DB2_BAL ON BCDebitNote2(BillBalance);
CREATE  INDEX IDX_DB2_ROW	ON BCDebitNote2(ROWORDER);
CREATE  INDEX IDX_DB21 ON BCDebitNote2(ApCode,DocNo);
CREATE  INDEX IDX_DB22 ON BCDebitNote2(ApCode,DocDate);
CREATE  INDEX IDX_DB23 ON BCDebitNote2(TaxNo);
CREATE  INDEX IDX_DBPNTC ON BCDebitNote2(printcount);
		
create table BCDebitNoteSub2 -- 
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=ปกติ ใช้เพื่อ Sort ในรายงาน Stock Card คือ DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 3,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocNo	VARCHAR(20),
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	DiscQty	MONEY DEFAULT 0.0,
	TempQty	MONEY DEFAULT 0.0, -- ยอดส่งคืนตามที่ Key ไม่มีผลอะไร
	BillQty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	InvoiceNo	VARCHAR(20),
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	StockProcess SMALLINT DEFAULT 0, -- 0 = Update Stock and cost 1= Update cost only 2= ไม่ Update Stock
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ของสินค้าที่อ้างอิงมาจากเอกสารอื่น
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	FixUnitCost	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	FixUnitQty	MONEY DEFAULT 0.0, --Auto Packing Section by นก
	AVERAGECOST	MONEY DEFAULT 0.0,
	LotNumber	VARCHAR(50), -- Jeab 2003-04-24 Lot กำหนดเอง
	LotExpireDate	DATETIME,-- Jeab 2003-04-26 Lot กำหนดเอง
	LotMyDesc	VARCHAR(255), -- Jeab 2003-04-26 Lot กำหนดเอง
	SumOfCost	MONEY DEFAULT 0.0, --aom 2003-05-22
	SumOfCost2	MONEY DEFAULT 0.0,
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	ItemName	VARCHAR(255),
	CauseType	SMALLINT	DEFAULT 0, -- 0=รับคืนสินค้า  1=ราคาผิด  2=สินค้าแตกเสียหาย	
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_DB2SDATE ON BCDebitNoteSub2(DOCDATE);
CREATE  INDEX IDX_DB2SITEM ON BCDebitNoteSub2(ItemCode);
CREATE  INDEX IDX_DB2SWH ON BCDebitNoteSub2(WHCode);
CREATE  INDEX IDX_DB2SSHF ON BCDebitNoteSub2(ShelfCode);
CREATE  INDEX IDX_DB2SIND ON BCDebitNoteSub2(BehindIndex);
CREATE  INDEX IDX_DB2STYPE ON BCDebitNoteSub2(MyType);
CREATE  INDEX IDX_DB2STS ON BCDebitNoteSub2(TransState);
CREATE  INDEX IDX_DB2SAP ON BCDebitNoteSub2(ApCode);
CREATE  INDEX IDX_DB2S1 ON BCDebitNoteSub2(ItemCode,WHcode,ShelfCode,Linenumber);
CREATE  INDEX IDX_DB2S2 ON BCDebitNoteSub2(ItemCode,UnitCode);
CREATE  INDEX IDX_DB2S3 ON BCDebitNoteSub2(ApCode,DocNo);
CREATE  INDEX IDX_DB2S4 ON BCDebitNoteSub2(ApCode,DocDate);
CREATE  INDEX IDX_DB2SSERVICE ON BCDebitNoteSub2(ItemCode,DocDate,LotNumber,BehindIndex);
CREATE  INDEX IDX_DB2SPAK1 ON BCDebitNoteSub2(PackingRate1);
CREATE  INDEX IDX_DB2SPAK2 ON BCDebitNoteSub2(PackingRate2);
CREATE  INDEX IDX_DB2SISPC ON BCDebitNoteSub2(IsProcess);

create table BCPurchaseOrder
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0, -- รับสินค้าภายใน
	DueDate	DATETIME, -- วันที่ครบกำหนดสินค้า
	LeadTime	SMALLINT DEFAULT 0, -- ระยะเวลาขนส่ง
	LeadDate	DATETIME, -- วันที่รับสินค้า
	ExpireCredit SMALLINT DEFAULT 0, -- หมดอายุภายใน
	ExpireDate DATETIME , -- วันที่หมดอายุ
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	PoStatus	SMALLINT DEFAULT 0, -- 0=ใหม่ 1=Sent 2=รับเต็ม 3=รับบางส่วน 4=ยกเลิก
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยังไม่หมด 1=หมดแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	BillGroup	VARCHAR(15),
	ContactCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsConditionSend SMALLINT DEFAULT 0, -- เงื่อนไขการรับสินค้า 0 = รับเอง, 1 = ส่งให้
	OrderToArCode VARCHAR(20), -- สั่งซื้อให้กับลูกค้า
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	TempDate1	DATETIME, -- Date Temp 1
	TempDate2	DATETIME, -- Date Temp 2
	TempDate3	DATETIME, -- Date Temp 3
	TempDate4	DATETIME, -- Date Temp 4
	TempMyDesc1 VARCHAR(255), -- MyDescription 1
	TempMyDesc2 VARCHAR(255), -- MyDescription 2
	TempMyDesc3 VARCHAR(255), -- MyDescription 3
	TempMyDesc4 VARCHAR(255), -- MyDescription 4
	TempMyDesc5 VARCHAR(255), -- MyDescription 5
	TempMyDesc6 VARCHAR(255), -- MyDescription 6	
	TempMyDesc7 VARCHAR(255), -- MyDescription 7	
	TempMyDesc8 VARCHAR(255), -- MyDescription 8
	TempMyDesc9 VARCHAR(255), -- MyDescription 9
	ApproveCode	VARCHAR(10),--รหัสผู้อนุมัติ
	ApproveDateTime	DATETIME--วันที่อนุม้ติ	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_PO_DATE ON BCPurchaseOrder(DocDate);
CREATE  INDEX IDX_PO_AP ON BCPurchaseOrder(ApCode);
CREATE  INDEX IDX_PO_DUE ON BCPurchaseOrder(DueDate);
CREATE  INDEX IDX_PO_BS ON BCPurchaseOrder(BillStatus);
CREATE  INDEX IDX_PO_ROW ON BCPurchaseOrder(ROWORDER);
CREATE  INDEX IDX_PO1 ON BCPurchaseOrder(DocNo,ApCode);
CREATE  INDEX IDX_PO2 ON BCPurchaseOrder(DocDate,ApCode);
CREATE  INDEX IDX_PO3 ON BCPurchaseOrder(DueDate,ApCode);
CREATE  INDEX IDX_POPNTC ON BCPurchaseOrder(printcount);
	 		
create table BCPurchaseOrderSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	StkReqNo VARCHAR(20),
	ConfirmNo VARCHAR(20),
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	IsPromotion SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0,   --PR Approved line number 
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for bcservice
	BehindIndex	SMALLINT DEFAULT 1, 
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0,
	FactorPrice MONEY DEFAULT 0.0, --Price in factor Unit, แม่ทองสุข
	JobNo VARCHAR(20),
	SORefNo VARCHAR(20),
	SOLineNumber SMALLINT DEFAULT 0,
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_POS_DATE ON BCPurchaseOrderSub(DocDate);
CREATE  INDEX IDX_POS_AP ON BCPurchaseOrderSub(ApCode);
CREATE  INDEX IDX_POS_RQTY	ON BCPurchaseOrderSub(RemainQty);
CREATE  INDEX IDX_POS_TS ON BCPurchaseOrderSub(TransState);
CREATE  INDEX IDX_POS_REF ON BCPurchaseOrderSub(StkReqNo);
CREATE  INDEX IDX_POS1 ON BCPurchaseOrderSub(ItemCode,WhCode,ShelfCode,LineNumber);
CREATE  INDEX IDX_POS2 ON BCPurchaseOrderSub(DocNo,ItemCode);
CREATE  INDEX IDX_POSSERVICE ON BCPurchaseOrderSub(ItemCode,DocDate,BehindIndex);
CREATE  INDEX IDX_POSISPROCESS ON BCPurchaseOrderSub(ItemCode,IsProcess);
CREATE  INDEX IDX_POSPAK1 ON BCPurchaseOrderSub(PackingRate1);
CREATE  INDEX IDX_POSPAK2 ON BCPurchaseOrderSub(PackingRate2);
CREATE  INDEX IDX_POSISPC ON BCPurchaseOrderSub(IsProcess);
CREATE  INDEX IDX_SERV_PURORDSUB ON BCPurchaseOrderSub(ItemCode,ROWORDER,DocNo);

create table BCStkRequest -- ใบขอซื้อสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	DepartCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	WorkMan	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0, --0=ยัง 1=หมด
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	BillGroup	VARCHAR(10),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	ApCode	VARCHAR(20), 
	SaleApproved	VARCHAR(10),
	WorkSite	VARCHAR(255),
	Amount money default 0.0
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_SRQ_DATE ON BCStkRequest(DocDate);
CREATE  INDEX IDX_SRQ_BS ON BCStkRequest(BillStatus);
CREATE  INDEX IDX_SRQ_ROW	ON BCStkRequest(ROWORDER);
CREATE  INDEX IDX_SRQ1	ON BCStkRequest(Docdate,DocNo);
CREATE  INDEX IDX_SRQPNTC	ON BCStkRequest(printcount);
 		

create table BCStkRequestSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ApCode	VARCHAR(20), 
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือที่ยังไม่อนุมัติ
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	Priority SMALLINT DEFAULT 0, -- 0=ปกติ 1=ด่วนมาก
	WantDay SMALLINT DEFAULT 0, -- ต้องการสินค้าภายในกี่วัน
	WantDate DATETIME, --ลงวันที่ที่ต้องการ
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	LineNumber SMALLINT DEFAULT 0,
	BarCode	VARCHAR(20),
	ItemName	VARCHAR(255), ------- Jeab 2003-05-08------
	Colorcode VARCHAR(10),
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 SMALLMONEY DEFAULT 0.0,
	PackingRate2 SMALLMONEY DEFAULT 0.0,
	BehindIndex	SMALLINT DEFAULT 1,
	Price money default 0.0,
	Amount money default 0.0,
	JobNo VARCHAR(20)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_SRQS_DATE ON BCStkRequestSub(DocDate);
CREATE  INDEX IDX_SRQS_DOC ON BCStkRequestSub(DocNo);
CREATE  INDEX IDX_SRQS_RQTY	ON BCStkRequestSub(RemainQty);
CREATE  INDEX IDX_SRQS1	ON BCStkRequestSub(ItemCode,UnitCode,LineNumber);
CREATE  INDEX IDX_SRQS2	ON BCStkRequestSub(LineNumber);
CREATE  INDEX IDX_SRQS3	ON BCStkRequestSub(BarCode);
CREATE  INDEX IDX_SRQS4	ON BCStkRequestSub(DocNo,DocDate);
CREATE  INDEX IDX_SRQSPAK1 ON BCStkRequestSub(PackingRate1);
CREATE  INDEX IDX_SRQSPAK2 ON BCStkRequestSub(PackingRate2);

create table BCReqConfirm -- ใบอนุมัติซื้อสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ConfirmName	VARCHAR(255),
	MyDescription	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0, -- 0=ปกติ 1=หมด
	IsCancel	SMALLINT DEFAULT 0,
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	Amount money default 0.0,
	IsExport smallint default 0,
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DocNo)
);
CREATE  INDEX IDX_REQC1	ON BCReqConfirm(DocNo,DocDate);
CREATE  INDEX IDX_REQC2	ON BCReqConfirm(DocDate);

create table BCReqConfirmSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ItemCode	VARCHAR(25),
	ItemName	VARCHAR(255),
	StkRequestNo	VARCHAR(20), -- เลขที่ใบเสนอซื้อ
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	Qty	MONEY DEFAULT 0.0, -- ยอดที่ขอ
	ConfirmQty	MONEY DEFAULT 0.0, -- ยอดที่อนุมัติ
	RemainQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือสั่งซื้อ
	UnitCode	VARCHAR(10),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- อ้างใบเสนอซื้อ
	BarCode	VARCHAR(20),
	Colorcode VARCHAR(10),
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),	
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 SMALLMONEY DEFAULT 0.0,
	PackingRate2 SMALLMONEY DEFAULT 0.0,
	BehindIndex	SMALLINT DEFAULT 1,
	Price money default 0.0,
	Amount money default 0.0,
	ApCode	VARCHAR(20),
	requestCode VARCHAR(10),
	JobNo VARCHAR(20)
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_REQCS1	ON BCReqConfirmSub(DocNo,DocDate);
CREATE  INDEX IDX_REQCS2	ON BCReqConfirmSub(DocNo);
CREATE  INDEX IDX_REQCS3	ON BCReqConfirmSub(ItemCode);
CREATE  INDEX IDX_REQCS4	ON BCReqConfirmSub(DocNo,ItemCode);
CREATE  INDEX IDX_REQCS5	ON BCReqConfirmSub(DocNo,LineNumber);
CREATE  INDEX IDX_REQCS6	ON BCReqConfirmSub(LineNumber);
CREATE  INDEX IDX_REQCSPAK1	ON BCReqConfirmSub(PackingRate1);
CREATE  INDEX IDX_REQCSPAK2	ON BCReqConfirmSub(PackingRate2);

create table BCEnquirePrice -- ใบสืบราคารวม
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	DocNo	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ReqConfirmNo VARCHAR(20) ,
	BillStatus	SMALLINT DEFAULT 0, -- 0=ปกติ 1=หมด
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	PrintCount SMALLINT DEFAULT 0 -- Count Print form -- A-20030923
	
    PRIMARY KEY(DocNo)
);
CREATE  INDEX IDX_EQP1	ON BCEnquirePrice(DocDate);


create table BCEnquirePriceSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	StkRequestNo	VARCHAR(20), -- เลขที่ใบเสนอซื้อ
	DepartCode	VARCHAR(10),
	SupplierCode VARCHAR(20), -- รหัส Supplier ตามที่ตั้งไว้ใน BCITEM Master
	ItemCode	VARCHAR(25),
	MyDescription	VARCHAR(255),
	Qty	MONEY DEFAULT 0.0, -- ยอดที่จะสืบราคา
	UnitCode	VARCHAR(10),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	ItemType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	LineNumber SMALLINT DEFAULT 0,
	BarCode	VARCHAR(20),
--for bcservice
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 SMALLMONEY DEFAULT 0.0,
	PackingRate2 SMALLMONEY DEFAULT 0.0,
	BehindIndex	SMALLINT DEFAULT 1
    PRIMARY KEY(ROWORDER)
);

create table BCAPDeposit
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	TaxNo	VARCHAR(20),
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	BillBalance	MONEY DEFAULT 0.0, -- ถ้าเป็นรวมใน=NetAmount ถ้าเป็นแยกนอก=NetAmount ถอด Tax
	RefNo	VARCHAR(20),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsReturnMoney SMALLINT DEFAULT 0, -- 1=ลดหนี้หรือคืนเงิน
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME		
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_APDEP_DATE ON BCAPDeposit(DocDate);
CREATE  INDEX IDX_APDEP_AP ON BCAPDeposit(ApCode);
CREATE  INDEX IDX_APDEP_BAL ON BCAPDeposit(BillBalance);
CREATE  INDEX IDX_APDEP_PNTC ON BCAPDeposit(printcount);

create table BCStatement
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยัง 1=หมด
	CreditDay	SMALLINT DEFAULT 0,
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	DueDate	DATETIME,
	IsConfirm	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME,
	IsCancel  SMALLINT DEFAULT 0, --jum
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0	
PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_STM_DATE ON BCStatement(DocDate);
CREATE  INDEX IDX_STM_AP ON BCStatement(ApCode);
CREATE  INDEX IDX_STM_BS ON BCStatement(BillStatus);
			
create table BCStatementSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	PayBalance MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BillType	SMALLINT,
	HomeAmount MONEY DEFAULT 0.0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_STMS_NO ON BCStatementSub(DocNo);
CREATE  INDEX IDX_STMS_DATE ON BCStatementSub(DocDate);
CREATE  INDEX IDX_STMS_AP ON BCStatementSub(ApCode);
CREATE  INDEX IDX_STMS_PBAL ON BCStatementSub(PayBalance);
CREATE  INDEX IDX_STMS_INVN ON BCStatementSub(InvoiceNo);
			
create table BCPayment --ใบจ่ายชำระหนี้
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	SumHomeAmount1 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount1 In Sub) rate เดิม ตัดเจ้าหนี้
	SumHomeAmount2 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub) rate ใหม่
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsConfirm	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	SumOfDeposit1	MONEY DEFAULT 0.0, -- Jeab 20030530 สำหรับตัดยอดของบิล
	SumOfDeposit2	MONEY DEFAULT 0.0, -- Jeab 20030530 สำหรับ post GL 
	HomeAmountInv	MONEY DEFAULT 0.0,
	HomeAmountDebt	MONEY DEFAULT 0.0,
	HomeAmountCrd	MONEY DEFAULT 0.0,
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	SumOfEarnest MONEY DEFAULT 0.0, -- ยอดเงินล่วงหน้า
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_PYM_DATE ON BCPayment(DocDate);
CREATE  INDEX IDX_PYM_AP ON BCPayment(ApCode);
CREATE  INDEX IDX_PYM_PNTC ON BCPayment(printcount);
			
create table BCPaymentSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0, 
	PaybillNo	VARCHAR(20),
	RefType	SMALLINT DEFAULT 0, -- 0=ใบรับวางบิล 1=ใบเตรียมจ่ายค่าสินค้าว	
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PYMS_NO ON BCPaymentSub(DocNo);
CREATE  INDEX IDX_PYMS_DATE ON BCPaymentSub(DocDate);
CREATE  INDEX IDX_PYMS_AP ON BCPaymentSub(ApCode);
CREATE  INDEX IDX_PYMS_TS ON BCPaymentSub(TransState);
CREATE  INDEX IDX_PYMS_INVNO ON BCPaymentSub(InvoiceNo);


create table BCPaySubTemp
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	PaybillNo	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PYMSTEMP_NO ON BCPaySubTemp(DocNo);

create table BCPayment2 --บันทึกตัดยอดเจ้าหนี้สูญ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	SumHomeAmount1 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount1 In Sub) rate เดิม ตัดเจ้าหนี้
	SumHomeAmount2 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub) rate ใหม่
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsConfirm	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923 
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_PYM2_DATE ON BCPayment2(DocDate);
CREATE  INDEX IDX_PYM2_AP ON BCPayment2(ApCode);
CREATE  INDEX IDX_PYM2_PNTC ON BCPayment2(printcount);
			
create table BCPaymentSub2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	InvoiceDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	PaybillNo	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PYMS2_NO ON BCPaymentSub2(DocNo);
CREATE  INDEX IDX_PYMS2_DATE ON BCPaymentSub2(DocDate);
CREATE  INDEX IDX_PYMS2_AP ON BCPaymentSub2(ApCode);
CREATE  INDEX IDX_PYMS2_TS ON BCPaymentSub2(TransState);
CREATE  INDEX IDX_PYMS2_INVNO ON BCPaymentSub2(InvoiceNo);

create table BCChqIn
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
	BankCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ChqNumber	VARCHAR(20),
	DocNo	VARCHAR(20),
	ArCode	VARCHAR(20),
	ExtendStatus	VARCHAR(10),	--รหัสสถานะเพิ่มเติม
	SaleCode	VARCHAR(10),
	ReceiveDate	DATETIME,
	DueDate	DATETIME,
	BookNo	VARCHAR(30),
	Status	SMALLINT DEFAULT 0,
	SaveFrom	SMALLINT DEFAULT 0,
	StatusDate	DATETIME,
	StatusDocNo	VARCHAR(20),
	DepartCode	VARCHAR(10),
	BankBranchCode	VARCHAR(10),
	Amount	MONEY DEFAULT 0.0,
	Balance 	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	ChqUseStatus SMALLINT DEFAULT 0, -- 0=ปกติ 1=ตัดหลายใบเสร็จ
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	RECIVECHQBY	varchar(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	RECIVECONFIRM	smallint,
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHQI_BANK ON BCChqIn(BankCode);
CREATE  INDEX IDX_CHQI_NO ON BCChqIn(ChqNumber);
CREATE  INDEX IDX_CHQI_DNO ON BCChqIn(DocNo);
CREATE  INDEX IDX_CHQI_AR ON BCChqIn(ArCode);
CREATE  INDEX IDX_CHQI_SALE ON BCChqIn(SaleCode);
CREATE  INDEX IDX_CHQI_RED ON BCChqIn(ReceiveDate);
CREATE  INDEX IDX_CHQI_DUE ON BCChqIn(DueDate);
CREATE  INDEX IDX_CHQI_BNO ON BCChqIn(BookNo);
CREATE  INDEX IDX_CHQI_ST ON BCChqIn(Status);
			
create table BCChqOut
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BankCode	VARCHAR(10),
	ChqNumber	VARCHAR(20),
	DocNo	VARCHAR(20),
    isexport smallint default 0,   
    creatorcode varchar(30),
    createdatetime datetime,
    lasteditorcode varchar(30),
    lasteditdatet datetime,
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,	
	ApCode	VARCHAR(20),
	ExtendStatus	VARCHAR(10),	--รหัสสถานะเพิ่มเติม	
	PaymentDate	DATETIME,
	DueDate	DATETIME,
	BookNo	VARCHAR(30),
	Status	SMALLINT DEFAULT 0,
	SaveFrom	SMALLINT DEFAULT 0,
	StatusDate	DATETIME,
	StatusDocNo	VARCHAR(20),
	DepartCode	VARCHAR(10),
	BankBranchCode	VARCHAR(10),
	Amount	MONEY DEFAULT 0.0,
	Balance 	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	ChqUseStatus SMALLINT DEFAULT 0, -- 0=ปกติ 1=ตัดหลายใบเสร็จ
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	AutoDocNo varchar(20),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_CHQO_BANK ON BCChqOut(BankCode);
CREATE  INDEX IDX_CHQO_NO ON BCChqOut(ChqNumber);
CREATE  INDEX IDX_CHQO_DNO ON BCChqOut(DocNo);
CREATE  INDEX IDX_CHQO_AP ON BCChqOut(ApCode);
CREATE  INDEX IDX_CHQO_PYD ON BCChqOut(PaymentDate);
CREATE  INDEX IDX_CHQO_DUE ON BCChqOut(DueDate);
CREATE  INDEX IDX_CHQO_BNO ON BCChqOut(BookNo);
CREATE  INDEX IDX_CHQO_ST ON BCChqOut(Status);

create table BCCreditCard
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
	BankCode	VARCHAR(10),
	CreditCardNo	VARCHAR(20),
	DocNo	VARCHAR(20),
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ReceiveDate	DATETIME,
	DueDate	DATETIME,
	BookNo	VARCHAR(30),
	Status	SMALLINT DEFAULT 0,
	SaveFrom	SMALLINT DEFAULT 0,
	StatusDate	DATETIME,
	StatusDocNo	VARCHAR(20),
	DepartCode	VARCHAR(10),
	BankBranchCode	VARCHAR(10),
	Amount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	CreditType	VARCHAR(10),
	ConfirmNo	VARCHAR(20),
	ChargeAmount MONEY DEFAULT 0.0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	CreditVatRate	MONEY DEFAULT 0.0, -- อัตราภาษีที่คิดค่า ชาร์ดบัตรเครดิต
	CreditVat	MONEY DEFAULT 0.0, -- ภาษีที่ได้จากการคิดค่า ชาร์ดบัตรเครดิต
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CreditSumVat	MONEY DEFAULT 0.0,-- มูลค่ารวมค่าชาร์ดบัตรเครดิต
	------------------------- POS ---------------
	POSDOCNO VARCHAR(25),
	EDCBatchNo  VARCHAR(6) ,  -- Batch no 
	EDCCardHolder VARCHAR(22) ,  -- Credit card Holder Name
	EDCCardExpr  VARCHAR(4), -- Creditcard Expire
	EDCTID	VARCHAR(8),   -- Terminal ID  (รหัสเครื่อง รูด)
	EDCSystemTrc  VARCHAR(6) , -- System trace
	EDCNII	VARCHAR(4),   -- System Reference Code
	EDCNetAmount MONEY DEFAULT 0.0
	------------------------- POS ---------------
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CRD_BANK ON BCCreditCard(BankCode);
CREATE  INDEX IDX_CRD_NO ON BCCreditCard(CreditCardNo);
CREATE  INDEX IDX_CRD_DNO ON BCCreditCard(DocNo);
CREATE  INDEX IDX_CRD_AR ON BCCreditCard(ArCode);
CREATE  INDEX IDX_CRD_SALE ON BCCreditCard(SaleCode);
CREATE  INDEX IDX_CRD_RED ON BCCreditCard(ReceiveDate);
CREATE  INDEX IDX_CRD_DUE ON BCCreditCard(DueDate);
CREATE  INDEX IDX_CRD_BNO ON BCCreditCard(BookNo);
CREATE  INDEX IDX_CRD_ST ON BCCreditCard(Status);

create table BCOtherIncome
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	GLBookCode	VARCHAR(5),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumofDebit	MONEY DEFAULT 0.0,
	SumofCredit	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	ArCode	VARCHAR(20),
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	BillGroup	VARCHAR(10),
	IsConfirm	 SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_OTHI_DATE ON BCOtherIncome(DocDate);
CREATE  INDEX IDX_OTHI_AR ON BCOtherIncome(ArCode);
			
create table BCOtherExpense2 -- เงินทดลองจ่าย
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumofAmount	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	ApCode	VARCHAR(20),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	GLTransData	SMALLINT DEFAULT 0, -- 0=auto 1=manual
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	PersonCode VARCHAR(10), -- รหัสพนักงานผู้เบิก
	BillStatus SMALLINT DEFAULT 0, -- 0=ยังไม่เคลียร์เงินทดลองจ่าย
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_OTHE2_DATE ON BCOtherExpense2(DocDate);
CREATE  INDEX IDX_OTHE2_AP ON BCOtherExpense2(ApCode);

create table BCOtherExpSub2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	Amount	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	ApCode	VARCHAR(20)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_OTHES2_DATE ON BCOtherExpSub2(DocDate);
CREATE  INDEX IDX_OTHES2_AP ON BCOtherExpSub2(ApCode);

create table BCOtherExpense
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	RefDocNo VARCHAR(20), -- เลขที่ใบทดลองจ่าย
	GLBookCode	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	DepartCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	SumofDebit	MONEY DEFAULT 0.0,
	SumofCredit	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	ApCode	VARCHAR(20),
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	BillGroup	VARCHAR(10),
	IsConfirm	 SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CancelDateTime	DATETIME,
	--สำหรับภาษีซื้อเฉลี่ย
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0	
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_OTHE_DATE ON BCOtherExpense(DocDate);
CREATE  INDEX IDX_OTHE_AP ON BCOtherExpense(ApCode);

create table BCBankTransfer
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	FromBook	VARCHAR(30),
	ToBook	VARCHAR(30),
	GLBookCode	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	DepartCode	VARCHAR(10),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),	
	MyDescription	VARCHAR(255),
	Amount	MONEY DEFAULT 0.0,
	ChargeAmount	MONEY DEFAULT 0.0, -- ค่าธรรมเนียมอื่นๆ
	TotalAmount MONEY DEFAULT 0.0, 
	RecurName	VARCHAR(40),
	IsConfirm	 SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_BNTF_DATE ON BCBankTransfer(DocDate);
CREATE  INDEX IDX_BNTF_FB ON BCBankTransfer(FromBook);
CREATE  INDEX IDX_BNTF_TB ON BCBankTransfer(ToBook);

create table BCCashBankIn
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	AccountCode VARCHAR(20),
	GLBookCode	VARCHAR(5),
	IsBankBalance SMALLINT DEFAULT 0, -- บันทึกยอดเงินยกมา
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	DepartCode VARCHAR(10),
	MyDescription VARCHAR(255),
	Amount MONEY DEFAULT 0.0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsConfirm	 SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CSHBI_DATE ON BCCashBankIn(DocDate);
CREATE  INDEX IDX_CSHBI_BNO ON BCCashBankIn(BookNo);

create table BCCashBankOut
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BookNo	VARCHAR(30),
	AccountCode VARCHAR(20),
	GLBookCode	VARCHAR(5),
	IsBankBalance SMALLINT DEFAULT 0, -- บันทึกยอดเงินยกมา
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	DepartCode VARCHAR(10),
	MyDescription VARCHAR(255),
	Amount MONEY,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsConfirm	 SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CSHBO_DATE ON BCCashBankOut(DocDate);
CREATE  INDEX IDX_CSHBO_BNO ON BCCashBankOut(BookNo);

create table BCBankExpense
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AccountCode VARCHAR(20),
	GLBookCode	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	DepartCode VARCHAR(10),
	MyDescription VARCHAR(255),
	Amount MONEY,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_BNKE_DATE ON BCBankExpense(DocDate);
CREATE  INDEX IDX_BNKE_BNO ON BCBankExpense(BookNo);

create table BCBankIncome
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AccountCode VARCHAR(20),
	GLBookCode	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	DepartCode VARCHAR(10),
	MyDescription VARCHAR(255),
	Amount MONEY,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsConfirm	 SMALLINT DEFAULT 0,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	RecurName	VARCHAR(40)
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_BNKI_DATE ON BCBankIncome(DocDate);
CREATE  INDEX IDX_BNKI_BNO ON BCBankIncome(BookNo);

create table BCChqInDeposit -- เช็คฝาก
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    isexport smallint default 0,   
    creatorcode varchar(30),
    createdatetime datetime,
    lasteditorcode varchar(30),
    lasteditdatet datetime,
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,	
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	RecurName	VARCHAR(40),
	PrintCount SMALLINT DEFAULT 0 -- Count Print form -- A-20030923
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHID_DATE ON BCChqInDeposit(DocDate);
CREATE  INDEX IDX_CHID_BNO ON BCChqInDeposit(BookNo);

create table BCChqInDeposSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	ChqRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	OrgChqStatus SMALLINT DEFAULT 0,
	Arcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHIDS_NO ON BCChqInDeposSub(DocNo);
CREATE  INDEX IDX_CHIDS_DATE ON BCChqInDeposSub(DocDate);
CREATE  INDEX IDX_CHIDS_BNO ON BCChqInDeposSub(BookNo);
CREATE  INDEX IDX_CHIDS_CNO ON BCChqInDeposSub(ChqNumber);
CREATE  INDEX IDX_CHIDS_TS ON BCChqInDeposSub(TransState);

create table BCChqInDeposit2 -- เช็คนำเข้าธนาคารอีกครั้ง
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHIDPS_DATE ON BCChqInDeposit2(DocDate);
CREATE  INDEX IDX_CHIDPS_BNO ON BCChqInDeposit2(BookNo);

create table BCChqInDepo2Sub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ChqRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	Arcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHID2S_NO ON BCChqInDepo2Sub(DocNo);
CREATE  INDEX IDX_CHID2S_DATE ON BCChqInDepo2Sub(DocDate);
CREATE  INDEX IDX_CHID2S_BNO ON BCChqInDepo2Sub(BookNo);
CREATE  INDEX IDX_CHID2S_CNO ON BCChqInDepo2Sub(ChqNumber);
CREATE  INDEX IDX_CHID2S_TS ON BCChqInDepo2Sub(TransState);

create table BCChqInPass
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0, -- ยอดเงินบาท
	SumExpend	MONEY DEFAULT 0.0,  -- ยอดเงินบาท
	NetAmount	MONEY DEFAULT 0.0,  -- Sum HomeAmount ยอดเงินบาท
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHIP_DATE ON BCChqInPass(DocDate);
CREATE  INDEX IDX_CHIP_BNO ON BCChqInPass(BookNo);

create table BCChqInPassSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ChqRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0, -- เป็นเงินบาท
	NetAmount	MONEY DEFAULT 0.0, -- เป็นเงินบาท HomeAmount - Expend
	CurrencyCode	VARCHAR(10), 
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	OrgChqStatus SMALLINT DEFAULT 0,
	Arcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHIPS_NO ON BCChqInPassSub(DocNo);
CREATE  INDEX IDX_CHIPS_DATE ON BCChqInPassSub(DocDate);
CREATE  INDEX IDX_CHIPS_BNO ON BCChqInPassSub(BookNo);
CREATE  INDEX IDX_CHIPS_CNO ON BCChqInPassSub(ChqNumber);
CREATE  INDEX IDX_CHIPS_TS ON BCChqInPassSub(TransState);

create table BCChqInCancel
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	CancelStatus SMALLINT DEFAULT 0, -- 0 = ยกเลิกจากเช็คในมือ 1= ยอกเลิกจากเช็คผ่าน
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHIC_DATE ON BCChqInCancel(DocDate);
CREATE  INDEX IDX_CHIC_BNO ON BCChqInCancel(BookNo);

create table BCChqInCancelSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BookNo	VARCHAR(30),
	ChqRowOrder	INT,
	CancelStatus SMALLINT DEFAULT 0, -- 0 = ยกเลิกจากเช็คในมือ 1= ยอกเลิกจากเช็คผ่าน
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	Arcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHICS_NO ON BCChqInCancelSub(DocNo);
CREATE  INDEX IDX_CHICS_DATE ON BCChqInCancelSub(DocDate);
CREATE  INDEX IDX_CHICS_BNO ON BCChqInCancelSub(BookNo);
CREATE  INDEX IDX_CHICS_CNO ON BCChqInCancelSub(ChqNumber);
CREATE  INDEX IDX_CHICS_TS ON BCChqInCancelSub(TransState);

create table BCChqInReturn -- เช็คคืน
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHIR_DATE ON BCChqInReturn(DocDate);
CREATE  INDEX IDX_CHIR_BNO ON BCChqInReturn(BookNo);

create table BCChqInRetSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	ChqRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	Arcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHIRS_NO ON BCChqInRetSub(DocNo);
CREATE  INDEX IDX_CHIRS_DATE ON BCChqInRetSub(DocDate);
CREATE  INDEX IDX_CHIRS_BNO ON BCChqInRetSub(BookNo);
CREATE  INDEX IDX_CHIRS_CNO ON BCChqInRetSub(ChqNumber);
CREATE  INDEX IDX_CHIRS_TS ON BCChqInRetSub(TransState);

create table BCChqInSale
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHIS_DATE ON BCChqInSale(DocDate);
CREATE  INDEX IDX_CHIS_BNO ON BCChqInSale(BookNo);

create table BCChqInSaleSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ChqRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	Arcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHISS_NO ON BCChqInSaleSub(DocNo);
CREATE  INDEX IDX_CHISS_DATE ON BCChqInSaleSub(DocDate);
CREATE  INDEX IDX_CHISS_BNO ON BCChqInSaleSub(BookNo);
CREATE  INDEX IDX_CHISS_CNO ON BCChqInSaleSub(ChqNumber);
CREATE  INDEX IDX_CHISS_TS ON BCChqInSaleSub(TransState);

create table BCChqOutPass
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    isexport smallint default 0,   
    creatorcode varchar(30),
    createdatetime datetime,
    lasteditorcode varchar(30),
    lasteditdatet datetime,
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,		
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	RecurName	VARCHAR(40),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHOP_DATE ON BCChqOutPass(DocDate);
CREATE  INDEX IDX_CHOP_BNO ON BCChqOutPass(BookNo);

create table BCChqOutPassSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	ChqRowOrder	INT,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	APcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHOPS_NO ON BCChqOutPassSub(DocNo);
CREATE  INDEX IDX_CHOPS_DATE ON BCChqOutPassSub(DocDate);
CREATE  INDEX IDX_CHOPS_BNO ON BCChqOutPassSub(BookNo);
CREATE  INDEX IDX_CHOPS_CNO ON BCChqOutPassSub(ChqNumber);
CREATE  INDEX IDX_CHOPS_TS ON BCChqOutPassSub(TransState);

create table BCChqOutCancel
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	CancelStatus SMALLINT DEFAULT 0, -- 0 = ยกเลิกจากเช็คในมือ 1= ยกเลิกจากเช็คผ่าน
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumChqAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CHOC_DATE ON BCChqOutCancel(DocDate);
CREATE  INDEX IDX_CHOC_BNO ON BCChqOutCancel(BookNo);

create table BCChqOutCancelSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ChqRowOrder	INT,
	CancelStatus SMALLINT DEFAULT 0, -- 0 = ยกเลิกจากเช็คในมือ 1= ยอกเลิกจากเช็คผ่าน
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ChqNumber	VARCHAR(20),
	ChqAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	APcode varchar(20),
	Bankcode varchar(10),
	BankBranchCode	VARCHAR(10),
	RefChqRowOrder INT
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CHOCS_NO ON BCChqOutCancelSub(DocNo);
CREATE  INDEX IDX_CHOCS_DATE ON BCChqOutCancelSub(DocDate);
CREATE  INDEX IDX_CHOCS_BNO ON BCChqOutCancelSub(BookNo);
CREATE  INDEX IDX_CHOCS_CNO ON BCChqOutCancelSub(ChqNumber);
CREATE  INDEX IDX_CHOCS_TS ON BCChqOutCancelSub(TransState);

create table BCCreditPass
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumCreditAmount	MONEY DEFAULT 0.0,
	TaxRate	MONEY DEFAULT 7.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CRP_DATE ON BCCreditPass(DocDate);
CREATE  INDEX IDX_CRP_BNO ON BCCreditPass(BookNo);

create table BCCreditPassSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	CreditRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	CreditNumber	VARCHAR(20),
	CreditAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0 -- NetAmount * ExchangeRate	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CCRPS_NO ON BCCreditPassSub(DocNo);
CREATE  INDEX IDX_CCRPS_DATE ON BCCreditPassSub(DocDate);
CREATE  INDEX IDX_CCRPS_BNO ON BCCreditPassSub(BookNo);
CREATE  INDEX IDX_CCRPS_CNO ON BCCreditPassSub(CreditNumber);
CREATE  INDEX IDX_CCRPS_TS ON BCCreditPassSub(TransState);

create table BCCreditCancel
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	MyDescription	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BookNo	VARCHAR(30),
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumExpend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	IsConfirm	 SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DOCNO)
);

CREATE  INDEX IDX_CRC_DATE ON BCCreditCancel(DocDate);
CREATE  INDEX IDX_CRC_BNO ON BCCreditCancel(BookNo);

create table BCCreditCancelSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	BookNo	VARCHAR(30),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CreditRowOrder	INT,
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	CreditNumber	VARCHAR(20),
	CreditAmount	MONEY DEFAULT 0.0,
	Expend	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	HomeAmount MONEY DEFAULT 0.0 -- NetAmount * ExchangeRate
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CCRCS_NO ON BCCreditCancelSub(DocNo);
CREATE  INDEX IDX_CCRCS_DATE ON BCCreditCancelSub(DocDate);
CREATE  INDEX IDX_CCRCS_BNO ON BCCreditCancelSub(BookNo);
CREATE  INDEX IDX_CCRCS_CNO ON BCCreditCancelSub(CreditNumber);
CREATE  INDEX IDX_CCRCS_TS ON BCCreditCancelSub(TransState);

create table BCPettyCash
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Amount	MONEY DEFAULT 0.0,
	BeginAmount	MONEY DEFAULT 0.0,
	Balance	MONEY DEFAULT 0.0
    PRIMARY KEY(Code)
);

create table BCOutputTax
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	SaveFrom	SMALLINT DEFAULT 0,
	DocNo	VARCHAR(20),
	BookCode	VARCHAR(15),
	Source		 SMALLINT DEFAULT 0,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxDate	DATETIME,
	TaxNo	VARCHAR(20),
	ArCode	VARCHAR(20),
	ShortTaxDesc	VARCHAR(255),
	TaxRate	MONEY DEFAULT 7.0,
	Process	SMALLINT DEFAULT 0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	IsMultiCurrency SMALLINT DEFAULT 0, -- 1=มาจากบิลที่เป็น ExchangeRate
	FAmount 	MONEY DEFAULT 0.0, -- ยอดเงินตามสกุลเงิน
	ExChangeRate DECIMAL(19,10) DEFAULT 1.0, -- อัตราแลกเปลี่ยน
	TaxGroup	VARCHAR(10),	
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	IsCancel SMALLINT DEFAULT 0,
	CancelOutPeriod SMALLINT DEFAULT 0, -- 1= ยกเลิกข้ามงวด
	CancelDocNo VARCHAR(20), -- GL cancel document
	CancelDocDate DATETIME,--GL cancel date
	IsPos SMALLINT DEFAULT 0 -- 0=ทั่วไป 1=POS อย่าเต็ม 2=POS อย่างย่อแบบสรุป Key เอง
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_OPT_BOOK ON BCOutputTax(BookCode);
CREATE  INDEX IDX_OPT_Source ON BCOutputTax(Source);
CREATE  INDEX IDX_OPT_DATE ON BCOutputTax(DocDate);
CREATE  INDEX IDX_OPT_DNO ON BCOutputTax(DocNo);
CREATE  INDEX IDX_OPT_TDATE ON BCOutputTax(TaxDate);
CREATE  INDEX IDX_OPT_TNO ON BCOutputTax(TaxNo);
			
create table BCInputTax
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	SaveFrom	SMALLINT DEFAULT 0,
	DocNo	VARCHAR(20),
	BookCode	VARCHAR(15),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Source		 SMALLINT DEFAULT 0,
	DocDate	DATETIME,
	TaxDate	DATETIME,
	TaxDate2	DATETIME, -- วันที่ยื่นภาษี
	TaxNo	VARCHAR(20),
	ApCode	VARCHAR(20),
	ShortTaxDesc	VARCHAR(255),
	TaxRate	MONEY DEFAULT 7.0,
	Process	SMALLINT DEFAULT 0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	IsMultiCurrency SMALLINT DEFAULT 0, -- 1=มาจากบิลที่เป็น ExchangeRate
	FAmount 	MONEY DEFAULT 0.0, -- ยอดเงินตามสกุลเงิน
	ExChangeRate DECIMAL(19,10) DEFAULT 1.0, -- อัตราแลกเปลี่ยน
	ReturnTax smallint default 0, -- 0=ขอคืนได้ 1=ขอคืนไม่ได้
	TaxGroup	VARCHAR(10),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	CancelOutPeriod SMALLINT DEFAULT 0, -- 1= ยกเลิกข้ามงวด
	CancelDocNo VARCHAR(20), -- GL cancel document
	CancelDocDate DATETIME,--GL cancel date
	IsCancel SMALLINT DEFAULT 0,
	AvgTaxRate money default 0.0,
	AvgTaxAmount money default 0.0	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_IPT_BOOK ON BCInputTax(BookCode);
CREATE  INDEX IDX_IPT_Source ON BCInputTax(Source);
CREATE  INDEX IDX_IPT_DATE ON BCInputTax(DocDate);
CREATE  INDEX IDX_IPT_DNO ON BCInputTax(DocNo);
CREATE  INDEX IDX_IPT_TDATE ON BCInputTax(TaxDate);
CREATE  INDEX IDX_IPT_TNO ON BCInputTax(TaxNo);

create table BCARWTaxList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BaseOfTax	MONEY DEFAULT 0.0,
	WTaxRate	MONEY DEFAULT 0.0,
	WTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	ShortDesc	VARCHAR(255),
	TaxGroup VARCHAR(10),
	SaveFrom SMALLINT DEFAULT 0,
	OrderDocNo SMALLINT DEFAULT 0,
	Paydate	DATETIME,
	BookNo VARCHAR(30),
	MyType SMALLINT DEFAULT 0 -- 0 = AR, 1 = AP
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ARWL_DNO ON BCARWTaxList(DocNo);
CREATE  INDEX IDX_ARWL_DATE ON BCARWTaxList(DocDate);
CREATE  INDEX IDX_ARWL_AR ON BCARWTaxList(ArCode);
CREATE  INDEX IDX_ARWL_SF ON BCARWTaxList(SaveFrom);

create table BCARWTaxCashList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode VARCHAR(20),
	BaseOfTax	MONEY DEFAULT 0.0,
	WTaxRate	MONEY DEFAULT 0.0,
	WTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	ShortDesc	VARCHAR(255),
	TaxGroup VARCHAR(10),
	SaveFrom SMALLINT DEFAULT 0,
	OrderDocNo SMALLINT DEFAULT 0,
	PayDate	DATETIME,
	BookNo VARCHAR(30),
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ARWC_DNO ON BCARWTaxCashList(DocNo);
CREATE  INDEX IDX_ARWC_DATE ON BCARWTaxCashList(DocDate);
CREATE  INDEX IDX_ARWC_AR ON BCARWTaxCashList(ArCode);
CREATE  INDEX IDX_ARWC_SF ON BCARWTaxCashList(SaveFrom);

create table BCAPWTaxList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode VARCHAR(20),
	BaseOfTax	MONEY DEFAULT 0.0,
	WTaxRate	MONEY DEFAULT 0.0,
	WTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	ShortDesc	VARCHAR(255),
	TaxGroup VARCHAR(10),
	SaveFrom SMALLINT DEFAULT 0,
	Paydate	DATETIME,
	BookNo VARCHAR(30),
	ReceiptNo VARCHAR(20),-- เลขที่ใบเสร็จที่ยื่น
	MyType SMALLINT DEFAULT 0, -- 0 = AP, 1 = AR
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_APWL_DNO ON BCAPWTaxList(DocNo);
CREATE  INDEX IDX_APWL_DATE ON BCAPWTaxList(DocDate);
CREATE  INDEX IDX_APWL_AP ON BCAPWTaxList(ApCode);
CREATE  INDEX IDX_APWL_SF ON BCAPWTaxList(SaveFrom);

create table BCAPWTaxList2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode VARCHAR(20),
	BaseOfTax	MONEY DEFAULT 0.0,
	WTaxRate	MONEY DEFAULT 0.0,
	WTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	ShortDesc	VARCHAR(255),
	TaxGroup VARCHAR(10),
	SaveFrom SMALLINT DEFAULT 0,
	Paydate	DATETIME,
	BookNo VARCHAR(30),
	MyType SMALLINT DEFAULT 0 -- 0 = AP, 1 = AR
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_APWL_DNO2 ON BCAPWTaxList2(DocNo);
CREATE  INDEX IDX_APWL_DATE2 ON BCAPWTaxList2(DocDate);
CREATE  INDEX IDX_APWL_AP2 ON BCAPWTaxList2(ApCode);
CREATE  INDEX IDX_APWL_SF2 ON BCAPWTaxList2(SaveFrom);

create table BCAPWTaxCashList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode VARCHAR(20),
	BaseOfTax	MONEY DEFAULT 0.0,
	WTaxRate	MONEY DEFAULT 0.0,
	WTaxAmount	MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0,
	ShortDesc	VARCHAR(255),
	TaxGroup VARCHAR(10),
	SaveFrom SMALLINT DEFAULT 0,
	OrderDocNo SMALLINT DEFAULT 0,
	PayDate	DATETIME,
	BookNo VARCHAR(30),
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_APWC_DNO ON BCAPWTaxCashList(DocNo);
CREATE  INDEX IDX_APWC_DATE ON BCAPWTaxCashList(DocDate);
CREATE  INDEX IDX_APWC_AP ON BCAPWTaxCashList(ApCode);
CREATE  INDEX IDX_APWC_SF ON BCAPWTaxCashList(SaveFrom);

create table BCGLCondition
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	FormatGroup	SMALLINT DEFAULT 0,
	MyID	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(255),
	LineNumber SMALLINT DEFAULT 0,
	InventoryMethod SMALLINT DEFAULT -1 -- วิธีการ post บัญชีสินค้า 0=Periodic 1=Perpetual -1 ไม่สนใจ
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_GLC_G ON BCGLCondition(FormatGroup);
CREATE  INDEX IDX_GLC_ID ON BCGLCondition(MyID);

create table BCGLFormat
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	Code VARCHAR(5) NOT NULL,
	Name	VARCHAR(50),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	FormatGroup	SMALLINT DEFAULT 0,
	GLBookCode VARCHAR(5),
	RecurName	VARCHAR(40),
	GLDescription VARCHAR(255),
	IsDefault SMALLINT DEFAULT 0
    PRIMARY KEY(Code)
);

create table BCGLFormatSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code VARCHAR(5),
	AccountCode VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	IsDebit SMALLINT DEFAULT 0,
	Condition SMALLINT DEFAULT 0,
	LineNumber SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_GLCS_CD ON BCGLFormatSub(Code);
CREATE  INDEX IDX_GLCS_LN ON BCGLFormatSub(LineNumber);
CREATE  INDEX IDX_GLCS1 ON BCGLFormatSub(Code,LineNumber);

-- ******************* GL Struct ************ ***** 

CREATE TABLE BCChartOfAccount
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	Code	 VARCHAR(20) NOT NULL,
	Name1	 VARCHAR(70),
	Name2	 VARCHAR(70),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AccountGroup	SMALLINT DEFAULT 0, -- หมวด
	DepartSeparate	 SMALLINT DEFAULT 0,
	ProjectSeparate	 SMALLINT DEFAULT 0,
	AllocateSeparate 	SMALLINT DEFAULT 0,
	JobSeparate 	SMALLINT DEFAULT 0,
	PartSeparate 	SMALLINT DEFAULT 0,
	SideSeparate 	SMALLINT DEFAULT 0,
	BranchSeparate 	SMALLINT DEFAULT 0,
	AccLevel SMALLINT DEFAULT 0,
	IsGLAccess SMALLINT DEFAULT 0, -- ที่รายวัน GL ทำรายการได้หรือไม่ 0=ทำไม่ได้ 1=ทำได้ 
	IsHeader	SMALLINT DEFAULT 0 -- 0=ไม่ใช้ 1=ใช่
	PRIMARY KEY(Code)
);

CREATE  INDEX IDX_CHT_ACCN ON BCChartOfAccount(Name1);

CREATE TABLE BCGLBook
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	 VARCHAR(15) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name 	VARCHAR(50),
	TitleName	VARCHAR(50),
	PrintSlip	SMALLINT, -- 0 ไม่พิมพ์ 1=พิมพ์
	FomFileName	VARCHAR(255)
	PRIMARY KEY(Code)
);

create table BCGLChq
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BookCode	 VARCHAR(15) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate		 DATETIME NOT NULL, 
	DocNo		 VARCHAR(20) NOT NULL,
	Source		 SMALLINT DEFAULT 0,
	BankCode VARCHAR(10) NOT NULL,
	Chqno VARCHAR(30) NOT NULL,
	Amount MONEY DEFAULT 0.0,
	Duedate DATETIME NOT NULL,
	MyDescription VARCHAR(255),
	BookNo	VARCHAR(30),
	ChqType	SMALLINT DEFAULT 0,
	ExChangeRate DECIMAL(19,10) DEFAULT 1.0,
	BranchID VARCHAR(10)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ChqNo on BCGLChq (ChqNo);
CREATE  INDEX IDX_Duedate on BCGLChq(Duedate);

CREATE TABLE BCPeriod
(	
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PeriodNo	 SMALLINT NOT NULL,
	StartDate	 DATETIME NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StopDate	 DATETIME NOT NULL,
	ItemRemain 	MONEY DEFAULT 0.0,
	NetProfitLoss 	MONEY DEFAULT 0.0, -- กำไร(ขาดทุน) สุทธิ (450206)
	SummProfitLoss 	MONEY DEFAULT 0.0, -- กำไร(ขาดทุน) สะสม (450206)
	Status 	SMALLINT DEFAULT 1 --0=CLOSE 1=OPEN
	PRIMARY KEY(PeriodNo)
);

CREATE  INDEX IDX_PNO_STRD ON BCPeriod(StartDate);
CREATE  INDEX IDX_PNO_STPD ON BCPeriod(StopDate);

CREATE TABLE BCPart
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	 VARCHAR(15) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	 VARCHAR(255),
	UserGroup VARCHAR(255)
	PRIMARY KEY(Code)
);

CREATE TABLE BCSide
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	 VARCHAR(15) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	 VARCHAR(255),
	UserGroup VARCHAR(255)
	PRIMARY KEY(Code)
);
CREATE INDEX IDX_SIDE1 ON  BCSide(Roworder);

CREATE TABLE BCJob
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	 VARCHAR(15) NOT NULL,
	Name	 VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UserGroup VARCHAR(255)
	PRIMARY KEY(Code)
);
CREATE INDEX IDX_JOB1 ON  BCJob(Roworder);

CREATE TABLE BCBranch
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	 VARCHAR(15) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	 VARCHAR(255),
	UserGroup VARCHAR(255)
	PRIMARY KEY(Code)
);
CREATE INDEX IDX_BRANCH1 ON  BCBranch(Roworder);

CREATE TABLE BCGLBudget
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	 VARCHAR(10) NOT NULL,
	Name	 VARCHAR(255) NOT NULL,
	AccountCode	 VARCHAR(15) NOT NULL,
	BranchCode	 VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	 VARCHAR(10),
	ProjectCode	 VARCHAR(10),
	AllocateCode	 VARCHAR(10),
	JobCode		 VARCHAR(20),
	PartCode	VARCHAR(10),
	SideCode	VARCHAR(10),
	StartDate	 DATETIME,
	StopDate	DATETIME,
	Amount		 MONEY	DEFAULT 0.0,
	Remark		 VARCHAR(255),
	Status		 SMALLINT DEFAULT 0
	PRIMARY KEY(CODE)
);

CREATE INDEX IDX_BGG_ACCCODE ON BCGLBudget(AccountCode);
CREATE INDEX IDX_BGG_NAME ON BCGLBudget(NAME);

CREATE TABLE BCPostTrans
(
	BatchNo	VARCHAR(20) NOT NULL,
	WorkStation	VARCHAR(255),
	MyDescription	VARCHAR(255),
	BatchDate		DATETIME NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BatchStatus	 SMALLINT NOT NULL,
	TransCount	 SMALLINT NOT NULL,
	TaxCount		 SMALLINT DEFAULT 0,
	ChqCount		 SMALLINT DEFAULT 0,
	BatchOwner	VARCHAR(50) NOT NULL,
	BatchCheck1	 VARCHAR(50),
	BatchCheck2	 VARCHAR(50),
	BatchApprove	 VARCHAR(50)
	PRIMARY KEY (BatchNo)
);
CREATE INDEX IDX_BCPOSTDATE ON  BCPostTrans(BatchDate);
CREATE INDEX IDX_BCPOSTOWNER_TR  ON  BCPostTrans(BatchOwner);

CREATE TABLE  BCPostHistory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BatchNo	VARCHAR(20) NOT NULL,
	EventDate		 DATETIME NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	EventType	 SMALLINT DEFAULT 1,-- 1=create batch , 2= Cancel batch
	WorkStation	 VARCHAR(255)
	PRIMARY KEY(ROWORDER)
);
CREATE INDEX IDX_POSTHIS1 ON  BCPostHistory(BatchNo);
CREATE INDEX IDX_POSTHIS2 ON  BCPostHistory(EventDate);

CREATE TABLE BCClosePeriod
(
	BatchNo	VARCHAR(20) NOT NULL,
	WorkStation	VARCHAR(255),
	MyDescription	VARCHAR(255),
	BatchDate		DATETIME NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BatchStatus	 SMALLINT NOT NULL,
	TransCount	 SMALLINT NOT NULL,
	TaxCount		 SMALLINT DEFAULT 0,
	ChqCount		 SMALLINT DEFAULT 0,
	BatchOwner	VARCHAR(50) NOT NULL,
	BatchCheck1	 VARCHAR(50),
	BatchCheck2	 VARCHAR(50),
	BatchApprove	 VARCHAR(50)
	PRIMARY KEY (BatchNo)
);

CREATE INDEX IDX_BCCLOSEDATE ON  BCClosePeriod(BatchDate);
CREATE INDEX IDX_BCCLOSEOWNER_TR  ON  BCClosePeriod(BatchOwner);

CREATE TABLE  BCClsPdHistory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BatchNo	VARCHAR(20) NOT NULL,
	EventDate		 DATETIME NOT NULL,
	EventType	 SMALLINT  DEFAULT 1,-- 1=create batch , 2= Cancel batch
	WorkStation	 VARCHAR(255)
	PRIMARY KEY(ROWORDER)
);

CREATE TABLE BCPeriodBalance
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PeriodNo		 SMALLINT NOT NULL,
	BranchCode	 VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AccountCode   	VARCHAR(20) NOT NULL,
	DepartCode	 VARCHAR(10),
	ProjectCode	 VARCHAR(10),
	AllocateCode	 VARCHAR(10),
	PartCode	VARCHAR(10),
	SideCode	VARCHAR(10),
	JobCode		 VARCHAR(20),
	StartDate	 DATETIME,
	StopDate	DATETIME,
	Debit 		MONEY DEFAULT 0.0,
	Credit		 MONEY DEFAULT 0.0
	PRIMARY KEY(ROWORDER)
);

CREATE INDEX IDX_PB_PNO ON BCPeriodBalance(PeriodNo);
CREATE INDEX IDX_PB_ACC ON BCPeriodBalance(AccountCode);
CREATE INDEX IDX_PB_BC ON BCPeriodBalance(BranchCode);
CREATE INDEX IDX_PB_DP ON BCPeriodBalance(DepartCode);
CREATE INDEX IDX_PB_PC ON BCPeriodBalance(ProjectCode);
CREATE INDEX IDX_PB_AC ON BCPeriodBalance(AllocateCode);
CREATE INDEX IDX_PB_JC ON BCPeriodBalance(JobCode);
CREATE INDEX IDX_PB_PRC ON BCPeriodBalance(PartCode);
CREATE INDEX IDX_PB_SC ON BCPeriodBalance(SideCode);


CREATE TABLE BCYearPeriodBal -- ยอดสะสมประจำปี
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	YearCode	 VARCHAR(10),
	BranchCode	 VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AccountCode   	VARCHAR(20) NOT NULL,
	DepartCode	 VARCHAR(10),
	ProjectCode	 VARCHAR(10),
	AllocateCode	 VARCHAR(10),
	PartCode	VARCHAR(10),
	SideCode	VARCHAR(10),
	JobCode		 VARCHAR(20),
	StartDate	 DATETIME,
	StopDate	DATETIME,
	Debit 		MONEY DEFAULT 0.0,
	Credit		 MONEY DEFAULT 0.0
	PRIMARY KEY(ROWORDER)
);

CREATE INDEX IDX_YPB_YC ON BCYearPeriodBal(YearCode);
CREATE INDEX IDX_YPB_ACC ON BCYearPeriodBal(AccountCode);
CREATE INDEX IDX_YPB_BC ON BCYearPeriodBal(BranchCode);
CREATE INDEX IDX_YPB_DP ON BCYearPeriodBal(DepartCode);
CREATE INDEX IDX_YPB_PC ON BCYearPeriodBal(ProjectCode);
CREATE INDEX IDX_YPB_AC ON BCYearPeriodBal(AllocateCode);
CREATE INDEX IDX_YPB_JC ON BCYearPeriodBal(JobCode);
CREATE INDEX IDX_YPB_PRC ON BCYearPeriodBal(PartCode);
CREATE INDEX IDX_YPB_SC ON BCYearPeriodBal(SideCode);

CREATE TABLE BCTrans
(	
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	BatchNo	VARCHAR(20),
	BookCode	 VARCHAR(15) NOT NULL,
	DocDate		 DATETIME NOT NULL, 
	IsExport smallint default 0,
	DocNo		 VARCHAR(20) NOT NULL,
	RefDocNo	 VARCHAR(20),
	RefDate	 	DATETIME,
	Amount		  MONEY DEFAULT 0.0,
	FAmount		 MONEY DEFAULT 0.0,
	FCurrency		 VARCHAR(10),
	FExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	Source		 SMALLINT DEFAULT 0 NOT NULL,
	TransType	SMALLINT DEFAULT 0, -- 0=ด้านรับ 1=ด้านจ่าย
	IsManualKey	SMALLINT DEFAULT 0, -- 0 = Post 1= manual key
	MyDescription	 VARCHAR(255),
	RecurName	VARCHAR(40), -- รูปแบบเอกสาร
	creatorcode varchar(30),
	createdatetime datetime,
	lasteditorcode varchar(30),
	lasteditdatet datetime,
	iscancel	smallint default 0, -- 0 = enable 1=disable
	isconfirm smallint default 0,
	confirmcode	varchar(30),
	confirmdatetime	datetime,
	cancelcode	varchar(30),
	canceldatetime	datetime,
	IsPassError SMALLINT DEFAULT 0, -- ผ่านรายการแล้ว Error
	TaxCount		 SMALLINT DEFAULT 0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CheqCount	 SMALLINT DEFAULT 0
	PRIMARY KEY(DocNo,Source,BookCode)
);

CREATE INDEX IDX_BCTRANSDOCNO ON   BCTrans(DocNo);
CREATE INDEX IDX_BCTRANSDOCDATE ON   BCTrans(DocDate);
CREATE INDEX IDX_BCTRANSBOOK ON   BCTrans(BookCode);

CREATE TABLE BCTransSub
(	
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	BatchNo	VARCHAR(20),
	LineNumber 	SMALLINT DEFAULT 0,
	BookCode	VARCHAR(15) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	 	DATETIME NOT NULL,
	DocNo 		VARCHAR(20) NOT NULL,
	AccountCode 	VARCHAR(20) NOT NULL,
	ExtDescription 	VARCHAR(255),
	DepartCode		VARCHAR(10),
	ProjectCode 	VARCHAR(10),
	AllocateCode 	VARCHAR(10),
	PartCode	VARCHAR(10),
	SideCode	VARCHAR(10),
	JobCode 		VARCHAR(20),
	BranchCode 	VARCHAR(15),
	Debit 		MONEY DEFAULT 0.0,
	Credit 		MONEY DEFAULT 0.0,
	FDebit 		MONEY  DEFAULT 0.0,
	FCredit 		MONEY  DEFAULT 0.0,
	Source		 SMALLINT DEFAULT 0,
	IsManualKey	SMALLINT DEFAULT 0, -- 0 = Post 1= manual key
	IsCancel SMALLINT DEFAULT 0,
	IsConfirm	SMALLINT DEFAULT 0
	PRIMARY KEY (ROWORDER)
);
 --- ตัว Link ระหว่าง Head และ Detail คือ DocNo,BookCode,Source เด้อ
CREATE INDEX IDX_GTS_ACC ON  BCTransSub(AccountCode);
CREATE INDEX IDX_GTS_SOU ON  BCTransSub(Source);
CREATE INDEX IDX_GTS_DOC ON  BCTransSub(DocNo);
CREATE INDEX IDX_GTS_BOO ON  BCTransSub(BookCode);
CREATE INDEX IDX_GTS_BC ON BCTransSub(BranchCode);
CREATE INDEX IDX_GTS_DP ON BCTransSub(DepartCode);
CREATE INDEX IDX_GTS_PC ON BCTransSub(ProjectCode);
CREATE INDEX IDX_GTS_AC ON BCTransSub(AllocateCode);
CREATE INDEX IDX_GTS_JC ON BCTransSub(JobCode);
CREATE INDEX IDX_GTS_PRC ON BCTransSub(PartCode);
CREATE INDEX IDX_GTS_SC ON BCTransSub(SideCode);


--add bctrans_tmp and bctranssub_tmp by Jum
CREATE TABLE BCTrans_tmp
(	
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	BatchNo	VARCHAR(20),
	BookCode	 VARCHAR(15) NOT NULL,
	DocDate		 DATETIME NOT NULL, 
	DocNo		 VARCHAR(20) NOT NULL,
	RefDocNo	 VARCHAR(20),
	RefDate	 	DATETIME,
	Amount		  MONEY DEFAULT 0.0,
	FAmount		 MONEY DEFAULT 0.0,
	FCurrency		 VARCHAR(10),
	FExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	Source		 SMALLINT DEFAULT 0 NOT NULL,
	TransType	SMALLINT DEFAULT 0, -- 0=ด้านรับ 1=ด้านจ่าย
	IsManualKey	SMALLINT DEFAULT 0, -- 0 = Post 1= manual key
	MyDescription	 VARCHAR(255),
	RecurName	VARCHAR(40), -- รูปแบบเอกสาร
	creatorcode varchar(30),
	createdatetime datetime,
	lasteditorcode varchar(30),
	lasteditdatet datetime,
	iscancel	smallint default 0, -- 0 = enable 1=disable
	isconfirm smallint default 0,
	confirmcode	varchar(30),
	confirmdatetime	datetime,
	cancelcode	varchar(30),
	canceldatetime	datetime,
	IsPassError SMALLINT DEFAULT 0, -- ผ่านรายการแล้ว Error
	TaxCount		 SMALLINT DEFAULT 0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	CheqCount	 SMALLINT DEFAULT 0
	PRIMARY KEY(DocNo,Source,BookCode)
);

CREATE INDEX IDX_BCTRANSDOCNO_tmp ON   BCTrans_tmp(DocNo);
CREATE INDEX IDX_BCTRANSDOCDATE_tmp ON   BCTrans_tmp(DocDate);
CREATE INDEX IDX_BCTRANSBOOK_tmp ON   BCTrans_tmp(BookCode);

CREATE TABLE BCTransSub_tmp
(	
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	BatchNo	VARCHAR(20),
	LineNumber 	SMALLINT DEFAULT 0,
	BookCode	VARCHAR(15) NOT NULL,
	DocDate	 	DATETIME NOT NULL,
	DocNo 		VARCHAR(20) NOT NULL,
	AccountCode 	VARCHAR(20) NOT NULL,
	ExtDescription 	VARCHAR(255),
	DepartCode		VARCHAR(10),
	ProjectCode 	VARCHAR(10),
	AllocateCode 	VARCHAR(10),
	PartCode	VARCHAR(10),
	SideCode	VARCHAR(10),
	JobCode 		VARCHAR(20),
	BranchCode 	VARCHAR(15),
	Debit 		MONEY DEFAULT 0.0,
	Credit 		MONEY DEFAULT 0.0,
	FDebit 		MONEY  DEFAULT 0.0,
	FCredit 		MONEY  DEFAULT 0.0,
	Source		 SMALLINT DEFAULT 0,
	IsManualKey	SMALLINT DEFAULT 0, -- 0 = Post 1= manual key
	IsCancel SMALLINT DEFAULT 0,
	IsConfirm	SMALLINT DEFAULT 0
	PRIMARY KEY (ROWORDER)
);
 --- ตัว Link ระหว่าง Head และ Detail คือ DocNo,BookCode,Source เด้อ
CREATE INDEX IDX_GTS_ACC_tmp ON  BCTransSub_tmp(AccountCode);
CREATE INDEX IDX_GTS_SOU_tmp ON  BCTransSub_tmp(Source);
CREATE INDEX IDX_GTS_DOC_tmp ON  BCTransSub_tmp(DocNo);
CREATE INDEX IDX_GTS_BOO_tmp ON  BCTransSub_tmp(BookCode);
CREATE INDEX IDX_GTS_BC_tmp ON BCTransSub_tmp(BranchCode);
CREATE INDEX IDX_GTS_DP_tmp ON BCTransSub_tmp(DepartCode);
CREATE INDEX IDX_GTS_PC_tmp ON BCTransSub_tmp(ProjectCode);
CREATE INDEX IDX_GTS_AC_tmp ON BCTransSub_tmp(AllocateCode);
CREATE INDEX IDX_GTS_JC_tmp ON BCTransSub_tmp(JobCode);
CREATE INDEX IDX_GTS_PRC_tmp ON BCTransSub_tmp(PartCode);
CREATE INDEX IDX_GTS_SC_tmp ON BCTransSub_tmp(SideCode);




CREATE TABLE BCAccSeparate
(	
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	SeparateType		 SMALLINT DEFAULT 0, -- 0=dep 1= project 2=allocate 3=site 4-part 5 =branch 6=job
	AccountCode 	VARCHAR(20) NOT NULL,
	SeparateCode VARCHAR(255) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	 
	PRIMARY KEY (ROWORDER)
);
create index IDX_AccSeparate1  ON BCAccSeparate(AccountCode);
-- ******************* Fixed Assets ********************************
create table BCAssetsMaster -- ทะเบียนทรัพย์สิน
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,		
	Code			VARCHAR(25) NOT NULL,
	Name			VARCHAR(255),
	UnitCode	VARCHAR(10),
	AssetsType	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode		VARCHAR(10),
	LocateCode		VARCHAR(10),
	PictureFileName			VARCHAR(255),
	BuyDate			DATETIME,
	BuyPrice		MONEY	DEFAULT 0.0,
	BuyDocNo		VARCHAR(20),
	BuyDocDate	DATETIME,
	BuyForm			VARCHAR(255),
	StartCalcDate DATETIME,
	AmountCalc		MONEY DEFAULT 0.0,
	CalcType		SMALLINT DEFAULT 0,
	AssetsRate			MONEY DEFAULT 0.0,
	AssetsAge				SMALLINT DEFAULT 0,
	StopCalcDate	DATETIME,
	AssetsBalance		MONEY DEFAULT 0.0, -- มูลค่าคงเหลือยกมา
	SumOfAssetsBal	MONEY DEFAULT 0.0, -- ค่าเสื่อมสะสมยกมา
	SaleDate		DATETIME,
	SalePrice		MONEY DEFAULT 0.0,
	SaleAssetsBal	MONEY DEFAULT 0.0,
	SaleDocNo		VARCHAR(20),
	SaleDocDate			DATETIME,
	CustName		VARCHAR(255),
	InsuranceNo			VARCHAR(20),
	SaftyNo			VARCHAR(20),
	SaftyName		VARCHAR(255),
	InsurePremium		MONEY DEFAULT 0.0,
	InsureAge			SMALLINT DEFAULT 0,
	InsureStartDate			DATETIME,
	InsureStopDate		DATETIME,
	MyDescription			VARCHAR(255),
	Remain		MONEY DEFAULT 0.0,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	FirstYearRate  MONEY DEFAULT 0.0,
	IsFirstScrap  SMALLINT DEFAULT 1,
	ProcessType		SMALLINT DEFAULT 0 --0=คำนวณเป็นวัน 1=คำนวณเป็นปี
	PRIMARY KEY (Code)
);

create table BCAssetsLocate -- ที่ตั้งค่าเสื่อม
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50),
	UserGroup VARCHAR(255)
	PRIMARY KEY (Code)
);

create table BCAssetsType -- ประเภทสินทรัพย์
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50),
	DrAccountCode VARCHAR(20),
	CrAccountCode VARCHAR(20)
	PRIMARY KEY (Code)
);

create table BCAssetsOfYear	-- ค่าเสื่อมประจำปี
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	AssetsCode	VARCHAR(25) ,	-- รหัสสินทรัพย์
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StartCalcDate	DATETIME, -- วันที่เริ่มคำนวณจริง
	StopCalcDate	DATETIME,	-- วันที่สิ้นสุดการคำนวณ
	DepartCode		VARCHAR(10),	--แผนกของสินทรัพย์
	AssetsType	VARCHAR(10),	-- ประเภทของสินทรัพย์
	LocateCode	VARCHAR(10),	-- ที่ตั้งของสินทรัพย์
	DayCalc			SMALLINT DEFAULT 0,	-- จำนวนวันที่คำนวณจริง
	BeginBalance MONEY DEFAULT 0.0,		-- ยอดยกมาของต้นงวด
	AssetsAmount		MONEY DEFAULT 0.0,	-- ค่าเสื่อมรวมของงวดนี้
	AssetsAmass		MONEY DEFAULT 0.0,	-- ยอดค่าเสื่อมสำสมประจำงวดนี้
	EndBalance		MONEY DEFAULT 0.0	-- ยอดยกไป
	PRIMARY KEY (ROWORDER)
);

CREATE INDEX IDX_ASY_ASC ON BCAssetsOfYear(AssetsCode);
CREATE INDEX IDX_ASY_STRD ON BCAssetsOfYear(StartCalcDate);
CREATE INDEX IDX_ASY_STPD ON BCAssetsOfYear(StopCalcDate);
CREATE INDEX IDX_ASY_DEP ON BCAssetsOfYear(DepartCode);
CREATE INDEX IDX_ASY_TYP ON BCAssetsOfYear(AssetsType);
CREATE INDEX IDX_ASY_LOC ON BCAssetsOfYear(LocateCode);

create table BCAssetsOfPeriod	-- ค่าเสื่อมประจำงวดบัญชี
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	AssetsCode	VARCHAR(25) ,	-- รหัสสินทรัพย์
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StartCalcDate	DATETIME, -- วันที่เริ่มคำนวณจริง
	StopCalcDate	DATETIME,	-- วันที่สิ้นสุดการคำนวณ
	DepartCode		VARCHAR(10),	--แผนกของสินทรัพย์
	AssetsType	VARCHAR(10),	-- ประเภทของสินทรัพย์
	LocateCode	VARCHAR(10),	-- ที่ตั้งของสินทรัพย์
	BeginBalance MONEY DEFAULT 0.0,		-- ยอดยกมาของต้นงวด
	AssetsAmount MONEY DEFAULT 0.0,	-- ค่าเสื่อมรวมของงวดนี้
	AssetsPeriod1 MONEY DEFAULT 0.0,
	AssetsPeriod2 MONEY DEFAULT 0.0,
	AssetsPeriod3 MONEY DEFAULT 0.0,
	AssetsPeriod4 MONEY DEFAULT 0.0,
	AssetsPeriod5 MONEY DEFAULT 0.0,
	AssetsPeriod6 MONEY DEFAULT 0.0,
	AssetsPeriod7 MONEY DEFAULT 0.0,
	AssetsPeriod8 MONEY DEFAULT 0.0,
	AssetsPeriod9 MONEY DEFAULT 0.0,
	AssetsPeriod10 MONEY DEFAULT 0.0,
	AssetsPeriod11 MONEY DEFAULT 0.0,
	AssetsPeriod12 MONEY DEFAULT 0.0,
	AssetsPeriod13 MONEY DEFAULT 0.0, -- เผื่อไว้
	EndBalance		MONEY DEFAULT 0.0	-- ยอดยกไป
	PRIMARY KEY (ROWORDER)
);

CREATE INDEX IDX_ASP_ASC ON BCAssetsOfPeriod(AssetsCode);
CREATE INDEX IDX_ASP_STRD ON BCAssetsOfPeriod(StartCalcDate);
CREATE INDEX IDX_ASP_STPD ON BCAssetsOfPeriod(StopCalcDate);
CREATE INDEX IDX_ASP_DEP ON BCAssetsOfPeriod(DepartCode);
CREATE INDEX IDX_ASP_TYP ON BCAssetsOfPeriod(AssetsType);
CREATE INDEX IDX_ASP_LOC ON BCAssetsOfPeriod(LocateCode);

create table BCAssetsOfBuild
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),	
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,	
	AssetsCode	VARCHAR(25) NOT NULL,	-- รหัสสินทรัพย์
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription		VARCHAR(255),
	Amount		MONEY DEFAULT 0.0,
	PrintCount SMALLINT DEFAULT 0 -- Count Print form -- A-20030923
	PRIMARY KEY (AssetsCode)
);
create index IDX_ASBLDDES ON BCAssetsOfBuild ( MyDescription );

create table BCAssetsOfBldSub
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	LineNumber	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AssetsCode	VARCHAR(25) ,	-- รหัสสินทรัพย์
	DocDate		DATETIME,
	DocNo	VARCHAR(20),
	Desc1	 VARCHAR(255),
	Desc2		VARCHAR(255),
	Amount		MONEY DEFAULT 0.0
	PRIMARY KEY (ROWORDER)
);

create index IDX_ASBLDS_AS ON BCAssetsOfBldSub(AssetsCode);
create index IDX_ASBLDS_LI ON BCAssetsOfBldSub(LineNumber);
--create index IDX_ASBLDSS1  ON BCAssetsOfBldSub(roworder);
create index IDX_ASBLDSS2  ON BCAssetsOfBldSub(Docdate);
create index IDX_ASBLDSS3  ON BCAssetsOfBldSub(Docno,linenumber);

create table BCRenovate
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),	
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,	
	AssetsCode	VARCHAR(25) NOT NULL,	-- รหัสสินทรัพย์
	Amount		MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	PrintCount SMALLINT DEFAULT 0 -- Count Print form -- A-20030923
	PRIMARY KEY (AssetsCode)
);
create index IDX_Renovate1 on BCRenovate(roworder);

create table BCRenovateSub
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	LineNumber	SMALLINT DEFAULT 0,
	AssetsCode	VARCHAR(25) ,	-- รหัสสินทรัพย์
	DocDate		DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocNo	VARCHAR(20),
	Desc1	 VARCHAR(255),
	Desc2		VARCHAR(255),
	Amount		MONEY DEFAULT 0.0
	PRIMARY KEY (ROWORDER)
);

create index IDX_ASREVS_AS on BCRenovateSub(AssetsCode);
create index IDX_ASREVS_LI on BCRenovateSub(LineNumber);
create index IDX_ASREVS1 on BCRenovateSub(docno);
create index IDX_ASREVS2 on BCRenovateSub(docdate);

create table BCAccGroup 
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50),
	AccGroup	VARCHAR(255), -- 1:2,4,5,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
	PRIMARY KEY (Code)
);
create index idx_accgrp1 on BCAccGroup(ROWORDER);
create index idx_accgrp2 on BCAccGroup(AccGroup);
-- *************** BC Point Of Sale 




create table BPSCreditType
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50), 
	ChargeWord VARCHAR(30),
	UserGroup VARCHAR(255)
    PRIMARY KEY(Code)
);
create index IDX_CREDITTYPEROW ON BPSCreditType(roworder);

create table BPSItemPromotion
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	GroupCode	VARCHAR(10) NOT NULL,
	StartDate	DATETIME,
	StopDate	DATETIME,
	PromotionPrice	MONEY DEFAULT 0.0,
	PromotionItem	VARCHAR(20),
	PromotionQty	MONEY DEFAULT 0.0,
	PromotionDiscount	VARCHAR(25),
	QtyChk	MONEY DEFAULT 0.0,
	AmountChk	MONEY DEFAULT 0.0,
	GroupName	VARCHAR(50),
	PromotionFor	SMALLINT, 
	PromotionType	SMALLINT,
	ExchangeItem	VARCHAR(20),
	ExchangeDiscount	VARCHAR(25),
	PromotionItem2	VARCHAR(25),
	ExchangeItem2	VARCHAR(25),
	StartItemGroup VARCHAR(10),
	StopItemGroup VARCHAR(10)
    PRIMARY KEY(GroupCode)
);
create index IDX_ItemPromo1 ON BPSItemPromotion(startdate,stopdate);
create index IDX_ItemPromo2 ON BPSItemPromotion(roworder);

create table BPSCashierShift -- บันทึกเปิดปิดกะ
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ShiftNo	SMALLINT,
	CashierCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	MachineNo	VARCHAR(10), -- เลขที่เครื่อง
	MachineCode	VARCHAR(30), -- เลขประจำเครื่อง
	ShiftStatus	SMALLINT, -- 0=เปิด 1=ปิด
	BeginAmount MONEY DEFAULT 0.0, -- ยอดเงินยกมา
	CashAmount	MONEY DEFAULT 0.0, -- ยอดเงินสดรับ
	CreditAmount	MONEY DEFAULT 0.0, -- ยอดบัตรเครดิต
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน
	CashInCase MONEY DEFAULT 0.0, -- ยอดเงินสดในเกะ BeginAmount+CashAmount-ChangeAmount
	ChqAmount MONEY DEFAULT 0.0,
	DraftAmount MONEY DEFAULT 0.0,
	SumOfQty MONEY DEFAULT 0.0, -- รวมปรมาณที่ขาย
	SaleCount SMALLINT DEFAULT 0, -- จำนวนการขาย
	DisCount SMALLINT DEFAULT 0, --จำนวนการลด
	CashPayCount SMALLINT DEFAULT 0, -- การรับเงินสด
	OtherPayCount SMALLINT DEFAULT 0, -- การรับอื่นๆ
	OTHERAMOUNT  MONEY DEFAULT 0.0,
	OTHERFEE  MONEY DEFAULT 0.0,
	CREDITPAY MONEY DEFAULT 0.0,
	COUPONPAY MONEY DEFAULT 0.0,
	RECAMOUNT  MONEY DEFAULT 0.0,
	TaxInvStart	VARCHAR(20), -- ใบกำกับอย่างย่อเริ่ม
	TaxInvStop	VARCHAR(20),
	SumOfItemAmount MONEY DEFAULT 0.0, -- ยอดขายสินค้าคิดภาษี
	SumOfTaxAmount MONEY DEFAULT 0.0, -- ยอดภาษี
	ZeroTaxAmount	MONEY DEFAULT 0.0, -- ยอดภาษี 0
	ExceptTaxAmount	MONEY DEFAULT 0.0, -- ยอดยกเว้นภาษี
	NetAmount	MONEY DEFAULT 0.0, -- รวมทั้งสิ้น SumOfItemAmount+ZeroTaxAmount+ExceptTaxAmount
	DisAmount MONEY DEFAULT 0.0, -- สรุปส่วนลด
	SHIFTCODE VARCHAR(10),
	DEPARTCODE VARCHAR(10),
	CHKSTATUS SMALLINT DEFAULT 0,
	CREDITCHARGE MONEY DEFAULT 0.0,
	COUPONAMOUNT MONEY DEFAULT 0.0,	
	CASHINTILL  MONEY DEFAULT 0.0,
	COUPONINTILL   MONEY DEFAULT 0.0,
	CEDITINTILL MONEY DEFAULT 0.0,
	CREDITSERINTILL  MONEY DEFAULT 0.0,
	ISEXPORT SMALLINT DEFAULT 0,
	CREATORCODE VARCHAR(30),
	CREATEDATETIME DATETIME,
	LASTEDITORCODE VARCHAR(30),
	LASTEDITDATET DATETIME,
	ISCANCEL SMALLINT DEFAULT 0,
	ISCONFIRM SMALLINT DEFAULT 0,
	CONFIRMCODE VARCHAR(30),
	CONFIRMDATETIME DATETIME,
	CANCELCODE VARCHAR(30),
	CANCELDATETIME DATETIME



    PRIMARY KEY(DocNo)
);
create index IDX_BPSCashierS1 ON BPSCashierShift(docdate);
create index IDX_BPSCashierS2 ON BPSCashierShift(docno,docdate);
create index IDX_BPSCashierS3 ON BPSCashierShift(MachineNo);
--create index IDX_BPSCashierS4 ON BPSCashierShift(docno,docdate);

create table BPSReturnDesc -- หมายเหตุการคืนสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50)
    PRIMARY KEY(Code)
);
create index IDX_BPSReturnDesc1 ON BPSReturnDesc(roworder);


create table BPSHoldingBill
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME NOT NULL,
	ExpireCredit SMALLINT DEFAULT 0,
	ExpireDate DATETIME ,
	ArCode	VARCHAR(20) NOT NULL,
	CashierCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	MyDescription	VARCHAR(255),
	BillGroup	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	NetDebtAmount	MONEY DEFAULT 0.0,
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME,
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
-- ************* POS ------------
	Ismultitaxabb	SMALLINT DEFAULT 0, -- 0=บิลเดียวรับเงินเลย 1=รวมยอดบิลไว้ใบสุดท้าย
	TaxABBno_1 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TaxABBno_2 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TaxABBNO_3 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TaxABBNO_4 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TaxABBNO_5 	VARCHAR(20), -- เลขใบกำกับแบบรวมใบกำักับหลายใบ
	TaxABBAMOUNT1  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ	
	TaxABBAMOUNT2  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ		
	TaxABBAMOUNT3  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ		
	TaxABBAMOUNT4  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ		
	TaxABBAMOUNT5  MONEY DEFAULT 0.0, -- มูลค่าของใบกำกับ	
	ISAPPROVED	SMALLINT DEFAULT 0,   -- 1=รออนุมัติ 2=อนุมัติ
	APPROVEDCODE	VARCHAR(10),   -- รหัสผู้อนุมัติ
	APPROVEDDATE	DATETIME,  -- วันที่อนุมัติ
	SHIFTCODE	VARCHAR(10), -- กะที่
	MACHINENO	VARCHAR(10), -- เลขที่เครื่อง
	MACHINECODE	VARCHAR(30), -- เลขประจำเครื่อง
	BILLTIME	VARCHAR(15), -- เวลาของ POS

	ReceiveItemType Varchar(10) NULL,
	IsConditionSend SMALLINT DEFAULT 0,

	 
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel

-- ************* POS ------------
    PRIMARY KEY(DOCNO)
);
create index IDX_BPSHoldingB1 ON BPSHoldingBill(docdate);
create index IDX_BPSHoldingB2 ON BPSHoldingBill(MachineNo);
create index IDX_BPSHoldingB3 ON BPSHoldingBill(arcode,docno);
create index IDX_BPSHoldingB4 ON BPSHoldingBill(docno,docdate);

create table BPSHoldingBillSUB
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	SORefNo	VARCHAR(20),
	StockType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	LineNumber	SMALLINT DEFAULT 0,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	BarCode	VARCHAR(20),
	CustTypeCode	VARCHAR(10),
	CustGroupCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
-- ************* POS ------------
	MachineNo	VARCHAR(10), -- เลขที่เครื่อง
	MachineCode	VARCHAR(30), -- เลขประจำเครื่อง
	BillTime	VARCHAR(15),
	CashierCode	VARCHAR(10),
	PosStatus SMALLINT DEFAULT 0, -- 0=ไม่ใช่ 1=ใบกำกับอย่างย่อ 2=ใบกำกับอย่างเต็ม
	PRICESTATUS SMALLINT DEFAULT 0, -- 0=ราคาปกติ 1=ราคาโปรโมชั่น
	PROMOSTATUS SMALLINT DEFAULT 0,--แสดงโปรโมชั่น ทำตัว P ตัว N ของคุณเจือ
	USERCODE	VARCHAR(10),--รหัสผู้แก้ราคา	
	POSCREDIT	MONEY DEFAULT 0.0,
	SUMOFQTY	MONEY DEFAULT 0.0,
	USERMODIFY	SMALLINT DEFAULT 0, --0 = ไม่โม 1 =โม เกี่ยวกันราคาสินค้า

	-- nauy for sale and transport type
	ReceiveItemType Varchar(10) NULL,
	SaleCode varchar(10) ,

	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
-- ************* POS ------------
    PRIMARY KEY(ROWORDER)
);
create index IDX_BPSHoldingBillS1 ON BPSHoldingBillSUB(Linenumber);
create index IDX_BPSHoldingBillS2 ON BPSHoldingBillSUB(Itemcode);
create index IDX_BPSHoldingBillS3 ON BPSHoldingBillSUB(Itemcode,whcode,shelfcode,linenumber);
create index IDX_BPSHoldingBillS4 ON BPSHoldingBillSUB(docno,linenumber);
create index IDX_BPSHoldingBillS5 ON BPSHoldingBillSUB(docno,itemcode);



CREATE TABLE BPSCancelMemberMark
(
	ROWORDER INT IDENTITY(1,1) NOT NULL,
	DOCNO	VARCHAR(25) NOT NULL,
	DOCDATE	DATETIME,
	SALECODE	VARCHAR(10),
	REMARK	VARCHAR(255),
	ISEXPORT SMALLINT DEFAULT 0,
	CREATORCODE VARCHAR(30),
	CREATEDATETIME DATETIME,
	LASTEDITORCODE VARCHAR(30),
	LASTEDITDATET DATETIME,
	ISCANCEL SMALLINT DEFAULT 0,
	ISCONFIRM SMALLINT DEFAULT 0,
	CONFIRMCODE VARCHAR(30),
	CONFIRMDATETIME DATETIME,
	CANCELCODE VARCHAR(30),
	CANCELDATETIME DATETIME
	PRIMARY KEY(DOCNO)
);
create index IDX_BPSCANCELMARK_DOCNO ON BPSCancelMemberMark(DOCNO);
create index IDX_BPSCANCELMARK_DOCDATE ON BPSCancelMemberMark(DOCDATE);
 
CREATE TABLE BPSCancelMemberMarkSub
(
	ROWORDER INT IDENTITY(0,1) NOT NULL,
	DOCNO	VARCHAR(25),
	DOCDATE	DATETIME,
	INVOICENO	VARCHAR(25),
	INVOICEDATE	DATETIME,
	INVAMOUNT	MONEY DEFAULT 0.0,
	INVOICEMARK	SMALLINT DEFAULT 0,
	MEMBERID	VARCHAR(25),
	ARCODE		VARCHAR(25),
	ARNAME		VARCHAR(255),
	LINENUMBER	SMALLINT DEFAULT 0,
	ISEXPORT SMALLINT DEFAULT 0,
	CREATORCODE VARCHAR(30),
	CREATEDATETIME DATETIME,
	LASTEDITORCODE VARCHAR(30),
	LASTEDITDATET DATETIME,
	ISCANCEL SMALLINT DEFAULT 0,
	ISCONFIRM SMALLINT DEFAULT 0,
	CONFIRMCODE VARCHAR(30),
	CONFIRMDATETIME DATETIME,
	CANCELCODE VARCHAR(30),
	CANCELDATETIME DATETIME
	PRIMARY KEY(ROWORDER)
);
create index IDX_BPSCANCELMARKSUB_DOCNO ON BPSCancelMemberMarkSUB(DOCNO);
create index IDX_BPSCANCELMARKSUB_INVNO ON BPSCancelMemberMarkSUB(INVOICENO);

-- ให้รางวัลสมาชิก 1
CREATE TABLE BCMEMBERREWARD
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),
	DOCNO		VARCHAR(25) NOT NULL,
	ISSUEDOCNO	VARCHAR(20),-- เลขที่เอกสารเบิกสินค้า
	DOCDATE	DATETIME NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MYDESCRIPTION	VARCHAR(100), 
	ArCode	VARCHAR(20),
	Description	VARCHAR(255),
	REFTYPE	SMALLINT DEFAULT 0,-- 0=อ้างอิงใบกำกับ 1=อ้างอิงลูกค้า	
	REFARCODE	VARCHAR(20),
	REFDOCNO	VARCHAR(20),
	DEPARTCODE	VARCHAR(10),
	SALECODE	VARCHAR(10)	,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(DOCNO)
);

create index IDX_MemberReward1 ON BCMemberReward(Roworder);
create index IDX_MemberReward2 ON BCMemberReward(Docdate);
create index IDX_MemberReward3 ON BCMemberReward(Arcode,DocNo);
create index IDX_MemberReward4 ON BCMemberReward(Arcode);

-- ให้รางวัลสมาชิก 2
CREATE TABLE BCMMBREWARDSUB
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	LINENUMBER	SMALLINT DEFAULT 0,
	TRANSSTATE 	SMALLINT DEFAULT 0, -- 0 = รายการใหม่ 1 = รายการเก่า
	DOCNO	VARCHAR(25) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DOCDATE	DATETIME NOT NULL,
	REFARCODE	VARCHAR(20),
	REFDOCNO	VARCHAR(20),	
	ITEMCODE	VARCHAR(25),	
	UNITCODE	VARCHAR(10),	
	QTY	MONEY DEFAULT 0.0,
	SCORETYPE SMALLINT DEFAULT 0, -- 0=ตัดแต้ม 1=ตัดมูลค่า
	PRICETYPE SMALLINT DEFAULT 0, -- 0=ราคาปกติ 1=ราคาโปรโมชั่น
	ArCode	VARCHAR(20),
	Description	VARCHAR(255), -- ให้เป็นอะไร/หมายเหตุ
	RewardType SMALLINT DEFAULT 0, -- 0=ตัดยอดมูลค่า 1=ตัดแต้ม
	Promotype SMALLINT DEFAULT 0, 
	MarkUse	MONEY DEFAULT 0.0, -- ยอดตัด
	SCORE	MONEY DEFAULT 0.0 ,-- ยอดตัด
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(ROWORDER)
);

create index IDX_MMBRS1 ON BCMmbRewardSub(Docno);
create index IDX_MMBRS2 ON BCMmbRewardSub(Docdate);
create index IDX_MMBRS3 ON BCMmbRewardSub(DocNo,Docdate);
create index IDX_MMBRS4 ON BCMmbRewardSub(Docno,linenumber);

create table BCCatchProccess
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(35) NOT NULL,
	DocDate	DATETIME NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CurDateTime	DATETIME NOT NULL,
	ItemCode	VARCHAR(25),
	TransType	SMALLINT DEFAULT 0,
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	UnitCode	VARCHAR(10),
	TransQty	MONEY DEFAULT 0.0 ,
	ProcQty 	MONEY DEFAULT 0.0 ,
	StockQty MONEY DEFAULT 0.0 ,
	ProcResult	SMALLINT DEFAULT 0,
	DeleteMode SMALLINT DEFAULT 0,
	PeriodNo SMALLINT DEFAULT 0,
	ComputerName VARCHAR(100),
	QueryUpdate	VARCHAR(255)
    PRIMARY KEY(ROWORDER)
);

create table BCItemStandardCost
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UnitCode	VARCHAR(10),
	StartDate	DATETIME ,
	StopDate	DATETIME ,
	StandardCost	MONEY DEFAULT 0.0,
	IsRevalue SMALLINT DEFAULT 0, --0 open ,1=close this standard cost
	RevalueDate DATETIME,
	TransState	SMALLINT DEFAULT 0 
    PRIMARY KEY(ROWORDER)
);

create index IDX_STDC1 ON BCItemStandardCost(itemcode);
create index IDX_STDC2 ON BCItemStandardCost(startdate,stopdate);

create table BCRecurTemp
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME ,
	MyType	SMALLINT DEFAULT 0, -- 0 = ยังไม่เอาไปทำ Sale Order, 1 = ทำ Sale Order แล้ว
	TaxNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	ArCode	VARCHAR(20) NOT NULL,
	PassBillTo VARCHAR(20) ,
	DepartCode	VARCHAR(10),
	CreditDay	SMALLINT DEFAULT 0,
	DeliveryDay	SMALLINT DEFAULT 0, --
	DeliveryDate	DATETIME, --
	DueDate	DATETIME,
	PayBillDate	DATETIME,
	SaleCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	TaxRate	MONEY DEFAULT 7.0,
	IsConfirm	SMALLINT DEFAULT 0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	BillGroup	VARCHAR(10),
	RefDocNo	VARCHAR(20), -- 
	CrAuthorizeMan VARCHAR(20),
	DeliveryAddr VARCHAR(10),
	ContactCode	VARCHAR(10),
	TransportCode	VARCHAR(10),
	SumOfItemAmount	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	AfterDiscount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountCase	SMALLINT DEFAULT 0,
	ZeroTaxAmount	MONEY DEFAULT 0.0,
	ExceptTaxAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	DepositIncTax SMALLINT DEFAULT 1, -- ?.??????? 1 = ?????? 0= ????? Tax
	SumOfDeposit1	MONEY DEFAULT 0.0, -- ??????????????.???
	SumOfDeposit2	MONEY DEFAULT 0.0, -- ?????? post GL ??????..?? Vat .???????????
	SumOfWTax	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	NetDebtAmount	MONEY DEFAULT 0.0,
	OtherIncome	MONEY DEFAULT 0.0, -- ??????????? ?????????.????????
	OtherExpense	MONEY DEFAULT 0.0, --???????????????
	ExcessAmount1	MONEY DEFAULT 0.0, --?.????????????????
	ExcessAmount2	MONEY DEFAULT 0.0, --????.???????????????????????????????
	BillBalance	MONEY DEFAULT 0.0,
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other		
	IsCancel	SMALLINT DEFAULT 0, -- 0=??.???Cancel 1=Cancel
	IsCreditNote	SMALLINT DEFAULT 0, -- 0=??.????????? 1=??????????
	IsDebitNote	SMALLINT DEFAULT 0, -- 0=??.???????????? 1=?????????????
	IsProcessOK SMALLINT DEFAULT 0, -- 0=????????? 1=??????
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=?????????? 1=???????
	IsPostGL	SMALLINT DEFAULT 0, -- 0=??.????????????? 1=??????????????
	GLTransData	SMALLINT DEFAULT 0, -- 0=auto 1=manual
	PayBillStatus	SMALLINT DEFAULT 0, -- 1 ??.???????
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RecurName	VARCHAR(40),
	ExchangeProfit	MONEY DEFAULT 0.0,
	CustTypeCode	VARCHAR(10),
	CustGroupCode	VARCHAR(10),
	
	IsConditionSend SMALLINT DEFAULT 0,
	OwnReceive VARCHAR(255),
	CarLicense VARCHAR(30),
	SOStatus	SMALLINT DEFAULT 0, -- 0=สั่งขาย 1=สั่งจอง
	HoldingStatus SMALLINT DEFAULT 0, -- 0=ไม่ Holding 1= Holding
	TotalTransport	MONEY DEFAULT 0.0, -- ค่าขนส่ง
	SumOtherValue	MONEY DEFAULT 0.0, -- รวมค่าอื่น
	TimeTransport		VARCHAR(10),	-- เวลาข่นส่ง
	CarType		VARCHAR(10), -- ประเภทรถ
	CondPayCode	VARCHAR(10)  --เงื่อนไขการชำระเงิน
    PRIMARY KEY(ROWORDER)
);
create index IDX_RECT1 ON BCRecurTemp(docno);
create index IDX_RECT2 ON BCRecurTemp(docdate);
create index IDX_RECT3 ON BCRecurTemp(arcode);
create index IDX_RECT4 ON BCRecurTemp(arcode,docno);
create index IDX_RECT5 ON BCRecurTemp(arcode,docdate);


create table BCRecurTempSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BehindIndex	SMALLINT DEFAULT 1, -- 1=???? ???????? Sort ?????.?? Stock Card ??? DocDate,BehindIndex,MyType
	MyType	SMALLINT DEFAULT 0, -- 0 = ยังไม่เอาไปทำ Sale Order, 1 = ทำ Sale Order แล้ว
	DocNo	VARCHAR(20),
	RecurName	VARCHAR(40),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxNo	VARCHAR(20),
	TaxType	SMALLINT DEFAULT 0,
	ItemCode	VARCHAR(25),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	RemainQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือหลังตัด
	CNQty	MONEY DEFAULT 0.0,
	Qty	MONEY DEFAULT 0.0,
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	SumOfCost	MONEY DEFAULT 0.0, -- ????????????.???? ???????????????????????
	SumOfCost2	MONEY DEFAULT 0.0,
	BalanceAmount	MONEY DEFAULT 0.0,
	UnitCode	VARCHAR(10),
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	OppositePrice2	MONEY DEFAULT 0.0, -- ??????????????? 2 (????)
	SORefNo	VARCHAR(20),
	StockType	SMALLINT DEFAULT 0,
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=??????? 1=?????????? 2=??????????????
	LineNumber	SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ??.????????????.??.???????????????
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=??.???Cancel 1=Cancel
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	SOStatus	SMALLINT DEFAULT 0, -- 0=สั่งขาย 1=สั่งจอง
	HoldingStatus SMALLINT DEFAULT 0, -- 0=ไม่ Holding 1= Holding
	BarCode	VARCHAR(20),
	CustTypeCode	VARCHAR(10),
	CustGroupCode	VARCHAR(10),
	SaleAreaCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),	
	GroupCode	VARCHAR(10),	
	BrandCode	VARCHAR(10), 
	TypeCode	VARCHAR(10),	
	FormatCode	VARCHAR(10),	
	PosStatus SMALLINT DEFAULT 0, 
	IsPromotion SMALLINT DEFAULT 0, 
	PremiumStatus SMALLINT DEFAULT 0,
	--Auto Packing Section by ??
	FixUnitCost	MONEY DEFAULT 0.0,
	FixUnitQty		MONEY DEFAULT 0.0,
--support color,size,style
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	IsConditionSend SMALLINT DEFAULT 0,
	TransportAmount	MONEY DEFAULT 0.0,
	OtherValue	MONEY DEFAULT 0.0,
	REMAINPAYQTY	MONEY DEFAULT 0.0,
	ISPAYMENT SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);
create index IDX_RECS1 ON BCRecurTempSub(docno);
create index IDX_RECS2 ON BCRecurTempSub(docdate);
create index IDX_RECS3 ON BCRecurTempSub(arcode);
create index IDX_RECS4 ON BCRecurTempSub(arcode,docno);
create index IDX_RECS5 ON BCRecurTempSub(arcode,docdate);
create index IDX_RECS6 ON BCRecurTempSub(barcode);
create index IDX_RECS7 ON BCRecurTempSub(docno,linenumber);
create index IDX_RECS8 ON BCRecurTempSub(linenumber);
create index IDX_RECS9 ON BCRecurTempSub(itemcode,unitcode,whcode,shelfcode);
create index IDX_RECS10 ON BCRecurTempSub(itemcode);
create index IDX_RECS11 ON BCRecurTempSub(BehindIndex);

create table BCQuotationStatus -- สถานะการเสนอราคา
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);
create index IDX_QAS1 ON BCQuotationStatus(roworder);

create table BCContactList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50)	NOT NULL,
	Address	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Telephone	VARCHAR(30),
	ParentCode	VARCHAR(20) NOT NULL,
	MyType	SMALLINT	DEFAULT 0 NOT NULL,
	PictureFileName	VARCHAR(255),
	CardPicFileName	VARCHAR(255),
	PersonPosition	VARCHAR(50),
	DefaultStatus	SMALLINT,
	MyJob VARCHAR(50),
--for address by aom
	companyname VARCHAR(255),
	isdefault SMALLINT DEFAULT 0,
	restype VARCHAR(255),
	contactno varchar(10),
	moo varchar(10),
	village VARCHAR(255),
	building VARCHAR(255),
	floor varchar(10),
	room varchar(10),
	soi VARCHAR(255),
	road VARCHAR(255),
	subdist VARCHAR(255),
	district VARCHAR(255),
	province VARCHAR(255),
	country VARCHAR(255),
	zipcode varchar(10)
    PRIMARY KEY(Code,ParentCode,MyType)
);

CREATE  INDEX IDX_CCLNAME ON BCContactList(NAME);
CREATE  INDEX IDX_CCLPCODE ON BCContactList(ParentCode);
CREATE  INDEX IDX_CCLTYPE	ON BCContactList(MyType);

-- เก็บรหัสธนาคาร
create table BCBank
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);
create index IDX_BANK_ROWORDER ON BCBank(roworder);

-- เก็บรหัสสาขาธนาคาร
create table BCBankBranch
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);
create index IDX_BANKBranchROW ON BCBankBranch(roworder);

-- เก็บรหัสสมุดเงินฝากธนาคาร
create table BCBankBook
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	BookNo	VARCHAR(30) NOT NULL, -- เลขที่บัญชี
	Name	VARCHAR(255), -- ชื่อบัญชี
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AccountType	VARCHAR(10) , -- รหัสประเภทบัญชีธนาคาร	
	BankCode	VARCHAR(50), -- รหัสธนาคาร
	BranchCode	VARCHAR(10),-- รหัสสาขาธนาคาร
	AccountCode	VARCHAR(20),-- รหัสบัญชี GL	
	Balance	MONEY	DEFAULT 0.0-- ยอดคงเหลือ
    PRIMARY KEY(BookNo)
);
create index IDX_BANKBOOKNO ON BCBankBook(BankCode,BookNo);
create index IDX_BANKBOOKACC ON BCBankBook(Accountcode);
create index IDX_BANKBOOKCODE ON BCBankBook(BankCode);

-- เก็บรหัสผู้ติดต่อธนาคาร
create table BCBankConHD
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BankCode	VARCHAR(50), -- รหัสธนาคาร
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BranchCode	VARCHAR(10)-- รหัสสาขาธนาคาร
    PRIMARY KEY(ROWORDER)
);
create index IDX_BANKHD_BANKCODE ON BCBankConHD(BankCode);
create index IDX_BANKHD_BRANCHCODE ON BCBankConHD(BranchCode);

-- เก็บรหัสผู้ติดต่อธนาคาร
create table BCBankContact
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	BankCode	VARCHAR(50), -- รหัสธนาคาร
	BranchCode	VARCHAR(10),-- รหัสสาขาธนาคาร	
	BookNo	VARCHAR(30) NOT NULL, -- เลขที่บัญชีธนาคาร
	Code	VARCHAR(10) NOT NULL, -- รหัสผู้ติดต่อ
	Name	VARCHAR(50)	NOT NULL, -- ชื่อผู้ติดต่อ
	Address	VARCHAR(255), -- ที่อยู่
	Telephone	VARCHAR(30), -- เบอร์โทร
	PictureFileName	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CardPicFileName	VARCHAR(255),
	PersonPosition	VARCHAR(50),
	DefaultStatus	SMALLINT DEFAULT 1 	-- 1=ติดต่อ   0=ไม่ติดต่อ
    PRIMARY KEY(ROWORDER)
);
create index IDX_BANKCT_BANKCODE ON BCBankContact(BankCode);
create index IDX_BANKCT_CODE ON BCBankContact(Code);
create index IDX_BANKCT_BRANCHCODE ON BCBankContact(BranchCode);
create index IDX_BANKCT_CBCODE ON BCBankContact(Code,BankCode);
-- Currency 
-- jum 2-9-2004
create table BCCurrency
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,-- currency code
	Name	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DispWording VARCHAR(20),-- Currency name example Dollar
	DispWording2 VARCHAR(20),-- After decimal currency sub word example cent
	Fullstopword VARCHAR(50),-- Currency full stop word example only
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	ExchangeDate	DATETIME,
	Symbol	VARCHAR(2)	DEFAULT 'B'
    PRIMARY KEY(CODE)
);
--	Currency exchange rate
-- jum 2-9-2004
create table bccurexchangerate
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Code	VARCHAR(10) NOT NULL,-- currency code
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, --exchange rate
	ExchangeDate	DATETIME NOT NULL
	PRIMARY KEY(CODE,ExchangeDate)
);	
CREATE INDEX IDX_CUR1_1 ON bccurexchangerate(CODE);
CREATE INDEX IDX_CUR1_2 ON bccurexchangerate(ExchangeDate);


-- เก็บรหัสประเภทบัญชีธนาคาร
create table BCBankAccount
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

 -- เก็บอัตราดอกเบี้ยของธนาคาร
create table BCBankInterests
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BankCode	VARCHAR(10) NOT NULL, -- รหัสธนาคาร
	AccountType	VARCHAR(10) NOT NULL, -- รหัสประเภทบัญชีธนาคาร
	Interests		DECIMAL(19,10) DEFAULT 0.0, -- อัตราดอกเบี้ย
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription  VARCHAR(255)
	PRIMARY KEY(ROWORDER)
);
create index IDX_INTERESTS_1 ON BCBankInterests ( BankCode );
create index IDX_INTERESTS_2 ON BCBankInterests ( AccountType );

 -- เก็บประวัติอัตราดอกเบี้ยของธนาคาร
create table BCInterestsLog
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BankCode	VARCHAR(10) NOT NULL, -- รหัสธนาคาร
	AccountType	VARCHAR(10) NOT NULL, -- รหัสประเภทบัญชีธนาคาร
	Interests		DECIMAL(19,10) DEFAULT 0.0, -- อัตราดอกเบี้ย
	IsExport smallint default 0,
	MyDescription  VARCHAR(255),
	CREATORCODE	VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
	PRIMARY KEY(ROWORDER)
);
create index IDX_INTERESTSL_1 ON BCInterestsLog ( BankCode );
create index IDX_INTERESTSL_2 ON BCInterestsLog ( AccountType );
create index IDX_INTERESTSL_3 ON BCInterestsLog ( CreateDateTime );

--	Currency exchange rate
-- jum 2-9-2004
create table BCCurrencyExch
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,-- currency code
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, --exchange rate
	ExchangeDate	DATETIME,
    PRIMARY KEY(CODE)
);

CREATE INDEX IDX_CUR2_1 ON BCCurrencyExch(CODE);
CREATE INDEX IDX_CUR2_2 ON BCCurrencyExch(ExchangeDate);

-- Bank interest
create table BCBankCurrency
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BankCode	VARCHAR(10) NOT NULL, -- รหัสธนาคาร
	CurrencyCode	VARCHAR(10) NOT NULL,-- รหัสรหัสสกุลเงิน
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- อัตราดอกเบี้ย
	ExchangeDate	DATETIME, -- วันที่
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription  VARCHAR(255)	
	PRIMARY KEY(ROWORDER)
);

create index IDX_CURRENBANKCODE ON BCBankCurrency ( BankCode );
create index IDX_CURRENCODE ON BCBankCurrency ( CurrencyCode );

-- เก็บอัตราแลกเปลี่ยน
create table BCCurrencyLog
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BankCode	VARCHAR(10) NOT NULL, -- รหัสธนาคาร
	CurrencyCode	VARCHAR(10) NOT NULL,-- รหัสรหัสสกุลเงิน
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- อัตราดอกเบี้ย
	ExchangeDate	DATETIME, -- วันที่
	IsExport smallint default 0,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDescription  VARCHAR(255),
	CREATORCODE	VARCHAR(10),
	CREATEDATETIME		DATETIME		
	PRIMARY KEY(ROWORDER)
);
create index IDX_CURRENCYLBANKCODE ON BCCurrencyLog ( BankCode );
create index IDX_CURRENCYLCODE ON BCCurrencyLog ( CurrencyCode );
create index IDX_CURRENCYLEXCHANGE ON BCCurrencyLog ( ExchangeDate );


-- เก็บรหัสบริการของธนาคาร
create table BCBankService
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

-- เก็บค่าบริการของธนาคาร
create table BCServiceFee
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ServiceCode	VARCHAR(10) NOT NULL,--รหัสบริการของธนาคาร
	BankCode	VARCHAR(10) NOT NULL, -- รหัสธนาคาร
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ServiceFee	MONEY DEFAULT 0.0, -- อัตราค่าบริการ
	MyDescription  VARCHAR(255)		
    PRIMARY KEY(ROWORDER )
);
create index IDX_SERVICEF_1 ON BCServiceFee ( ServiceCode );
create index IDX_SERVICEF_2 ON BCServiceFee ( BankCode );

-- เก็บรหัสสถานะเช็คเพิ่มเติม
CREATE TABLE BCChqStatus
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	NAME	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);
create index IDX_CHQSTATUSROW ON BCChqStatus ( Roworder );

-- เก็บประวัติการเปลี่ยนสถานะ้เช็ค
CREATE TABLE BCChqStatusLog
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ChqType	SMALLINT DEFAULT 0, 	-- 1=เช็คจ่าย   0=เช็ครับ
	CHQNUMBER	VARCHAR(20),
	BANKCODE	VARCHAR(10),
	BANKBRANCHCODE	VARCHAR(10),
	StatusCODE	VARCHAR(10),--รหัสสถานะเช็คเพิ่มเติม
	IsExport smallint default 0,
	CREATORCODE	VARCHAR(10),
	CREATEDATETIME		DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);
create index IDX_CQLOG_CHQNUMBER ON BCChqStatusLog(CHQNUMBER);
create index IDX_CQLOG_BANKCODE ON BCChqStatusLog(BANKCODE);
create index IDX_CQLOG_BRANCHCODE ON BCChqStatusLog(BANKBRANCHCODE);


CREATE TABLE BCCreditLimit
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code VARCHAR(10) NOT NULL,
	Name VARCHAR(50),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CreditCheck SMALLINT DEFAULT 0,  -- ตรวจสอบยอดวงเงิน
	ChqReturnCheck SMALLINT DEFAULT 0, -- ตรวจสอบเช็คคืน
	OverDueCheck SMALLINT DEFAULT 0, -- ตรวจสอบ invoice เกินกำหนดชำระ
	OverDay SMALLINT DEFAULT 0, -- จำนวนวันที่เกินกำหนด
	CreditExpireCheck SMALLINT DEFAULT 0, -- ตรวจสอบวงเงินหมดอายุ
	ExpireDay SMALLINT DEFAULT 0 -- จำนวนวันหมดอายุ
	PRIMARY KEY(Code)
);
--create index IDX_BCCRELIM_1 ON BCCreditLimit( Code);

CREATE TABLE BCArCreditGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
    iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	Code VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name VARCHAR(255),
	LimitCode VARCHAR(10),
	IsGroup SMALLINT DEFAULT  0,-- ถ้าเป็นกลุ่ม
	Amount  MONEY DEFAULT 0.0, -- จำนวนเงินกลุ่ม
	Expire_Date DATETIME,
	StartDate DATETIME,
	CleanValue MONEY DEFAULT 0.0,  -- วงเงินไม่มีหลักทรัพ	
	MyDescription VARCHAR(255),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	MaxAmount  MONEY DEFAULT 0.0
	PRIMARY KEY(Code)
);
--create index IDX_BCCREGRP_1 ON BCArCreditGroup( Code);


CREATE TABLE BCArCreditGrpDe
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	LineNumber  SMALLINT DEFAULT  0,
	MasterCode VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	RefDocNo VARCHAR(20) ,
	StartDate DATETIME,
	Expire_Date DATETIME,	
	MyDescription VARCHAR(255),
	Amount  MONEY DEFAULT 0.0,
	InsureType  VARCHAR(10) 		
	PRIMARY KEY(ROWORDER)
);
create index IDX_CREGRPDE_CODE ON BCArCreditGrpDe( MasterCode);
create index IDX_CREGRPDE_LINE ON BCArCreditGrpDe( LineNumber );
create index IDX_CREGRPDE_REFNO ON BCArCreditGrpDe( RefDocNo);

CREATE TABLE BCCondMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code  VARCHAR(10) NOT NULL, --รหัสเงื่อนไข
	IsExport smallint default 0,
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CreatorCode	VARCHAR(10), --รหัสผู้บันทึก
	DocDate DATETIME, --วันที่ประมวลผล
	SystemName VARCHAR(20) NOT NULL, --เลขที่ เพื่อบอกว่าอยู่ระบบไหน เช่น BillAuto
	MyDescription	VARCHAR(255)
	PRIMARY KEY(Code)
);
--create index IDX_CondMaster_ONE ON BCCondMaster(Code);
create index IDX_CondMaster_TWO ON BCCondMaster(Docdate);

CREATE TABLE BCCondDocDate
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code  VARCHAR(10) NOT NULL, --รหัสเงื่อนไข
	SystemName VARCHAR(20) NOT NULL, --เลขที่ เพื่อบอกว่าอยู่ระบบไหน เช่น BillAuto
	LineNumber  SMALLINT DEFAULT  0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TypeName	VARCHAR(20),  --ชื่อชนิด เช่น DocDate,DueDate
	StartFormulaDate VARCHAR(20), --จากวันที่
	StopFormulaDate VARCHAR(20),	--ถึงวันที่
	StartDate DATETIME, --จากวันที่
	StopDate DATETIME	--ถึงวันที่
	PRIMARY KEY(ROWORDER)
);
create index IDX_CondDocDate_ONE ON BCCondDocDate(Code);
create index IDX_CondDocDate_TWO ON BCCondDocDate(Linenumber);

CREATE TABLE BCCondLinkCode
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code  VARCHAR(10) NOT NULL, --รหัสเงื่อนไข
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SystemName VARCHAR(20) NOT NULL, --เลขที่ เพื่อบอกว่าอยู่ระบบไหน เช่น BillAuto
	LineNumber  SMALLINT DEFAULT  0,
	TypeName	VARCHAR(20),  --ชื่อชนิด เช่น ArCode,ItemCode,A
	StartCode	VARCHAR(20), 
	StopCode	VARCHAR(20)
	PRIMARY KEY(ROWORDER)
);
create index IDX_CondLinkCodeOne ON BCCondLinkCode(Code);
create index IDX_CondLinkCodeTwo ON BCCondLinkCode(Linenumber);

CREATE TABLE BCCondOrderBy
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code  VARCHAR(10) NOT NULL, --รหัสเงื่อนไข
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SystemName VARCHAR(20) NOT NULL, --เลขที่ เพื่อบอกว่าอยู่ระบบไหน เช่น BillAuto
	LineNumber  SMALLINT DEFAULT  0,
	OrderCode	VARCHAR(20)
	PRIMARY KEY(ROWORDER)
);
create index IDX_CondOrderByOne ON BCCondOrderBy(Code);
create index IDX_CondOrderByTwo ON BCCondOrderBy(OrderCode);
create index IDX_CondOrderByThree ON BCCondOrderBy(Linenumber);

create table BCInsureType
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UserGroup VARCHAR(255)	
    PRIMARY KEY(CODE)
);
--create index IDX_InsureType ON BCInsureType(Code);

--create table bcprocesslog
--(
--	ROWORDER INT NOT NULL IDENTITY(0,1),
--	DOCNO VARCHAR(30), --document number to process
--	MODE SMALLINT DEFAULT 0,--0=normal 1=delete 2=cancel
--	TRANSTYPE SMALLINT, --see more information
--	TRANSSTATE SMALLINT DEFAULT 0, --0 wait for process 1=processed
--	INSERTTIME DATETIME ,--insert  to process log time
--	PROCESSTIME DATETIME --process at time
--	PRIMARY KEY(ROWORDER)
--);
--create index IDX_processlog1 ON bcprocesslog(Docno);
--
-- BC5Process Extention script
-- Add by jum 08-02-2003 at BKK

CREATE TABLE processbarcode
(
	roworder int  NOT NULL IDENTITY(1,1),
	itemcode VARCHAR(50)
	PRIMARY KEY(ROWORDER)
);


CREATE TABLE processstatus 
(
	roworder int  NOT NULL IDENTITY(1,1),
	ItemCode varchar(50),
	DocDate datetime,
	ProcessFlag SMALLINT DEFAULT 0,
	FlowStatus SMALLINT DEFAULT 1,
	roworderref int,
	guid	char(32),
	processtype smallint default 0,
	processcase smallint default 0  
	PRIMARY KEY(ROWORDER)
);
create index IDX_processstatus1 ON processstatus(ItemCode);
create index IDX_processstatus2 ON processstatus(ItemCode,Docdate);
create index IDX_processstatus3 ON processstatus(Docdate);


-- Jam by aom 29-03-2003

CREATE TABLE processstatus2 
(
	roworder int  NOT NULL IDENTITY(1,1),
	ItemCode varchar(50),
	DocDate datetime,
	ProcessFlag SMALLINT DEFAULT 0,
	FlowStatus SMALLINT DEFAULT 1,
	guid	char(32),
	processtype smallint default 0,
	processcase smallint default 0     
	PRIMARY KEY(ROWORDER)
);
create index IDX_processstatus21 ON processstatus2(ItemCode);
create index IDX_processstatus22 ON processstatus2(ItemCode,Docdate);
create index IDX_processstatus23 ON processstatus2(Docdate);

CREATE TABLE processstock 
(
	RowOrder int  NOT NULL IDENTITY(1,1),
	ItemCode VARCHAR(50),
	DocDate datetime,
	ProcessFlag SMALLINT DEFAULT 0,
	FlowStatus SMALLINT DEFAULT 1,
	guid	char(32),
	processtype smallint default 0,
	processcase smallint default 0,
	StockRetroact smallint default 0 
	PRIMARY KEY(ROWORDER) 
);
create index IDX_processstock1 ON processstock(ItemCode);
create index IDX_processstock2 ON processstock(ItemCode,Docdate);
create index IDX_processstock3 ON processstock(Docdate);

CREATE TABLE processdoc 
(
	RowOrder int  NOT NULL IDENTITY(1,1),
	DocNo VARCHAR(50),
	DocType int DEFAULT 0,
	ProcessFlag SMALLINT DEFAULT 0,
	guid	char(32)  
	PRIMARY KEY(ROWORDER)	
);
create index IDX_processdoc1 ON processdoc(DocNo);

CREATE TABLE processstatus3
(
	roworder int  NOT NULL IDENTITY(1,1),
	ItemCode varchar(50),
	DocDate datetime,
	ProcessFlag SMALLINT DEFAULT 0,
	FlowStatus SMALLINT DEFAULT 1,
	roworderref int,
	guid	char(32),
	processtype smallint default 0,
	processcase smallint default 0  
	PRIMARY KEY(ROWORDER)
);
create index IDX_processstatus31 ON processstatus3(ItemCode);
create index IDX_processstatus32 ON processstatus3(ItemCode,Docdate);
create index IDX_processstatus33 ON processstatus3(Docdate);
create index IDX_ROWODR ON processstatus3(roworder);

-- Firm Industry : Modify  17/12/2545  by or CommissionOil
create table BCComOil
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	AtMonth	SMALLINT DEFAULT 0,	-- ประจำเดือน 0 = มกราคม ...
	AtYear SMALLINT DEFAULT 0, -- ประจำปี
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AtDate		DATETIME,  -- พิมพ์ ณ วันที่
	CarPerKM	MONEY DEFAULT 0.0,
	BikePerKM	 MONEY DEFAULT 0.0,
	Remark		VARCHAR(255),
	Amount		MONEY DEFAULT 0.0
	PRIMARY KEY (ROWORDER)
);
create index IDX_COMOIL_AM ON BCComOil( AtMonth );
create index IDX_COMOIL_YM ON BCComOil(AtYear,AtMonth );

create table BCComOilSub
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	AtMonth	SMALLINT DEFAULT 0,	-- ประจำเดือน
	AtYear SMALLINT DEFAULT 0, -- ประจำปี
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SaleCode		VARCHAR(30),  -- พิมพ์ ณ วันที่
	TargetAmount	MONEY DEFAULT 0.0, -- เป้ายอดขาย
	ReceiptAmount	 MONEY DEFAULT 0.0, -- ยอดรับเงินสุทธิ
	SaleAmount		MONEY DEFAULT 0.0, -- ยอดขายสุทธิ(รวม E)
	PercentTarget		MONEY DEFAULT 0.0, -- %เป้ายอดขาย
	ESaleAmount		MONEY DEFAULT 0.0,  -- ยอดขาย E 
	SaleTotalAmount		MONEY DEFAULT 0.0,  -- ยอดขายสุทธิหักยอดขาย E
	ComRate		MONEY DEFAULT 0.0,  -- อัตราค่าคอม
	ComCalAmount		MONEY DEFAULT 0.0, -- จากการคำนวณค่าคอม
	TrueReceiptAmount		MONEY DEFAULT 0.0,  -- รับจริง(หัก 50 %)
	CarLicense		VARCHAR(20), -- ทะเบียนรถ
	KM		MONEY DEFAULT 0.0, -- ระยะทาง
	OilCalOld		MONEY DEFAULT 0.0, -- ค่าคอมคิดตามวิธีเดิม
	OilCalSale		MONEY DEFAULT 0.0, -- ค่าคอมคิดตามระบบการขาย
	ComAmount		MONEY DEFAULT 0.0, --รวมรายได้
	DebitAmount		MONEY DEFAULT 0.0, -- เพิ่มหนี้
	DiscountAmount		MONEY DEFAULT 0.0, -- ส่วนลดจ่าย
	ReturnAmount		MONEY DEFAULT 0.0, -- รับคืน
	CarType SMALLINT DEFAULT 0	-- ประเภทรถ 0 = รถยนต์   1 = จักรยานยนต์
	PRIMARY KEY (ROWORDER)
);
create index IDX_BCCOMOILSUB_ATMON ON BCComOilSub (AtMonth);
create index IDX_BCCOMOILSUB_SALECODE ON BCComOilSub (SaleCode);
create index IDX_BCCOMOILSUB_AYAM ON BCComOilSub (AtYear,AtMonth);

-- วิธีการชำระเงิน ตัว Pro มีแล้ว
create table BCPaymentType
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCUserGroup
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(255) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);
create index idx_usergroup1 on BCUserGroup(roworder);


---------------  กำหนดราคาตั้งของสินค้า -----------------
create table BCPriceErect
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25)  NOT NULL,
	UnitCode VARCHAR(10) , 
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	PriceErect VARCHAR(50), -- ราคาตั้งของสินค้า สูตร
	MyDescription	VARCHAR(255)
    PRIMARY KEY(ROWORDER)
);
create index idx_priceE1 on BCPriceErect(ItemCode);

create table BCItemWarehouse
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	WHCode	VARCHAR(10) NOT NULL,
	ShelfCode	VARCHAR(10)
    PRIMARY KEY(ROWORDER)
);
create index idx_ItemWH1 on BCItemWarehouse(ItemCode);
create index idx_ItemWH2 on BCItemWarehouse(ItemCode,Whcode,ShelfCode);
create index idx_ItemWH3 on BCItemWarehouse(WHcode);
create index idx_ItemWH4 on BCItemWarehouse(SHelfCode);

create table Reportstatus
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	sessionid varchar(50) not null,--unique report request 
	reportid varchar(25) not null, --report id
	isfinish smallint default 0,
	reqtime datetime,
	finishtime datetime,
	StartDate datetime,
	StopDate datetime,
	GroupBy varchar(50),
	outfilename varchar(255),
	condition varchar(1500),
	condition2 varchar(1500),
	condition3 varchar(1500),
	condition4 varchar(1500),
	condition5 varchar(1500),
	Progress int default 0,
	StockRetroact smallint default 0
	primary key (sessionid)
);
create index idx_ReportST1 on Reportstatus(ReportID);

-- for report dialog by aom
create table FieldDetail
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IdCode VARCHAR(255),
	TableName varchar(255),
	FieldData varchar(255),
	MyDescription varchar(255),
	FieldType VARCHAR(255),
	LinkTable varchar(255)
	primary key (ROWORDER)
);

create index IDX_FIELDDETAIL_IDCODE on FieldDetail(IdCode);
create index IDX_FIELDDETAIL_TWO on FieldDetail(TableName);
create index IDX_FIELDDETAIL_THREE on FieldDetail(LinkTable);
create index IDX_FIELDDETAIL_FOUR on FieldDetail(IdCode,LinkTable);

create table FieldConfig
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IdCode VARCHAR(255),
	TableName varchar(255),
	FieldData varchar(255),
	MyDescription varchar(255),
	FieldType VARCHAR(255),
	LinkTable varchar(255)
	primary key (ROWORDER)
);
create index IDX_FIELDFIG_IDCODE on FieldConfig(IdCode);
create index IDX_FIELDFIG_TNAME on FieldConfig(TableName);
create index IDX_FIELDFIG_LINK on FieldConfig(LinkTable);
create index IDX_FIELDFIG_IDLINK on FieldConfig(IdCode,LinkTable);

create table bcpovoid
(
	Roworder int not null IDENTITY(0,1),
	isconfirm smallint default 0,
	Docno varchar(20) not null,--Document Number
	Docdate datetime not null, --Document Date
	DepartCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RequestUID varchar(10), --Requset to void
	ApproveUID varchar(10), --Approve user 
	TotalAmount	money default 0.0,--summary of detail amount
	VoidReasonCode varchar(10),--void reason code
	Remark VARCHAR(255),       --Transaction comment
	ConfirmCode	VARCHAR(10),--Confirm user
	ConfirmDateTime	DATETIME,   --confirm date time
	CancelCode	VARCHAR(10),--Cancel user
	CancelDateTime	DATETIME,   --Cancel date time
	IsCancel smallint default 0,
	IsProcessOK SMALLINT DEFAULT 0,
	IsCompleteSave	SMALLINT DEFAULT 0
	Primary Key(Docno)
);

create index idx_povoid_docdate on bcpovoid(docdate);
create index idx_povoid1 on bcpovoid(docno,docdate);
create index idx_povoid2 on bcpovoid(roworder);

create table bcpovoidsub
(
	Roworder INT NOT NULL IDENTITY(0,1),
	Docno VARCHAR(20) NOT NULL,   --Document Number
	Docdate datetime NOT NULL, --Document Date
	APCode VARCHAR(20),           --Supplier or Vender code
	PONo VARCHAR(20) NOT NULL,    --PO Number to void
	DepartCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),
	GroupCode	VARCHAR(10),
	BrandCode	VARCHAR(10),
	TypeCode	VARCHAR(10),
	FormatCode	VARCHAR(10),
	ItemCode VARCHAR(35) NOT NULL,      --Product code
	MyDescription	VARCHAR(255),       --Product comment	
	Price MONEY DEFAULT 0.0,            --Unit price
	UnitCode VARCHAR(10) NOT NULL,      --Unit code
	WHCode VARCHAR(15),
	ShelfCode VARCHAR(15),
	Qty MONEY DEFAULT 0.0,            --PO Qty
	VoidQty MONEY DEFAULT 0.0,          --Void Qty
	PODate datetime,
	PODueDate datetime,
	Amount money default 0.0,
	VoidAmount money default 0.0,
	CancelAll	SMALLINT DEFAULT 0,
	IsCancel SMALLINT DEFAULT 0,        --Cancel status 1=Cancel 
	LineNumber	SMALLINT DEFAULT 0, --Line of list
	RefLineNumber SMALLINT DEFAULT 0,   --PO line number from PO referance doc.
	TransState 	SMALLINT DEFAULT 0, --0 = new transaction 1 = old transaction 
--for bcservice
	BehindIndex	SMALLINT DEFAULT 1,
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
	Primary Key(roworder)
);

create index idx_povoids_docdate on bcpovoidsub(docdate);
create index idx_povoids_apcode on bcpovoidsub(apcode);
create index idx_povoids_po  on bcpovoidsub(pono);
create index idx_povoids_Itemcode on bcpovoidsub(itemcode);
create index idx_povoids1 on bcpovoidsub(itemcode,whcode,shelfcode,linenumber);
create index idx_povoids2 on bcpovoidsub(apcode,pono);
create index idx_povoidsservice on bcpovoidsub(itemcode,docdate,behindindex);
CREATE  INDEX IDX_POVOIDISPROCESS ON bcpovoidsub(ItemCode,IsProcess);
CREATE  INDEX IDX_POVOIDPAK1 ON bcpovoidsub(PackingRate1);
CREATE  INDEX IDX_POVOIDPAK2 ON bcpovoidsub(PackingRate2);
CREATE  INDEX IDX_POVOIDISPC ON bcpovoidsub(IsProcess);

create table bcsovoid
(
	Roworder int not null IDENTITY(0,1),
	isconfirm smallint default 0,
	Docno varchar(20) not null,--Document Number
	Docdate datetime not null, --Document Date
	DepartCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RequestUID varchar(10), --Requset to void
	ApproveUID varchar(10), --Approve user 
	TotalAmount	money default 0.0,--summary of detail amount
	VoidReasonCode varchar(10),--void reason code
	Remark VARCHAR(255),       --Transaction comment
	ConfirmCode	VARCHAR(10),--Confirm user
	ConfirmDateTime	DATETIME,   --confirm date time
	CancelCode	VARCHAR(10),--Cancel user
	CancelDateTime	DATETIME,   --Cancel date time
	IsCancel smallint default 0,
	IsProcessOK SMALLINT DEFAULT 0,
	IsCompleteSave	SMALLINT DEFAULT 0
	Primary Key(Docno)
);

create index idx_sovoid_docdate on bcsovoid(docdate);
create index idx_sovoid1 on bcsovoid(docno,docdate);
create index idx_sovoid2 on bcsovoid(roworder);

create table bcsovoidsub
(
	Roworder INT NOT NULL IDENTITY(0,1),
	Docno VARCHAR(20) NOT NULL,   --Document Number
	Docdate DATETIME NOT NULL, --Document Date
	ARCode VARCHAR(20),           --Customer COde
	SONo VARCHAR(20) NOT NULL,    --SO Number to void
	DepartCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),
	GroupCode	VARCHAR(10),
	BrandCode	VARCHAR(10),
	TypeCode	VARCHAR(10),
	FormatCode	VARCHAR(10),
	ItemCode VARCHAR(35) NOT NULL,      --Product code
	MyDescription	VARCHAR(255),       --Product comment	
	Price MONEY DEFAULT 0.0,            --Unit price
	UnitCode VARCHAR(10) NOT NULL,      --Unit code
	WHCode VARCHAR(15),
	ShelfCode VARCHAR(15),
	Qty MONEY DEFAULT 0.0,            --SO Qty
	VoidQty MONEY DEFAULT 0.0,          --Void Qty
	SODate datetime,
	SODueDate datetime,
	Amount money default 0.0,
	VoidAmount money default 0.0,
	CancelAll	SMALLINT DEFAULT 0,
	IsCancel SMALLINT DEFAULT 0,        --Cancel status 1=Cancel 
	LineNumber	SMALLINT DEFAULT 0, --Line of list
	RefLineNumber SMALLINT DEFAULT 0,   --PO line number from PO referance doc.
	TransState 	SMALLINT DEFAULT 0, --0 = new transaction 1 = old transaction 
--for bcservice
	BehindIndex	SMALLINT DEFAULT 1,
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
	Primary Key(roworder)
);

create index idx_sovoids_docdate on bcsovoidsub (docdate);
create index idx_sovoids_apcode on bcsovoidsub (arcode);
create index idx_sovoids_so  on bcsovoidsub (sono);
create index idx_sovoids_Itemcode on bcsovoidsub (itemcode);
create index idx_sovoids1 on bcsovoidsub (itemcode,WHcode,ShelfCode,Linenumber);
create index idx_sovoids2 on bcsovoidsub (docdate,docno);
create index idx_sovoids3 on bcsovoidsub (arcode,docno);
create index idx_sovoidsservice on bcsovoidsub (itemcode,docdate,behindindex);
CREATE  INDEX IDX_SOVOIDISPROCESS ON bcsovoidsub(ItemCode,IsProcess);
CREATE  INDEX IDX_SOVOIDPAK1 ON bcsovoidsub(PackingRate1);
CREATE  INDEX IDX_SOVOIDPAK2 ON bcsovoidsub(PackingRate2);
CREATE  INDEX IDX_SOVOIDISPC ON bcsovoidsub(IsProcess);

CREATE TABLE processitemreport 
(
	ROWORDER INT NOT NULL IDENTITY(1,1),
	ItemCode VARCHAR(50),
	DocDate DATETIME, 
	sessionid VARCHAR(50),
	guid	char(32),
	processflag smallint default 0 
	Primary Key(ROWORDER)
);
create index IDX_PROCESSOITEMREP1 ON processitemreport(ItemCode);
create index IDX_PROCESSOITEMREP2 ON processitemreport(sessionid);


CREATE TABLE BCCancelReason 
(
	ROWORDER INT NOT NULL IDENTITY(1,1),
	Code VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name VARCHAR(255),
	UserGroup VARCHAR(255)
	Primary Key(ROWORDER)
);
create index IDX_CancelReasCode ON BCCancelReason(Code);

----------------------------- มาจาก อุบล -----------------------------------
create table  BCCAR
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL, --รหัสประเภทรถ
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	NAME	VARCHAR(50) NOT NULL,	--ชื่อประเภทรถ
    PRIMARY KEY(CODE)
);
create index IDX_CARROWORDER ON BCCAR(RowOrder);

CREATE TABLE BCCARIDFORPO    -- บันทึกทะเบียนรถสำหรับใบสั่งซื้อ(PO) -- อุบลฯ 04/Jan/2002
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DOCNO	VARCHAR(20),  --เลขที่PO
	CARID	VARCHAR(20),	--ทะเบียนรถ
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TransCode 	VARCHAR(10),	--รหัสผู้ขนส่ง	
	DocDate		DATETIME, --วันที่รับสินค้า
	PointReceive		VARCHAR(10), --จุดรับสินค้า
	Mydescription	VARCHAR(255),
	LineNumber SMALLINT DEFAULT 0,
	COMPANYID  VARCHAR(20)
    PRIMARY KEY(ROWORDER)
);

create index IDX_CARIDFORPO_DOCNO ON BCCARIDFORPO(DocNo);
create index IDX_CARIDFORPO_DOCDATE ON BCCARIDFORPO(DocDate);
create index IDX_CARIDFORPO_LINENO ON BCCARIDFORPO(LineNumber);
create index IDX_CARIDFORPO_COMPANY ON BCCARIDFORPO(CompanyID);
create index IDX_CARIDFORPO_TRANS ON BCCARIDFORPO(TransCode);
create index IDX_CARIDFORPO_CARID ON BCCARIDFORPO(CarID);
create index IDX_CARIDFORPO_NODATE ON BCCARIDFORPO(DocNo,DocDate);

create table BCHistoryAdjustPrice -- ประวัติการปรับราคาขาย
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	UnitCode VARCHAR(10), -- หน่วยนับ
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StartQty MONEY DEFAULT 0.0, -- จากจำนวน
	StopQty MONEY DEFAULT 0.0,-- ถึงจำนวน
	StartDate DATETIME, -- จากวันที่
	StopDate DATETIME, -- ถึงวันที่
	SaleType SMALLINT DEFAULT 0, -- ประเภทการขาย
	TransportType SMALLINT DEFAULT 0, -- เงื่อนการขนส่ง
	SalePrice1	VARCHAR(50),
	SalePrice2	VARCHAR(50),
	SalePrice3	VARCHAR(50),
	SalePrice4	VARCHAR(50),
	SalePrice5	VARCHAR(50),
	SalePrice6	VARCHAR(50),
	SalePrice7	VARCHAR(50),
	SalePrice8	VARCHAR(50),
	SalePrice9	MONEY DEFAULT 0.0,
	SalePrice10	MONEY DEFAULT 0.0,
	SalePrice11	MONEY DEFAULT 0.0,
	SalePrice12	MONEY DEFAULT 0.0,
	SalePrice13	MONEY DEFAULT 0.0,
	SalePrice14	MONEY DEFAULT 0.0,
	SalePrice15	MONEY DEFAULT 0.0,
	SalePrice16	MONEY DEFAULT 0.0,
	SalePrice17	MONEY DEFAULT 0.0,
	SalePrice18	MONEY DEFAULT 0.0,
	SalePrice19	MONEY DEFAULT 0.0,
	SalePrice20	MONEY DEFAULT 0.0,
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	LineNumber SMALLINT DEFAULT 0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	AdjustDesc	VARCHAR(20),
	
	DocNo VARCHAR(20),
	CreateDateTime	DATETIME
    PRIMARY KEY(ROWORDER)
);
create index IDX_HISADJPRICE1 ON BCHistoryAdjustPrice(ItemCode);
create index IDX_HISADJPRICE2 ON BCHistoryAdjustPrice(ItemCode,UnitCode);
create index IDX_HISADJPRICE3 ON BCHistoryAdjustPrice(LineNumber);
create index IDX_HISADJPRICE4 ON BCHistoryAdjustPrice(ItemCode,UnitCode);

create table BCPriceList2Head 
(
	ROWORDER  INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	StartQty MONEY DEFAULT 0.0,
	StopQty MONEY DEFAULT 0.0,
	StartDate DATETIME, 
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StopDate DATETIME,
	SaleType SMALLINT DEFAULT 0,
	SaleTypeName  VARCHAR(50),
	TransportName  VARCHAR(50),
	TaxName  VARCHAR(50),
	TransportType SMALLINT DEFAULT 0, 
	TaxType	SMALLINT DEFAULT 0,
	TransState SMALLINT DEFAULT 0
	PRIMARY KEY(DocNo)
);
create index IDX_PRICELIST2_1 ON BCPriceList2Head(RowOrder);


create table BCSysUpdatePrice (
	ROWORDER  INT NOT NULL IDENTITY(0,1),
	FieldName VARCHAR(255) NOT NULL,
	SetTemplate SMALLINT DEFAULT 0 NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Length VARCHAR(10),
	UserType VARCHAR(50),
	MyDescription VARCHAR(255),
	UseFlag SMALLINT DEFAULT 0,
	LinkTable VARCHAR(255),
	DataType VARCHAR(50),
	TemplateName VARCHAR(50)
	PRIMARY KEY(ROWORDER,SetTemplate)
);

CREATE TABLE BCRECPOINT 
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ProductCode	VARCHAR(25),  
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Code	VARCHAR(10) NOT NULL,	
	Priority SMALLINT DEFAULT 0,
	IsWarehouse  SMALLINT DEFAULT 0, 
	LineNumber SMALLINT DEFAULT 0 
    PRIMARY KEY(ROWORDER)
);
create index IDX_RECPOINT_1 ON BCRECPOINT(ProductCode);
create index IDX_RECPOINT_2 ON BCRECPOINT(Code);
create index IDX_RECPOINT_3 ON BCRECPOINT(ProductCode,Priority);
ALTER TABLE BCRECPOINT ALTER COLUMN ProductCode varchar(25);

create table BCReceiveMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

CREATE TABLE BCRECPRODUCT 
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ProductCode	VARCHAR(25),  
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UnitCode	VARCHAR(10),
	Priority SMALLINT DEFAULT 0,
	MinAmount  MONEY DEFAULT 0.0,
	MaxAmount  MONEY DEFAULT 0.0,
	LineNumber SMALLINT DEFAULT 0 
    PRIMARY KEY(ROWORDER)
);
create index IDX_RECPRODT_1 ON BCRECPRODUCT(ProductCode,WhCode,ShelfCode,Linenumber);
create index IDX_RECPRODT_2 ON BCRECPRODUCT(LineNumber);
create index IDX_RECPRODT_3 ON BCRECPRODUCT(WhCode);
create index IDX_RECPRODT_4 ON BCRECPRODUCT(ShelfCode);
create index IDX_RECPRODT_5 ON BCRECPRODUCT(ProductCode);
ALTER TABLE BCRECPRODUCT ALTER COLUMN ProductCode varchar(25);

---------------- เก็บประวัติการเปลี่ยน master Item,Ap,Ar -- jeab 2003-04-17 -------------
create table BCHistoryMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	OldCode	VARCHAR(25)  NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	EventDate DATETIME, --change datetime
	EditorCode VARCHAR(10), --change by
	NewCode	VARCHAR(25),
	TransKey	VARCHAR(255)
    PRIMARY KEY(ROWORDER)
);
create index IDX_HISMASTER1 ON BCHistoryMaster(EventDate);
create index IDX_HISMASTER2 ON BCHistoryMaster(OldCode);

----------------BC Service ใช้ตรวจสอบยอดคงเหลือย้อนหลัง Aom 02-05-2003--------------

create table FunctionStock
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	SessionId VARCHAR(255),
	FunctionId INT, --101 = get stock qty
	ItemCode VARCHAR(800),
	IsFinish INT,
	FinalDate DATETIME,
    PRIMARY KEY(ROWORDER)
);
create index IDX_FUNCTIONSTOCK1 ON FunctionStock(itemcode);


create table FunctionStockResult
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	SessionId VARCHAR(255),
	ItemCode VARCHAR(50),
	UnitCode VARCHAR(50),
	WHCode VARCHAR(50),
	Location VARCHAR(50),
	StockQty MONEY
    PRIMARY KEY(ROWORDER)
);
create index IDX_FUNCTIONSTOCKRESULT ON FunctionStockResult(sessionid);
create index IDX_FUNCTIONSTOCKRESUL2T ON FunctionStockResult(itemcode);

---BC Service By Aom 06-05-2003---
create table BCSTKLocation
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode VARCHAR(50),
	WHCode VARCHAR(10),
	ShelfCode VARCHAR(15),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UnitCode VARCHAR(10),
	Qty MONEY,
	DocDate DATETIME,
    PRIMARY KEY(ROWORDER)	
);

create index IDX_BCSTKLOCATION ON BCSTKLocation(ItemCode);
create index IDX_BCSTKLOCATION2 ON BCSTKLocation(ItemCode,WHCode,ShelfCode);

create table bcitemcolor
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
	PRIMARY KEY(CODE)
);

create table bcitemsize
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
	PRIMARY KEY(CODE)
);


create table bcitemstyle
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
	PRIMARY KEY(CODE)
);

create table bcitempublisher
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255)
	PRIMARY KEY(CODE)
);

-------------------------start A-FOSS script----------------
create table BCInquiry	--สอบถามรายการสินค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocNo	Varchar(20)	NOT NULL,
	DocDate	Datetime		NOT NULL,	--ต้องบันทึกทั้งวันที่และเวลา
	DepartCode	Varchar(10),
	SaleCode		Varchar(10),
	ArCode		Varchar(20),
	Amount		Money	DEFAULT 0.0, 	-- ยอดรวมทั้งเอกสาร
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923 
	RecurName	VARCHAR(40)
	PRIMARY KEY(DOCNO)
);
create table BCInquirySub	 --สอบถามรายการสินค้าย่อย
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo		Varchar(20) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate		Datetime NOT NULL,--ต้องบันทึกทั้งวันที่และเวลา
	LineNumber	SmallInt	NOT NULL DEFAULT 0,--ลำดับที่สินค้า
	ItemCode		Varchar(25),	--รหัสสินค้า  (มีค่าเป็น NULL ได้)
	Description	VARCHAR(255),	--รายละเอียดสินค้า
	Qty		Money	DEFAULT 0.0,
	 Price		Money	DEFAULT 0.0,
	 Amount		Money	DEFAULT 0.0,
	 UnitCode		Varchar(10),
	 TypeCode		Varchar(10),
	 Specification	Varchar(255),	--คุณสมบัติ	 
	DepartCode	Varchar(10),
	SaleCode		Varchar(10),
	ArCode		Varchar(20),	
	ManufactoryCode	Varchar(10),	--รหัสผู้ผลิต (เพิ่ม table ด้วย***)
	AFT_remark	VARCHAR(255),	--ใช้เฉพาะใน A-FOSS
	UnitWeight	Money	DEFAULT 0.0,	--ใช้เฉพาะใน A-FOSS
	WeightUnitCode	Varchar(10),	--หน่วยนับของ unitWeight
	LeadTime		varchar(60),	--ใช้เฉพาะใน A-FOSS
	OfferedBy		VARCHAR(255),		--ใช้เฉพาะใน A-FOSS
	OfferedDate	Datetime,
	HS_SMX_remark	VARCHAR(255),
	ItemAdded		Smallint	DEFAULT 0,	--เพิ่มเข้าไปในรายการสินค้าหรือยัง 0= ไม่  , 1 = เพิ่มแล้ว	
	ConfirmCode	Varchar(10),
	ConfirmDate	Datetime,	
	CancelCode	Varchar(10),
	CancelDate	Datetime
	PRIMARY KEY(DocNo,LineNumber)
);
create table BCManufactory	--โรงงานผู้ผลิต
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10)  NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(255)
    PRIMARY KEY(Code)
);

create table BCTermCondition	--รายการเงื่อนไขให้เลือก (A-FOSS)
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(2)  NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50)
    PRIMARY KEY(Code)
);

create table BCTermCondition1	--รายการเงื่อนไขให้เลือก (A-FOSS)
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(2)  NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(50)
    PRIMARY KEY(Code)
);

create table BCDeliveryOrderCondition	--(Term & Conditions) เงื่อนไขใบเสนอราคา
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocNo	Varchar(20)	NOT NULL,	--เลขทีใบเสนอราคา	
	LineNumber	Smallint	NOT NULL,	--ลำดับที่
	TermCondition	Varchar(50),		--Table ref:- BCTermCondition.Name
	Data		Varchar(20)		--ข้อมูล
    PRIMARY KEY(DocNo,LineNumber)
);
create table BCArInstalment	--ตารางการแบ่งงวดของลูกหนี้
(	
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo		Varchar(20)	NOT NULL,--เลขที่ออกบิลล์
	DocDate		Datetime		NOT NULL,--วันที่เอกสาร
	NumOfInstalment	Smallint	DEFAULT 1,	--จำนวนงวด
	StartReceiptDate	Datetime,			--เริ่มงวดแรกชำระวันที่
	InstalmentNo	Smallint DEFAULT 1,	--เลขที่งวด เริ่มต้นจาก 1,2,3,.....	
	ArCode		Varchar(20),		--รหัสสินค้า
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DueDate		Datetime,			--วันที่ครบกำหนด
	ReceiptDate	Datetime,			--วันที่รับชำระจริง
	Amount		Money	DEFAULT 0.0,	--จำนวนเงินงวด
	PayBillStatus	Smallint	DEFAULT 0,	--0=ยังไม่วางบิล 1=วางบิล
	BalanceAmount	Money	DEFAULT 0.0,	--จำนวนเงินคงเหลือ	
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10)	DEFAULT 1.0
	PRIMARY KEY(DocNo,InstalmentNo)
);

create table BCApInstalment	--ตารางการแบ่งงวดของเจ้าหนี้
(	
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo		Varchar(20)	NOT NULL,--เลขที่ออกบิลล์
	DocDate		Datetime		NOT NULL,--วันที่เอกสาร
	NumOfInstalment	Smallint	DEFAULT 1,	--จำนวนงวด
	StartPayDate		Datetime,		--เริ่มชำระงวดแรกวันที่
	InstalmentNo	Smallint DEFAULT 1,	--เลขที่งวด เริ่มต้นจาก 1,2,3,.....	
	ApCode		Varchar(20),		--รหัสสินค้า
	DueDate		Datetime,			--วันที่ครบกำหนด
	PaidDate		Datetime,			--วันที่จ่ายจริง
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Amount		Money	DEFAULT 0.0,	--จำนวนเงินงวด
	PayBillStatus	Smallint	DEFAULT 0,	--0=ยังไม่วางบิล 1=วางบิล
	BalanceAmount	Money	DEFAULT 0.0,	--จำนวนเงินคงเหลือ
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10)	DEFAULT	1.0
	PRIMARY KEY(DocNo,InstalmentNo)
);

--Purpose Store current connection
-- jum 01-08-2003
create table processconnection
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	SessionID	 varchar(128) not null,
	ComputerName VARCHAR(255) not null,
	UserID varchar(50) not null,
	IPAddress varchar(300),
	StartTime datetime,
	Status smallint default 0, --0 None active,1 Acctice with process
	MessageText VARCHAR(255)
	PRIMARY KEY(SessionID)
);

create index IDX_processconn_1 on processconnection(sessionid);
create index IDX_processconn_2 on processconnection(computername);
create index IDX_processconn_3 on processconnection(ipaddress);
create index IDX_processconn_4 on processconnection(starttime);

create table BCArBarCodeMaster
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Barcode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	BarcodeName	VARCHAR(255), -- ชื่อ Barcode
	ArCode	VARCHAR(20),
	Remark	VARCHAR(255),
	ActiveStatus	SMALLINT DEFAULT 1
    PRIMARY KEY(ROWORDER)
);

CREATE TABLE BCArPriceList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	ArCode		VARCHAR(20),
	ArGroupCode		VARCHAR(255),
	UnitCode 	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Remark	VARCHAR(255),
	FromQty	MONEY DEFAULT 0.0,
	ToQty		MONEY DEFAULT 0.0,
	PriceAmount1	MONEY DEFAULT 0.0,
	PriceAmount2	MONEY DEFAULT 0.0,
	PriceAmount3	MONEY DEFAULT 0.0,
	PriceAmount4	MONEY DEFAULT 0.0,
	PriceAmount5	MONEY DEFAULT 0.0,
	PriceAmount6	MONEY DEFAULT 0.0,
	PriceAmount7	MONEY DEFAULT 0.0,
	PriceAmount8	MONEY DEFAULT 0.0,
	PriceFormula1	VARCHAR(255),
	PriceFormula2	VARCHAR(255),
	PriceFormula3	VARCHAR(255),
	PriceFormula4	VARCHAR(255),
	PriceFormula5	VARCHAR(255),
	PriceFormula6	VARCHAR(255),
	PriceFormula7	VARCHAR(255),
	PriceFormula8	VARCHAR(255),
	LineNumber SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

create table BCStkWarehouseHistory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	UnitCode	VARCHAR(10),
	Qty	MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ReserveQty	MONEY DEFAULT 0.0,
	RemainInQty	MONEY DEFAULT 0.0,
	RemainOutQty	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	ItemPriority	SMALLINT DEFAULT 0, -- ลำดับความสำคัญ
	ReadyQtyAll MONEY DEFAULT 0.0, -- ยอดที่ขายได้
	ReserveQtyAll MONEY DEFAULT 0.0, -- 
	RemainQtyAll MONEY DEFAULT 0.0, -- 
	RemainOutQtyAll	MONEY DEFAULT 0.0,
	averagecost MONEY DEFAULT 0.0,
	DocDate	DATETIME
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_WHSTKITEMHIS ON BCStkWarehouseHistory(ItemCode);
CREATE  INDEX IDX_WHSTKWHHIS ON BCStkWarehouseHistory(WHCode);
CREATE  INDEX IDX_WHSTKSHFHIS ON BCStkWarehouseHistory(ShelfCode);
CREATE  INDEX IDX_WHSTKUNITHIS ON BCStkWarehouseHistory(UnitCode);
CREATE  INDEX IDX_WHSTKITEM1HIS ON BCStkWarehouseHistory(ItemCode,UnitCode,WhCode,ShelfCode);

create table BCSTKLocationHistory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode VARCHAR(50),
	WHCode VARCHAR(10),
	ShelfCode VARCHAR(15),
	UnitCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Qty MONEY,
	DocDate DATETIME
    PRIMARY KEY(ROWORDER)	
);

create index IDX_BCSTKLOCATIONHIS ON BCSTKLocationHistory(ItemCode);

create table BCLotMasterHistory
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25) NOT NULL,
	LotNumber	VARCHAR(50) NOT NULL,
	WHCode	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ShelfCode	VARCHAR(15) NOT NULL,
	BillLineNumber	SMALLINT DEFAULT 0,
	TransType	SMALLINT DEFAULT 0, -- ตาม MyType ของรายวันที่เพิ่ม
	TransPeriod SMALLINT DEFAULT 0, -- ข้อมูลเกิดใน Period ที่
	DocNo	VARCHAR(50) NOT NULL,
	DocDate	DATETIME,
	ExpireDate	DATETIME,
	MyDescription	VARCHAR(255),
	Qty	MONEY DEFAULT 0.0, -- ยอดรับครั้งแรก
	Cost	MONEY DEFAULT 0.0, -- ต้นทุนครั้งแรก
	Amount	MONEY DEFAULT 0.0 NOT NULL, -- มูลค่าครั้งแรก
	BalAmount	MONEY DEFAULT 0.0, -- ยอดมูลค่าคงเหลือปัจุบัน
	BalQty	MONEY DEFAULT 0.0, -- ยอดจำนวนคงเหลือปัจุบัน
	BalCost	MONEY DEFAULT 0.0, -- ต้นทุนคงเหลือปัจุบัน Jeab 1/11/2545
	BalQtyPeriod1 MONEY DEFAULT 0.0,
	BalQtyPeriod2 MONEY DEFAULT 0.0,
	BalQtyPeriod3 MONEY DEFAULT 0.0,
	BalQtyPeriod4 MONEY DEFAULT 0.0,
	BalQtyPeriod5 MONEY DEFAULT 0.0,
	BalQtyPeriod6 MONEY DEFAULT 0.0,
	BalQtyPeriod7 MONEY DEFAULT 0.0,
	BalQtyPeriod8 MONEY DEFAULT 0.0,
	BalQtyPeriod9 MONEY DEFAULT 0.0,
	BalQtyPeriod10 MONEY DEFAULT 0.0,
	BalQtyPeriod11 MONEY DEFAULT 0.0,
	BalQtyPeriod12 MONEY DEFAULT 0.0,
	BalQtyPeriod13 MONEY DEFAULT 0.0,
	BalQtyPeriod14 MONEY DEFAULT 0.0,
	BalQtyPeriod15 MONEY DEFAULT 0.0,
	BalQtyPeriod16 MONEY DEFAULT 0.0,
	BalQtyPeriod17 MONEY DEFAULT 0.0,
	BalQtyPeriod18 MONEY DEFAULT 0.0,
	BalQtyPeriod19 MONEY DEFAULT 0.0,
	BalQtyPeriod20 MONEY DEFAULT 0.0,
	BalQtyPeriod21 MONEY DEFAULT 0.0,
	BalQtyPeriod22 MONEY DEFAULT 0.0,
	BalQtyPeriod23 MONEY DEFAULT 0.0,
	BalQtyPeriod24 MONEY DEFAULT 0.0,
	BalQtyPeriod25 MONEY DEFAULT 0.0,
	DocDateHistory DATETIME,
	reflot varchar(50) -- Jum use
    PRIMARY KEY(RowOrder)
);

CREATE  INDEX IDX_LTMLINEHIS ON BCLotMasterHistory(BillLineNumber);
CREATE  INDEX IDX_LTMITEMHIS ON BCLotMasterHistory(ItemCode);
CREATE  INDEX IDX_LTMTTYPHIS ON BCLotMasterHistory(TransType);
CREATE  INDEX IDX_LTMTDATEHIS ON BCLotMasterHistory(DocDateHistory);

------------------- รับเงินล่วงหน้า ------------------
create table BCARDepositSpecial
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	MyDescription	VARCHAR(500),--Jum 255  to 500
	TotalAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0, -- TotalAmount - SumOfWTax
	BillBalance	MONEY DEFAULT 0.0, -- ถ้าเป็นรวมใน=NetAmount ถ้าเป็นแยกนอก=NetAmount ถอด Tax
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน เฉพาะเงินสด
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	RefNo	VARCHAR(20),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsReturnMoney SMALLINT DEFAULT 0, -- 1=ลดหนี้หรือคืนเงิน
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(35),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PaymentTypeCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923 
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_ARDEPS_DATE ON BCARDepositSpecial(DocDate);
CREATE  INDEX IDX_ARDEPS_AR ON BCARDepositSpecial(ArCode);
CREATE  INDEX IDX_ARDEPS_BAL ON BCARDepositSpecial(BillBalance);

------------------- รับคืนเงินล่วงหน้า ------------------
create table BCReturnDepSpecial
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	EarnestNo VARCHAR(20), -- เลขที่ใบรับเงินมัดจำ
	ArCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	CreditDay	SMALLINT DEFAULT 0,
	SaleCode	VARCHAR(10),
	DueDate	DATETIME,
	MyDescription	VARCHAR(255),
	TotalAmount	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	BillBalance	MONEY DEFAULT 0.0, -- ถ้าเป็นรวมใน=NetAmount ถ้าเป็นแยกนอก=NetAmount ถอด Tax
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	EarnestAmount	MONEY DEFAULT 0.0, -- ยอดเงินของเงินมัดจำ
	EarnestBalance	MONEY DEFAULT 0.0, -- ยอดเงินคงเหลือของเงินมัดจำ
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	GLFormat	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsReturnMoney SMALLINT DEFAULT 0, -- 1=ลดหนี้หรือคืนเงิน
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(35),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923 
	JobNo VARCHAR(20) -- Job สำหรับ GL -- 2003-07-25
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_RTDEPS_DATE ON BCReturnDepSpecial(DocDate);
CREATE  INDEX IDX_RTDEPS_AR ON BCReturnDepSpecial(ArCode);
--CREATE  INDEX IDX_RTDEPS_BAL ON BCReturnDepSpecial(BillBalance);

------------------- จ่ายเงินล่วงหน้า ------------------
create table BCAPDepositSpecial
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	MyDescription	VARCHAR(255),
	TotalAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0, -- TotalAmount - SumOfWTax
	BillBalance	MONEY DEFAULT 0.0, -- ถ้าเป็นรวมใน=NetAmount ถ้าเป็นแยกนอก=NetAmount ถอด Tax
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	RefNo	VARCHAR(20),
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(35),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PaymentTypeCode	VARCHAR(10),
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	PrePayStatus smallint default 0,
	PrePayAmount money default 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_APDEPS_DATE ON BCAPDepositSpecial(DocDate);
CREATE  INDEX IDX_APDEPS_AR ON BCAPDepositSpecial(ApCode);
--CREATE  INDEX IDX_APDEPS_BAL ON BCAPDepositSpecial(BillBalance);

------------------- ส่งคืนเงินล่วงหน้า ------------------
create table BCAPReturnDepSpecial
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	EarnestNo VARCHAR(20), -- เลขที่ใบรับเงินมัดจำ
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	SaleCode	VARCHAR(10),
	IsConfirm	SMALLINT DEFAULT 0,
	CreditDay	SMALLINT DEFAULT 0,
	DueDate	DATETIME,
	MyDescription	VARCHAR(255),
	TotalAmount	MONEY DEFAULT 0.0,
	BeforeTaxAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	BillBalance	MONEY DEFAULT 0.0, -- ถ้าเป็นรวมใน=NetAmount ถ้าเป็นแยกนอก=NetAmount ถอด Tax
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	EarnestAmount	MONEY DEFAULT 0.0, -- ยอดเงินของเงินมัดจำ
	EarnestBalance	MONEY DEFAULT 0.0, -- ยอดเงินคงเหลือของเงินมัดจำ
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน เฉพาะเงินสด
	GLFormat	VARCHAR(5),
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(35),
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_APRTDEPS_DATE ON BCAPReturnDepSpecial(DocDate);
CREATE  INDEX IDX_APRTDEPS_AP ON BCAPReturnDepSpecial(ApCode);
--CREATE  INDEX IDX_APRTDEPS_BAL ON BCAPReturnDepSpecial(BillBalance);

CREATE TABLE BCLOTMASTERPERIOD
(
	ROWORDER int NOT NULL IDENTITY (0, 1),
	ITEMCODE varchar(25) NOT NULL ,
	LOTNUMBER varchar(50) NOT NULL ,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	WHCODE varchar (10),
	SHELFCODE varchar (15),
	BILLLINENUMBER smallint DEFAULT 0,
	TRANSTYPE smallint DEFAULT 0,
	TRANSPERIOD smallint DEFAULT 0,
	DOCNO varchar (20),
	DOCDATE datetime NULL ,
	EXPIREDATE datetime NULL ,
	UNITCODE varchar (10),
	MYDESCRIPTION varchar (200),
	ISTRANS00 smallint DEFAULT 0,
	ISTRANS01 smallint DEFAULT 0,
	ISTRANS02 smallint DEFAULT 0,
	ISTRANS03 smallint DEFAULT 0,
	ISTRANS04 smallint DEFAULT 0,
	ISTRANS05 smallint DEFAULT 0,
	ISTRANS06 smallint DEFAULT 0,
	ISTRANS07 smallint DEFAULT 0,
	ISTRANS08 smallint DEFAULT 0,
	ISTRANS09 smallint DEFAULT 0,
	ISTRANS10 smallint DEFAULT 0,
	ISTRANS11 smallint DEFAULT 0,
	ISTRANS12 smallint DEFAULT 0,
	ISTRANS13 smallint DEFAULT 0,
	ISTRANS14 smallint DEFAULT 0,
	ISTRANS15 smallint DEFAULT 0,
	ISTRANS16 smallint DEFAULT 0,
	ISTRANS17 smallint DEFAULT 0,
	ISTRANS18 smallint DEFAULT 0,
	ISTRANS19 smallint DEFAULT 0,
	ISTRANS20 smallint DEFAULT 0,
	ISTRANS21 smallint DEFAULT 0,
	ISTRANS22 smallint DEFAULT 0,
	ISTRANS23 smallint DEFAULT 0,
	ISTRANS24 smallint DEFAULT 0,
	ISTRANS25 smallint DEFAULT 0,
	ISTRANS26 smallint DEFAULT 0,
	ISTRANS27 smallint DEFAULT 0,
	ISTRANS28 smallint DEFAULT 0,
	ISTRANS29 smallint DEFAULT 0,
	ISTRANS30 smallint DEFAULT 0,
	ISTRANS31 smallint DEFAULT 0,
	ISTRANS32 smallint DEFAULT 0,
	ISTRANS33 smallint DEFAULT 0,
	ISTRANS34 smallint DEFAULT 0,
	ISTRANS35 smallint DEFAULT 0,
	ISTRANS36 smallint DEFAULT 0,
	ISTRANS37 smallint DEFAULT 0,
	ISTRANS38 smallint DEFAULT 0,
	ISTRANS39 smallint DEFAULT 0,
	ISTRANS40 smallint DEFAULT 0,
	ISTRANS41 smallint DEFAULT 0,
	ISTRANS42 smallint DEFAULT 0,
	ISTRANS43 smallint DEFAULT 0,
	ISTRANS44 smallint DEFAULT 0,
	ISTRANS45 smallint DEFAULT 0,
	ISTRANS46 smallint DEFAULT 0,
	ISTRANS47 smallint DEFAULT 0,
	ISTRANS48 smallint DEFAULT 0,
	ISTRANS49 smallint DEFAULT 0,
	ISTRANS50 smallint DEFAULT 0,
	ISTRANS51 smallint DEFAULT 0,
	ISTRANS52 smallint DEFAULT 0,
	ISTRANS53 smallint DEFAULT 0,
	ISTRANS54 smallint DEFAULT 0,
	ISTRANS55 smallint DEFAULT 0,
	ISTRANS56 smallint DEFAULT 0,
	ISTRANS57 smallint DEFAULT 0,
	ISTRANS58 smallint DEFAULT 0,
	ISTRANS59 smallint DEFAULT 0,
	ISTRANS60 smallint DEFAULT 0,
	QTY00 money DEFAULT 0.0,
	QTY01 money DEFAULT 0.0,
	QTY02 money DEFAULT 0.0,
	QTY03 money DEFAULT 0.0,
	QTY04 money DEFAULT 0.0,
	QTY05 money DEFAULT 0.0,
	QTY06 money DEFAULT 0.0,
	QTY07 money DEFAULT 0.0,
	QTY08 money DEFAULT 0.0,
	QTY09 money DEFAULT 0.0,
	QTY10 money DEFAULT 0.0,
	QTY11 money DEFAULT 0.0,
	QTY12 money DEFAULT 0.0,
	QTY13 money DEFAULT 0.0,
	QTY14 money DEFAULT 0.0,
	QTY15 money DEFAULT 0.0,
	QTY16 money DEFAULT 0.0,
	QTY17 money DEFAULT 0.0,
	QTY18 money DEFAULT 0.0,
	QTY19 money DEFAULT 0.0,
	QTY20 money DEFAULT 0.0,
	QTY21 money DEFAULT 0.0,
	QTY22 money DEFAULT 0.0,
	QTY23 money DEFAULT 0.0,
	QTY24 money DEFAULT 0.0,
	QTY25 money DEFAULT 0.0,
	QTY26 money DEFAULT 0.0,
	QTY27 money DEFAULT 0.0,
	QTY28 money DEFAULT 0.0,
	QTY29 money DEFAULT 0.0,
	QTY30 money DEFAULT 0.0,
	QTY31 money DEFAULT 0.0,
	QTY32 money DEFAULT 0.0,
	QTY33 money DEFAULT 0.0,
	QTY34 money DEFAULT 0.0,
	QTY35 money DEFAULT 0.0,
	QTY36 money DEFAULT 0.0,
	QTY37 money DEFAULT 0.0,
	QTY38 money DEFAULT 0.0,
	QTY39 money DEFAULT 0.0,
	QTY40 money DEFAULT 0.0,
	QTY41 money DEFAULT 0.0,
	QTY42 money DEFAULT 0.0,
	QTY43 money DEFAULT 0.0,
	QTY44 money DEFAULT 0.0,
	QTY45 money DEFAULT 0.0,
	QTY46 money DEFAULT 0.0,
	QTY47 money DEFAULT 0.0,
	QTY48 money DEFAULT 0.0,
	QTY49 money DEFAULT 0.0,
	QTY50 money DEFAULT 0.0,
	QTY51 money DEFAULT 0.0,
	QTY52 money DEFAULT 0.0,
	QTY53 money DEFAULT 0.0,
	QTY54 money DEFAULT 0.0,
	QTY55 money DEFAULT 0.0,
	QTY56 money DEFAULT 0.0,
	QTY57 money DEFAULT 0.0,
	QTY58 money DEFAULT 0.0,
	QTY59 money DEFAULT 0.0,
	QTY60 money DEFAULT 0.0,
	COST00 money DEFAULT 0.0,
	COST01 money DEFAULT 0.0,
	COST02 money DEFAULT 0.0,
	COST03 money DEFAULT 0.0,
	COST04 money DEFAULT 0.0,
	COST05 money DEFAULT 0.0,
	COST06 money DEFAULT 0.0,
	COST07 money DEFAULT 0.0,
	COST08 money DEFAULT 0.0,
	COST09 money DEFAULT 0.0,
	COST10 money DEFAULT 0.0,
	COST11 money DEFAULT 0.0,
	COST12 money DEFAULT 0.0,
	COST13 money DEFAULT 0.0,
	COST14 money DEFAULT 0.0,
	COST15 money DEFAULT 0.0,
	COST16 money DEFAULT 0.0,
	COST17 money DEFAULT 0.0,
	COST18 money DEFAULT 0.0,
	COST19 money DEFAULT 0.0,
	COST20 money DEFAULT 0.0,
	COST21 money DEFAULT 0.0,
	COST22 money DEFAULT 0.0,
	COST23 money DEFAULT 0.0,
	COST24 money DEFAULT 0.0,
	COST25 money DEFAULT 0.0,
	COST26 money DEFAULT 0.0,
	COST27 money DEFAULT 0.0,
	COST28 money DEFAULT 0.0,
	COST29 money DEFAULT 0.0,
	COST30 money DEFAULT 0.0,
	COST31 money DEFAULT 0.0,
	COST32 money DEFAULT 0.0,
	COST33 money DEFAULT 0.0,
	COST34 money DEFAULT 0.0,
	COST35 money DEFAULT 0.0,
	COST36 money DEFAULT 0.0,
	COST37 money DEFAULT 0.0,
	COST38 money DEFAULT 0.0,
	COST39 money DEFAULT 0.0,
	COST40 money DEFAULT 0.0,
	COST41 money DEFAULT 0.0,
	COST42 money DEFAULT 0.0,
	COST43 money DEFAULT 0.0,
	COST44 money DEFAULT 0.0,
	COST45 money DEFAULT 0.0,
	COST46 money DEFAULT 0.0,
	COST47 money DEFAULT 0.0,
	COST48 money DEFAULT 0.0,
	COST49 money DEFAULT 0.0,
	COST50 money DEFAULT 0.0,
	COST51 money DEFAULT 0.0,
	COST52 money DEFAULT 0.0,
	COST53 money DEFAULT 0.0,
	COST54 money DEFAULT 0.0,
	COST55 money DEFAULT 0.0,
	COST56 money DEFAULT 0.0,
	COST57 money DEFAULT 0.0,
	COST58 money DEFAULT 0.0,
	COST59 money DEFAULT 0.0,
	COST60 money DEFAULT 0.0,
	AMOUNT00 money DEFAULT 0.0,
	AMOUNT01 money DEFAULT 0.0,
	AMOUNT02 money DEFAULT 0.0,
	AMOUNT03 money DEFAULT 0.0,
	AMOUNT04 money DEFAULT 0.0,
	AMOUNT05 money DEFAULT 0.0,
	AMOUNT06 money DEFAULT 0.0,
	AMOUNT07 money DEFAULT 0.0,
	AMOUNT08 money DEFAULT 0.0,
	AMOUNT09 money DEFAULT 0.0,
	AMOUNT10 money DEFAULT 0.0,
	AMOUNT11 money DEFAULT 0.0,
	AMOUNT12 money DEFAULT 0.0,
	AMOUNT13 money DEFAULT 0.0,
	AMOUNT14 money DEFAULT 0.0,
	AMOUNT15 money DEFAULT 0.0,
	AMOUNT16 money DEFAULT 0.0,
	AMOUNT17 money DEFAULT 0.0,
	AMOUNT18 money DEFAULT 0.0,
	AMOUNT19 money DEFAULT 0.0,
	AMOUNT20 money DEFAULT 0.0,
	AMOUNT21 money DEFAULT 0.0,
	AMOUNT22 money DEFAULT 0.0,
	AMOUNT23 money DEFAULT 0.0,
	AMOUNT24 money DEFAULT 0.0,
	AMOUNT25 money DEFAULT 0.0,
	AMOUNT26 money DEFAULT 0.0,
	AMOUNT27 money DEFAULT 0.0,
	AMOUNT28 money DEFAULT 0.0,
	AMOUNT29 money DEFAULT 0.0,
	AMOUNT30 money DEFAULT 0.0,
	AMOUNT31 money DEFAULT 0.0,
	AMOUNT32 money DEFAULT 0.0,
	AMOUNT33 money DEFAULT 0.0,
	AMOUNT34 money DEFAULT 0.0,
	AMOUNT35 money DEFAULT 0.0,
	AMOUNT36 money DEFAULT 0.0,
	AMOUNT37 money DEFAULT 0.0,
	AMOUNT38 money DEFAULT 0.0,
	AMOUNT39 money DEFAULT 0.0,
	AMOUNT40 money DEFAULT 0.0,
	AMOUNT41 money DEFAULT 0.0,
	AMOUNT42 money DEFAULT 0.0,
	AMOUNT43 money DEFAULT 0.0,
	AMOUNT44 money DEFAULT 0.0,
	AMOUNT45 money DEFAULT 0.0,
	AMOUNT46 money DEFAULT 0.0,
	AMOUNT47 money DEFAULT 0.0,
	AMOUNT48 money DEFAULT 0.0,
	AMOUNT49 money DEFAULT 0.0,
	AMOUNT50 money DEFAULT 0.0,
	AMOUNT51 money DEFAULT 0.0,
	AMOUNT52 money DEFAULT 0.0,
	AMOUNT53 money DEFAULT 0.0,
	AMOUNT54 money DEFAULT 0.0,
	AMOUNT55 money DEFAULT 0.0,
	AMOUNT56 money DEFAULT 0.0,
	AMOUNT57 money DEFAULT 0.0,
	AMOUNT58 money DEFAULT 0.0,
	AMOUNT59 money DEFAULT 0.0,
	AMOUNT60 money NULL,
	BehindIndex smallint default 0,
	RowIndex smallint default 0 
PRIMARY KEY(RowOrder)
);

CREATE  INDEX IDX_LOTPERIOD ON BCLOTMASTERPERIOD(ITEMCODE,WHCode,LOTNUMBER);
CREATE  INDEX IDX_LOTPERIOD2 ON BCLOTMASTERPERIOD(ITEMCODE);

CREATE TABLE BCSTKLocationPeriod 
(
	ROWORDER int NOT NULL IDENTITY (0, 1),
	ITEMCODE varchar (25),
	WHCODE varchar (10),
	SHELFCODE varchar (15),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UNITCODE varchar (10),
	MOVEMENTLASTINDATE datetime,
	MOVEMENTLASTINTYPE int,
	MOVEMENTLASTOUTDATE datetime,
	MOVEMENTLASTOUTTYPE int,
	MOVEMENTLASTSALEDATE datetime,
	MOVEMENTLASTBUYDATE datetime,
	ISTRANS00 smallint DEFAULT 0,
	ISTRANS01 smallint DEFAULT 0,
	ISTRANS02 smallint DEFAULT 0,
	ISTRANS03 smallint DEFAULT 0,
	ISTRANS04 smallint DEFAULT 0,
	ISTRANS05 smallint DEFAULT 0,
	ISTRANS06 smallint DEFAULT 0,
	ISTRANS07 smallint DEFAULT 0,
	ISTRANS08 smallint DEFAULT 0,
	ISTRANS09 smallint DEFAULT 0,
	ISTRANS10 smallint DEFAULT 0,
	ISTRANS11 smallint DEFAULT 0,
	ISTRANS12 smallint DEFAULT 0,
	ISTRANS13 smallint DEFAULT 0,
	ISTRANS14 smallint DEFAULT 0,
	ISTRANS15 smallint DEFAULT 0,
	ISTRANS16 smallint DEFAULT 0,
	ISTRANS17 smallint DEFAULT 0,
	ISTRANS18 smallint DEFAULT 0,
	ISTRANS19 smallint DEFAULT 0,
	ISTRANS20 smallint DEFAULT 0,
	ISTRANS21 smallint DEFAULT 0,
	ISTRANS22 smallint DEFAULT 0,
	ISTRANS23 smallint DEFAULT 0,
	ISTRANS24 smallint DEFAULT 0,
	ISTRANS25 smallint DEFAULT 0,
	ISTRANS26 smallint DEFAULT 0,
	ISTRANS27 smallint DEFAULT 0,
	ISTRANS28 smallint DEFAULT 0,
	ISTRANS29 smallint DEFAULT 0,
	ISTRANS30 smallint DEFAULT 0,
	ISTRANS31 smallint DEFAULT 0,
	ISTRANS32 smallint DEFAULT 0,
	ISTRANS33 smallint DEFAULT 0,
	ISTRANS34 smallint DEFAULT 0,
	ISTRANS35 smallint DEFAULT 0,
	ISTRANS36 smallint DEFAULT 0,
	ISTRANS37 smallint DEFAULT 0,
	ISTRANS38 smallint DEFAULT 0,
	ISTRANS39 smallint DEFAULT 0,
	ISTRANS40 smallint DEFAULT 0,
	ISTRANS41 smallint DEFAULT 0,
	ISTRANS42 smallint DEFAULT 0,
	ISTRANS43 smallint DEFAULT 0,
	ISTRANS44 smallint DEFAULT 0,
	ISTRANS45 smallint DEFAULT 0,
	ISTRANS46 smallint DEFAULT 0,
	ISTRANS47 smallint DEFAULT 0,
	ISTRANS48 smallint DEFAULT 0,
	ISTRANS49 smallint DEFAULT 0,
	ISTRANS50 smallint DEFAULT 0,
	ISTRANS51 smallint DEFAULT 0,
	ISTRANS52 smallint DEFAULT 0,
	ISTRANS53 smallint DEFAULT 0,
	ISTRANS54 smallint DEFAULT 0,
	ISTRANS55 smallint DEFAULT 0,
	ISTRANS56 smallint DEFAULT 0,
	ISTRANS57 smallint DEFAULT 0,
	ISTRANS58 smallint DEFAULT 0,
	ISTRANS59 smallint DEFAULT 0,
	ISTRANS60 smallint DEFAULT 0,
	QTY00 money DEFAULT 0.0,
	QTY01 money DEFAULT 0.0,
	QTY02 money DEFAULT 0.0,
	QTY03 money DEFAULT 0.0,
	QTY04 money DEFAULT 0.0,
	QTY05 money DEFAULT 0.0,
	QTY06 money DEFAULT 0.0,
	QTY07 money DEFAULT 0.0,
	QTY08 money DEFAULT 0.0,
	QTY09 money DEFAULT 0.0,
	QTY10 money DEFAULT 0.0,
	QTY11 money DEFAULT 0.0,
	QTY12 money DEFAULT 0.0,
	QTY13 money DEFAULT 0.0,
	QTY14 money DEFAULT 0.0,
	QTY15 money DEFAULT 0.0,
	QTY16 money DEFAULT 0.0,
	QTY17 money DEFAULT 0.0,
	QTY18 money DEFAULT 0.0,
	QTY19 money DEFAULT 0.0,
	QTY20 money DEFAULT 0.0,
	QTY21 money DEFAULT 0.0,
	QTY22 money DEFAULT 0.0,
	QTY23 money DEFAULT 0.0,
	QTY24 money DEFAULT 0.0,
	QTY25 money DEFAULT 0.0,
	QTY26 money DEFAULT 0.0,
	QTY27 money DEFAULT 0.0,
	QTY28 money DEFAULT 0.0,
	QTY29 money DEFAULT 0.0,
	QTY30 money DEFAULT 0.0,
	QTY31 money DEFAULT 0.0,
	QTY32 money DEFAULT 0.0,
	QTY33 money DEFAULT 0.0,
	QTY34 money DEFAULT 0.0,
	QTY35 money DEFAULT 0.0,
	QTY36 money DEFAULT 0.0,
	QTY37 money DEFAULT 0.0,
	QTY38 money DEFAULT 0.0,
	QTY39 money DEFAULT 0.0,
	QTY40 money DEFAULT 0.0,
	QTY41 money DEFAULT 0.0,
	QTY42 money DEFAULT 0.0,
	QTY43 money DEFAULT 0.0,
	QTY44 money DEFAULT 0.0,
	QTY45 money DEFAULT 0.0,
	QTY46 money DEFAULT 0.0,
	QTY47 money DEFAULT 0.0,
	QTY48 money DEFAULT 0.0,
	QTY49 money DEFAULT 0.0,
	QTY50 money DEFAULT 0.0,
	QTY51 money DEFAULT 0.0,
	QTY52 money DEFAULT 0.0,
	QTY53 money DEFAULT 0.0,
	QTY54 money DEFAULT 0.0,
	QTY55 money DEFAULT 0.0,
	QTY56 money DEFAULT 0.0,
	QTY57 money DEFAULT 0.0,
	QTY58 money DEFAULT 0.0,
	QTY59 money DEFAULT 0.0,
	QTY60 money NULL 
PRIMARY KEY(RowOrder)
);

CREATE  INDEX IDX_LOCATESTKPERIOD ON BCSTKLocationPeriod(ITEMCODE,WHCODE,SHELFCODE); 
CREATE  INDEX IDX_LOCATESTKPERIOD2 ON BCSTKLocationPeriod(ITEMCODE); 
ALTER TABLE BCSTKLocationPeriod ALTER COLUMN SHELFCODE varchar(15);


CREATE TABLE BCSTKWAREHOUSEPeriod
(
	ROWORDER int NOT NULL IDENTITY (0, 1),
	ITEMCODE varchar (25),
	WHID int,
	WHCODE varchar (10),
	UNITCODE varchar (10),
	MOVEMENTLASTINDATE datetime,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MOVEMENTLASTINTYPE int,
	MOVEMENTLASTOUTDATE datetime,
	MOVEMENTLASTOUTTYPE int,
	MOVEMENTLASTSALEDATE datetime,
	MOVEMENTLASTBUYDATE datetime,
	ISTRANS00 smallint DEFAULT 0,
	ISTRANS01 smallint DEFAULT 0,
	ISTRANS02 smallint DEFAULT 0,
	ISTRANS03 smallint DEFAULT 0,
	ISTRANS04 smallint DEFAULT 0,
	ISTRANS05 smallint DEFAULT 0,
	ISTRANS06 smallint DEFAULT 0,
	ISTRANS07 smallint DEFAULT 0,
	ISTRANS08 smallint DEFAULT 0,
	ISTRANS09 smallint DEFAULT 0,
	ISTRANS10 smallint DEFAULT 0,
	ISTRANS11 smallint DEFAULT 0,
	ISTRANS12 smallint DEFAULT 0,
	ISTRANS13 smallint DEFAULT 0,
	ISTRANS14 smallint DEFAULT 0,
	ISTRANS15 smallint DEFAULT 0,
	ISTRANS16 smallint DEFAULT 0,
	ISTRANS17 smallint DEFAULT 0,
	ISTRANS18 smallint DEFAULT 0,
	ISTRANS19 smallint DEFAULT 0,
	ISTRANS20 smallint DEFAULT 0,
	ISTRANS21 smallint DEFAULT 0,
	ISTRANS22 smallint DEFAULT 0,
	ISTRANS23 smallint DEFAULT 0,
	ISTRANS24 smallint DEFAULT 0,
	ISTRANS25 smallint DEFAULT 0,
	ISTRANS26 smallint DEFAULT 0,
	ISTRANS27 smallint DEFAULT 0,
	ISTRANS28 smallint DEFAULT 0,
	ISTRANS29 smallint DEFAULT 0,
	ISTRANS30 smallint DEFAULT 0,
	ISTRANS31 smallint DEFAULT 0,
	ISTRANS32 smallint DEFAULT 0,
	ISTRANS33 smallint DEFAULT 0,
	ISTRANS34 smallint DEFAULT 0,
	ISTRANS35 smallint DEFAULT 0,
	ISTRANS36 smallint DEFAULT 0,
	ISTRANS37 smallint DEFAULT 0,
	ISTRANS38 smallint DEFAULT 0,
	ISTRANS39 smallint DEFAULT 0,
	ISTRANS40 smallint DEFAULT 0,
	ISTRANS41 smallint DEFAULT 0,
	ISTRANS42 smallint DEFAULT 0,
	ISTRANS43 smallint DEFAULT 0,
	ISTRANS44 smallint DEFAULT 0,
	ISTRANS45 smallint DEFAULT 0,
	ISTRANS46 smallint DEFAULT 0,
	ISTRANS47 smallint DEFAULT 0,
	ISTRANS48 smallint DEFAULT 0,
	ISTRANS49 smallint DEFAULT 0,
	ISTRANS50 smallint DEFAULT 0,
	ISTRANS51 smallint DEFAULT 0,
	ISTRANS52 smallint DEFAULT 0,
	ISTRANS53 smallint DEFAULT 0,
	ISTRANS54 smallint DEFAULT 0,
	ISTRANS55 smallint DEFAULT 0,
	ISTRANS56 smallint DEFAULT 0,
	ISTRANS57 smallint DEFAULT 0,
	ISTRANS58 smallint DEFAULT 0,
	ISTRANS59 smallint DEFAULT 0,
	ISTRANS60 smallint DEFAULT 0,
	QTY00 money DEFAULT 0.0,
	QTY01 money DEFAULT 0.0,
	QTY02 money DEFAULT 0.0,
	QTY03 money DEFAULT 0.0,
	QTY04 money DEFAULT 0.0,
	QTY05 money DEFAULT 0.0,
	QTY06 money DEFAULT 0.0,
	QTY07 money DEFAULT 0.0,
	QTY08 money DEFAULT 0.0,
	QTY09 money DEFAULT 0.0,
	QTY10 money DEFAULT 0.0,
	QTY11 money DEFAULT 0.0,
	QTY12 money DEFAULT 0.0,
	QTY13 money DEFAULT 0.0,
	QTY14 money DEFAULT 0.0,
	QTY15 money DEFAULT 0.0,
	QTY16 money DEFAULT 0.0,
	QTY17 money DEFAULT 0.0,
	QTY18 money DEFAULT 0.0,
	QTY19 money DEFAULT 0.0,
	QTY20 money DEFAULT 0.0,
	QTY21 money DEFAULT 0.0,
	QTY22 money DEFAULT 0.0,
	QTY23 money DEFAULT 0.0,
	QTY24 money DEFAULT 0.0,
	QTY25 money DEFAULT 0.0,
	QTY26 money DEFAULT 0.0,
	QTY27 money DEFAULT 0.0,
	QTY28 money DEFAULT 0.0,
	QTY29 money DEFAULT 0.0,
	QTY30 money DEFAULT 0.0,
	QTY31 money DEFAULT 0.0,
	QTY32 money DEFAULT 0.0,
	QTY33 money DEFAULT 0.0,
	QTY34 money DEFAULT 0.0,
	QTY35 money DEFAULT 0.0,
	QTY36 money DEFAULT 0.0,
	QTY37 money DEFAULT 0.0,
	QTY38 money DEFAULT 0.0,
	QTY39 money DEFAULT 0.0,
	QTY40 money DEFAULT 0.0,
	QTY41 money DEFAULT 0.0,
	QTY42 money DEFAULT 0.0,
	QTY43 money DEFAULT 0.0,
	QTY44 money DEFAULT 0.0,
	QTY45 money DEFAULT 0.0,
	QTY46 money DEFAULT 0.0,
	QTY47 money DEFAULT 0.0,
	QTY48 money DEFAULT 0.0,
	QTY49 money DEFAULT 0.0,
	QTY50 money DEFAULT 0.0,
	QTY51 money DEFAULT 0.0,
	QTY52 money DEFAULT 0.0,
	QTY53 money DEFAULT 0.0,
	QTY54 money DEFAULT 0.0,
	QTY55 money DEFAULT 0.0,
	QTY56 money DEFAULT 0.0,
	QTY57 money DEFAULT 0.0,
	QTY58 money DEFAULT 0.0,
	QTY59 money DEFAULT 0.0,
	QTY60 money DEFAULT 0.0,
	AVERAGECOST00 money DEFAULT 0.0,
	AVERAGECOST01 money DEFAULT 0.0,
	AVERAGECOST02 money DEFAULT 0.0,
	AVERAGECOST03 money DEFAULT 0.0,
	AVERAGECOST04 money DEFAULT 0.0,
	AVERAGECOST05 money DEFAULT 0.0,
	AVERAGECOST06 money DEFAULT 0.0,
	AVERAGECOST07 money DEFAULT 0.0,
	AVERAGECOST08 money DEFAULT 0.0,
	AVERAGECOST09 money DEFAULT 0.0,
	AVERAGECOST10 money DEFAULT 0.0,
	AVERAGECOST11 money DEFAULT 0.0,
	AVERAGECOST12 money DEFAULT 0.0,
	AVERAGECOST13 money DEFAULT 0.0,
	AVERAGECOST14 money DEFAULT 0.0,
	AVERAGECOST15 money DEFAULT 0.0,
	AVERAGECOST16 money DEFAULT 0.0,
	AVERAGECOST17 money DEFAULT 0.0,
	AVERAGECOST18 money DEFAULT 0.0,
	AVERAGECOST19 money DEFAULT 0.0,
	AVERAGECOST20 money DEFAULT 0.0,
	AVERAGECOST21 money DEFAULT 0.0,
	AVERAGECOST22 money DEFAULT 0.0,
	AVERAGECOST23 money DEFAULT 0.0,
	AVERAGECOST24 money DEFAULT 0.0,
	AVERAGECOST25 money DEFAULT 0.0,
	AVERAGECOST26 money DEFAULT 0.0,
	AVERAGECOST27 money DEFAULT 0.0,
	AVERAGECOST28 money DEFAULT 0.0,
	AVERAGECOST29 money DEFAULT 0.0,
	AVERAGECOST30 money DEFAULT 0.0,
	AVERAGECOST31 money DEFAULT 0.0,
	AVERAGECOST32 money DEFAULT 0.0,
	AVERAGECOST33 money DEFAULT 0.0,
	AVERAGECOST34 money DEFAULT 0.0,
	AVERAGECOST35 money DEFAULT 0.0,
	AVERAGECOST36 money DEFAULT 0.0,
	AVERAGECOST37 money DEFAULT 0.0,
	AVERAGECOST38 money DEFAULT 0.0,
	AVERAGECOST39 money DEFAULT 0.0,
	AVERAGECOST40 money DEFAULT 0.0,
	AVERAGECOST41 money DEFAULT 0.0,
	AVERAGECOST42 money DEFAULT 0.0,
	AVERAGECOST43 money DEFAULT 0.0,
	AVERAGECOST44 money DEFAULT 0.0,
	AVERAGECOST45 money DEFAULT 0.0,
	AVERAGECOST46 money DEFAULT 0.0,
	AVERAGECOST47 money DEFAULT 0.0,
	AVERAGECOST48 money DEFAULT 0.0,
	AVERAGECOST49 money DEFAULT 0.0,
	AVERAGECOST50 money DEFAULT 0.0,
	AVERAGECOST51 money DEFAULT 0.0,
	AVERAGECOST52 money DEFAULT 0.0,
	AVERAGECOST53 money DEFAULT 0.0,
	AVERAGECOST54 money DEFAULT 0.0,
	AVERAGECOST55 money DEFAULT 0.0,
	AVERAGECOST56 money DEFAULT 0.0,
	AVERAGECOST57 money DEFAULT 0.0,
	AVERAGECOST58 money DEFAULT 0.0,
	AVERAGECOST59 money DEFAULT 0.0,
	AVERAGECOST60 money DEFAULT 0.0,
	AMOUNT00 money DEFAULT 0.0,
	AMOUNT01 money DEFAULT 0.0,
	AMOUNT02 money DEFAULT 0.0,
	AMOUNT03 money DEFAULT 0.0,
	AMOUNT04 money DEFAULT 0.0,
	AMOUNT05 money DEFAULT 0.0,
	AMOUNT06 money DEFAULT 0.0,
	AMOUNT07 money DEFAULT 0.0,
	AMOUNT08 money DEFAULT 0.0,
	AMOUNT09 money DEFAULT 0.0,
	AMOUNT10 money DEFAULT 0.0,
	AMOUNT11 money DEFAULT 0.0,
	AMOUNT12 money DEFAULT 0.0,
	AMOUNT13 money DEFAULT 0.0,
	AMOUNT14 money DEFAULT 0.0,
	AMOUNT15 money DEFAULT 0.0,
	AMOUNT16 money DEFAULT 0.0,
	AMOUNT17 money DEFAULT 0.0,
	AMOUNT18 money DEFAULT 0.0,
	AMOUNT19 money DEFAULT 0.0,
	AMOUNT20 money DEFAULT 0.0,
	AMOUNT21 money DEFAULT 0.0,
	AMOUNT22 money DEFAULT 0.0,
	AMOUNT23 money DEFAULT 0.0,
	AMOUNT24 money DEFAULT 0.0,
	AMOUNT25 money DEFAULT 0.0,
	AMOUNT26 money DEFAULT 0.0,
	AMOUNT27 money DEFAULT 0.0,
	AMOUNT28 money DEFAULT 0.0,
	AMOUNT29 money DEFAULT 0.0,
	AMOUNT30 money DEFAULT 0.0,
	AMOUNT31 money DEFAULT 0.0,
	AMOUNT32 money DEFAULT 0.0,
	AMOUNT33 money DEFAULT 0.0,
	AMOUNT34 money DEFAULT 0.0,
	AMOUNT35 money DEFAULT 0.0,
	AMOUNT36 money DEFAULT 0.0,
	AMOUNT37 money DEFAULT 0.0,
	AMOUNT38 money DEFAULT 0.0,
	AMOUNT39 money DEFAULT 0.0,
	AMOUNT40 money DEFAULT 0.0,
	AMOUNT41 money DEFAULT 0.0,
	AMOUNT42 money DEFAULT 0.0,
	AMOUNT43 money DEFAULT 0.0,
	AMOUNT44 money DEFAULT 0.0,
	AMOUNT45 money DEFAULT 0.0,
	AMOUNT46 money DEFAULT 0.0,
	AMOUNT47 money DEFAULT 0.0,
	AMOUNT48 money DEFAULT 0.0,
	AMOUNT49 money DEFAULT 0.0,
	AMOUNT50 money DEFAULT 0.0,
	AMOUNT51 money DEFAULT 0.0,
	AMOUNT52 money DEFAULT 0.0,
	AMOUNT53 money DEFAULT 0.0,
	AMOUNT54 money DEFAULT 0.0,
	AMOUNT55 money DEFAULT 0.0,
	AMOUNT56 money DEFAULT 0.0,
	AMOUNT57 money DEFAULT 0.0,
	AMOUNT58 money DEFAULT 0.0,
	AMOUNT59 money DEFAULT 0.0,
	AMOUNT60 money DEFAULT 0.0,
	LOTNUMBER00 smallint DEFAULT 0,
	LOTNUMBER01 smallint DEFAULT 0,
	LOTNUMBER02 smallint DEFAULT 0,
	LOTNUMBER03 smallint DEFAULT 0,
	LOTNUMBER04 smallint DEFAULT 0,
	LOTNUMBER05 smallint DEFAULT 0,
	LOTNUMBER06 smallint DEFAULT 0,
	LOTNUMBER07 smallint DEFAULT 0,
	LOTNUMBER08 smallint DEFAULT 0,
	LOTNUMBER09 smallint DEFAULT 0,
	LOTNUMBER10 smallint DEFAULT 0,
	LOTNUMBER11 smallint DEFAULT 0,
	LOTNUMBER12 smallint DEFAULT 0,
	LOTNUMBER13 smallint DEFAULT 0,
	LOTNUMBER14 smallint DEFAULT 0,
	LOTNUMBER15 smallint DEFAULT 0,
	LOTNUMBER16 smallint DEFAULT 0,
	LOTNUMBER17 smallint DEFAULT 0,
	LOTNUMBER18 smallint DEFAULT 0,
	LOTNUMBER19 smallint DEFAULT 0,
	LOTNUMBER20 smallint DEFAULT 0,
	LOTNUMBER21 smallint DEFAULT 0,
	LOTNUMBER22 smallint DEFAULT 0,
	LOTNUMBER23 smallint DEFAULT 0,
	LOTNUMBER24 smallint DEFAULT 0,
	LOTNUMBER25 smallint DEFAULT 0,
	LOTNUMBER26 smallint DEFAULT 0,
	LOTNUMBER27 smallint DEFAULT 0,
	LOTNUMBER28 smallint DEFAULT 0,
	LOTNUMBER29 smallint DEFAULT 0,
	LOTNUMBER30 smallint DEFAULT 0,
	LOTNUMBER31 smallint DEFAULT 0,
	LOTNUMBER32 smallint DEFAULT 0,
	LOTNUMBER33 smallint DEFAULT 0,
	LOTNUMBER34 smallint DEFAULT 0,
	LOTNUMBER35 smallint DEFAULT 0,
	LOTNUMBER36 smallint DEFAULT 0,
	LOTNUMBER37 smallint DEFAULT 0,
	LOTNUMBER38 smallint DEFAULT 0,
	LOTNUMBER39 smallint DEFAULT 0,
	LOTNUMBER40 smallint DEFAULT 0,
	LOTNUMBER41 smallint DEFAULT 0,
	LOTNUMBER42 smallint DEFAULT 0,
	LOTNUMBER43 smallint DEFAULT 0,
	LOTNUMBER44 smallint DEFAULT 0,
	LOTNUMBER45 smallint DEFAULT 0,
	LOTNUMBER46 smallint DEFAULT 0,
	LOTNUMBER47 smallint DEFAULT 0,
	LOTNUMBER48 smallint DEFAULT 0,
	LOTNUMBER49 smallint DEFAULT 0,
	LOTNUMBER50 smallint DEFAULT 0,
	LOTNUMBER51 smallint DEFAULT 0,
	LOTNUMBER52 smallint DEFAULT 0,
	LOTNUMBER53 smallint DEFAULT 0,
	LOTNUMBER54 smallint DEFAULT 0,
	LOTNUMBER55 smallint DEFAULT 0,
	LOTNUMBER56 smallint DEFAULT 0,
	LOTNUMBER57 smallint DEFAULT 0,
	LOTNUMBER58 smallint DEFAULT 0,
	LOTNUMBER59 smallint DEFAULT 0,
	LOTNUMBER60 smallint NULL 
PRIMARY KEY(RowOrder)
);

CREATE  INDEX IDX_WHSTKPERIOD1 ON BCSTKWAREHOUSEPeriod(ITEMCODE);
CREATE  INDEX IDX_WHSTKPERIOD2 ON BCSTKWAREHOUSEPeriod(ITEMCODE,WHID);
CREATE  INDEX IDX_WHSTKPERIOD3 ON BCSTKWAREHOUSEPeriod(ITEMCODE,WHCODE);
CREATE  INDEX IDX_WHSTKPERIOD4 ON BCSTKWAREHOUSEPeriod(ITEMCODE,WHID,WHCODE);

Create table BCGLPostque
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Docdate DateTime,
	Docno Varchar(35) NOT NULL,
	Source 	smallint NOT NULL,
	GLGroup smallint DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME
	PRIMARY KEY(Docno,Source)
);

----- MERIDIAN
create table BCPackingList
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo  VARCHAR(20),
	LineNumber SMALLINT DEFAULT 0,
	ItemCode   VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Descriptions VARCHAR(255), 
	Quantity MONEY DEFAULT 0.0,
	ItemWeight MONEY DEFAULT 0.0,
	NetWeight MONEY DEFAULT 0.0,
	GrossWeight MONEY DEFAULT 0.0,
	Measurement VARCHAR(255),
	MeasureWide	MONEY DEFAULT 0.0,
	MeasureLong	MONEY DEFAULT 0.0,
	MeasureHigh	MONEY DEFAULT 0.0,
	MyType SMALLINT DEFAULT 4,
	UnitCode VARCHAR(10),
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	PalleteStatus 	SMALLINT DEFAULT 0, -- 0 = 40 BAGS/PALLET, 1= 50 BAGS/PALLET
	PackingLine SMALLINT DEFAULT 0
	PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_PACKINGLIST1 ON BCPackingList(DocNo);
CREATE  INDEX IDX_PACKINGLIST2 ON BCPackingList(ItemCode);
CREATE  INDEX IDX_PACKINGLIST3 ON BCPackingList(MyType);

--for evs project
create table BCStandardPrice
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCInvoiceType
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	UserGroup VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(CODE)
);

------------------ Tohome Moditfy -------------------
create table BCReceiptSpecial
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	TransCode	VARCHAR(10) NOT NULL,  --รหัสขนส่ง
	MethodePaybill	VARCHAR(10) NOT NULL, --วิธีการชำระเงิน
	MethodePaybill2	VARCHAR(255) NOT NULL, --วิธีการชำระเงิน 2
	DescDebt	VARCHAR(255) NOT NULL, --หมายเหตุการับชำระ
	Other1	VARCHAR(255) NOT NULL, --อื่นๆ 1
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Other2	VARCHAR(255) NOT NULL, --อื่นๆ 2
	Earnest	VARCHAR(255) NOT NULL, --ดอกเบี้ย
	Interest	VARCHAR(255) NOT NULL, --เงินดาวน์
	Instalment	VARCHAR(255) NOT NULL --งวด
    PRIMARY KEY(ROWORDER)
);

create table BCReceiptMultiAr -- รับเงินอัตโนมัติ หลายลูกค้า
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	TaxNo	VARCHAR(35),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	StartArCode	VARCHAR(20),
	StopArCode	VARCHAR(20),
	RefNo	VARCHAR(20),	
	DocType SMALLINT DEFAULT 0,  -- 0 = ตามรายการเดิม ....  จนถึง 7  , เพิ่มเงื่อนไข 8 รับเงินล่วงหน้าไม่คิดภาษี(tohome)
	SaleCode	VARCHAR(10),
	DepartCode	VARCHAR(10),
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumCreditAmount	MONEY DEFAULT 0.0,
	ChargeAmount	MONEY DEFAULT 0.0, -- ยอด Charge บัตรเครดิต
	ChangeAmount MONEY DEFAULT 0.0, -- ยอดเงินทอน เฉพาะเงินสด
	SumBankAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(35),
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ 
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	SumHomeAmount1 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount1 In Sub) rate เดิม ตัดลูกหนี้
	SumHomeAmount2 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub) rate ใหม่
	DebtLimitReturn MONEY DEFAULT 0.0, -- ยอดทีคืนวงเงิน Default = SumHomeAmount1
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	IsConfirm	SMALLINT DEFAULT 0,
	PayServiceOnly SMALLINT DEFAULT 0, -- 1=รับชำระค่าบริการอย่างเดียว (อ้างได้เฉพาะ  type=3)
	PrintItemOfBill SMALLINT DEFAULT 0, -- 1=พิมพ์ใบเสร็จเหมือนใบส่งของ
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PayType SMALLINT DEFAULT 0 -- 0 = เงินสด, 1 = เช็ค , 2= เงินโอน, 3 = บัตรเครดิต
    PRIMARY KEY(DocNo)
);
CREATE  INDEX IDX_REP_MULTI_DOCNO ON BCReceiptMultiAr(DocNo);
CREATE  INDEX IDX_REP_MULTI_DOCDATE ON BCReceiptMultiAr(DocDate);

			
create table BCRecMultiArSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	InvoiceDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceNo	VARCHAR(20),
	ReceiptNo	VARCHAR(20), -- สร้างเลขที่เอกสารรับชำระอัตโนมัติ  = DocNo/ArCode
	InvBalance	MONEY DEFAULT 0.0,
	MethodePaybill VARCHAR(10),
	PayAmount	MONEY DEFAULT 0.0,
	DebtLimitReturn MONEY DEFAULT 0.0, -- ยอดทีคืนวงเงิน Default = SumHomeAmount1
	DebtLimitRetDesc VARCHAR(255), -- หมายเหตุการคืนวงเงิน
	MyDescription	VARCHAR(255),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	BillType	SMALLINT DEFAULT 0,  -- 0=ใบส่งของ 1=เอกสารยกมา 2=ใบลดหนี้ 3=ใบเพิ่มหนี้ 4=ลูกหนี้อื่นๆ
	RefNo	VARCHAR(20),
	RefType	SMALLINT DEFAULT 0, -- 0=ใบวางบิล 1=ใบเสร็จชั่วคราว
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0,  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
	PayType SMALLINT DEFAULT 0 -- 0 = เงินสด, 1 = เช็ค , 2= เงินโอน, 3 = บัตรเครดิต
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_REPSMULTI1_NO ON BCRecMultiArSub(DocNo);
CREATE  INDEX IDX_REPSMULTI1_DATE ON BCRecMultiArSub(DocDate);
CREATE  INDEX IDX_REPSMULTI1_AR ON BCRecMultiArSub(ArCode);
CREATE  INDEX IDX_REPSMULTI1_TS ON BCRecMultiArSub(TransState);
CREATE  INDEX IDX_REPSMULTI1_INVNO ON BCRecMultiArSub(InvoiceNo);

create table BCItemCodeForSale
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	iscancel    smallint default 0, -- 0 = enable 1=disable
    isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	ItemCode	VARCHAR(25),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	MyDesc		VARCHAR(255),
	LineNumber	SMALLINT DEFAULT 0,
	unitcode	varchar(10),
	whcode		varchar(10),
	shelfcode	varchar(10),
	shortname	VARCHAR(255)
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_ITFORSAL_CODE ON BCItemCodeForSale(ItemCode);
CREATE  INDEX IDX_ITFORSAL_UNIT ON BCItemCodeForSale(unitcode);
CREATE  INDEX IDX_ITFORSAL_WH ON BCItemCodeForSale(whcode);
CREATE  INDEX IDX_ITFORSAL_SHELF ON BCItemCodeForSale(shelfcode);

create table BCSysTRFomName
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	TransKey	VARCHAR(255) NOT NULL,
	FormFileName	VARCHAR(255),
	FormName	varchar(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_TRFONASYS_TK	ON BCSysTRFomName(TransKey);


create table BCItemClassfication
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Name	VARCHAR(255),
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

--Prepare payment
create table BCPaymentTemp
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	TaxNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	DepartCode	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	SumOfInvoice	MONEY DEFAULT 0.0,
	SumOfDebitNote	MONEY DEFAULT 0.0,
	SumOfCreditNote	MONEY DEFAULT 0.0,
	BeforeTaxAmount MONEY DEFAULT 0.0,
	TaxAmount	MONEY DEFAULT 0.0,
	TotalAmount	MONEY DEFAULT 0.0,
	DiscountAmount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	PettyCashAmount	MONEY DEFAULT 0.0,
	SumCashAmount	MONEY DEFAULT 0.0,
	SumChqAmount	MONEY DEFAULT 0.0,
	SumBankAmount	MONEY DEFAULT 0.0,
	SumOfWTax	MONEY DEFAULT 0.0,
	GLFormat	VARCHAR(5),
	GLStartPosting  SMALLINT DEFAULT 0,--1=start posting GL 0=other			
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsPostGL	SMALLINT DEFAULT 0, -- 0=ยังไม่ผ่านรายการ 1=ผ่านรายการแล้ว
	GLTransData	SMALLINT DEFAULT 0, -- 0=atuo 1=manual
	MyDescription	VARCHAR(255),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	BillGroup	VARCHAR(10),
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยัง 1=หมด
	SumHomeAmount1 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount1 In Sub) rate เดิม ตัดเจ้าหนี้
	SumHomeAmount2 MONEY DEFAULT 0.0, -- ยอดรวมสกุลเงินหลัก (Sum Of HomeAmount2 In Sub) rate ใหม่
	OtherIncome	MONEY DEFAULT 0.0, -- รายได้อื่นๆ เพื่อให้ลงบัญชีได้
	OtherExpense	MONEY DEFAULT 0.0, --ค่าใช้จ่ายอื่นๆ
	ExcessAmount1	MONEY DEFAULT 0.0, --เงินเกินใบเสร็จรับ
	ExcessAmount2	MONEY DEFAULT 0.0, --ยอดเงินเกินที่พัดไว้นำมาหักในใบเสร็จ
	CurrencyCode	VARCHAR(10), -- สกุลเงินที่รับ
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0, -- Rate  ณ ตอนรับ
	ExchangeProfit	MONEY DEFAULT 0.0, -- ยอดกำไรขาดทุนทั้งหมด
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	IsConfirm	SMALLINT DEFAULT 0,
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	SumOfDeposit1	MONEY DEFAULT 0.0, -- Jeab 20030530 สำหรับตัดยอดของบิล
	SumOfDeposit2	MONEY DEFAULT 0.0, -- Jeab 20030530 สำหรับ post GL 
	HomeAmountInv	MONEY DEFAULT 0.0,
	HomeAmountDebt	MONEY DEFAULT 0.0,
	HomeAmountCrd	MONEY DEFAULT 0.0,
	JobNo VARCHAR(20), -- Job สำหรับ GL -- 2003-07-25
	PrintCount SMALLINT DEFAULT 0, -- Count Print form -- A-20030923
	SumOfEarnest MONEY DEFAULT 0.0, -- ยอดเงินล่วงหน้า
	PayStatus smallint default 0	
    PRIMARY KEY(DocNo)
);

CREATE  INDEX IDX_PYMT_DATE ON BCPaymentTemp(DocDate);
CREATE  INDEX IDX_PYMT_AP ON BCPaymentTemp(ApCode);
			
create table BCPaymentTempSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	DocDate	DATETIME,
	ApCode	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	InvoiceDate	DATETIME,
	InvoiceNo	VARCHAR(20),
	InvBalance	MONEY DEFAULT 0.0,
	PayAmount	MONEY DEFAULT 0.0,
	MyDescription	VARCHAR(255),
	BillType	SMALLINT DEFAULT 0,
	PaybillNo	VARCHAR(20),
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	InvCurrency	VARCHAR(10), -- รหัสสกุลเงินของบิล
	InvExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนเดิม
	NewExchangeRate	DECIMAL(19,10) DEFAULT 1.0,	-- อัตราแลกเปลี่ยนใหม่
	HomeAmount1	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินเดิม InvExchangeRate * PayAmount
	HomeAmount2	MONEY DEFAULT 0.0, -- ยอดลดตามสกุลเงินใหม่ NewExchangeRate * PayAmount
	ExchangeProfit	MONEY DEFAULT 0.0  -- กำไร(ขาดทุน) HomeAmount1-HomeAmount2
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PYMST_NO ON BCPaymentTempSub(DocNo);
CREATE  INDEX IDX_PYMST_DATE ON BCPaymentTempSub(DocDate);
CREATE  INDEX IDX_PYMST_AP ON BCPaymentTempSub(ApCode);
CREATE  INDEX IDX_PYMST_TS ON BCPaymentTempSub(TransState);
CREATE  INDEX IDX_PYMST_INVNO ON BCPaymentTempSub(InvoiceNo);

CREATE TABLE DocTrans
(
	ROWORDER int  NOT NULL IDENTITY(1,1),
	DocNo VARCHAR(20),
	DocDate	DATETIME,
	DocType smallint NOT NULL,--(ตรงกับ prossstock)
	DocMode smallint NOT NULL, -- (เพิ่ม,ลบ,แก้)
	IsProcess SMALLINT DEFAULT 0,
	DocUser	VARCHAR(10), -- รหัสผู้บันทึก
	DocTimeStamp	DATETIME	-- วันเวลาที่บันทึก (ถ้าไม่ได้ก็แยก field เวลาออก)
	PRIMARY KEY(ROWORDER)
);


--***********************************
-- Comment log entry by: Jum
-- On: 29/9/2547 22:57:01
-- Request: 
-- Comments: Promotion config
--***********************************
CREATE TABLE BCPromotion
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	isconfirm smallint default 0,
    confirmcode    varchar(30),
    confirmdatetime    datetime,
    cancelcode    varchar(30),
    canceldatetime    datetime,
	Code	VARCHAR(20)	NOT NULL,
	DocDate DATETIME,
	PromotionType SMALLINT DEFAULT 0,--0=FOC,1=Pricing
	MyDescription VARCHAR(255),
	StartSaleArea VARCHAR(10),
	IsExport smallint default 0,
	StopSaleArea VARCHAR(10),
	StartDate DATETIME,
	StopDate DATETIME,
	Iscancel	SMALLINT DEFAULT 0, -- 0 = Enable 1=Disable
	CustGroup VARCHAR(255),
	CustType VARCHAR(255),
	StartArcode VARCHAR(25),
	StopArcode VARCHAR(25),
	CreatorCode	VARCHAR(10),
	CreateDateTime	DATETIME,
	LastEditorCode	VARCHAR(10),
	LastEditDateT	DATETIME
    PRIMARY KEY(Code)
);

CREATE  INDEX IDX_BCPROMOTION_1 ON BCPromotion(DocDate);

CREATE TABLE BCPromotionSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code VARCHAR(20),
	DocDate DATETIME,
	PromotionType SMALLINT DEFAULT 0,--0=FOC,1=FOC ,2=Pricing,3=Bottom Line discount
	ItemCode VARCHAR(25),
	ItemName	VARCHAR(255),
	UnitCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Keycode VARCHAR(255),
	StartSaleArea VARCHAR(10),
	StopSaleArea VARCHAR(10),
	StartDate DATETIME,
	StopDate DATETIME,
	Iscancel	SMALLINT DEFAULT 0, -- 0= Enable 1=Disable
	CustGroup VARCHAR(255),
	CustType VARCHAR(255),
	StartArcode VARCHAR(25),
	StopArcode VARCHAR(25),
	FromQty MONEY DEFAULT 0.0,
	ToQty MONEY DEFAULT 0.0,
	FromAmt MONEY DEFAULT 0.0,
	ToAmt MONEY DEFAULT 0.0,
	BillType SMALLINT DEFAULT 0,--see bcarinvoice.billtype
	FOCItemCode VARCHAR(25),
	FOCUnitCode VARCHAR(10),
	FOCQty MONEY DEFAULT 0.0,
	PriceperUnit  MONEY DEFAULT 0.0,
	DiscountWord VARCHAR(255),
	Linenumber SMALLINT DEFAULT 0,
	ItemGroup VARCHAR(10),
	ItemType VARCHAR(10),
	PriceLevel SMALLINT DEFAULT 0,
	FromArGroup varchar(10),
	ToArGroup varchar(10),
	ChmType smallint default 0,
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_BCPROMOTIONSUB_1 ON BCPromotionSub(Code);
CREATE  INDEX IDX_BCPROMOTIONSUB_2 ON BCPromotionSub(DocDate);
CREATE  INDEX IDX_BCPROMOTIONSUB_3 ON BCPromotionSub(ItemCode);
CREATE  INDEX IDX_BCPROMOTIONSUB_4 ON BCPromotionSub(UnitCode);

CREATE TABLE BCPromotionsub_Log
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code VARCHAR(20),
	DocDate DATETIME,
	PromotionType SMALLINT DEFAULT 0,--0=FOC,1=FOC ,2=Pricing,3=Bottom Line discount
	ItemCode VARCHAR(25),
	ItemName	VARCHAR(255),
	UnitCode VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	Keycode VARCHAR(255),
	StartSaleArea VARCHAR(10),
	StopSaleArea VARCHAR(10),
	StartDate DATETIME,
	StopDate DATETIME,
	Iscancel	SMALLINT DEFAULT 0, -- 0= Enable 1=Disable
	CustGroup VARCHAR(255),
	CustType VARCHAR(255),
	StartArcode VARCHAR(25),
	StopArcode VARCHAR(25),
	FromQty MONEY DEFAULT 0.0,
	ToQty MONEY DEFAULT 0.0,
	FromAmt MONEY DEFAULT 0.0,
	ToAmt MONEY DEFAULT 0.0,
	BillType SMALLINT DEFAULT 0,--see bcarinvoice.billtype
	FOCItemCode VARCHAR(25),
	FOCUnitCode VARCHAR(10),
	FOCQty MONEY DEFAULT 0.0,
	PriceperUnit  MONEY DEFAULT 0.0,
	DiscountWord VARCHAR(255),
	Linenumber SMALLINT DEFAULT 0,
	ItemGroup VARCHAR(10),
	ItemType VARCHAR(10),
	PriceLevel SMALLINT DEFAULT 0,
	FromArGroup varchar(10),
	ToArGroup varchar(10),
	ChmType smallint default 0,
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_BCPROMOTIONSUBLOG_1 ON BCPromotionsub_Log(Code);
CREATE  INDEX IDX_BCPROMOTIONSUBLOG_2 ON BCPromotionsub_Log(DocDate);
CREATE  INDEX IDX_BCPROMOTIONSUBLOG_3 ON BCPromotionsub_Log(ItemCode);
CREATE  INDEX IDX_BCPROMOTIONSUBLOG_4 ON BCPromotionsub_Log(UnitCode);

create table BCDeliveryOrder
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20) NOT NULL,
	DocDate	DATETIME,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	BillType	SMALLINT DEFAULT 0, -- Add 01/12/2002		
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),-- ผู้ขนส่ง
	DeliveryDate DATETIME,-- วันที่ส่งสินค้า
	DeliveryAddr VARCHAR(10),-- สถานที่ส่งสินค้า
	DeliveryTel VARCHAR(255),-- โทรศัพท์ สถานที่ส่งสินค้า
	PORefNo	VARCHAR(20), -- อ้างถึงใบสั่งซื้อเลขที่
	CarLicense	VARCHAR(50), -- ทะเบียนรถ
	IssueAddr VARCHAR(255),-- สถานที่เบิกสินค้า
	SaleDriver VARCHAR(255),-- ชื่อผู้ขับรถ
	OwnReceive VARCHAR(255),-- ผู้รับสินค้า
	TimeTransport		VARCHAR(10),	-- เวลาข่นส่ง
	TransportCode	VARCHAR(10),
	CarType		VARCHAR(10), -- ประเภทรถ
	MyDescription	VARCHAR(255),
	BillStatus	SMALLINT DEFAULT 0, -- 0=ยังไม่หมด 1=ตัดหมดแล้ว
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	IsProcessOK SMALLINT DEFAULT 0, -- 0=ไม่สำเร็จ 1=สำเร็จ
	IsCompleteSave	SMALLINT DEFAULT 0, -- 0=ไม่สมบูรณ์ 1=สมบูรณ์
	RecurName	VARCHAR(40),
	ConfirmCode	VARCHAR(10),
	ConfirmDateTime	DATETIME,
	CancelCode	VARCHAR(10),
	CancelDateTime	DATETIME,
	PrintCount SMALLINT DEFAULT 0, -- Count Print saleorder -- Jeab-20030923 
	IsImport SMALLINT DEFAULT 0, -- 1= ข้อมูลที่ Import เข้ามา
	UserGroup VARCHAR(10) -- กลุ่มพนักงาน Jeab 2004-02-03
    PRIMARY KEY(DocNo)
);
	 		
CREATE  INDEX IDX_DO_DATE ON BCDeliveryOrder(DocDate);
CREATE  INDEX IDX_DO_AR ON BCDeliveryOrder(ArCode);
CREATE  INDEX IDX_DO_BS ON BCDeliveryOrder(BillStatus);
CREATE  INDEX IDX_DO_ROW	ON BCDeliveryOrder(ROWORDER);

create table BCDeliveryOrderSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DocNo	VARCHAR(20),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	DocDate	DATETIME,
	TaxType	SMALLINT DEFAULT 0,
	BillType	SMALLINT DEFAULT 0, -- Add 01/12/2002		
	DepartCode	VARCHAR(10),
	ArCode	VARCHAR(20),
	SaleCode	VARCHAR(10),
	MyDescription	VARCHAR(255),
	ItemCode	VARCHAR(25),
	ItemName	VARCHAR(255),
	WHCode	VARCHAR(10),
	ShelfCode	VARCHAR(15),
	Qty	MONEY DEFAULT 0.0,
	RemainQty	MONEY DEFAULT 0.0, -- ยอดคงเหลือหลังตัด
	Price	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(30),
	DiscountAmount	MONEY DEFAULT 0.0,
	Amount	MONEY DEFAULT 0.0,
	NetAmount	MONEY DEFAULT 0.0,
	HomeAmount MONEY DEFAULT 0.0, -- NetAmount * ExchangeRate
	UnitCode	VARCHAR(10),
	OppositePrice2	MONEY DEFAULT 0.0, -- ราคาต่อหน่วยที่ 2 (เส้น)
	OppositeUnit	VARCHAR(10),
	OppositeQty	MONEY DEFAULT 0.0,
	StkReserveNo	VARCHAR(20),
	SOStatus	SMALLINT DEFAULT 0, -- 0=สั่งขาย 1=สั่งจอง
	StockType	SMALLINT DEFAULT 0,
	SORefNo	VARCHAR(20), -- Total SO reference -- Jeab 19-04-2003 -- A& 
	ExceptTax	SMALLINT DEFAULT 0,  -- 0=คิดภาษี 1=ยกเว้นภาษี 2=ภาษีอัตราศูนย์
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),	
	CurrencyCode	VARCHAR(10),
	ExchangeRate	DECIMAL(19,10) DEFAULT 1.0,
	TransState 	SMALLINT DEFAULT 0, -- 0 = new transaction 1 = old transaction 
	IsCancel	SMALLINT DEFAULT 0, -- 0=ยังไม่Cancel 1=Cancel
	LineNumber SMALLINT DEFAULT 0,
	RefLineNumber SMALLINT DEFAULT 0, -- Line Number ของสินค้าที่อ้างอิงมาจากเอกสารอื่น
	CategoryCode	VARCHAR(10),	-- หมวด
	GroupCode	VARCHAR(10),	-- กลุ่ม
	BrandCode	VARCHAR(10), -- ยี่ห้อ
	TypeCode	VARCHAR(10),	-- ประเภท	
	FormatCode	VARCHAR(10),	-- รูปแบบ
	BarCode	VARCHAR(20),
	IsConditionSend SMALLINT DEFAULT 0,-- เงื่อนไขการรับสินค้า 0 = รับเอง, 1 = ส่งให้
	TransportAmount	MONEY DEFAULT 0.0, -- ค่าขนส่ง
	OtherValue	MONEY DEFAULT 0.0, -- ค่าอื่น
	REMAINPAYQTY	MONEY DEFAULT 0.0,
	ISPAYMENT SMALLINT DEFAULT 0, 	--1=เอาไปทำใบจ่ายได้	
	Colorcode VARCHAR(10)	,
	SizeCode VARCHAR(10),
	StyleCode VARCHAR(10),
	itemsetcode VARCHAR(25),
	PORefNo VARCHAR(20),
	BehindIndex	SMALLINT DEFAULT 1,
	TaxRate	SMALLMONEY DEFAULT 0.0,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	UserGroup VARCHAR(10), -- กลุ่มพนักงาน Jeab 2004-02-03
	IsProcess SMALLINT DEFAULT 0,
	IsLockCost SMALLINT DEFAULT 0
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_DOS_DATE ON BCDeliveryOrderSub(DocDate);
CREATE  INDEX IDX_DOS_NO ON BCDeliveryOrderSub(DocNo);
CREATE  INDEX IDX_DOS_AR ON BCDeliveryOrderSub(ArCode);
CREATE  INDEX IDX_DOS_SALE ON BCDeliveryOrderSub(SaleCode);
CREATE  INDEX IDX_DOS_RQTY	ON BCDeliveryOrderSub(RemainQty);
CREATE  INDEX IDX_DOS_TS ON BCDeliveryOrderSub(TransState);
CREATE  INDEX IDX_DOS_SERVICE ON BCDeliveryOrderSub(ItemCode,DocDate,BehindIndex);
CREATE  INDEX IDX_DOS_SISPROCESS ON BCDeliveryOrderSub(ItemCode,IsProcess);
CREATE  INDEX IDX_DOS_PAK1 ON BCDeliveryOrderSub(PackingRate1);
CREATE  INDEX IDX_DOS_PAK2 ON BCDeliveryOrderSub(PackingRate2);
CREATE  INDEX IDX_DOS_ISPC ON BCDeliveryOrderSub(IsProcess);

create table bcappconfig
(
	keycode varchar(20) not null,
	keyvalue varchar(100),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	resourceText varchar(30),
	linenumber smallint,
	category varchar(20)	
	primary key (keycode)
);

--*******************************************
-- Jum
-- For BCDTS
--create table BCARINVOICEDEL(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
--create table BCCAR(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
--create table BCCLSPDHISTORY(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
--create table BCPOSTHISTORY(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
--create table BCUPDATESCRIPT(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
--create table BCITEMSET(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
--create table BCITEMSETDETAIL(IsExport smallint default 0,CreatorCode VARCHAR(10),CreateDateTime DATETIME,LastEditorCode VARCHAR(10),LastEditDateT DATETIME);
-- Jum
-- end For BCDTS


--*******************************************
--
-- For POS
-- ประเภทคูปอง
CREATE TABLE BCCOUPONTYPE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL,
	NAME	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(CODE)
);

 -- MASTER คูปอง
CREATE TABLE BCCOUPON
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL,
	NAME	VARCHAR(50) NOT NULL,	
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	COUPONTYPE 	VARCHAR(10),	--รหัสประเภทคูปอง
	STARTBOOK	VARCHAR(10), --จากเล่มที่
	STOPBOOK 	VARCHAR(10),	--ถึง
	STARTNO	VARCHAR(10),	--จากเลขที่คูปอง
	STOPNO	VARCHAR(10),	---ถึง
	BEGINDATE DATETIME,		--วันที่เริ่ม
	EXPIREDATE DATETIME,	--วันที่หมดอายุ
	COUPONVAL MONEY DEFAULT 0.0,	--ราคา หรือ คูปองส่วนลด 
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	couponstatus smallint default 0,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(CODE)
);

 -- รับคูปอง
CREATE TABLE BCCOUPONRECEIVE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	COUPONCODE VARCHAR(10),
	COUPONTYPE 	VARCHAR(10),--0= คูปองทั่วไป 1=คูปองอื่นๆ
	COUPONNO	VARCHAR(10),
	TOCOUPONNO	VARCHAR(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	COUPONCOUNT	SMALLINT DEFAULT 0,--จำนวนคูปอง
	DOCNO		VARCHAR(20) NOT NULL,--เลขที่ใบกำกับภาษี
	BOOK				VARCHAR(10),
	COUPONVAL MONEY DEFAULT 0.0,--มูลค่ารวมของคูปอง
	LINENUMBER	SMALLINT DEFAULT 0,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	couponstatus smallint default 0,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
	PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_COUREC_DOCNO ON BCCOUPONRECEIVE(DOCNO);

-- เครื่อง POS
CREATE TABLE BPSMACHINE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	MACHINENO	VARCHAR(10) NOT NULL, -- เลขที่เครื่อง
	MACHINECODE	VARCHAR(30) NOT NULL, -- เลขประจำเครื่อง
	MYDESCRIPTION	VARCHAR(255),
	ISUSE		SMALLINT DEFAULT 0, --  0=ยังไม่ได้ใช้ 1=นำไปใช้แล้ว
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(MACHINENO)
);

-- กะการทำงาน
CREATE TABLE BPSSHIFT
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL,--	รหัสกะทำงาน
	NAME	VARCHAR(50) NOT NULL,--	ชื่อกะทำงาน
	STARTTIME VARCHAR(8), --	เวลาเริ่มต้น
	STOPTIME VARCHAR(8) ,--	เวลาสิ้นสุด
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(CODE)
);
-- กำหนดราคาโปรโมชั่น POS
CREATE TABLE BPSPROMOPRICE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	BARCODE		VARCHAR(20),
	ITEMCODE	VARCHAR(25),
	UNITCODE VARCHAR(10),
	TAXTYPE	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FROMQTY	MONEY DEFAULT 0.0,
	TOQTY	MONEY DEFAULT 0.0,
	SALEPRICE	MONEY DEFAULT 0.0,
	DISCOUNTWORD	VARCHAR(35),
	FROMDATE	DATETIME,
	TODATE	DATETIME,
	FROMARGROUP	VARCHAR(10),
	TOARGROUP	VARCHAR(10),
	LINENUMBER SMALLINT DEFAULT 0	,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_BPPROITEM ON BPSPROMOPRICE(ITEMCODE);
CREATE  INDEX IDX_BPPROFQTY ON BPSPROMOPRICE(FROMQTY);
CREATE  INDEX IDX_BPPROTQTY ON BPSPROMOPRICE(TOQTY);
CREATE  INDEX IDX_BPPROFDATE ON BPSPROMOPRICE(FROMDATE);
CREATE  INDEX IDX_BPPROTDATE ON BPSPROMOPRICE(TODATE);
CREATE  INDEX IDX_BPPROUNIT ON BPSPROMOPRICE(UNITCODE);
CREATE  INDEX IDX_BPPROFARG ON BPSPROMOPRICE(FROMARGROUP);
CREATE  INDEX IDX_BPPROTARG ON BPSPROMOPRICE(TOARGROUP);

-- กำหนดราคาขาย POS
CREATE TABLE BPSPRICELIST
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ITEMCODE	VARCHAR(25),
	UNITCODE VARCHAR(10),
	REMARK	VARCHAR(100),
	TAXTYPE	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	BARCODE 	VARCHAR(20),
	FROMQTY	MONEY DEFAULT 0.0,
	TOQTY	MONEY DEFAULT 0.0,
	STARTDATE DATETIME,
	STOPDATE DATETIME,
	SalePrice1	MONEY DEFAULT 0.0,
	SalePrice2	MONEY DEFAULT 0.0,
	SalePrice3	MONEY DEFAULT 0.0,
	SalePrice4	MONEY DEFAULT 0.0,
	SalePrice5	MONEY DEFAULT 0.0,
	SalePrice6	MONEY DEFAULT 0.0,
	SalePrice7	MONEY DEFAULT 0.0,
	SalePrice8	MONEY DEFAULT 0.0,
	SalePrice9	MONEY DEFAULT 0.0,
	SalePrice10	MONEY DEFAULT 0.0,
	SalePrice11	MONEY DEFAULT 0.0,
	SalePrice12	MONEY DEFAULT 0.0,
	SalePrice13	MONEY DEFAULT 0.0,
	SalePrice14	MONEY DEFAULT 0.0,
	SalePrice15	MONEY DEFAULT 0.0,
	SalePrice16	MONEY DEFAULT 0.0,
	SalePrice17	MONEY DEFAULT 0.0,
	SalePrice18	MONEY DEFAULT 0.0,
	SalePrice19	MONEY DEFAULT 0.0,
	SalePrice20	MONEY DEFAULT 0.0,	
	LINENUMBER SMALLINT DEFAULT 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(ROWORDER)
);


CREATE  INDEX IDX_BPPRLITEM ON BPSPRICELIST(ITEMCODE);
CREATE  INDEX IDX_BPPRLFQTY ON BPSPRICELIST(FROMQTY);
CREATE  INDEX IDX_BPPRLTQTY ON BPSPRICELIST(TOQTY);
CREATE  INDEX IDX_BPPRLUNIT ON BPSPRICELIST(UNITCODE);


-- กำหนดราคาโปรโมชั่น POS ตามกลุ่ม
CREATE TABLE BPSPROMOGROUP
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE		VARCHAR(20),--รหัสกลุ่มโปรโมชั่น
	NAME	VARCHAR(25),--ชื่อ/รายละเอียดโปรโมชั่น			
	FROMQTY	MONEY DEFAULT 0.0,
	TOQTY	MONEY DEFAULT 0.0,
	FROMDATE	DATETIME,
	TODATE	DATETIME,
	FROMARGROUP	VARCHAR(10),
	TOARGROUP	VARCHAR(10),
	STARTITEMGROUP VARCHAR(10),
	STOPITEMGROUP VARCHAR(10),
	SALEPRICE	MONEY DEFAULT 0.0,
	DISCOUNTWORD	VARCHAR(35)	,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_BPCODE ON BPSPROMOGROUP(CODE);
CREATE  INDEX IDX_BPSGPROFQTY ON BPSPROMOGROUP(FROMQTY);
CREATE  INDEX IDX_BPSGPROTQTY ON BPSPROMOGROUP(TOQTY);
CREATE  INDEX IDX_BPSGPROFDATE ON BPSPROMOGROUP(FROMDATE);
CREATE  INDEX IDX_BPSGPROTDATE ON BPSPROMOGROUP(TODATE);
CREATE  INDEX IDX_BPSGPROFARG ON BPSPROMOGROUP(FROMARGROUP);
CREATE  INDEX IDX_BPSGPROTARG ON BPSPROMOGROUP(TOARGROUP);
CREATE INDEX IDX_BPSGPROFITEM ON BPSPROMOGROUP(STARTITEMGROUP);
CREATE INDEX IDX_BPSGPROTITEM ON BPSPROMOGROUP(STOPITEMGROUP);

 -- บันทึกนำส่งรายได้จากการขาย
CREATE TABLE BPSCASHIERINC
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	DOCNO	VARCHAR(20) NOT NULL,
	WORKNO	VARCHAR(20) NOT NULL, -- เลขที่เอกสารการเปิดกะ
	DOCDATE	DATETIME,
	SHIFTCODE		VARCHAR(10), -- กะที่
	DEPTCODE  VARCHAR(10),  -- แผนก
	CASHIERCODE	VARCHAR(10),
	MYDESCRIPTION	VARCHAR(100),
	MACHINENO	VARCHAR(10), -- เลขที่เครื่อง
	MACHINECODE	VARCHAR(30), -- เลขประจำเครื่อง
	BEGINAMOUNT MONEY DEFAULT 0.0, -- ยอดเงินยกมา
	CASHAMOUNT	MONEY DEFAULT 0.0, -- ยอดรับเงินสด
	CREDITAMOUNT	MONEY DEFAULT 0.0, -- ยอดรับบัตรเครดิต
	COUPONAMOUNT	MONEY DEFAULT 0.0, -- ยอดรับคูปอง
	OTHERAMOUNT	MONEY DEFAULT 0.0, -- ยอดรับอื่นๆ
	MONEY1000	SMALLINT DEFAULT	0,
	MONEY500	SMALLINT DEFAULT 	0,
	MONEY100	SMALLINT DEFAULT 	0,
	MONEY50	SMALLINT DEFAULT 	0,
	MONEY20	SMALLINT DEFAULT 	0,
	MONEY10	SMALLINT DEFAULT 	0,
	MONEY5		SMALLINT DEFAULT 	0,
	MONEY2		SMALLINT DEFAULT 	0,
	MONEY1		SMALLINT DEFAULT 	0,
	MONEY50ST	SMALLINT DEFAULT 	0,
	MONEY25ST	SMALLINT DEFAULT 	0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,

	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(DOCNO)
);

 -- ที่ตั้งสินค้าบนชั้นวางของ
CREATE TABLE BPSHELF
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL, -- รหัสที่ตั้งสินค้า
	NAME	VARCHAR(50) NOT NULL, -- ชื่อที่ตั้งสินค้า
	MAPCODE	VARCHAR(10),	-- รหัสแผนที่
	MAPPOSITION_X	SMALLINT	DEFAULT  0,
	MAPPOSITION_Y	SMALLINT	DEFAULT 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(CODE)
);

 -- ที่ตั้งสินค้าบนชั้นวางของ
CREATE TABLE BPSHELFTRANS
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	SHELFCODE	VARCHAR(10) NOT NULL, -- รหัสที่ตั้งสินค้า
	SHELFORDER 	SMALLINT	DEFAULT  0,
	ITEMCODE	VARCHAR(25),
	BARCODE	VARCHAR(20),
	UNITCODE	VARCHAR(10),
	QTY		MONEY DEFAULT 0.0,
	MYDESCRIPTION	VARCHAR(100),
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_SHELFCODE ON BPSHELFTRANS(SHELFCODE);
CREATE  INDEX IDX_SHELFITEM ON BPSHELFTRANS(ITEMCODE);
CREATE  INDEX IDX_SHELFUNIT ON BPSHELFTRANS(UNITCODE);

--  nauy 2006-12-12
 -- ที่ตั้งสินค้าบนชั้นวางของ
CREATE TABLE BPSITEMRECEIVETYPE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL, -- รหัสประเภทการรับสินค้า
	Name 	VARCHAR(50)  NULL,	 -- ชื่อประเภทการรับสินค้า
	Remark	VARCHAR(255) NULL,     -- หมายเหต
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(Code)
);


CREATE TABLE BCINCOMECHK -- บันทึกการตรวจนับรายได้จากการรับชำระ
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),
	DOCNO		VARCHAR(20) NOT NULL ,	
	DOCDATE	DATETIME,	
	WKDOCNO	VARCHAR(20), -- เลขที่ใบเปิดกะ	
	MYDESCRIPTION	VARCHAR(255),
	SALECODE	VARCHAR(10),-- พนักงานผู้ตรวจนับ
	CASHIERCODE	VARCHAR(10),-- แคชเชียร์
	CASHREC	MONEY	DEFAULT 0.0, -- ยอดเงินสดนำส่ง
	CASHCHK	MONEY	DEFAULT 0.0, -- ยอดเงินสดนับได้
	CREDITREC	MONEY	DEFAULT 0.0, -- ยอดบัตรเครดิตนำส่ง
	CREDITCHK	MONEY	DEFAULT 0.0, -- ยอดบัตรเครดิตนับได้
	COUPONREC	MONEY	DEFAULT 0.0, -- ยอดคูปองนำส่ง
	COUPONCHK	MONEY	DEFAULT 0.0, -- ยอดคูปองนับได้
	OTHERREC	MONEY	DEFAULT 0.0, -- ยอดอื่นๆนำส่ง
	OTHERCHK	MONEY	DEFAULT 0.0, -- ยอดอื่นๆนับได้								
	ISCONFIRM	SMALLINT DEFAULT 0,
	ISCANCEL	SMALLINT DEFAULT 0, -- 0=ยังไม่CANCEL 1=CANCEL
	CREATORCODE		VARCHAR(10),
	CREATEDATETIME	DATETIME,
	LASTEDITORCODE	VARCHAR(10),
	LASTEDITDATET	DATETIME,

	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	
    PRIMARY KEY(DOCNO)
);	



---------------------------------------------------------------------


-- BPCRSERVICETRANS
CREATE TABLE BPCRSERVICETRANS
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),
	CREDITSERVICE	VARCHAR(20),
	PROMISE	VARCHAR(20),--เลขที่สัญญา
	FEEWORD 	VARCHAR(35),--ค่าธรรมเนียม
	FEE		 MONEY DEFAULT 0.0, --ค่าธรรมเนียม
	AMOUNT		MONEY DEFAULT 0.0, --จำนวนเงินไม่รวมค่าธรรมเนียม
	SERVICEANDCHARGE MONEY DEFAULT 0.0, --จำนวนเงินรวมค่าธรรมเนียม
	DOCNO		VARCHAR(20),--เลขที่ใบกำกับภาษี
	MYDESCRIPTION	VARCHAR(100),--หมายเหตุ
	DUEDATE	DATETIME,--วันครบกำหนด
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CS_DOCNO ON BPCRSERVICETRANS(DOCNO);
CREATE  INDEX IDX_CS_PNO ON BPCRSERVICETRANS(PROMISE);
CREATE  INDEX IDX_CS_CR ON BPCRSERVICETRANS(CREDITSERVICE);
-- กำหนดทางเลือกการทำงาน
CREATE TABLE BPSCONFIG -- POS CONFIG
(
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	PRINTSLIPMODE SMALLINT	DEFAULT 0, -- 0=พิมพ์ทีหลัง 1=พิมพ์เลย
	CASHIERMODE SMALLINT	DEFAULT 0, -- 0=CASHIER กับ SALE คนเดียวกัน 1=คนละคน
	AFTERDECIMALMODE SMALLINT	DEFAULT 0, -- 0=ปัดขึ้นหมด 1=ปัดลงหมด 2=ไม่ปัด 3=ปัดเศษสตางค์
	GROUPITEMSTATUS SMALLINT	DEFAULT 0, -- 0=สินค้าตัวเดียวกันให้รวมรายการ 1=ไม่ต้องรวม
	STOCKPROCESS SMALLINT	DEFAULT 0, -- 0=สิ้นวัน 1=ทันที
	SOUNDFOLDER VARCHAR(100),
	SLIPTYPE SMALLINT	DEFAULT 0, -- 0=ไม่พิมพ์ 1=SLIP เป็นม้วน 2=SLIP ที่มีรูปแบบแน่นอน
	PRINTERPORT VARCHAR(50), --
	PRINTERTYPE	SMALLINT	DEFAULT 0, 
	CASHDRAWER SMALLINT	DEFAULT 0, -- 0=ไม่ใช้ 1=ใช้
	BILLDISC SMALLINT	DEFAULT 0, -- ส่วนลดท้ายบิล 0=ไม่ใช้ 1=ใช้
	CASHDRAWERPORT VARCHAR(50), -- เครื่องเก็บเงิน
	PRINTERPORTRATE SMALLINT DEFAULT 9600, -- RATE ของเครื่อง PRINTER
	CASHDRAWERPORTRATE SMALLINT DEFAULT 9600, -- RATE ของเครื่อง PRINTER
	MACHINENO	VARCHAR(10), -- เลขที่เครื่อง
	MACHINECODE	VARCHAR(30), -- เลขประจำเครื่อง
	BILLGROUP	VARCHAR(4),	-- กลุ่มเอกสาร
	DEFAULTCUSTCODE VARCHAR(15),	-- รหัสลูกค้าเริ่มต้น
	DEFAULTDEPART VARCHAR(10), -- รหัสแผนกเริ่มต้น
	DEFAULTWH VARCHAR(10), -- รหัสคลังเริ่มต้น
	MEMBERMODE SMALLINT DEFAULT 0, -- 0=ไม่มีระบบสามาชิก 1=มีระบบสมาชิกสะสมแต้ม
	MEMBERDISC	VARCHAR(10), -- ส่วนลดสำหรับสมาชิก	
	SALEBARTERPOINT SMALLINT DEFAULT 0, -- 0=มีจุดแลกซื้อต่างหาก 1=ยิงให้ในบิลขายเลย
	PROMOTIONTYPE	SMALLINT DEFAULT 0, -- 0=ไม่ใช้ 1=แบบที่ 1 2=แบบที่ 2 
	MARKTYPE SMALLINT DEFAULT 0, -- 0=สะสมแบบเป็นแต้ม 1=แบบเป็นมูลค่า
	MARKMODE SMALLINT DEFAULT 0, -- 0=มีแบบเดียว 1= แยกเป็น 2 แบบ
	VALUEPERMARK1 MONEY DEFAULT 0.0, -- มูลค่าต่อแต้มแบที่ 1 (ราคาปกติ)
	VALUEPERMARK2 MONEY DEFAULT 0.0, -- มูลค่าต่อแต้มแบที่ 2 (ราคาโปรโมชั่น)
	ABBREMARK VARCHAR(255), -- หมายเหตุท้ายใบกำกับ
	CNPAYTYPE SMALLINT	DEFAULT 0, -- 0=คืนคูปอง 1=คืนเงินสด 2=ทั้ง 2แบบ
	CNCOUPONDATE SMALLINT	DEFAULT 0, -- อายุของคูปองที่จ่ายคืน (วัน)
	BILLCOUNT  INT DEFAULT 0,  -- นับจำนวนบิลที่เกิดโปรโมชั้น เช่นตั้งไว้ 1000 เกิดโปรโมชั่น 1 ครั้ง
	SHOWBARCODE SMALLINT	DEFAULT 0,  --  0 = แสดง BARCODE 1= แสดงรหัสสินค้า
	PROMOCOUNT	SMALLINT DEFAULT 0,--ใช้เป็นเค้าเตอร์ในการนับจำนวน BACKGROUD PROCESS
	PROMODISCOUNT VARCHAR(35),	--เป็นส่วนลดที่ได้โปรโมชั่นจำนวนคน ถ้าใส่ % แสดงว่าเป็นส่วนลด % ถ้าไม่ใส่เป็นบาท
	PROMOBARCODE SMALLINT DEFAULT 0, --ราคาสินค้าอิงบาร์โค้ด
	AUTOCLEAR SMALLINT DEFAULT 0, --ลบเอกสารที่พักอัตโนมัติ 0=ไม่ใช้  1=ใช้
	CHANGEPRICE SMALLINT DEFAULT 0, --แคชเชียร์แก้ราคาสินค้า 0=ไม่ได้  1=ได้
	DEFAULTRETWH VARCHAR(10), -- รหัสคลังรับคืน-ส่งคืน
	DEFAULTRETSH VARCHAR(10), -- รหัสที่เก็บรับคืน-ส่งคืน	
	GIFTWH VARCHAR(10), -- คลังของสมนาคุณ
	GIFTSH VARCHAR(10), -- ที่เก็บของสมนาคุณ
	CHECKSTOCK	SMALLINT DEFAULT 0,-- 0=ไม่นับ STOCK 1=ยอมให้ติดลบได้ เฉพาะสินค้าที่มีการทำรายการ 2=ไม่ให้ STOCK ติดลบ
	EXPDATEMODE	SMALLINT DEFAULT 0,
	CASHINDRAWER MONEY DEFAULT 0.0, -- จำนวนเงินสูงสุดที่มีในเครื่อง POS
	MULTIDEFAR	SMALLINT DEFAULT 0, -- กำหนดลูกค้าเริ่มต้นแยกตามจุดขาย   0=ไม่ใช้  1=ใช้
	DEFAULTCURSOR	SMALLINT DEFAULT 0, -- 0=อยู่ี่รหัส 1=อยู่ที่จำนวน
	AUTOSHIFTMODE	SMALLINT DEFAULT 0, -- กะทำงานอัตโนมัติ   0=ไม่ใช้  1=ใช้	
	ALARMMODE	SMALLINT DEFAULT 0, -- เตือนเมื่อใกล้เวลาปิดกะ   0=ไม่ใช้  1=ใช้
	ALARMTIME	SMALLINT DEFAULT 0, -- เวลาก่อนปิดกะที่เริ่มเตือน   นาที	
	DYNAMICBARCODE	SMALLINT DEFAULT 0, -- 1=ใช้  barcode ราคาตามน้ำหนัก 0=ไม่ใช้
	ITEMCODEDIGIT	SMALLINT DEFAULT 0, -- จำนวนหลักสำหรับรหัส
	PRICEDIGIT	SMALLINT DEFAULT 0, -- จำนวนหลักสำหรับราคา
	CREDITSALE	SMALLINT DEFAULT 0, -- ขายเงินเชื่อ 1=ใช้ 0=ไม่ใช้
	PASSWORDCON	SMALLINT DEFAULT 0,
	MARKCON SMALLINT DEFAULT 0,
	ISRUNNING SMALLINT DEFAULT 0, -- ดูว่าใช้เลขที่กลุ่มเอกสารไง 0 ตามโปรแกรม 1 กำหนดกลุ่มเอง
	RUNNINGGROUP VARCHAR(20),
	PRNABBMODE	SMALLINT DEFAULT 0, -- 0=พิมพ์เมื่อรับเงิน, 1= ยิงแล้วพิมพ์เลย		
	CheckStocklevel SMALLINT DEFAULT 0,
	CANCELDOCONSALE  SMALLINT DEFAULT 0,
	CreditcardAmountType  SMALLINT DEFAULT 0,   --จำนวนเงินที่ส่งผ่านเครื่องรูดบัตรเครดิต  EDC
	EJournal  SMALLINT DEFAULT 0, -- สำเนาอิเล็กทรอนิก
	EdtPrcOnInputLst SMALLINT DEFAULT 0, --แก้ไขราคาที่รายการใน Inputlist
	BarCodeScaleFormat  SMALLINT DEFAULT 0, --รูปแบบของบาร์โค๊ดเครื่องชั่ง  0=จำนวน,1=มูลค่า
	PriceScaleRound SMALLINT DEFAULT 0, -- ปัดเศษราคาจากเครื่องชั่ง
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
    PRIMARY KEY(ROWORDER)
);

-- กำหนดประเภทบัตรเครดิต


CREATE TABLE BPSCREDITSERVICE
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(10) NOT NULL,
	NAME	VARCHAR(50),
	FEE VARCHAR(30)
    PRIMARY KEY(CODE)
);

-- กำหนดโปรโมชั่น POS

 -- บันทึกเปิดปิดกะ


-- หมายเหตุการคืนสินค้า


--รายการโปรโมชั่น						 แบบที่ 3
CREATE TABLE BPSPROMOTION
 (	
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CODE	VARCHAR(20) NOT NULL,
	NAME	VARCHAR(50),
	ITEMCODE	VARCHAR(25) NOT NULL,
	UNITCODE	VARCHAR(10),
	STARTDATE	DATETIME,
	STOPDATE	DATETIME,
	QTY	MONEY DEFAULT 0.0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
	 PRIMARY KEY(CODE)
 );
 ALTER TABLE BPSPROMOTION ALTER COLUMN ITEMCODE varchar(25);
 
CREATE TABLE BPSPROMOTIONSUB1
 (
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PROMOCODE	VARCHAR(20) NOT NULL,
	ITEMCODE	VARCHAR(25),
	UNITCODE	VARCHAR(10),
	QTY	MONEY DEFAULT 0.0,
	LINENUMBER	SMALLINT DEFAULT 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME	,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
  	PRIMARY KEY(ROWORDER)
 );
CREATE  INDEX IDX_BSPROMO1CODE ON BPSPROMOTIONSUB1(PROMOCODE);
CREATE  INDEX IDX_BSPROMO1ITEM ON BPSPROMOTIONSUB1(ITEMCODE);
ALTER TABLE BPSPROMOTIONSUB1 ALTER COLUMN ITEMCODE varchar(25);

CREATE TABLE BPSPROMOTIONSUB2
 (
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PROMOCODE	VARCHAR(20) NOT NULL,
	ITEMCODE	VARCHAR(25),
	UNITCODE	VARCHAR(10),	
	PROMOSTATUS	SMALLINT DEFAULT 0,--0 = รับฟรี 1 = แลกซื้อในราคาพิเศษ หน้าเค้าเตอร์ 2 = ส่วนลดพิเศษ POS
	DISCOUNTWORD	VARCHAR(35),
	QTY				MONEY DEFAULT 0.0,--จำนวนในการโปโมชั่นแบบ 2
	PROMOPRICE		MONEY DEFAULT 0.0,
	PROMOQTY		MONEY DEFAULT 0.0,
	EXCHANGEDISCOUNT	VARCHAR(25),
	LINENUMBER	SMALLINT DEFAULT 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	CONFIRMCODE	VARCHAR(10),
	CONFIRMDATETIME	DATETIME,
	CANCELCODE	VARCHAR(10),
	CANCELDATETIME	DATETIME,
	IsConfirm	SMALLINT DEFAULT 0,
	IsCancel	SMALLINT DEFAULT 0 -- 0=ยังไม่Cancel 1=Cancel
   	PRIMARY KEY(ROWORDER)	
 );
CREATE  INDEX IDX_BSPROMO2CODE ON BPSPROMOTIONSUB2(PROMOCODE);
CREATE  INDEX IDX_BSPROMO2ITEM ON BPSPROMOTIONSUB2(ITEMCODE);
ALTER TABLE BPSPROMOTIONSUB2 ALTER COLUMN ITEMCODE varchar(25);



--for BCConfigurations
update bcconfigurations set itemamountpoint=costpoint where itemamountpoint is null;
update bcconfigurations set IsStockAmounttype=0 where IsStockAmounttype is null;
update bcconfigurations set IsReturnType=0 where IsReturnType is null;
update bcconfigurations set UseAvgTax=0 where UseAvgTax is null;
--for prepare payment
update bcapinvoice set PrePayStatus=0 where PrePayStatus is null;
update bcapinvbalance set PrePayStatus=0 where PrePayStatus is null;
update bcstkrefund set PrePayStatus=0 where PrePayStatus is null;
update bcdebitnote2 set PrePayStatus=0 where PrePayStatus is null;
update bcstatement set PrePayStatus=0 where PrePayStatus is null;
update bcapotherdebt set PrePayStatus=0 where PrePayStatus is null;
update BCAPDepositSpecial set PrePayStatus=0 where PrePayStatus is null;

update bcapinvoice set PrePayAmount=0.0 where prepayamount is null;
update bcapinvbalance set PrePayAmount=0.0 where prepayamount is null;
update bcstkrefund set PrePayAmount=0.0 where prepayamount is null;
update bcdebitnote2 set PrePayAmount=0.0 where prepayamount is null;
update bcstatement set PrePayAmount=0.0 where prepayamount is null;
update bcapotherdebt set PrePayAmount=0.0 where prepayamount is null;
update BCAPDepositSpecial set PrePayAmount=0.0 where prepayamount is null;


create table BCRegion
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(50) NOT NULL,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	UserGroup VARCHAR(255)
    PRIMARY KEY(CODE)
);

create table BCProvince
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(255) NOT NULL,
	UserGroup VARCHAR(255),
	NameEng varchar(255),
	RegionCode varchar(10),
	SaleAreaCode varchar(10),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
    PRIMARY KEY(CODE)
);

create table BCTransRegister
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(255) NOT NULL,
	UserGroup VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
);

create table BCDriverCode
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	Code	VARCHAR(10) NOT NULL,
	Name	VARCHAR(255) NOT NULL,
	UserGroup VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME
	PRIMARY KEY(roworder)
);

create table BCIC2Report
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	sessionid varchar(50) not null,
	BreakCode	VARCHAR(10) NOT NULL,
	BreakName	VARCHAR(255) NOT NULL,
	ItemCode VARCHAR(25),
	ItemName1 varchar(255),
	ItemName2 varchar(255),
	UnitDesc varchar(50),
	StockQty money default 0.0,
	StockQtyWord varchar(100),
	AverageCost money default 0.0,
	Amount money default 0.0
	PRIMARY KEY(roworder)
);

create index IDX_IC2REPBRCD ON BCIC2Report(BreakCode);

create table BCIC2Report2
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	sessionid varchar(50) not null,
	BreakCode	VARCHAR(10) NOT NULL,
	BreakName	VARCHAR(255) NOT NULL,
	ItemCode VARCHAR(25),
	ItemName1 varchar(255),
	ItemName2 varchar(255),
	BeginBalQty money default 0.0,
	PurchaseQty money default 0.0,
	FGQty money default 0.0,
	IssueRetQty money default 0.0,
	SaleRetQty money default 0.0,
	AdjInQty money default 0.0,
	TransInQty money default 0.0,
	ForwardBalQty money default 0.0,
	SaleQty money default 0.0,
	IssueQty money default 0.0,
	PurchaseRetQty money default 0.0,
	AdjOutQty money default 0.0,
	TransOutQty money default 0.0,
	EndBalQty money default 0.0,
	BeginBalAmount money default 0.0,
	PurchaseAmount money default 0.0,
	FGAmount money default 0.0,
	IssueRetAmount money default 0.0,
	SaleRetAmount money default 0.0,
	AdjInAmount money default 0.0,
	TransInAmount money default 0.0,
	ForwardBalAmount money default 0.0,
	SaleAmount money default 0.0,
	IssueAmount money default 0.0,
	PurchaseRetAmount money default 0.0,
	AdjOutAmount money default 0.0,
	TransOutAmount money default 0.0,
	EndBalAmount money default 0.0,
	UnitDesc varchar(50)
	PRIMARY KEY(roworder)	
);

create index IDX_IC2SESS ON BCIC2Report2(sessionid);

create table BCIC2Report3
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	sessionid varchar(50) not null,
	LineNumber int,
	ItemCode varchar(25),
	WHCode varchar(10),
	LotNumber varchar(50),
	DocDate datetime,
	DocNo varchar(30),
	TransDesc varchar(255),
	QtyIn money default 0.0,
	CostIn money default 0.0,
	AmountIn money default 0.0,
	QtyOut money default 0.0,
	CostOut money default 0.0,
	AmountOut money default 0.0
	PRIMARY KEY(roworder)
);

create index IDX_IC2SESS3 ON BCIC2Report3(sessionid);

create table BCIC2Report4
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	sessionid varchar(50) not null,
	ItemCode varchar(25),
	ItemName varchar(255),
	UnitCode varchar(255),
	WH1 varchar(10),
	WH2 varchar(10),
	WH3 varchar(10),
	WH4 varchar(10),
	WH5 varchar(10),
	WH6 varchar(10),
	WH7 varchar(10),
	WH8 varchar(10),
	WH9 varchar(10),
	WH10 varchar(10),
	QtyWH1 money default 0.0,
	QtyWH2 money default 0.0,
	QtyWH3 money default 0.0,
	QtyWH4 money default 0.0,
	QtyWH5 money default 0.0,
	QtyWH6 money default 0.0,
	QtyWH7 money default 0.0,
	QtyWH8 money default 0.0,
	QtyWH9 money default 0.0,
	QtyWH10 money default 0.0,
	QtyTotal money default 0.0,
	CostWH1 money default 0.0,
	CostWH2 money default 0.0,
	CostWH3 money default 0.0,
	CostWH4 money default 0.0,
	CostWH5 money default 0.0,
	CostWH6 money default 0.0,
	CostWH7 money default 0.0,
	CostWH8 money default 0.0,
	CostWH9 money default 0.0,
	CostWH10 money default 0.0,
	AmountWH1 money default 0.0,
	AmountWH2 money default 0.0,
	AmountWH3 money default 0.0,
	AmountWH4 money default 0.0,
	AmountWH5 money default 0.0,
	AmountWH6 money default 0.0,
	AmountWH7 money default 0.0,
	AmountWH8 money default 0.0,
	AmountWH9 money default 0.0,
	AmountWH10 money default 0.0,
	AmountTotal money default 0.0
	PRIMARY KEY(roworder)
);

create index IDX_IC2SESS4 ON BCIC2Report4(sessionid);

create table BCCancelBill -- ยกเลิกใบเสนอซื้อ, อนุมัติเสนอซื้อ, เสนอราคา
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	isexport smallint default 0,    
	isconfirm smallint default 0,
	DocNo VARCHAR(30) NOT NULL,--Document Number
	CancelType	SMALLINT DEFAULT 0, -- 0= Cancel PR , 1 = Cancel Approved PR, 2 = Cancel Quotation
	DocDate DATETIME NOT NULL, --Document Date
	DepartCode VARCHAR(10),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	RequestUID VARCHAR(10), --Requset to void
	ApproveUID VARCHAR(10), --Approve user 
	TotalAmount	money default 0.0,--summary of detail amount
	VoidReasonCode varchar(10),--void reason code
	Remark VARCHAR(255),       --Transaction comment
	CreatorCode	VARCHAR(10),--create user
	CreateDateTime	DATETIME,   --date time to create this document
	LastEditorCode	VARCHAR(10),--Last edit user  
	LastEditDateT	DATETIME,   --Last edit date time
	ConfirmCode	VARCHAR(10),--Confirm user
	ConfirmDateTime	DATETIME,   --confirm date time
	CancelCode	VARCHAR(10),--Cancel user
	CancelDateTime	DATETIME,   --Cancel date time
	IsCancel smallint default 0,
	IsProcessOK SMALLINT DEFAULT 0,
	IsCompleteSave	SMALLINT DEFAULT 0
	PRIMARY KEY(DocNo,CancelType)
);

CREATE  INDEX IDX_CANCELBILL1 on BCCancelBill(DocDate);
CREATE  INDEX IDX_CANCELBILL2 on BCCancelBill(DocNo,DocDate);
CREATE  INDEX IDX_CANCELBILL3 on BCCancelBill(ROWORDER);

create table BCCancelBillSub
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	CancelType	SMALLINT DEFAULT 0, -- 0= Cancel PR , 1 = Cancel Approved PR, 2 = Cancel Quotation
	DocNo VARCHAR(30) NOT NULL,   --Document Number
	DocDate DATETIME NOT NULL, --Document Date
	ParentCode VARCHAR(20),           --AP OR AR code
	RefNo VARCHAR(30) NOT NULL,   --Ref Number to void
	ItemCode VARCHAR(35) NOT NULL,      --Product code
	MyDescription	VARCHAR(255),       --Product comment	
	Price MONEY DEFAULT 0.0,            --Unit price
	UnitCode VARCHAR(10) NOT NULL,  --Unit code
	Qty MONEY DEFAULT 0.0,            --Bill Qty
	RemainQty MONEY DEFAULT 0.0,            --Bill RemainQty
	VoidQty MONEY DEFAULT 0.0,          --Void Qty
	RefDate DATETIME,
	Amount MONEY DEFAULT 0.0,
	VoidAmount MONEY DEFAULT 0.0,
	RemainAmount MONEY DEFAULT 0.0,            --Bill Remain Amount
	DepartCode VARCHAR(10),
	AllocateCode	VARCHAR(10),
	ProjectCode	VARCHAR(10),
	CategoryCode	VARCHAR(10),
	GroupCode	VARCHAR(10),
	BrandCode	VARCHAR(10),
	TypeCode	VARCHAR(10),
	FormatCode	VARCHAR(10),	
	Approved	SMALLINT DEFAULT 0,
	IsCancel SMALLINT DEFAULT 0,        --Cancel status 1=Cancel 
	TransState 	SMALLINT DEFAULT 0, --0 = new transaction 1 = old transaction 
	LineNumber	SMALLINT DEFAULT 0, --Line of list
	RefLineNumber SMALLINT DEFAULT 0,   --PO line number from PO referance doc.
	BehindIndex	SMALLINT DEFAULT 1,
	PackingRate1 	SMALLMONEY DEFAULT 0.0,
	PackingRate2 	SMALLMONEY DEFAULT 0.0,
	stkrequestno	varchar(30)
	PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_CANCELBILL_SUB01 on BCCancelBillSub (DocDate);
CREATE  INDEX IDX_CANCELBILL_SUB02 on BCCancelBillSub (ParentCode);
CREATE  INDEX IDX_CANCELBILL_SUB03  on BCCancelBillSub (RefNo);
CREATE  INDEX IDX_CANCELBILL_SUB04 on BCCancelBillSub (ItemCode);
CREATE  INDEX IDX_CANCELBILL_SUB05 on BCCancelBillSub (ItemCode,LineNumber);
CREATE  INDEX IDX_CANCELBILL_SUB06 on BCCancelBillSub (DocDate,DocNo);
CREATE  INDEX IDX_CANCELBILL_SUB07 on BCCancelBillSub (ParentCode,DocNo);
CREATE  INDEX IDX_CANCELBILL_SUB08 ON BCCancelBillSub(PackingRate1);
CREATE  INDEX IDX_CANCELBILL_SUB09 ON BCCancelBillSub(PackingRate2);

create table BCGLFSStoreValue
(	
	Code	varchar(25) not null,
	Name	varchar(50),
	Value	money	default 0.0
	PRIMARY KEY(Code)
);

--for allocate expense by aom 09-06-2006
create table BCExpFormula
(
	roworder int not null identity(0,1),
	chartofaccount varchar(20),
	departcode varchar(10),
	projectcode varchar(10),
	personqty smallint default 0,
	percent1 money default 0.0,
	code varchar(10),
	docdate datetime
	primary key(roworder)
);

create table BCExpFormulaHD
(
	roworder int not null identity(0,1),
	code varchar(10) not null,
	chartofaccount varchar(20),
	departcode varchar(10),
	ChartName varchar(200),
	docdate datetime
	primary key(code)
);

create table BCExpProject
(
	roworder int not null identity(0,1),
	code varchar(10),
	name varchar(50),
	StartDate datetime,
	FinishDate datetime,
	PersonQty money default 0.0
	primary key(roworder)
);

CREATE TABLE BCTransSub_exp
(	
	ROWORDER 	INT NOT NULL IDENTITY(0,1),		
	BatchNo	VARCHAR(20),
	LineNumber 	SMALLINT DEFAULT 0,
	BookCode	VARCHAR(15) NOT NULL,
	DocDate	 	DATETIME NOT NULL,
	DocNo 		VARCHAR(20) NOT NULL,
	AccountCode 	VARCHAR(20) NOT NULL,
	ExtDescription 	VARCHAR(255),
	DepartCode		VARCHAR(10),
	ProjectCode 	VARCHAR(10),
	AllocateCode 	VARCHAR(10),
	PartCode	VARCHAR(10),
	SideCode	VARCHAR(10),
	JobCode 		VARCHAR(20),
	BranchCode 	VARCHAR(15),
	Debit 		MONEY DEFAULT 0.0,
	Credit 		MONEY DEFAULT 0.0,
	FDebit 		MONEY  DEFAULT 0.0,
	FCredit 		MONEY  DEFAULT 0.0,
	Source		 SMALLINT DEFAULT 0,
	IsManualKey	SMALLINT DEFAULT 0, -- 0 = Post 1= manual key
	IsCancel SMALLINT DEFAULT 0,
	IsConfirm	SMALLINT DEFAULT 0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME	
	PRIMARY KEY (ROWORDER)
);

create table BCChqOutAuto
(
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	DocNo	varchar(30) NOT NULL,
	DocDate datetime,
	BankCode varchar(10),
	BankBranchCode varchar(10),
	BookNo varchar(30),
	MyDescription varchar(255),
	ChqNoStart varchar(20),
	ChqRun smallint default 1,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME
	PRIMARY KEY(DocNo)
);

create table BCChqOutAutoSub
(
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	DocNo	varchar(30) NOT NULL,
	DocDate datetime,
	BankCode varchar(10),
	BankBranchCode varchar(10),
	BookNo varchar(30),
	MyDescription varchar(255),
	ChqNumber varchar(20),
	IsUse smallint default 0
	PRIMARY KEY(ROWORDER)
);

create table BCItemSetTrans
(
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	DocNo	varchar(30) NOT NULL,
	BillType smallint default 0,--0=Build 1=Part
	IssueDocNo varchar(30) NOT NULL,
	FGDocNo varchar(30) NOT NULL,
	DocDate datetime,
	ItemSetCode varchar(25),
	SetQty money default 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME
	PRIMARY KEY(DocNo)
);

create table BCItemSetTransSub
(
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	DocNo	varchar(30) NOT NULL,
	BillType smallint default 0,--0=Build 1=Part
	IssueDocNo varchar(30) NOT NULL,
	FGDocNo varchar(30) NOT NULL,
	DocDate datetime,
	ItemSetCode varchar(25),
	ItemCode varchar(25),
	UnitCode varchar(10),
	Qty money default 0.0,
	ItemSetCost money default 0.0,	
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME
	PRIMARY KEY(DocNo)
);

---- Maetongsuk Project ----
create table BCPriceFactor
(
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	ItemCode	varchar(25),
	UnitCode	varchar(10),
	Factor		money default 0.0,
	Multiplier	money default 0.0
	PRIMARY KEY(ROWORDER)
);

DROP TABLE BCGLSource;
create table BCGLSource
(
	ROWORDER	INT NOT NULL IDENTITY(0,1),
	GLTable	 VARCHAR(255),
	MyDescription	VARCHAR(255),
	GLSource smallint default 0,
	PRIMARY KEY(glsource)
);

Create table bcrole
(
	roworder Integer Identity(0,1) NOT NULL,
	code varchar(30) not null,
	name varchar(255) not null --role name
	primary key(code)
);


Create table bcuser
(
	roworder Integer Identity(0,1) NOT NULL,
	code VARCHAR(30) NOT NULL,
	Name Varchar(255) NOT NULL,
	RoleCode varchar(30) not null
	Primary Key (code)
) ;

Create table bcrolepermission
(
	roworder Integer Identity(0,1) NOT NULL,
	code VARCHAR(30) NOT NULL,
	menuid Money NOT NULL,
	programstring Varchar(30) NOT NULL,
	ismake Smallint NULL,
	isdelete Smallint NULL,
	isinsert Smallint NULL,
	isedit Smallint NULL,
	Primary Key (code,menuid,programstring)
) ;


Create table bcrolepermission2
(
	roworder Integer Identity(0,1) NOT NULL,
	code VARCHAR(30) NOT NULL,
	configID Varchar(30) NOT NULL,
	programstring Varchar(30) NOT NULL,
	configValue Varchar(50) NULL,
	Primary Key (code,configID,programstring)
) ;


Create table bcuserpermission
(
	roworder Integer Identity(0,1) NOT NULL,
	code VARCHAR(30) NOT NULL,
	menuid Money NOT NULL,
	programstring Varchar(30) NOT NULL,
	ismake Smallint NULL,
	isdelete Smallint NULL,
	isinsert Smallint NULL,
	isedit Smallint NULL,
	Primary Key (code,menuid,programstring)
) ;


Create table bcuserpermission2
(
	roworder Integer Identity(0,1) NOT NULL,
	code VARCHAR(30) NOT NULL,
	configID Varchar(30) NOT NULL,
	programstring Varchar(30) NOT NULL,
	configValue Varchar(50) NULL,
	Primary Key (code,configID,programstring)
) ;



CREATE TABLE bcextarinformation
(
	ROWORDER int IDENTITY(0,1) NOT NULL,
	ArCode varchar(20) NOT NULL,
	Career varchar(255),
	WorH_Name varchar(255),
	WorH_BitrhDay datetime NULL,
	WorH_Career varchar(255),
	Nationality varchar(255),
	Father_Name varchar(255),
	Mother_Name varchar(255),
	GrandFather_Name varchar(255),
	GrandMother_Name varchar(255),
	Acquisition varchar(255),
	Book_Number varchar(255),
	RightOwner varchar(255),
	Page_Number varchar(255),
	Sequence_Number smallint NULL DEFAULT 0,
	Sheet_Number varchar(255),
	Other_Description varchar(255),
	Paragraph_Number varchar(255),
	Primary key(arcode)
);

create table bcprintlog
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	PrintType smallint default 0,--0=preview 1=print
	DocNo	VARCHAR(20)  NOT NULL,
	TableName Varchar(30) not null,
	UserID	Varchar(30) not null,
	FormName varchar(255),
	Printdate datetime default getdate()
	primary key(roworder)	
);

create index bcprintlog_idx1 on bcprintlog(docno);
create index bcprintlog_idx2 on bcprintlog(UserID);

create table BCPromotionValue
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	FocItemCode	VARCHAR(25),
	FocUnitCode VARCHAR(10),
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FromAmount	MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ToAmount	MONEY DEFAULT 0.0,
	FromDate	DATETIME,
	ToDate	DATETIME,
	FromARGroup	VARCHAR(10),
	ToARGroup	VARCHAR(10),
	FOCQty	MONEY DEFAULT 0.0,
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PROVALFOC ON BCPromotionValue(FOCItemCode);
CREATE  INDEX IDX_PROVALFAMT ON BCPromotionValue(FromAmount);
CREATE  INDEX IDX_PROVALTAMT ON BCPromotionValue(ToAmount);
CREATE  INDEX IDX_PROVALFDATE ON BCPromotionValue(FromDate);
CREATE  INDEX IDX_PROVALTDATE ON BCPromotionValue(ToDate);
CREATE  INDEX IDX_PROVALFOCUNIT ON BCPromotionValue(FOCUnitCode);
CREATE  INDEX IDX_PROVALFARG ON BCPromotionValue(FromARGroup);
CREATE  INDEX IDX_PROVALTARG ON BCPromotionValue(ToARGroup);

create table BCPromotionValue_Log
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	FocItemCode	VARCHAR(25),
	FocUnitCode VARCHAR(10),
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FromAmount	MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ToAmount	MONEY DEFAULT 0.0,
	FromDate	DATETIME,
	ToDate	DATETIME,
	FromARGroup	VARCHAR(10),
	ToARGroup	VARCHAR(10),
	FOCQty	MONEY DEFAULT 0.0,
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PROVALLOGFOC ON BCPromotionValue_Log(FOCItemCode);
CREATE  INDEX IDX_PROVALLOGFAMT ON BCPromotionValue_Log(FromAmount);
CREATE  INDEX IDX_PROVALLOGTAMT ON BCPromotionValue_Log(ToAmount);
CREATE  INDEX IDX_PROVALLOGDATE ON BCPromotionValue_Log(FromDate);
CREATE  INDEX IDX_PROVALLOGTDATE ON BCPromotionValue_Log(ToDate);
CREATE  INDEX IDX_PROVALLOGFOCUNIT ON BCPromotionValue_Log(FOCUnitCode);
CREATE  INDEX IDX_PROVALLOGFARG ON BCPromotionValue_Log(FromARGroup);
CREATE  INDEX IDX_PROVALLOGTARG ON BCPromotionValue_Log(ToARGroup);

create table BCPriceList_Log
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	UnitCode VARCHAR(10),
	Remark	VARCHAR(255),
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FromQty	MONEY DEFAULT 0.0,
	ToQty	MONEY DEFAULT 0.0,
	StartDate DATETIME, -- จากวันที่
	StopDate DATETIME, -- ถึงวันที่
	SaleType SMALLINT DEFAULT 0, -- ประเภทการขาย
	TransportType SMALLINT DEFAULT 0, -- เงื่อนการขนส่ง
	SalePrice1	MONEY DEFAULT 0.0,
	SalePrice2	MONEY DEFAULT 0.0,
	SalePrice3	MONEY DEFAULT 0.0,
	SalePrice4	MONEY DEFAULT 0.0,
	SalePrice5	MONEY DEFAULT 0.0,
	SalePrice6	MONEY DEFAULT 0.0,
	SalePrice7	MONEY DEFAULT 0.0,
	SalePrice8	MONEY DEFAULT 0.0,
	SalePrice9	MONEY DEFAULT 0.0,
	SalePrice10	MONEY DEFAULT 0.0,
	SalePrice11	MONEY DEFAULT 0.0,
	SalePrice12	MONEY DEFAULT 0.0,
	SalePrice13	MONEY DEFAULT 0.0,
	SalePrice14	MONEY DEFAULT 0.0,
	SalePrice15	MONEY DEFAULT 0.0,
	SalePrice16	MONEY DEFAULT 0.0,
	SalePrice17	MONEY DEFAULT 0.0,
	SalePrice18	MONEY DEFAULT 0.0,
	SalePrice19	MONEY DEFAULT 0.0,
	SalePrice20	MONEY DEFAULT 0.0,
	LowPrice	MONEY DEFAULT 0.0, --- Jeab 04/11/2002 --- ราคาขายขั้นต่ำ ---
	LineNumber SMALLINT DEFAULT 0,
	RetailPrice	MONEY DEFAULT 0.0, -- ราคาขายปลีก
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);

CREATE  INDEX IDX_PRLLOGITEM ON BCPriceList_Log(ItemCode);
CREATE  INDEX IDX_PRLLOGFQTY ON BCPriceList_Log(FromQty);
CREATE  INDEX IDX_PRLLOGTQTY ON BCPriceList_Log(ToQty);
CREATE  INDEX IDX_PRLLOGUNIT ON BCPriceList_Log(UnitCode);
CREATE  INDEX IDX_PRLLOG1    ON BCPriceList_Log(ItemCode,UnitCode);

create table BCPromoPrice_Log
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	ItemCode	VARCHAR(25),
	UnitCode VARCHAR(10),
	TaxType	SMALLINT DEFAULT 0, -- 0=แยกนอก 1=รวมใน
	FromQty	MONEY DEFAULT 0.0,
	IsExport smallint default 0,
	CreatorCode VARCHAR(10),
	CreateDateTime DATETIME,
	LastEditorCode VARCHAR(10),
	LastEditDateT DATETIME,
	ToQty	MONEY DEFAULT 0.0,
	SalePrice	MONEY DEFAULT 0.0,
	DiscountWord	VARCHAR(35),
	FromDate	DATETIME,
	ToDate	DATETIME,
	FromARGroup	VARCHAR(10),
	ToARGroup	VARCHAR(10),
	ChangeDate datetime,
	UserId varchar(10),
	ChangeDateTime datetime
    PRIMARY KEY(ROWORDER)
);
CREATE  INDEX IDX_PROMOLOGUNIT ON BCPromoPrice_Log(ItemCode,UnitCode);
CREATE  INDEX IDX_PROMOLOGITEM ON BCPromoPrice_Log(ItemCode);
CREATE  INDEX IDX_PROMOLOGFQTY ON BCPromoPrice_Log(FromQty);
CREATE  INDEX IDX_PROMOLOGTQTY ON BCPromoPrice_Log(ToQty);
CREATE  INDEX IDX_PROMOLOGFDATE ON BCPromoPrice_Log(FromDate);
CREATE  INDEX IDX_PROMOLOGTDATE ON BCPromoPrice_Log(ToDate);
CREATE  INDEX IDX_PROMOLOGUNIT2 ON BCPromoPrice_Log(UnitCode);
CREATE  INDEX IDX_PROMOLOGFARG ON BCPromoPrice_Log(FromARGroup);
CREATE  INDEX IDX_PROMOLOGTARG ON BCPromoPrice_Log(ToARGroup);

INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCArInvoice','บันทึกขายหน้าร้าน (POS)',-1);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCTrans','สินทรัพย์ (โอนข้อมูลเข้าสู่ GL)',-2);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCTrans','บันทึกข้อมูลรายวัน (GL)',0);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCAPDeposit','จ่ายเงินมัดจำ (เจ้าหนี้)',1);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCAPInvoice','ซื้อสินค้า,บริการ-รับสินค้า-ตั้งหนี้(เจ้าหนี้)',2);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCStkRefund','ลดหนี้/ส่งคืนสินค้า (เจ้าหนี้)',3);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCDebitNote2','เพิ่มหนี้ (เจ้าหนี้)',4);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCARDeposit','รับเงินมัดจำ (ลูกหนี้)',5);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCARInvoice','ขายสินค้า,บริการ',6);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCCreditNote','ลดหนี้/รับคืนสินค้า (ลูกหนี้)',7);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCDebitNote1','เพิ่มหนี้ (ลูกหนี้)',8);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCPayment','จ่ายชำระหนี้ (เจ้าหนี้)',9);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCReceipt1','รับชำระหนี้ (ลูกหนี้)',10);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqInPass','บันทึกเช็ครับผ่าน',11);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqOutPass','บันทึกเช็คจ่ายผ่าน',12);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCCreditPass','บันทึกขึ้นเงินบัตรเครดิต',13);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCCashBankIn','บันทึกนำฝากเงินสด',14);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCCashBankOut','บันทึกถอนเงินสด',15);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCBankExpense','บันทึกค่าใช้จ่ายธนาคาร',16);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCBankIncome','บันทึกรายได้จากธนาคาร ',17);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCBankTransfer','บันทึกโอนเงินระหว่างธนาคาร',18);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCOtherIncome','บันทึกรายได้อื่นๆ',19);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCOtherExpense','บันทึกค่าใช้จ่ายอื่นๆ',20);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCStkIssue','บันทึกใบเบิกสินค้า',21);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCStkIssueRet','บันทึกรับคืนเบิก',22);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCFinishGoods','บันทึกรับสินค้าสำเร็จรูป',23);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqInReturn','บันทึกเช็ครับคืน',24);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqInCancel','บันทึกยกเลิกเช็ครับ',25);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqOutCancel','บันทึกยกเลิกเช็คจ่าย',27);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCCreditCancel','บันทึกยกเลิกบัตรเครดิต',28);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqInSale','บันทึกขายลดเช็ครับ',29);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCAROtherDebt','บันทึกตั้งลูกหนี้อื่นๆ',30);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCApOtherDebt','บันทึกตั้งเจ้าหนี้อื่นๆ',31);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCChqInDeposit2','บันทึกนำเช็คเข้าใหม่',32);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCStkAdjust','ปรับปรุงสินค้าหลังตรวจนับ',34);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCReceipt3','บันทึกตัดหนี้สูญ(ลูกหนี้)',35);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCPayment2','บันทึกตัดหนี้สูญ(เจ้าหนี้)',36);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCOtherExpense2','บันทึกขอเบิกเงินทดรองจ่าย',37);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCARDepositSpecial','บันทึกรับเงินล่วงหน้า (ลูกหนี้)',38);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCReturnDepSpecial','บันทึกคืนเงินรับล่วงหน้า (ลูกหนี้)',39);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCStdRevalueSub','ปรับปรุงมูลค่าสินค้าต้นทุนมาตรฐาน',41);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCAPDepositSpecial','บันทึกจ่ายเงินล่วงหน้า (เจ้าหนี้)',42);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCAPReturnDepSpecial','บันทึกรับคืนเงินล่วงหน้า (เจ้าหนี้)',43);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCArInvoice','บันทึกขายสินค้าเงินเชื่อ(IOU)-Green Spot',51);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcpaymenttemp','เตรียมจ่ายชำระ',52);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCAdjustExchageRate','ปรับอัตราแลกเปลี่ยนสิ้นปี',55);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('BCReceiptMultiAr','รับชำระหนี้ (หลายลูกหนี้)',56);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcsaleorder','รับเงินล่วงหน้า (BMS)',57);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','ขายห้าง (BMS)',58); --salechannel = 2,4
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','ขนเอเยนต์ (BMS)',59);--salechannel = 1
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','รถเร่ (BMS)',60);--salechannel = 3
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice1','รถปลีก (BMS)',61);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcbmscalccost','คำนวนต้นทุนขาย (BMS)',62);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcsovoid','ยกเลิกรับล่วงหน้า ',63);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','ขายคูปอง',64);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','ขายสินค้าสด,เชื่อ(สมาชิก)',65);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','คูปองแลกน้ำ',66);
INSERT INTO BCGLSource(GLTable,MyDescription,GLSource) VALUES('bcarinvoice','รับคืนคูปอง',67);



UPDATE BCARInvBalance SET IsCancel = 0 WHERE IsCancel IS NULL OR IsCancel = '';
UPDATE BCAPInvBalance SET IsCancel = 0 WHERE IsCancel IS NULL OR IsCancel = '';
UPDATE BCItem SET IsChangeQty = 0 WHERE IsChangeQty IS NULL OR IsChangeQty = '';
UPDATE BCITEMComponents SET TempQty = 0.0 WHERE TempQty IS NULL;
UPDATE BCSaleOrderSub SET RefLineNumber = (select top 1 LineNumber from BCQuotationSub where DocNo = BCSaleOrderSub.StkReserveNo and ItemCode = BCSaleOrderSub.ItemCode) 
WHERE RefLineNumber IS NULL OR RefLineNumber = '';
UPDATE BCChqIn SET RefChqRowOrder = RowOrder WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqOut SET RefChqRowOrder = RowOrder WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqInDeposSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqIn where ArCode = BCChqInDeposSub.ArCode and BankCode = BCChqInDeposSub.BankCode 
and BankBranchCode = BCChqInDeposSub.BankBranchCode and ChqNumber = BCChqInDeposSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqInDepo2Sub SET RefChqRowOrder = (select RefChqRowOrder from BCChqIn where ArCode = BCChqInDepo2Sub.ArCode and BankCode = BCChqInDepo2Sub.BankCode 
and BankBranchCode = BCChqInDepo2Sub.BankBranchCode and ChqNumber = BCChqInDepo2Sub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqInPassSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqIn where ArCode = BCChqInPassSub.ArCode and BankCode = BCChqInPassSub.BankCode 
and BankBranchCode = BCChqInPassSub.BankBranchCode and ChqNumber = BCChqInPassSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqInCancelSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqIn where ArCode = BCChqInCancelSub.ArCode and BankCode = BCChqInCancelSub.BankCode 
and BankBranchCode = BCChqInCancelSub.BankBranchCode and ChqNumber = BCChqInCancelSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqInRetSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqIn where ArCode = BCChqInRetSub.ArCode and BankCode = BCChqInRetSub.BankCode 
and BankBranchCode = BCChqInRetSub.BankBranchCode and ChqNumber = BCChqInRetSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqInSaleSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqIn where ArCode = BCChqInSaleSub.ArCode and BankCode = BCChqInSaleSub.BankCode 
and BankBranchCode = BCChqInSaleSub.BankBranchCode and ChqNumber = BCChqInSaleSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqOutPassSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqOut where ApCode = BCChqOutPassSub.ApCode and BankCode = BCChqOutPassSub.BankCode 
and BankBranchCode = BCChqOutPassSub.BankBranchCode and ChqNumber = BCChqOutPassSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';
UPDATE BCChqOutCancelSub SET RefChqRowOrder = (select RefChqRowOrder from BCChqOut where ApCode = BCChqOutCancelSub.ApCode and BankCode = BCChqOutCancelSub.BankCode 
and BankBranchCode = BCChqOutCancelSub.BankBranchCode and ChqNumber = BCChqOutCancelSub.ChqNumber) WHERE RefChqRowOrder IS NULL OR RefChqRowOrder = '';