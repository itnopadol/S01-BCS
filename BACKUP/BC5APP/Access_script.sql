--dbversion=185
--progstring=bc5acc
--
--
--	bc account verion 5.0 jet 4.0 script
--
--	ban chiang soft .,ltd
--	create time : 4/21/2003 14:03:54
-----------------------------------------------------------

create table bcautoprochistory
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	mytype smallint,
	status smallint,
	itemcode varchar(25)
	,primary key(roworder)
);

default on bcautoprochistory
(
	mytype smallint 0,
	status smallint 0,
);


create table bcautoprochist2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	status smallint,
	persontype smallint,
	personcode varchar(20)
	,primary key(roworder)
);

default on bcautoprochist2
(
	status smallint 0,
	persontype smallint 0,
);


create table bcdevreportlist
(
	
	roworder autoincrement not null, 
	reportname varchar(50) not null,
	reportfile varchar(50)
	,primary key(reportname)
);
create table bcuserlogbook
(
	
	roworder autoincrement not null, 
	workmode smallint,
	worktype smallint,
	menuid double ,
	workdate datetime not null,
	computername varchar(50),
	docdate datetime ,
	docno varchar(20),
	userid varchar(20),
	shortword varchar(50),
	detailcount smallint,
	primary key(roworder)
);

default on bcuserlogbook
(
	workmode smallint 0,
	worktype smallint 0,
	menuid double  0.0,
	detailcount smallint 0,
);


create table bcbuypricecondit
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	refno varchar(20),
	docdate datetime not null,
	mydescription varchar(255),
	billstatus smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime
	,primary key(docno)
);

default on bcbuypricecondit
(
	billstatus smallint 0,
);


create table bcbypricecondsub
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	mydescription varchar(255),
	departcode varchar(10),
	stkrequestno varchar(20),
	selectap smallint,
	itemcode varchar(25),
	unitcode varchar(10),
	apcode varchar(20),
	createpoflag smallint,
	qty currency ,
	buyqty currency ,
	buyprice currency ,
	discountword varchar(30),
	creditday smallint,
	trasportday smallint,
	iscancel smallint,
	transportcondit varchar(100)
	,primary key(roworder)
);

default on bcbypricecondsub
(
	selectap smallint 0,
	createpoflag smallint 0,
	qty currency  0.0,
	buyqty currency  0.0,
	buyprice currency  0.0,
	creditday smallint 0,
	trasportday smallint 0,
	iscancel smallint 0,
);


create table bcsystrformat
(
	
	roworder autoincrement not null, 
	transkey varchar(100) not null,
	maintable varchar(20),
	jointable varchar(200),
	filterby varchar(100),
	sortby varchar(100),
	transtitle varchar(100),
	findrect varchar(50),
	docformat varchar(50),
	slipfomname varchar(50),
	wtaxfomname varchar(50),
	searchstyle smallint,
	displaystyle smallint,
	issearchfirst smallint,
	printfrmintext smallint,
	primary key(transkey)
);

default on bcsystrformat
(
	searchstyle smallint 0,
	displaystyle smallint 0,
	issearchfirst smallint 0,
	printfrmintext smallint 0,
);


create table bcsystrfind
(
	
	roworder autoincrement not null, 
	transkey varchar(100) not null,
	fieldname varchar(50),
	coltext varchar(50),
	sortby varchar(50),
	colwidth smallint,
	colalign smallint,
	colcolor currency ,
	linenumber smallint,
	primary key(roworder)
);

default on bcsystrfind
(
	colwidth smallint 0,
	colalign smallint 0,
	colcolor currency  0,
	linenumber smallint 0,
);


create index idx_trfsys_tk on bcsystrfind(transkey);
create table bcsystrfom
(
	
	roworder autoincrement not null, 
	transkey varchar(100) not null,
	formfilename varchar(100)
	,primary key(roworder)
);
create index idx_trfosys_tk on bcsystrfom(transkey);
create table bcsystrdocg
(
	
	roworder autoincrement not null, 
	transkey varchar(100) not null,
	goupcode varchar(10) not null,
	goupdesc varchar(50),
	linenumber smallint,
	primary key(transkey,goupcode)
);

default on bcsystrdocg
(
	linenumber smallint 0,
);


create table bcroute
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcitemcategory
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcmap
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	filename varchar(100)
	,primary key(code)
);
create table bcargroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcardebtgroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	paymentby varchar(20) not null,
	name varchar(50) not null
	,primary key(code)
);
create index idx_adbpay on bcardebtgroup(paymentby);
create table bctransport
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcconditpay
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50)
	,primary key(code)
);
create table bcconditpaysub
(
	
	roworder autoincrement not null, 
	mastercode varchar(10) not null,
	linenumber smallint,
	remark varchar(100),
	start smallint ,
	stop smallint ,
	condition varchar(50),
	priority smallint,
	primary key(roworder)
);

default on bcconditpaysub
(
	linenumber smallint 0,
	priority smallint 1,
);


create table bcallocate
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcapbankbook
(
	
	roworder autoincrement not null, 
	apcode varchar(20) not null,
	bookno varchar(30) not null,
	name varchar(50),
	bankcode varchar(50),
	branchcode varchar(10)
	,primary key(roworder)
);
create table bcitembrand
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcapgroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcaptype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bccusttype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcdepartment
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcgeneric
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcitemgroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcissuetype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcitemformat
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcitemtype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcshelf
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	whcode varchar(10)
	,primary key(code)
);
create table bcwarehouse
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	mappicfilename varchar(100)
	,primary key(code)
);
create table bcsalearea
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcproject
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcsale
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	address varchar(255),
	telephone varchar(30),
	picturefilename varchar(50),
	userpassword varchar(20),
	userid varchar(40),
	emailaddress varchar(100),
	poapprove smallint,
	quoapprove smallint,
	soapprove smallint,
	informprice smallint,
	activestatus smallint,
	departcode varchar(10),
	approvecredit smallint,
	usergroup varchar(10)
	,primary key(code)
);

default on bcsale
(
	poapprove smallint 0,
	quoapprove smallint 0,
	soapprove smallint 0,
	informprice smallint 0,
	activestatus smallint 1,
	approvecredit smallint 0,
);


create table bcitemunit
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50),
	wavefile varchar(50)
	,primary key(code)
);
create table bcconfigurations
(
	companyname varchar(255) not null,
	companynameeng varchar(255),
	managername varchar(100),
	managernameeng varchar(100),
	address varchar(255),
	addresseng varchar(255),
	telephone varchar(100),
	fax varchar(100),
	deficitstatus smallint,
	yeartype smallint,
	taxnumber varchar(30),
	defaulttaxtype smallint,
	defaulttaxrate currency ,
	debtoverwarning smallint,
	sodebtwarning smallint,
	billdebtwarning smallint,
	stockstatus smallint,
	pricewarning smallint,
	pricecostratio varchar(30),
	itemsetstatus smallint,
	beginqty currency ,
	qtypoint smallint,
	costpoint smallint,
	pricepoint smallint,
	amountpoint smallint,
	stockremain smallint,
	detaildiscount smallint,
	billdiscount smallint,
	multicurrency smallint,
	discpromotion smallint,
	pricepromotion smallint,
	postglstatus smallint,
	glbalancecheck smallint,
	billconfirm smallint,
	defaultitemname smallint,
	defaultarname smallint,
	defaultapname smallint,
	defaultaccname smallint,
	excepttax smallint,
	zerotaxrate smallint,
	uselotstatus smallint,
	lotstatus smallint,
	serviceitem smallint,
	specialitem smallint,
	serialitem smallint,
	useexpcost smallint,
	discountmethod smallint,
	billdetaildesc smallint,
	buyitemsupplier smallint,
	oppositeunit smallint,
	chqcondition varchar(50),
	paybillremark varchar(50),
	invoiceonstart smallint,
	chqonstart smallint,
	stocklowonstart smallint,
	stkdeficitwarn smallint,
	stkremainout smallint,
	stkremainin smallint,
	logbookuse smallint,
	consignment smallint,
	printslip smallint,
	printbill smallint,
	autobilldocgroup smallint,
	defitembilltype smallint,
	defbuybilltype smallint,
	displaypicture smallint,
	currencysymbol smallint,
	hcurrencysymbol varchar(2),
	hcurrencycode varchar(10),
	cashbalance currency ,
	paybillduplicate smallint,
	departseparate smallint,
	projectseparate smallint,
	allocateseparate smallint,
	jobseparate smallint,
	partseparate smallint,
	sideseparate smallint,
	isexdescription smallint,
	branchseparate smallint,
	inventorymethod smallint,
	excessstatus smallint,
	otherincome smallint,
	sonoaddnew smallint,
	sonoeditqty smallint,
	sonoeditprice smallint,
	sonoeditdiscount smallint,
	billnoaddnew smallint,
	billnoeditqty smallint,
	billnoeditprice smallint,
	billnoeditdiscount smallint,
	buynoaddnew smallint,
	buynoeditqty smallint,
	buynoeditprice smallint,
	buynoeditdiscount smallint,
	grnoaddnew smallint,
	grnoeditqty smallint,
	grnoeditprice smallint,
	autopostgl smallint,
	autoserverproc smallint,
	posrepseparate smallint,
	isboxduplicate smallint,
	isjob smallint,
	creditlimitflag smallint,
	serialitemperline smallint,
	printserialinvoice smallint,
	isedititemname smallint,
	fscursum1 currency ,
	fscursum2 currency ,
	fscursum3 currency ,
	fscursum4 currency ,
	daycallcust smallint,
	isprintsumpage smallint,
	isprintcancel smallint,
	isusewarehouse smallint,
	mailsmtp varchar(255),
	mailpop3 varchar(255),
	mailfrom varchar(255),
	isreceivemoney smallint,
	issetworkdate smallint,
	isusergroup smallint,
	formdatestyle smallint,
	formnumericstyle smallint,
	primary key(companyname)
);

default on bcconfigurations
(
	deficitstatus smallint 1,
	yeartype smallint 0,
	defaulttaxtype smallint 0,
	defaulttaxrate currency  7.0,
	debtoverwarning smallint 0,
	sodebtwarning smallint 0,
	billdebtwarning smallint 0,
	stockstatus smallint 0,
	pricewarning smallint 0,
	itemsetstatus smallint 0,
	beginqty currency  0.0,
	qtypoint smallint 2,
	costpoint smallint 4,
	pricepoint smallint 2,
	amountpoint smallint 2,
	stockremain smallint 0,
	detaildiscount smallint 0,
	billdiscount smallint 0,
	multicurrency smallint 0,
	discpromotion smallint 0,
	pricepromotion smallint 0,
	postglstatus smallint 0,
	glbalancecheck smallint 0,
	billconfirm smallint 0,
	defaultitemname smallint 0,
	defaultarname smallint 0,
	defaultapname smallint 0,
	defaultaccname smallint 0,
	excepttax smallint 0,
	zerotaxrate smallint 0,
	uselotstatus smallint 0,
	lotstatus smallint 0,
	serviceitem smallint 0,
	specialitem smallint 0,
	serialitem smallint 0,
	useexpcost smallint 0,
	discountmethod smallint 0,
	billdetaildesc smallint 0,
	buyitemsupplier smallint 0,
	oppositeunit smallint 0,
	invoiceonstart smallint 0,
	chqonstart smallint 0,
	stocklowonstart smallint 0,
	stkdeficitwarn smallint 0,
	stkremainout smallint 0,
	stkremainin smallint 0,
	logbookuse smallint 0,
	consignment smallint 0,
	printslip smallint 0,
	printbill smallint 0,
	autobilldocgroup smallint 0,
	defitembilltype smallint 0,
	defbuybilltype smallint 0,
	displaypicture smallint 0,
	currencysymbol smallint 0,
	hcurrencysymbol varchar 2  'ß',
	hcurrencycode varchar 10  'hba',
	cashbalance currency  0.0,
	paybillduplicate smallint 0,
	departseparate smallint 0,
	projectseparate smallint 0,
	allocateseparate smallint 0,
	jobseparate smallint 0,
	partseparate smallint 0,
	sideseparate smallint 0,
	isexdescription smallint 0,
	branchseparate smallint 0,
	inventorymethod smallint 0,
	excessstatus smallint 0,
	otherincome smallint 0,
	sonoaddnew smallint 0,
	sonoeditqty smallint 0,
	sonoeditprice smallint 0,
	sonoeditdiscount smallint 0,
	billnoaddnew smallint 0,
	billnoeditqty smallint 0,
	billnoeditprice smallint 0,
	billnoeditdiscount smallint 0,
	buynoaddnew smallint 0,
	buynoeditqty smallint 0,
	buynoeditprice smallint 0,
	buynoeditdiscount smallint 0,
	grnoaddnew smallint 0,
	grnoeditqty smallint 0,
	grnoeditprice smallint 0,
	autopostgl smallint 0,
	autoserverproc smallint 0,
	posrepseparate smallint 0,
	isboxduplicate smallint 0,
	isjob smallint 0,
	creditlimitflag smallint 0,
	serialitemperline smallint 3,
	printserialinvoice smallint 1,
	isedititemname smallint 0,
	fscursum1 currency  0.0,
	fscursum2 currency  0.0,
	fscursum3 currency  0.0,
	fscursum4 currency  0.0,
	daycallcust smallint 0,
	isprintsumpage smallint 0,
	isprintcancel smallint 0,
	isusewarehouse smallint 0,
	isreceivemoney smallint 0,
	issetworkdate smallint 0,
	isusergroup smallint 0,
	formdatestyle smallint 0,
	formnumericstyle smallint 0,
);


create table bcmailconfig
(
	
	roworder autoincrement not null, 
	username varchar(50) not null,
	emailaddress varchar(100) not null,
	poapprove smallint,
	quoapprove smallint,
	soapprove smallint,
	primary key(username,emailaddress)
);

default on bcmailconfig
(
	poapprove smallint 0,
	quoapprove smallint 0,
	soapprove smallint 0,
);


create table bcardebttable
(
	
	roworder autoincrement not null, 
	arcode varchar(20) not null,
	periodno smallint,
	currencycode varchar(10) not null,
	debtamount currency ,
	chqonhand currency ,
	creditonhand currency ,
	chqreturn currency ,
	primary key(arcode,periodno,currencycode)
);

default on bcardebttable
(
	periodno smallint 0 not null,
	debtamount currency  0.0,
	chqonhand currency  0.0,
	creditonhand currency  0.0,
	chqreturn currency  0.0,
);


create table bctrnasportline
(
	
	roworder autoincrement not null, 
	code varchar(20) not null,
	starttransport varchar(200),
	stoptransport varchar(200)
	,primary key(code)
);
create table bcar
(
	
	roworder autoincrement not null, 
	code varchar(20) not null,
	name1 varchar(200) not null,
	name2 varchar(200),
	defdeliveryaddr varchar(10),
	defcontactcode varchar(10),
	deftransport varchar(10),
	billaddress varchar(255),
	workaddress varchar(255),
	telephone varchar(50),
	fax varchar(50),
	accountcode varchar(20),
	idcardno varchar(30),
	lastcontactdate datetime,
	lastpaydate datetime,
	salecode varchar(10),
	parentcode varchar(20),
	billcredit smallint,
	transportcredit smallint,
	detaildiscount varchar(35),
	discount varchar(35),
	cashdiscount varchar(35),
	debtlimit1 currency ,
	debtlimit2 currency ,
	debtlimitbal currency ,
	debtamount currency ,
	chqonhand currency ,
	creditonhand currency ,
	chqreturn currency ,
	excessamount currency ,
	ismaketrans smallint,
	taxtype smallint,
	defaulttaxrate currency ,
	taxno varchar(20),
	paymentremark varchar(50),
	statementremark varchar(50),
	picfilename varchar(50),
	typecode varchar(10),
	groupcode varchar(10),
	saleareacode varchar(10),
	homepage varchar(100),
	emailaddress varchar(40),
	groupofdebt varchar(10),
	persontype smallint,
	authorizeamount currency ,
	docpicreffile1 varchar(100),
	docpicreffile2 varchar(100),
	birthday datetime,
	custage smallint,
	custstatus smallint,
	custcredittype smallint,
	receivebyday varchar(30),
	receivebydate varchar(30),
	receivebyweek smallint,
	paybillbyday varchar(30),
	paybillbydate varchar(30),
	paybillbyweek smallint,
	routestep1 varchar(10),
	routestep2 varchar(10),
	routestep3 varchar(10),
	routestep4 varchar(10),
	routestep5 varchar(10),
	routestep6 varchar(10),
	routestep7 varchar(10),
	routestep8 varchar(10),
	routestep9 varchar(10),
	routestep10 varchar(10),
	pricelevel smallint,
	activestatus smallint,
	mapcode varchar(10),
	mapposition_x smallint,
	mapposition_y smallint,
	itemdescgroup smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	creditmencode varchar(10),
	creditmencode2 varchar(10),
	creditmencode3 varchar(10),
	pressmencode varchar(10),
	pressmencode2 varchar(10),
	pressmencode3 varchar(10),
	keepmoneymencode varchar(10),
	keepmoneymencode2 varchar(10),
	keepmoneymencode3 varchar(10),
	condpaycode varchar(10),
	usegroupmoney smallint,
	groupcreditcode varchar(10),
	memberid varchar(20),
	begindate datetime,
	expiredate datetime,
	remember smallint,
	sumofmark1 smallint,
	sumofmark2 smallint,
	sumofvalue1 currency ,
	sumofvalue2 currency ,
	primary key(code)
);

default on bcar
(
	billcredit smallint 0,
	transportcredit smallint 0,
	debtlimit1 currency  0.0,
	debtlimit2 currency  0.0,
	debtlimitbal currency  0.0,
	debtamount currency  0.0,
	chqonhand currency  0.0,
	creditonhand currency  0.0,
	chqreturn currency  0.0,
	excessamount currency  0.0,
	ismaketrans smallint 0,
	taxtype smallint 0,
	defaulttaxrate currency  7.0,
	persontype smallint 0,
	authorizeamount currency  0.0,
	custage smallint 0,
	custstatus smallint 0,
	custcredittype smallint 0,
	receivebyweek smallint 0,
	paybillbyweek smallint 0,
	pricelevel smallint 0,
	activestatus smallint 1,
	mapposition_x smallint 0,
	mapposition_y smallint 0,
	itemdescgroup smallint 0,
	usegroupmoney smallint 0,
	remember smallint 0,
	sumofmark1 smallint 0,
	sumofmark2 smallint 0,
	sumofvalue1 currency  0.0,
	sumofvalue2 currency  0.0,
);


create index idx_arname on bcar(name1);
create index idx_aract on bcar(activestatus);
create table bcarperiodstate
(
	
	roworder autoincrement not null, 
	arcode varchar(20) not null,
	periodno smallint,
	beginamount currency ,
	debtamount currency ,
	cnamount currency ,
	debitamount currency ,
	receiptamount currency ,
	endamount currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcarperiodstate
(
	periodno smallint 0,
	beginamount currency  0.0,
	debtamount currency  0.0,
	cnamount currency  0.0,
	debitamount currency  0.0,
	receiptamount currency  0.0,
	endamount currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_arpsar on bcarperiodstate(arcode);
create index idx_arpspno on bcarperiodstate(periodno);
create table bcarinvbalance
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	arcode varchar(20) not null,
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	paybilldate datetime,
	salecode varchar(10),
	isconfirm smallint,
	paybillstatus smallint,
	mydescription varchar(255),
	billgroup varchar(10),
	contactcode varchar(10),
	netdebtamount currency ,
	billbalance currency ,
	billtype smallint,
	currencycode varchar(10),
	exchangerate double ,
	allocatecode varchar(10),
	projectcode varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	paybillamount currency ,
	primary key(docno)
);

default on bcarinvbalance
(
	creditday smallint 0,
	isconfirm smallint 0,
	paybillstatus smallint 0,
	netdebtamount currency  0.0,
	billbalance currency  0.0,
	billtype smallint 0,
	exchangerate double  1.0,
	paybillamount currency  0.0,
);


create index idx_arinvbdate on bcarinvbalance(docdate);
create index idx_arinvbarcd on bcarinvbalance(arcode);
create index idx_arinvbardep on bcarinvbalance(departcode);
create index idx_arinvbsale on bcarinvbalance(salecode);
create index idx_arinvbbs on bcarinvbalance(paybillstatus);
create index idx_arinvbbt on bcarinvbalance(billtype);
create index idx_arinvbbal on bcarinvbalance(billbalance);
create index idx_arinvbdue on bcarinvbalance(duedate);
create table bcarotherdebt
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	arcode varchar(20) not null,
	glbookcode varchar(5),
	ispostgl smallint,
	sumofdebit currency ,
	sumofcredit currency ,
	departcode varchar(10) ,
	creditday smallint,
	duedate datetime,
	paybilldate datetime,
	salecode varchar(10),
	isconfirm smallint,
	paybillstatus smallint,
	mydescription varchar(255),
	billgroup varchar(10),
	contactcode varchar(10),
	netdebtamount currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	iscancel smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	paybillamount currency ,
	primary key(docno)
);

default on bcarotherdebt
(
	ispostgl smallint 0,
	sumofdebit currency  0.0,
	sumofcredit currency  0.0,
	creditday smallint 0,
	isconfirm smallint 0,
	paybillstatus smallint 0,
	netdebtamount currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	iscancel smallint 0,
	paybillamount currency  0.0,
);


create index idx_aodbs on bcarotherdebt(paybillstatus);
create index idx_aodbal on bcarotherdebt(billbalance);
create index idx_aodar on bcarotherdebt(arcode);
create index idx_aoddue on bcarotherdebt(duedate);
create table bcarinvoice
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	taxno varchar(20),
	taxtype smallint,
	arcode varchar(20) not null,
	passbillto varchar(20) ,
	arname varchar(200),
	araddress varchar(255),
	cashiercode varchar(10),
	shiftno smallint,
	machineno varchar(10),
	machinecode varchar(30),
	posstatus smallint,
	billtime varchar(15),
	credittype varchar(10),
	creditbranch varchar(40),
	creditduedate datetime,
	creditno varchar(20),
	cofirmno varchar(20),
	chargeword varchar(30),
	creditbaseamount currency ,
	chargeamount currency ,
	grandtotal currency ,
	coupongamount currency ,
	coupongdesc varchar(100),
	changeamount currency ,
	summarkcount1 smallint,
	summarkcount2 smallint,
	summarkvalue1 currency ,
	summarkvalue2 currency ,
	departcode varchar(10),
	creditday smallint,
	deliveryday smallint,
	deliverydate datetime,
	duedate datetime,
	paybilldate datetime,
	salecode varchar(10),
	saleareacode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	billtype smallint,
	billgroup varchar(10),
	refdocno varchar(20),
	crauthorizeman varchar(20),
	deliveryaddr varchar(10),
	contactcode varchar(10),
	transportcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(35),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	zerotaxamount currency ,
	excepttaxamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	sumbankamount currency ,
	depositinctax smallint,
	sumofdeposit1 currency ,
	sumofdeposit2 currency ,
	sumofwtax currency ,
	netdebtamount currency ,
	homeamount currency ,
	otherincome currency ,
	otherexpense currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	iscancel smallint,
	iscreditnote smallint,
	isdebitnote smallint,
	isprocessok smallint,
	iscompletesave smallint,
	ispostgl smallint,
	gltransdata smallint,
	paybillstatus smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	exchangeprofit currency ,
	custtypecode varchar(10),
	custgroupcode varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	remark1 varchar(30),
	remark2 varchar(30),
	remark3 varchar(30),
	remark4 varchar(30),
	remark5 varchar(30),
	isreceivemoney smallint,
	isconditionsend smallint,
	totaltransport currency ,
	paybillamount currency ,
	grossweight currency ,
	printcount smallint,
	sorefno varchar(100)
	,primary key(docno)
);

default on bcarinvoice
(
	taxtype smallint 0,
	shiftno smallint 0,
	posstatus smallint 0,
	creditbaseamount currency  0.0,
	chargeamount currency  0.0,
	grandtotal currency  0.0,
	coupongamount currency  0.0,
	changeamount currency  0.0,
	summarkcount1 smallint 0,
	summarkcount2 smallint 0,
	summarkvalue1 currency  0.0,
	summarkvalue2 currency  0.0,
	creditday smallint 0,
	deliveryday smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billtype smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	sumbankamount currency  0.0,
	depositinctax smallint 1,
	sumofdeposit1 currency  0.0,
	sumofdeposit2 currency  0.0,
	sumofwtax currency  0.0,
	netdebtamount currency  0.0,
	homeamount currency  0.0,
	otherincome currency  0.0,
	otherexpense currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	iscancel smallint 0,
	iscreditnote smallint 0,
	isdebitnote smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	paybillstatus smallint 0,
	exchangeprofit currency  0.0,
	isreceivemoney smallint 0,
	isconditionsend smallint 0,
	totaltransport currency  0.0,
	paybillamount currency  0.0,
	grossweight currency  0.0,
	printcount smallint 0,
);


create index idx_arinvdate on bcarinvoice(docdate);
create index idx_arinvarcd on bcarinvoice(arcode);
create index idx_arinvardep on bcarinvoice(departcode);
create index idx_arinvsale on bcarinvoice(salecode);
create index idx_arinvbal on bcarinvoice(billbalance);
create index idx_arinvdue on bcarinvoice(duedate);
create index idx_arinvbs on bcarinvoice(paybillstatus);
create index idx_arinvbt on bcarinvoice(billtype);
create index idx_arinvrec on bcarinvoice(recurname);
create index idx_arinvrow on bcarinvoice(roworder);
create table bcarinvoicesub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	cnqty currency ,
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	sumofcost currency ,
	balanceamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	oppositeprice2 currency ,
	sorefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	linenumber smallint,
	reflinenumber smallint,
	transstate smallint,
	iscancel smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	barcode varchar(20),
	custtypecode varchar(10),
	custgroupcode varchar(10),
	saleareacode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	machineno varchar(10),
	machinecode varchar(30),
	billtime varchar(15),
	cashiercode varchar(10),
	shiftno smallint,
	posstatus smallint,
	pricestatus smallint,
	ispromotion smallint,
	premiumstatus smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	isconditionsend smallint,
	transportamount currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcarinvoicesub
(
	behindindex smallint 1,
	mytype smallint 4,
	taxtype smallint 0,
	cnqty currency  0.0,
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	sumofcost currency  0.0,
	balanceamount currency  0.0,
	oppositeqty currency  0.0,
	oppositeprice2 currency  0.0,
	stocktype smallint 0,
	excepttax smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	exchangerate double  1.0,
	shiftno smallint 0,
	posstatus smallint 0,
	pricestatus smallint 0,
	ispromotion smallint 0,
	premiumstatus smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	isconditionsend smallint 0,
	transportamount currency  0.0,
	averagecost currency  0.0,
);


create index idx_arinvsdate on bcarinvoicesub(docdate);
create index idx_arinvsarcd on bcarinvoicesub(arcode);
create index idx_arinvsardep on bcarinvoicesub(departcode);
create index idx_arinvssale on bcarinvoicesub(salecode);
create index idx_arinvsind on bcarinvoicesub(behindindex);
create index idx_arinvstype on bcarinvoicesub(mytype);
create index idx_arinvsitem on bcarinvoicesub(itemcode);
create index idx_arinvswh on bcarinvoicesub(whcode);
create index idx_arinvsshlf on bcarinvoicesub(shelfcode);
create index idx_arinvsbnd on bcarinvoicesub(brandcode);
create index idx_arinvsgrp on bcarinvoicesub(groupcode);
create index idx_arinvstypec on bcarinvoicesub(typecode);
create index idx_arinvsfrm on bcarinvoicesub(formatcode);
create index idx_arinvsts on bcarinvoicesub(transstate);
create table bcitemsubstitute
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	substitutecode varchar(25),
	mydescription varchar(25),
	unitcode varchar(10)
	,primary key(roworder)
);
create index idx_itmsttcd on bcitemsubstitute(itemcode);
create index idx_itmstttc on bcitemsubstitute(substitutecode);
create table bcitemmatch
(
	
	roworder autoincrement not null, 
	mastercode varchar(25),
	matchcode varchar(25),
	mydescription varchar(25),
	qty currency ,
	unitcode varchar(10),
	matchstatus smallint,
	primary key(roworder)
);

default on bcitemmatch
(
	qty currency  0.0,
	matchstatus smallint 0,
);


create index idx_itmmmt on bcitemmatch(mastercode);
create index idx_itmmmc on bcitemmatch(matchcode);
create table bcstkinspect
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(200),
	resultdesc varchar(200),
	inspectby smallint,
	isconfirm smallint,
	confirmcode varchar(10),
	confirmdatetime datetime,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime
	,primary key(docno)
);

default on bcstkinspect
(
	inspectby smallint 0,
	isconfirm smallint 0,
);


create table bcstkinspectsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	inspectby smallint,
	transstate smallint,
	itemcode varchar(25),
	unitcode varchar(10),
	whcode varchar(10),
	shelfcode varchar(15),
	adjuststatus smallint,
	stkqty currency ,
	inspectqty currency ,
	inspectdesc varchar(100),
	diffqty currency ,
	primary key(roworder)
);

default on bcstkinspectsub
(
	inspectby smallint 0,
	transstate smallint 0,
	adjuststatus smallint 0,
	stkqty currency  0.0,
	inspectqty currency  0.0,
	diffqty currency  0.0,
);


create index idx_stkinscode on bcstkinspectsub(itemcode);
create index idx_stkinswh on bcstkinspectsub(whcode);
create table bcstkadjust
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	inspectno varchar(20),
	mydescription varchar(200),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	isconfirm smallint,
	iscancel smallint,
	sumamount currency ,
	sumamount2 currency ,
	iscompletesave smallint,
	taxamount currency ,
	totalamount currency ,
	sumofexcepttax currency ,
	outputtaxstatus smallint,
	adjusttype smallint,
	packingstatus smallint,
	confirmcode varchar(10),
	confirmdatetime datetime,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	sumofcost currency ,
	primary key(docno)
);

default on bcstkadjust
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	isconfirm smallint 0,
	iscancel smallint 0,
	sumamount currency  0.0,
	sumamount2 currency  0.0,
	iscompletesave smallint 0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	sumofexcepttax currency  0.0,
	outputtaxstatus smallint 0,
	adjusttype smallint 0,
	packingstatus smallint 0,
	sumofcost currency  0.0,
);


create table bcstkadjustsub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	docdate datetime,
	inspectno varchar(20),
	inspectrow int ,
	itemcode varchar(25),
	unitcode varchar(10),
	mydescription varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	transstate smallint,
	iscancel smallint,
	adjmark smallint,
	qty currency ,
	adjcost currency ,
	amount currency ,
	sumofcost currency ,
	excepttax smallint,
	price currency ,
	linenumber smallint,
	packingstatus smallint,
	netamount currency ,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcstkadjustsub
(
	behindindex smallint 1,
	mytype smallint 10,
	transstate smallint 0,
	iscancel smallint 0,
	adjmark smallint 0,
	qty currency  0.0,
	adjcost currency  0.0,
	amount currency  0.0,
	sumofcost currency  0.0,
	excepttax smallint 0,
	price currency  0.0,
	linenumber smallint 0,
	packingstatus smallint 0,
	netamount currency  0.0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_stkadscode on bcstkadjustsub(itemcode);
create index idx_stkadswh on bcstkadjustsub(whcode);
create index idx_stkadsmt on bcstkadjustsub(mytype);
create index idx_stkadsmi on bcstkadjustsub(behindindex);
create table bcitemcomponents
(
	
	roworder autoincrement not null, 
	parentcode varchar(25),
	itemcode varchar(25),
	qty currency ,
	price currency ,
	amount currency ,
	unitcode varchar(10)
	,primary key(roworder)
);

default on bcitemcomponents
(
	qty currency  0.0,
	price currency  0.0,
	amount currency  0.0,
);


create index idx_itmcpprc on bcitemcomponents(parentcode);
create index idx_itmcpitem on bcitemcomponents(itemcode);
create table bcstkperiodbal
(
	
	roworder autoincrement not null, 
	periodno smallint,
	isreprocess smallint,
	itemcode varchar(25),
	unitcode varchar(10),
	beginqty currency ,
	beginamount currency ,
	saleqty currency ,
	saleamount currency ,
	buyqty currency ,
	buyamount currency ,
	stkretqty currency ,
	stkretamount currency ,
	cnqty currency ,
	cnamount currency ,
	db1qty currency ,
	db1amount currency ,
	db2qty currency ,
	db2amount currency ,
	issueqty currency ,
	issueamount currency ,
	issueretqty currency ,
	issueretamount currency ,
	fgqty currency ,
	fgamount currency ,
	inqty currency ,
	inamount currency ,
	outqty currency ,
	outamount currency ,
	endqty currency ,
	endamount currency ,
	primary key(roworder)
);

default on bcstkperiodbal
(
	periodno smallint 0,
	isreprocess smallint 0,
	beginqty currency  0.0,
	beginamount currency  0.0,
	saleqty currency  0.0,
	saleamount currency  0.0,
	buyqty currency  0.0,
	buyamount currency  0.0,
	stkretqty currency  0.0,
	stkretamount currency  0.0,
	cnqty currency  0.0,
	cnamount currency  0.0,
	db1qty currency  0.0,
	db1amount currency  0.0,
	db2qty currency  0.0,
	db2amount currency  0.0,
	issueqty currency  0.0,
	issueamount currency  0.0,
	issueretqty currency  0.0,
	issueretamount currency  0.0,
	fgqty currency  0.0,
	fgamount currency  0.0,
	inqty currency  0.0,
	inamount currency  0.0,
	outqty currency  0.0,
	outamount currency  0.0,
	endqty currency  0.0,
	endamount currency  0.0,
);


create index idx_stkbalpno on bcstkperiodbal(periodno);
create index idx_stkbalic on bcstkperiodbal(itemcode);
create table bcstkwhperiodbal
(
	
	roworder autoincrement not null, 
	periodno smallint,
	itemcode varchar(25),
	whcode varchar(10),
	shelfcode varchar(10),
	unitcode varchar(10),
	beginqty currency ,
	beginamount currency ,
	qty currency ,
	amount currency ,
	primary key(roworder)
);

default on bcstkwhperiodbal
(
	periodno smallint 0,
	beginqty currency  0.0,
	beginamount currency  0.0,
	qty currency  0.0,
	amount currency  0.0,
);


create index idx_stkwbalpno on bcstkwhperiodbal(periodno);
create index idx_stkwbalic on bcstkwhperiodbal(itemcode);
create index idx_stkwbalwh on bcstkwhperiodbal(whcode);
create index idx_stkwbalsh on bcstkwhperiodbal(shelfcode);
create index idx_stkwbalun on bcstkwhperiodbal(unitcode);
create table bcitembilldesc
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	billdesc varchar(100),
	linenumber smallint,
	descgroup smallint,
	primary key(roworder)
);

default on bcitembilldesc
(
	linenumber smallint 0,
	descgroup smallint 0,
);


create index idx_itbilld_code on bcitembilldesc(itemcode);
create table bcsupplierpromo
(
	
	roworder autoincrement not null, 
	apcode varchar(20),
	itemcode varchar(25),
	itempromo varchar(25),
	unitcode varchar(10),
	qty currency ,
	prostartdate datetime,
	prostopdate datetime,
	linenumber smallint,
	primary key(roworder)
);

default on bcsupplierpromo
(
	qty currency  0.0,
	linenumber smallint 0,
);


create index idx_sppromo_ap on bcsupplierpromo(apcode);
create index idx_sppromo_itm on bcsupplierpromo(itemcode);
create index idx_sppromo_unit on bcsupplierpromo(unitcode);
create table bcitemrenovate
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	arcode varchar(20) not null,
	itemcode varchar(25) not null,
	invoiceno varchar(20),
	mydescription1 varchar(255),
	mydescription2 varchar(255),
	finishdate datetime,
	senddate datetime
	,primary key(docno)
);
create table bcitemstatus
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcitem
(
	
	roworder autoincrement not null, 
	code varchar(25) not null,
	name1 varchar(200),
	name2 varchar(200),
	shortname varchar(100),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	colorcode varchar(10),
	mygrade varchar(40),
	myclass varchar(20),
	genericcode varchar(10),
	unittype smallint,
	defstkunitcode varchar(10),
	defsaleunitcode varchar(10),
	defbuyunitcode varchar(10),
	oppositeunit varchar(10),
	oppositeunit2 varchar(10),
	opposite1price currency ,
	oppositerate currency ,
	mysize varchar(40),
	weight currency ,
	lastupdate datetime,
	stocktype smallint,
	stockprocess smallint,
	vendercode varchar(20),
	depositcondit varchar(35),
	deliverycharge varchar(35),
	installcharge varchar(35),
	returnremark varchar(100),
	returnstatus smallint,
	returncharge varchar(30),
	itemstatus varchar(10),
	newitemstatus smallint,
	renovatestatus smallint,
	excepttax smallint,
	promotiontype smallint,
	wtaxrate currency ,
	wavefile varchar(50),
	costtype smallint,
	orderpoint currency ,
	stockmin currency ,
	stockmax currency ,
	stockqty currency ,
	averagecost currency ,
	amount currency ,
	costofarea currency ,
	lastbuyprice currency ,
	standardcost currency ,
	picfilename1 varchar(100),
	picfilename2 varchar(100),
	picfilename3 varchar(100),
	picfilename4 varchar(100),
	specfilename varchar(100),
	avifilename varchar(100),
	accgroupcode varchar(10),
	mydescription varchar(255),
	defbuywhcode varchar(10),
	defbuyshelf varchar(15),
	defsalewhcode varchar(10),
	defsaleshelf varchar(15),
	defbadwhcode varchar(10),
	defbadshelf varchar(15),
	deffgwhcode varchar(10),
	deffgshelf varchar(15),
	defrepairwhcode varchar(10),
	defrepairshelf varchar(15),
	defrawwhcode varchar(10),
	defrawshelf varchar(15),
	formula1 varchar(10),
	formula2 varchar(10),
	formula3 varchar(10),
	discount varchar(35),
	reserveqty currency ,
	remainoutqty currency ,
	remaininqty currency ,
	baseprice currency ,
	activestatus smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	saleprice1 currency ,
	saleprice2 currency ,
	saleprice3 currency ,
	deffixunitcode varchar(10),
	deffixunitcost currency ,
	fixqty currency ,
	fixcost currency ,
	salepricenv1 currency ,
	salepricenv2 currency ,
	salepricenv3 currency ,
	processstatus smallint,
	isgift smallint,
	promomember smallint,
	promotype smallint,
	averagecostreal currency ,
	overreceive currency ,
	containercapacity currency ,
	containerweight currency ,
	capacityunit varchar(20),
	lastbuypricehome currency ,
	lastbuycurrencycode varchar(10),
	lastavgcost currency ,
	usergroup varchar(255),
	stockqty1 currency ,
	stockqty2 currency ,
	stockqtyword varchar(255)
	,primary key(code)
);

default on bcitem
(
	unittype smallint 0,
	opposite1price currency  0.0,
	oppositerate currency  0.0,
	weight currency  0.0,
	stocktype smallint 0,
	stockprocess smallint 0,
	returnstatus smallint 0,
	newitemstatus smallint 0,
	renovatestatus smallint 0,
	excepttax smallint 0,
	promotiontype smallint 0,
	wtaxrate currency  0.0,
	costtype smallint 0,
	orderpoint currency  0.0,
	stockmin currency  0.0,
	stockmax currency  0.0,
	stockqty currency  0.0,
	averagecost currency  0.0,
	amount currency  0.0,
	costofarea currency  0.0,
	lastbuyprice currency  0.0,
	standardcost currency  0.0,
	reserveqty currency  0.0,
	remainoutqty currency  0.0,
	remaininqty currency  0.0,
	baseprice currency  0.0,
	activestatus smallint 1,
	saleprice1 currency  0.0,
	saleprice2 currency  0.0,
	saleprice3 currency  0.0,
	deffixunitcost currency  0.0,
	fixqty currency  0.0,
	fixcost currency  0.0,
	salepricenv1 currency  0.0,
	salepricenv2 currency  0.0,
	salepricenv3 currency  0.0,
	processstatus smallint 0,
	isgift smallint 0,
	promomember smallint 0,
	promotype smallint 0,
	averagecostreal currency  0.0,
	overreceive currency  0.0,
	containercapacity currency  0.0,
	containerweight currency  0.0,
	lastbuypricehome currency  0.0,
	lastavgcost currency  0.0,
	stockqty1 currency  0.0,
	stockqty2 currency  0.0,
);


create index idx_item_name on bcitem(name1);
create index idx_item_stktp on bcitem(stocktype);
create index idx_item_csttp on bcitem(costtype);
create index idx_item_act on bcitem(activestatus);
create table bcformula
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(100),
	itemcode varchar(25),
	mydescription varchar(255),
	isconfirm smallint,
	confirmcode varchar(10),
	confirmdatetime datetime,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime
	,primary key(code)
);

default on bcformula
(
	isconfirm smallint 0,
);


create table bcformulasub
(
	
	roworder autoincrement not null, 
	code varchar(10),
	itemcode varchar(25),
	unitcode varchar(10),
	linenumber smallint,
	qty currency ,
	primary key(roworder)
);

default on bcformulasub
(
	linenumber smallint 0,
	qty currency  0.0,
);


create index idx_fms_code on bcformulasub(code);
create index idx_fms_icode on bcformulasub(itemcode);
create table bcitemsupplier
(
	
	roworder autoincrement not null, 
	itemcode varchar(25) not null,
	apcode varchar(20) not null,
	transporttime smallint,
	paymentcase varchar(255),
	buyprice currency ,
	unitcode varchar(10),
	fightcase varchar(100),
	lastbuyprice currency ,
	lastbuydate datetime,
	lastbuyunitcode varchar(10),
	priorityindex smallint,
	prostartdate datetime,
	prostopdate datetime,
	probuyprice currency ,
	primary key(roworder)
);

default on bcitemsupplier
(
	transporttime smallint 0,
	buyprice currency  0.0,
	lastbuyprice currency  0.0,
	priorityindex smallint 0,
	probuyprice currency  0.0,
);


create index idx_itmspcode on bcitemsupplier(itemcode);
create index idx_itmspap on bcitemsupplier(apcode);
create table bcitemaccgroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50),
	itemaccount varchar(20),
	costaccount varchar(20),
	revenueaccount varchar(20)
	,primary key(code)
);
create table bcstkwarehouse
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	whcode varchar(10),
	shelfcode varchar(15),
	unitcode varchar(10),
	qty currency ,
	reserveqty currency ,
	remaininqty currency ,
	remainoutqty currency ,
	amount currency ,
	itempriority smallint,
	readyqtyall currency ,
	reserveqtyall currency ,
	remainqtyall currency ,
	remainoutqtyall currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcstkwarehouse
(
	qty currency  0.0,
	reserveqty currency  0.0,
	remaininqty currency  0.0,
	remainoutqty currency  0.0,
	amount currency  0.0,
	itempriority smallint 0,
	readyqtyall currency  0.0,
	reserveqtyall currency  0.0,
	remainqtyall currency  0.0,
	remainoutqtyall currency  0.0,
	averagecost currency  0.0,
);


create index idx_whstkitem on bcstkwarehouse(itemcode);
create index idx_whstkwh on bcstkwarehouse(whcode);
create index idx_whstkshf on bcstkwarehouse(shelfcode);
create index idx_whstkunit on bcstkwarehouse(unitcode);
create table bclotout
(
	
	roworder autoincrement not null, 
	docdate datetime,
	docno varchar(20),
	itemcode varchar(25),
	billlinenumber smallint,
	transperiod smallint,
	lotnumber varchar(50),
	transtype smallint,
	lotqty currency ,
	cost currency ,
	costoflot currency ,
	primary key(roworder)
);

default on bclotout
(
	billlinenumber smallint 0,
	transperiod smallint 0,
	transtype smallint 0,
	lotqty currency  0.0,
	cost currency  0.0,
	costoflot currency  0.0,
);


create index idx_ltoitem on bclotout(itemcode);
create index idx_ltoline on bclotout(billlinenumber);
create index idx_ltottyp on bclotout(transtype);
create table bclotmaster
(
	
	roworder autoincrement not null, 
	itemcode varchar(25) not null,
	lotnumber varchar(50) not null,
	whcode varchar(10) not null,
	shelfcode varchar(15) not null,
	billlinenumber smallint,
	transtype smallint,
	transperiod smallint,
	docno varchar(50) not null,
	docdate datetime,
	expiredate datetime,
	mydescription varchar(200),
	qty currency ,
	cost currency ,
	amount currency ,
	balamount currency ,
	balqty currency ,
	balcost currency ,
	balqtyperiod1 currency ,
	balqtyperiod2 currency ,
	balqtyperiod3 currency ,
	balqtyperiod4 currency ,
	balqtyperiod5 currency ,
	balqtyperiod6 currency ,
	balqtyperiod7 currency ,
	balqtyperiod8 currency ,
	balqtyperiod9 currency ,
	balqtyperiod10 currency ,
	balqtyperiod11 currency ,
	balqtyperiod12 currency ,
	balqtyperiod13 currency ,
	balqtyperiod14 currency ,
	balqtyperiod15 currency ,
	balqtyperiod16 currency ,
	balqtyperiod17 currency ,
	balqtyperiod18 currency ,
	balqtyperiod19 currency ,
	balqtyperiod20 currency ,
	balqtyperiod21 currency ,
	balqtyperiod22 currency ,
	balqtyperiod23 currency ,
	balqtyperiod24 currency ,
	balqtyperiod25 currency ,
	reflot varchar(50)
	,primary key(docno,itemcode,lotnumber,whcode,shelfcode)
);

default on bclotmaster
(
	billlinenumber smallint 0,
	transtype smallint 0,
	transperiod smallint 0,
	qty currency  0.0,
	cost currency  0.0,
	amount currency  0.0 not null,
	balamount currency  0.0,
	balqty currency  0.0,
	balcost currency  0.0,
	balqtyperiod1 currency  0.0,
	balqtyperiod2 currency  0.0,
	balqtyperiod3 currency  0.0,
	balqtyperiod4 currency  0.0,
	balqtyperiod5 currency  0.0,
	balqtyperiod6 currency  0.0,
	balqtyperiod7 currency  0.0,
	balqtyperiod8 currency  0.0,
	balqtyperiod9 currency  0.0,
	balqtyperiod10 currency  0.0,
	balqtyperiod11 currency  0.0,
	balqtyperiod12 currency  0.0,
	balqtyperiod13 currency  0.0,
	balqtyperiod14 currency  0.0,
	balqtyperiod15 currency  0.0,
	balqtyperiod16 currency  0.0,
	balqtyperiod17 currency  0.0,
	balqtyperiod18 currency  0.0,
	balqtyperiod19 currency  0.0,
	balqtyperiod20 currency  0.0,
	balqtyperiod21 currency  0.0,
	balqtyperiod22 currency  0.0,
	balqtyperiod23 currency  0.0,
	balqtyperiod24 currency  0.0,
	balqtyperiod25 currency  0.0,
);


create index idx_ltmline on bclotmaster(billlinenumber);
create index idx_ltmitem on bclotmaster(itemcode);
create index idx_ltmttyp on bclotmaster(transtype);
create table bcstkissue
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	departcode varchar(10),
	issuetype varchar(10),
	dayofuse smallint,
	duedate datetime,
	mydescription varchar(255),
	personcode varchar(10),
	arcode varchar(20),
	sumofamount currency ,
	isconfirm smallint,
	iscancel smallint,
	glformat varchar(5),
	ispostgl smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	billretstatus smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkissue
(
	dayofuse smallint 0,
	sumofamount currency  0.0,
	isconfirm smallint 0,
	iscancel smallint 0,
	ispostgl smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
	billretstatus smallint 0,
);


create index idx_stkiss_rec on bcstkissue(recurname);
create index idx_stkiss_date on bcstkissue(docdate);
create table bcstkissuesub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	issuetype varchar(10),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	personcode varchar(10),
	mydescription varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	refno varchar(20),
	qty currency ,
	retqty currency ,
	sumofcost currency ,
	price currency ,
	amount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	reflinenumber smallint,
	primary key(roworder)
);

default on bcstkissuesub
(
	behindindex smallint 1,
	mytype smallint 8,
	qty currency  0.0,
	retqty currency  0.0,
	sumofcost currency  0.0,
	price currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
	reflinenumber smallint 0,
);


create index idx_stkisdate on bcstkissuesub(docdate);
create index idx_stkisitem on bcstkissuesub(itemcode);
create index idx_stkiswh on bcstkissuesub(whcode);
create index idx_stkisshf on bcstkissuesub(shelfcode);
create index idx_stkistype on bcstkissuesub(mytype);
create index idx_stkisind on bcstkissuesub(behindindex);
create index idx_stkists on bcstkissuesub(transstate);
create index idx_stkisist on bcstkissuesub(issuetype);
create table bcstkissue2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	departcode varchar(10),
	arcode varchar(20),
	issuetype varchar(10),
	dayofuse smallint,
	duedate datetime,
	mydescription varchar(255),
	personcode varchar(10),
	sumofamount currency ,
	isconfirm smallint,
	iscancel smallint,
	glformat varchar(5),
	billstatus smallint,
	ispostgl smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkissue2
(
	dayofuse smallint 0,
	sumofamount currency  0.0,
	isconfirm smallint 0,
	iscancel smallint 0,
	billstatus smallint 0,
	ispostgl smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
);


create index idx_stkiss2_rec on bcstkissue2(recurname);
create index idx_stkiss2_date on bcstkissue2(docdate);
create table bcstkissuesub2
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	issuetype varchar(10),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	personcode varchar(10),
	mydescription varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	issqty currency ,
	remainqty currency ,
	sumofcost currency ,
	price currency ,
	amount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	primary key(roworder)
);

default on bcstkissuesub2
(
	qty currency  0.0,
	issqty currency  0.0,
	remainqty currency  0.0,
	sumofcost currency  0.0,
	price currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
);


create index idx_stkis2date on bcstkissuesub2(docdate);
create index idx_stkis2item on bcstkissuesub2(itemcode);
create index idx_stkis2wh on bcstkissuesub2(whcode);
create index idx_stkis2shf on bcstkissuesub2(shelfcode);
create index idx_stkis2ts on bcstkissuesub2(transstate);
create index idx_stkis2ist on bcstkissuesub2(issuetype);
create table bcstkissueret
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	issuerefno varchar(20),
	departcode varchar(10),
	isconfirm smallint,
	iscancel smallint,
	personcode varchar(10),
	sumofamount currency ,
	mydescription varchar(255),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	isprocessok smallint,
	iscompletesave smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkissueret
(
	isconfirm smallint 0,
	iscancel smallint 0,
	sumofamount currency  0.0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create index idx_stkisrdate on bcstkissueret(docdate);
create index idx_stkisrdep on bcstkissueret(departcode);
create index idx_stkisrper on bcstkissueret(personcode);
create index idx_stkisrrec on bcstkissueret(recurname);
create table bcstkissretsub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	issuerefno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	personcode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	sumofcost currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	barcode varchar(20),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	reflinenumber smallint
	,primary key(roworder)
);

default on bcstkissretsub
(
	behindindex smallint 1,
	mytype smallint 9,
	qty currency  0.0,
	sumofcost currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_stkisrsdate on bcstkissretsub(docdate);
create index idx_stkisrsitem on bcstkissretsub(itemcode);
create index idx_stkisrswh on bcstkissretsub(whcode);
create index idx_stkisrsshf on bcstkissretsub(shelfcode);
create index idx_stkisrstype on bcstkissretsub(mytype);
create index idx_stkisrsind on bcstkissretsub(behindindex);
create index idx_stkisrsts on bcstkissretsub(transstate);
create table bcstkbalance
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	isconfirm smallint,
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(255),
	sumofamount currency ,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkbalance
(
	isconfirm smallint 0,
	sumofamount currency  0.0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create table bcstkbalancesub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	cost currency ,
	amount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	barcode varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcstkbalancesub
(
	behindindex smallint 1,
	mytype smallint 0,
	qty currency  0.0,
	cost currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_itmbdate on bcstkbalancesub(docdate);
create index idx_itmbitem on bcstkbalancesub(itemcode);
create index idx_itmbwh on bcstkbalancesub(whcode);
create index idx_itmbshf on bcstkbalancesub(shelfcode);
create index idx_itmbtype on bcstkbalancesub(mytype);
create index idx_itmbind on bcstkbalancesub(behindindex);
create index idx_itmbts on bcstkbalancesub(transstate);
create table bcfinishgoods
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	departcode varchar(10),
	personcode varchar(10),
	mydescription varchar(255),
	sumofamount currency ,
	isconfirm smallint,
	glformat varchar(5),
	iscancel smallint,
	ispostgl smallint,
	gltransdata smallint,
	isprocessok smallint,
	iscompletesave smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcfinishgoods
(
	sumofamount currency  0.0,
	isconfirm smallint 0,
	iscancel smallint 0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create index idx_fg_rec on bcfinishgoods(recurname);
create index idx_fg_date on bcfinishgoods(docdate);
create table bcfinishgoodssub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	personcode varchar(10),
	mydescription varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	cost currency ,
	amount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcfinishgoodssub
(
	behindindex smallint 1,
	mytype smallint 1,
	qty currency  0.0,
	cost currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_fgsno on bcfinishgoodssub(docno);
create index idx_fgsdate on bcfinishgoodssub(docdate);
create index idx_fgsitem on bcfinishgoodssub(itemcode);
create index idx_fgswh on bcfinishgoodssub(whcode);
create index idx_fgsshf on bcfinishgoodssub(shelfcode);
create index idx_fgstype on bcfinishgoodssub(mytype);
create index idx_fgsind on bcfinishgoodssub(behindindex);
create index idx_fgsts on bcfinishgoodssub(transstate);
create table bcstktransfer
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	isconfirm smallint,
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(255),
	sumofqty currency ,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	recurname varchar(40),
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstktransfer
(
	isconfirm smallint 0,
	sumofqty currency  0.0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create table bcstktransfsub3
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	price currency ,
	sumofcost currency ,
	amount currency ,
	refno varchar(20),
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	fromwhcode varchar(10),
	fromshelfcode varchar(10),
	reftrlinenum smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcstktransfsub3
(
	behindindex smallint 1,
	mytype smallint 12,
	qty currency  0.0,
	price currency  0.0,
	sumofcost currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create table bcstktransfsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(100),
	fromwh varchar(10),
	fromshelf varchar(15),
	towh varchar(10),
	toshelf varchar(15),
	qty currency ,
	price currency ,
	sumofcost currency ,
	amount currency ,
	refno varchar(20),
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint
	,primary key(roworder)
);

default on bcstktransfsub
(
	qty currency  0.0,
	price currency  0.0,
	sumofcost currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
);


create index idx_stktdate on bcstktransfsub(docdate);
create index idx_stktitem on bcstktransfsub(itemcode);
create index idx_stktwht on bcstktransfsub(towh);
create index idx_stktwhf on bcstktransfsub(fromwh);
create index idx_stktshft on bcstktransfsub(toshelf);
create index idx_stktshff on bcstktransfsub(fromshelf);
create index idx_stktts on bcstktransfsub(transstate);
create table bcstktransfer2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	isconfirm smallint,
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(255),
	sumofqty currency ,
	billstatus smallint,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstktransfer2
(
	isconfirm smallint 0,
	sumofqty currency  0.0,
	billstatus smallint 0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create table bcstktransfsub2
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(100),
	fromwh varchar(10),
	fromshelf varchar(15),
	towh varchar(10),
	toshelf varchar(15),
	qty currency ,
	price currency ,
	sumofcost currency ,
	amount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint
	,primary key(roworder)
);

default on bcstktransfsub2
(
	qty currency  0.0,
	price currency  0.0,
	sumofcost currency  0.0,
	amount currency  0.0,
	oppositeqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
);


create index idx_stk2tdate on bcstktransfsub2(docdate);
create index idx_stk2titem on bcstktransfsub2(itemcode);
create index idx_stk2twht on bcstktransfsub2(towh);
create index idx_stk2twhf on bcstktransfsub2(fromwh);
create index idx_stk2tshft on bcstktransfsub2(toshelf);
create index idx_stk2tshff on bcstktransfsub2(fromshelf);
create index idx_stk2tts on bcstktransfsub2(transstate);
create table bcbarcodemaster
(
	
	roworder autoincrement not null, 
	barcode varchar(20),
	barcodename varchar(200),
	itemcode varchar(25),
	remark varchar(100),
	activestatus smallint,
	unitcode varchar(10)
	,primary key(roworder)
);

default on bcbarcodemaster
(
	activestatus smallint 1,
);


create unique index idx_barcode on bcbarcodemaster(barcode);
create index idx_baritem on bcbarcodemaster(itemcode);
create table bcstkpacking
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	rate currency ,
	unitcode varchar(10),
	qty currency ,
	balqtyperiod1 currency ,
	balqtyperiod2 currency ,
	balqtyperiod3 currency ,
	balqtyperiod4 currency ,
	balqtyperiod5 currency ,
	balqtyperiod6 currency ,
	balqtyperiod7 currency ,
	balqtyperiod8 currency ,
	balqtyperiod9 currency ,
	balqtyperiod10 currency ,
	balqtyperiod11 currency ,
	balqtyperiod12 currency ,
	balqtyperiod13 currency ,
	balqtyperiod14 currency ,
	balqtyperiod15 currency ,
	balqtyperiod16 currency ,
	balqtyperiod17 currency ,
	balqtyperiod18 currency ,
	balqtyperiod19 currency ,
	balqtyperiod20 currency ,
	balqtyperiod21 currency ,
	balqtyperiod22 currency ,
	balqtyperiod23 currency ,
	balqtyperiod24 currency ,
	balqtyperiod25 currency ,
	rate1 currency ,
	rate2 currency ,
	running smallint,
	runner smallint,
	useflag smallint,
	useform smallint,
	primary key(roworder)
);

default on bcstkpacking
(
	rate currency  1.0,
	qty currency  0.0,
	balqtyperiod1 currency  0.0,
	balqtyperiod2 currency  0.0,
	balqtyperiod3 currency  0.0,
	balqtyperiod4 currency  0.0,
	balqtyperiod5 currency  0.0,
	balqtyperiod6 currency  0.0,
	balqtyperiod7 currency  0.0,
	balqtyperiod8 currency  0.0,
	balqtyperiod9 currency  0.0,
	balqtyperiod10 currency  0.0,
	balqtyperiod11 currency  0.0,
	balqtyperiod12 currency  0.0,
	balqtyperiod13 currency  0.0,
	balqtyperiod14 currency  0.0,
	balqtyperiod15 currency  0.0,
	balqtyperiod16 currency  0.0,
	balqtyperiod17 currency  0.0,
	balqtyperiod18 currency  0.0,
	balqtyperiod19 currency  0.0,
	balqtyperiod20 currency  0.0,
	balqtyperiod21 currency  0.0,
	balqtyperiod22 currency  0.0,
	balqtyperiod23 currency  0.0,
	balqtyperiod24 currency  0.0,
	balqtyperiod25 currency  0.0,
	rate1 currency  0.0,
	rate2 currency  0.0,
	running smallint 0,
	runner smallint 0,
	useflag smallint 1,
	useform smallint 0,
);


create index idx_packitem on bcstkpacking(itemcode);
create index idx_packunit on bcstkpacking(unitcode);
create table bcpromoprice
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	unitcode varchar(10),
	taxtype smallint,
	fromqty currency ,
	toqty currency ,
	saleprice currency ,
	discountword varchar(35),
	fromdate datetime,
	todate datetime,
	fromargroup varchar(10),
	toargroup varchar(10)
	,primary key(roworder)
);

default on bcpromoprice
(
	taxtype smallint 0,
	fromqty currency  0.0,
	toqty currency  0.0,
	saleprice currency  0.0,
);


create index idx_proitem on bcpromoprice(itemcode);
create index idx_profqty on bcpromoprice(fromqty);
create index idx_protqty on bcpromoprice(toqty);
create index idx_profdate on bcpromoprice(fromdate);
create index idx_protdate on bcpromoprice(todate);
create index idx_prounit on bcpromoprice(unitcode);
create index idx_profarg on bcpromoprice(fromargroup);
create index idx_protarg on bcpromoprice(toargroup);
create table bcpricelist
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	unitcode varchar(10),
	remark varchar(100),
	taxtype smallint,
	fromqty currency ,
	toqty currency ,
	startdate datetime,
	stopdate datetime,
	saletype smallint,
	transporttype smallint,
	saleprice1 currency ,
	saleprice2 currency ,
	saleprice3 currency ,
	saleprice4 currency ,
	saleprice5 currency ,
	saleprice6 currency ,
	saleprice7 currency ,
	saleprice8 currency ,
	lowprice currency ,
	linenumber smallint,
	primary key(roworder)
);

default on bcpricelist
(
	taxtype smallint 0,
	fromqty currency  0.0,
	toqty currency  0.0,
	saletype smallint 0,
	transporttype smallint 0,
	saleprice1 currency  0.0,
	saleprice2 currency  0.0,
	saleprice3 currency  0.0,
	saleprice4 currency  0.0,
	saleprice5 currency  0.0,
	saleprice6 currency  0.0,
	saleprice7 currency  0.0,
	saleprice8 currency  0.0,
	lowprice currency  0.0,
	linenumber smallint 0,
);


create index idx_prlitem on bcpricelist(itemcode);
create index idx_prlfqty on bcpricelist(fromqty);
create index idx_prltqty on bcpricelist(toqty);
create index idx_prlunit on bcpricelist(unitcode);
create table bcpricelist2
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	unitcode varchar(10),
	startqty currency ,
	stopqty currency ,
	startdate datetime,
	stopdate datetime,
	saletype smallint,
	transporttype smallint,
	saleprice1 varchar(50),
	saleprice2 varchar(50),
	saleprice3 varchar(50),
	saleprice4 varchar(50),
	saleprice5 varchar(50),
	saleprice6 varchar(50),
	saleprice7 varchar(50),
	saleprice8 varchar(50),
	taxtype smallint,
	linenumber smallint,
	primary key(roworder)
);

default on bcpricelist2
(
	startqty currency  0.0,
	stopqty currency  0.0,
	saletype smallint 0,
	transporttype smallint 0,
	taxtype smallint 0,
	linenumber smallint 0,
);


create table bcserialprintform
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	docno varchar(20),
	savefrom smallint,
	serialtext varchar(200),
	itemlinenumber smallint,
	linenumber smallint,
	primary key(roworder)
);

default on bcserialprintform
(
	savefrom smallint 0,
	itemlinenumber smallint 0,
	linenumber smallint 0,
);


create table bcserialtrans
(
	
	roworder autoincrement not null, 
	ctrlno varchar(35),
	itemcode varchar(25),
	docdate datetime,
	docno varchar(20),
	shelfcode varchar(15),
	whcode varchar(10),
	savefrom smallint,
	itemlinenumber smallint,
	linenumber smallint,
	primary key(roworder)
);

default on bcserialtrans
(
	savefrom smallint 0,
	itemlinenumber smallint 0,
	linenumber smallint 0,
);


create index idx_sert_ctrl on bcserialtrans(ctrlno);
create index idx_sert_item on bcserialtrans(itemcode);
create index idx_sert_sf on bcserialtrans(savefrom);
create index idx_sert_iline on bcserialtrans(itemlinenumber);
create index idx_sert_line on bcserialtrans(linenumber);
create table bcserialmaster
(
	
	roworder autoincrement not null, 
	ctrlno varchar(35) not null,
	model varchar(35),
	caseno varchar(35),
	caseposition varchar(35),
	itemcode varchar(25),
	itemcolor varchar(30),
	itemremark varchar(255),
	stopinsuredate datetime,
	receivedate datetime,
	receiveman varchar(10),
	receivedocno varchar(20),
	apcode varchar(20),
	saledate datetime,
	saleman varchar(10),
	saledocno varchar(20),
	cnsalecode varchar(10),
	cndocno varchar(20),
	arcode varchar(20),
	itemstatus smallint,
	serialno varchar(35),
	serialposition varchar(35),
	picturename varchar(100),
	registerno varchar(35),
	regisdate datetime,
	price currency ,
	stockstatus smallint,
	shelfcode varchar(15),
	whcode varchar(10),
	activestatus smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime
	,primary key(ctrlno)
);

default on bcserialmaster
(
	itemstatus smallint 0,
	price currency  0.0,
	stockstatus smallint 0,
	activestatus smallint 1,
);


create index idx_seritem on bcserialmaster(itemcode);
create table bcdeliveryaddr
(
	
	roworder autoincrement not null, 
	arcode varchar(20) not null,
	code varchar(10) not null,
	address varchar(255),
	telephone varchar(30),
	contact varchar(10),
	transport varchar(10),
	defaultstatus smallint,
	mydescription varchar(100),
	transportremark varchar(100),
	mapcode varchar(10),
	mapposition_x smallint,
	mapposition_y smallint,
	primary key(arcode,code)
);

default on bcdeliveryaddr
(
	mapposition_x smallint 0,
	mapposition_y smallint 0,
);


create index idx_dva_ar on bcdeliveryaddr(arcode);
create index idx_dva_code on bcdeliveryaddr(code);
create table bcrecmoney
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	currencycode varchar(10),
	exchangerate double ,
	payamount currency ,
	homeamount currency ,
	chqtotalamount currency ,
	paymenttype smallint,
	savefrom smallint,
	paychqstate smallint,
	credittype varchar(10),
	chargeamount currency ,
	chargeword varchar(40),
	confirmno varchar(30),
	linenumber smallint,
	refno varchar(30),
	bankcode varchar(10),
	projectcode varchar(10),
	departcode varchar(10),
	salecode varchar(10),
	bankbranchcode varchar(10),
	transbankdate datetime,
	mydescription varchar(100),
	refdate datetime
	,primary key(roworder)
);

default on bcrecmoney
(
	exchangerate double  1.0,
	payamount currency  0.0,
	homeamount currency  0.0,
	chqtotalamount currency  0.0,
	paymenttype smallint 0,
	savefrom smallint 0,
	paychqstate smallint 0,
	chargeamount currency  0.0,
	linenumber smallint 0,
);


create index idx_recm_date on bcrecmoney(docdate);
create index idx_recm_ar on bcrecmoney(arcode);
create index idx_recm_pty on bcrecmoney(paymenttype);
create table bcinvcreditnote
(
	
	roworder autoincrement not null, 
	docdate datetime,
	arcode varchar(20),
	creditnoteno varchar(20),
	returnmoney smallint,
	returnstatus smallint,
	invoiceno varchar(20),
	invoicedisc varchar(40),
	invexchangerate double ,
	newexchangerate double ,
	oldamount currency ,
	sumofitemamount currency ,
	discountamount currency ,
	diffamount currency ,
	zerotaxamount currency ,
	excepttaxamount currency ,
	trueamount currency ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	transstate smallint,
	iscancel smallint,
	billtype smallint,
	primary key(roworder)
);

default on bcinvcreditnote
(
	returnmoney smallint 0,
	returnstatus smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	oldamount currency  0.0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	diffamount currency  0.0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	trueamount currency  0.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	billtype smallint 0,
);


create index idx_invcn_date on bcinvcreditnote(docdate);
create index idx_invcn_ar on bcinvcreditnote(arcode);
create index idx_invcn_no on bcinvcreditnote(creditnoteno);
create index idx_invcn_inv on bcinvcreditnote(invoiceno);
create table bccnmaster
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(100) not null,
	doctype smallint not null,
	remark varchar(200)
	,primary key(code)
);
create table bccreditnote
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	taxdate datetime,
	docdate datetime,
	duedate datetime,
	taxtype smallint,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	cashiercode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	sumofitemamount currency ,
	sumoldamount currency ,
	sumtrueamount currency ,
	sumofdiffamount currency ,
	discountword varchar(30),
	discountamount currency ,
	sumofbeforetax currency ,
	sumoftaxamount currency ,
	sumoftotaltax currency ,
	sumofzerotax currency ,
	sumofexcepttax currency ,
	sumofwtax currency ,
	netdebtamount currency ,
	sumexchangeprofit currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	debtlimitstate smallint,
	ispostgl smallint,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	returnmoney smallint,
	returnstatus smallint,
	causetype smallint,
	paybillstatus smallint,
	iscndeposit smallint,
	ispos smallint,
	posdocno varchar(20),
	causecode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	paybillamount currency ,
	primary key(docno)
);

default on bccreditnote
(
	taxtype smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	sumofitemamount currency  0.0,
	sumoldamount currency  0.0,
	sumtrueamount currency  0.0,
	sumofdiffamount currency  0.0,
	discountamount currency  0.0,
	sumofbeforetax currency  0.0,
	sumoftaxamount currency  0.0,
	sumoftotaltax currency  0.0,
	sumofzerotax currency  0.0,
	sumofexcepttax currency  0.0,
	sumofwtax currency  0.0,
	netdebtamount currency  0.0,
	sumexchangeprofit currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	debtlimitstate smallint 0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
	returnmoney smallint 0,
	returnstatus smallint 0,
	causetype smallint 0,
	paybillstatus smallint 0,
	iscndeposit smallint 0,
	ispos smallint 0,
	paybillamount currency  0.0,
);


create index idx_cn_date on bccreditnote(docdate);
create index idx_cn_ar on bccreditnote(arcode);
create index idx_cn_pbs on bccreditnote(paybillstatus);
create index idx_cn_bal on bccreditnote(billbalance);
create index idx_cn_row on bccreditnote(roworder);
create table bccreditnotesub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	cashiercode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	discqty currency ,
	tempqty currency ,
	billqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	sumofcost currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	invoiceno varchar(20),
	itemtype smallint,
	excepttax smallint,
	ispos smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	stockprocess smallint,
	linenumber smallint,
	reflinenumber smallint,
	barcode varchar(20),
	ispromotion smallint,
	premiumstatus smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bccreditnotesub
(
	behindindex smallint 1,
	mytype smallint 5,
	taxtype smallint 0,
	discqty currency  0.0,
	tempqty currency  0.0,
	billqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	sumofcost currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	ispos smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	stockprocess smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	ispromotion smallint 0,
	premiumstatus smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_cnsno on bccreditnotesub(docno);
create index idx_cnsdate on bccreditnotesub(docdate);
create index idx_cnsitem on bccreditnotesub(itemcode);
create index idx_cnswh on bccreditnotesub(whcode);
create index idx_cnsshf on bccreditnotesub(shelfcode);
create index idx_cnsind on bccreditnotesub(behindindex);
create index idx_cnstype on bccreditnotesub(mytype);
create index idx_cnsts on bccreditnotesub(transstate);
create index idx_cnsar on bccreditnotesub(arcode);
create table bcinvdebitnote1
(
	
	roworder autoincrement not null, 
	docdate datetime,
	arcode varchar(20),
	debitnoteno varchar(20),
	invoiceno varchar(20),
	returnstatus smallint,
	invoicedisc varchar(40),
	invexchangerate double ,
	newexchangerate double ,
	oldamount currency ,
	sumofitemamount currency ,
	discountamount currency ,
	diffamount currency ,
	zerotaxamount currency ,
	excepttaxamount currency ,
	trueamount currency ,
	homeamount1 currency ,
	homeamount2 currency ,
	transstate smallint,
	iscancel smallint,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcinvdebitnote1
(
	returnstatus smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	oldamount currency  0.0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	diffamount currency  0.0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	trueamount currency  0.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	exchangeprofit currency  0.0,
);


create index idx_invdb1_date on bcinvdebitnote1(docdate);
create index idx_invdb1_ar on bcinvdebitnote1(arcode);
create index idx_invdb1_no on bcinvdebitnote1(debitnoteno);
create index idx_invdb1_inv on bcinvdebitnote1(invoiceno);
create table bcdebitnote1
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	creditday smallint,
	duedate datetime,
	taxtype smallint,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	sumofitemamount currency ,
	sumoldamount currency ,
	sumtrueamount currency ,
	sumofdiffamount currency ,
	sumofbeforetax currency ,
	sumoftaxamount currency ,
	sumoftotaltax currency ,
	sumofexcepttax currency ,
	sumofzerotax currency ,
	sumofwtax currency ,
	discountword varchar(30),
	discountamount currency ,
	netdebtamount currency ,
	sumexchangeprofit currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	ispostgl smallint,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	returnstatus smallint,
	causetype smallint,
	causecode varchar(10),
	paybillstatus smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	paybillamount currency ,
	primary key(docno)
);

default on bcdebitnote1
(
	creditday smallint 0,
	taxtype smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	sumofitemamount currency  0.0,
	sumoldamount currency  0.0,
	sumtrueamount currency  0.0,
	sumofdiffamount currency  0.0,
	sumofbeforetax currency  0.0,
	sumoftaxamount currency  0.0,
	sumoftotaltax currency  0.0,
	sumofexcepttax currency  0.0,
	sumofzerotax currency  0.0,
	sumofwtax currency  0.0,
	discountamount currency  0.0,
	netdebtamount currency  0.0,
	sumexchangeprofit currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
	returnstatus smallint 0,
	causetype smallint 0,
	paybillstatus smallint 0,
	paybillamount currency  0.0,
);


create index idx_db1_date on bcdebitnote1(docdate);
create index idx_db1_ar on bcdebitnote1(arcode);
create index idx_db1_pbs on bcdebitnote1(paybillstatus);
create index idx_db1_bal on bcdebitnote1(billbalance);
create index idx_db1_row on bcdebitnote1(roworder);
create table bcdebitnotesub1
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	discqty currency ,
	tempqty currency ,
	billqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	sumofcost currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	invoiceno varchar(20),
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	stockprocess smallint,
	linenumber smallint,
	reflinenumber smallint,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	ispromotion smallint,
	premiumstatus smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcdebitnotesub1
(
	behindindex smallint 1,
	mytype smallint 6,
	taxtype smallint 0,
	discqty currency  0.0,
	tempqty currency  0.0,
	billqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	sumofcost currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	stockprocess smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	ispromotion smallint 0,
	premiumstatus smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_db1sno on bcdebitnotesub1(docno);
create index idx_db1sdate on bcdebitnotesub1(docdate);
create index idx_db1sitem on bcdebitnotesub1(itemcode);
create index idx_db1swh on bcdebitnotesub1(whcode);
create index idx_db1sshf on bcdebitnotesub1(shelfcode);
create index idx_db1stype on bcdebitnotesub1(mytype);
create index idx_db1sind on bcdebitnotesub1(behindindex);
create index idx_db1sts on bcdebitnotesub1(transstate);
create index idx_db1sar on bcdebitnotesub1(arcode);
create table bcsaleorder
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxtype smallint,
	billtype smallint,
	arcode varchar(20),
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	salecode varchar(10),
	deliveryaddr varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	refdocno varchar(20),
	billstatus smallint,
	sostatus smallint,
	holdingstatus smallint,
	crauthorizeman varchar(20),
	billgroup varchar(10),
	contactcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(30),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	excepttaxamount currency ,
	zerotaxamount currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	isconditionsend smallint,
	ownreceive varchar(100),
	carlicense varchar(30),
	approvecode varchar(10),
	approvedatetime datetime,
	isuserobotsale smallint,
	totaltransport currency ,
	printcount smallint,
	primary key(docno)
);

default on bcsaleorder
(
	taxtype smallint 0,
	billtype smallint 0,
	creditday smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billstatus smallint 0,
	sostatus smallint 0,
	holdingstatus smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	isconditionsend smallint 0,
	isuserobotsale smallint 0,
	totaltransport currency  0.0,
	printcount smallint 0,
);


create index idx_so_date on bcsaleorder(docdate);
create index idx_so_ar on bcsaleorder(arcode);
create index idx_so_due on bcsaleorder(duedate);
create index idx_so_bs on bcsaleorder(billstatus);
create index idx_so_row on bcsaleorder(roworder);
create table bcsaleordersub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	remainqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	unitcode varchar(10),
	oppositeprice2 currency ,
	oppositeunit varchar(10),
	oppositeqty currency ,
	stkreserveno varchar(20),
	sostatus smallint,
	holdingstatus smallint,
	reftype smallint,
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	ispromotion smallint,
	premiumstatus smallint,
	isuserobotsale smallint,
	isconditionsend smallint,
	transportamount currency ,
	primary key(roworder)
);

default on bcsaleordersub
(
	taxtype smallint 0,
	qty currency  0.0,
	remainqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	oppositeprice2 currency  0.0,
	oppositeqty currency  0.0,
	sostatus smallint 0,
	holdingstatus smallint 0,
	reftype smallint 0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	ispromotion smallint 0,
	premiumstatus smallint 0,
	isuserobotsale smallint 0,
	isconditionsend smallint 0,
	transportamount currency  0.0,
);


create index idx_sos_date on bcsaleordersub(docdate);
create index idx_sos_ar on bcsaleordersub(arcode);
create index idx_sos_sale on bcsaleordersub(salecode);
create index idx_sos_rqty on bcsaleordersub(remainqty);
create index idx_sos_ts on bcsaleordersub(transstate);
create index idx_sos_ref on bcsaleordersub(stkreserveno);
create table bcstkreserve
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxtype smallint,
	arcode varchar(20),
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	salecode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	billstatus smallint,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	billgroup varchar(10),
	contactcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(30),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	excepttaxamount currency ,
	zerotaxamount currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkreserve
(
	taxtype smallint 0,
	creditday smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billstatus smallint 0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
);


create index idx_sr_date on bcstkreserve(docdate);
create index idx_sr_ar on bcstkreserve(arcode);
create index idx_sr_due on bcstkreserve(duedate);
create index idx_sr_bs on bcstkreserve(billstatus);
create index idx_sr_row on bcstkreserve(roworder);
create table bcstkreservesub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	remainqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	quotationno varchar(20),
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	barcode varchar(20)
	,primary key(roworder)
);

default on bcstkreservesub
(
	taxtype smallint 0,
	qty currency  0.0,
	remainqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
);


create index idx_srs_date on bcstkreservesub(docdate);
create index idx_srs_ar on bcstkreservesub(arcode);
create index idx_srs_sale on bcstkreservesub(salecode);
create index idx_srs_rqty on bcstkreservesub(remainqty);
create index idx_srs_ts on bcstkreservesub(transstate);
create index idx_srs_ref on bcstkreservesub(quotationno);
create table bcquotation
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxtype smallint,
	arcode varchar(20),
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	subject varchar(100),
	enclosures varchar(100),
	validity smallint,
	salecode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription1 varchar(255),
	mydescription2 varchar(255),
	billstatus smallint,
	iscancel smallint,
	expirecredit smallint,
	callcheckdate datetime,
	expiredate datetime,
	customerassert smallint,
	assertstatus smallint,
	billgroup varchar(10),
	contactcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(30),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	excepttaxamount currency ,
	zerotaxamount currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	totaltransport currency ,
	billtype smallint,
	primary key(docno)
);

default on bcquotation
(
	taxtype smallint 0,
	creditday smallint 0,
	validity smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billstatus smallint 0,
	iscancel smallint 0,
	expirecredit smallint 0,
	customerassert smallint 0,
	assertstatus smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	totaltransport currency  0.0,
	billtype smallint 0,
);


create index idx_quo_date on bcquotation(docdate);
create index idx_quo_ar on bcquotation(arcode);
create index idx_quo_due on bcquotation(duedate);
create index idx_quo_bs on bcquotation(billstatus);
create index idx_quo_row on bcquotation(roworder);
create table bcquotationsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	remainqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	transstate smallint,
	iscancel smallint,
	unitcode varchar(10),
	oppositeprice2 currency ,
	oppositeunit varchar(10),
	oppositeqty currency ,
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	linenumber smallint,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	ispromotion smallint,
	premiumstatus smallint,
	quostatuscode varchar(10),
	isconditionsend smallint,
	transportamount currency ,
	primary key(roworder)
);

default on bcquotationsub
(
	taxtype smallint 0,
	qty currency  0.0,
	remainqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	oppositeprice2 currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	linenumber smallint 0,
	ispromotion smallint 0,
	premiumstatus smallint 0,
	isconditionsend smallint 0,
	transportamount currency  0.0,
);


create index idx_quos_date on bcquotationsub(docdate);
create index idx_quos_ar on bcquotationsub(arcode);
create index idx_quos_sale on bcquotationsub(salecode);
create index idx_quos_rqty on bcquotationsub(remainqty);
create table bcardeposituse
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	depositno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	balance currency ,
	amount currency ,
	depostaxtype smallint,
	netamount currency ,
	linenumber smallint,
	currencycode varchar(10),
	dpexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(docno,depositno)
);

default on bcardeposituse
(
	balance currency  0.0,
	amount currency  0.0,
	depostaxtype smallint 0,
	netamount currency  0.0,
	linenumber smallint 0,
	dpexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_ardu_no on bcardeposituse(docno);
create index idx_ardu_dno on bcardeposituse(depositno);
create index idx_ardu_date on bcardeposituse(docdate);
create table bcapdeposituse
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	depositno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	balance currency ,
	amount currency ,
	depostaxtype smallint,
	netamount currency ,
	currencycode varchar(10),
	linenumber smallint,
	dpexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(docno,depositno)
);

default on bcapdeposituse
(
	balance currency  0.0,
	amount currency  0.0,
	depostaxtype smallint 0,
	netamount currency  0.0,
	linenumber smallint 0,
	dpexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_apdu_no on bcapdeposituse(docno);
create index idx_apdu_dno on bcapdeposituse(depositno);
create index idx_apdu_date on bcapdeposituse(docdate);
create table bcardeposit
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxdate datetime,
	taxtype smallint,
	taxno varchar(20),
	arcode varchar(20),
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	salecode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	sumofwtax currency ,
	netamount currency ,
	billbalance currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	chargeamount currency ,
	refno varchar(20),
	currencycode varchar(10),
	exchangerate double ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	sumbankamount currency ,
	glformat varchar(5),
	ispostgl smallint,
	iscancel smallint,
	isreturnmoney smallint,
	gltransdata smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcardeposit
(
	taxtype smallint 0,
	creditday smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	sumofwtax currency  0.0,
	netamount currency  0.0,
	billbalance currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	chargeamount currency  0.0,
	exchangerate double  1.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	sumbankamount currency  0.0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isreturnmoney smallint 0,
	gltransdata smallint 0,
);


create index idx_ardep_date on bcardeposit(docdate);
create index idx_ardep_ar on bcardeposit(arcode);
create index idx_ardep_bal on bcardeposit(billbalance);
create table bcpaybill
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	departcode varchar(10),
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	mydescription varchar(255),
	billgroup varchar(10),
	creditday smallint,
	billstatus smallint,
	duedate datetime,
	payserviceonly smallint,
	printitemofbill smallint,
	isprocessok smallint,
	iscompletesave smallint,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	isprintauto smallint,
	canceldatetime datetime,
	paybillamount currency ,
	primary key(docno)
);

default on bcpaybill
(
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	creditday smallint 0,
	billstatus smallint 0,
	payserviceonly smallint 0,
	printitemofbill smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	isconfirm smallint 0,
	isprintauto smallint 0,
	paybillamount currency  0.0,
);


create index idx_pb_date on bcpaybill(docdate);
create index idx_pb_ar on bcpaybill(arcode);
create index idx_pb_bs on bcpaybill(billstatus);
create table bcpaybillsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	paybalance currency ,
	mydescription varchar(100),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	billtype smallint
	,primary key(roworder)
);

default on bcpaybillsub
(
	invbalance currency  0.0,
	payamount currency  0.0,
	paybalance currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
);


create index idx_pbs_no on bcpaybillsub(docno);
create index idx_pbs_date on bcpaybillsub(docdate);
create index idx_pbs_ar on bcpaybillsub(arcode);
create index idx_pbs_pbal on bcpaybillsub(paybalance);
create index idx_pbs_invn on bcpaybillsub(invoiceno);
create table bcreceipt1
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	departcode varchar(10),
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountamount currency ,
	netamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	chargeamount currency ,
	sumbankamount currency ,
	sumofwtax currency ,
	glformat varchar(5),
	iscancel smallint,
	ispostgl smallint,
	gltransdata smallint,
	mydescription varchar(255),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	isprocessok smallint,
	iscompletesave smallint,
	sumhomeamount1 currency ,
	sumhomeamount2 currency ,
	debtlimitreturn currency ,
	currencycode varchar(10),
	exchangerate double ,
	exchangeprofit currency ,
	otherincome currency ,
	otherexpense currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	isconfirm smallint,
	payserviceonly smallint,
	printitemofbill smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcreceipt1
(
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountamount currency  0.0,
	netamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	chargeamount currency  0.0,
	sumbankamount currency  0.0,
	sumofwtax currency  0.0,
	iscancel smallint 0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	sumhomeamount1 currency  0.0,
	sumhomeamount2 currency  0.0,
	debtlimitreturn currency  0.0,
	exchangerate double  1.0,
	exchangeprofit currency  0.0,
	otherincome currency  0.0,
	otherexpense currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	isconfirm smallint 0,
	payserviceonly smallint 0,
	printitemofbill smallint 0,
);


create index idx_rep1_date on bcreceipt1(docdate);
create index idx_rep1_ar on bcreceipt1(arcode);
create table bcrecbillitemsub
(
	
	roworder autoincrement not null, 
	rectype smallint,
	taxtype smallint,
	itemcode varchar(25),
	itemname varchar(250),
	departcode varchar(10),
	salecode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	docno varchar(20),
	docdate datetime,
	invoiceno varchar(20),
	qty currency ,
	unitcode varchar(10),
	price currency ,
	discountword varchar(35),
	amount currency ,
	netamount currency ,
	inctaxamount currency ,
	primary key(roworder)
);

default on bcrecbillitemsub
(
	rectype smallint 0,
	taxtype smallint 0,
	qty currency  0.0,
	price currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	inctaxamount currency  0.0,
);


create table bcreceiptsub1
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	debtlimitreturn currency ,
	debtlimitretdesc varchar(200),
	mydescription varchar(100),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	billtype smallint,
	refno varchar(20),
	reftype smallint,
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcreceiptsub1
(
	invbalance currency  0.0,
	payamount currency  0.0,
	debtlimitreturn currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	billtype smallint 0,
	reftype smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_reps1_no on bcreceiptsub1(docno);
create index idx_reps1_date on bcreceiptsub1(docdate);
create index idx_reps1_ar on bcreceiptsub1(arcode);
create index idx_reps1_ts on bcreceiptsub1(transstate);
create index idx_reps1_invno on bcreceiptsub1(invoiceno);
create table bcrecsubtemp
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	debtlimitreturn currency ,
	debtlimitretdesc varchar(200),
	mydescription varchar(100),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	billtype smallint,
	refno varchar(20),
	reftype smallint,
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcrecsubtemp
(
	invbalance currency  0.0,
	payamount currency  0.0,
	debtlimitreturn currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	billtype smallint 0,
	reftype smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_repst_no on bcrecsubtemp(docno);
create table bcreceipt2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	departcode varchar(10),
	payserviceonly smallint,
	printitemofbill smallint,
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountamount currency ,
	netamount currency ,
	mydescription varchar(255),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	sumhomeamount currency ,
	billstatus smallint,
	iscompletesave smallint,
	isprocessok smallint,
	currencycode varchar(10),
	exchangerate double ,
	exchangeprofit currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcreceipt2
(
	payserviceonly smallint 0,
	printitemofbill smallint 0,
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountamount currency  0.0,
	netamount currency  0.0,
	sumhomeamount currency  0.0,
	billstatus smallint 0,
	iscompletesave smallint 0,
	isprocessok smallint 0,
	exchangerate double  1.0,
	exchangeprofit currency  0.0,
	isconfirm smallint 0,
);


create index idx_rep2_date on bcreceipt2(docdate);
create index idx_rep2_ar on bcreceipt2(arcode);
create table bcreceiptsub2
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	mydescription varchar(100),
	billtype smallint,
	transstate smallint,
	iscancel smallint,
	paybillno varchar(20),
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	linenumber smallint,
	primary key(roworder)
);

default on bcreceiptsub2
(
	invbalance currency  0.0,
	payamount currency  0.0,
	billtype smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
	linenumber smallint 0,
);


create index idx_reps2_no on bcreceiptsub2(docno);
create index idx_reps2_date on bcreceiptsub2(docdate);
create index idx_reps2_ar on bcreceiptsub2(arcode);
create index idx_reps2_ts on bcreceiptsub2(transstate);
create index idx_reps2_invno on bcreceiptsub2(invoiceno);
create table bcreceipt3
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	departcode varchar(10),
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountamount currency ,
	netamount currency ,
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	mydescription varchar(255),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	isprocessok smallint,
	iscompletesave smallint,
	sumhomeamount1 currency ,
	sumhomeamount2 currency ,
	currencycode varchar(10),
	exchangerate double ,
	exchangeprofit currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcreceipt3
(
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountamount currency  0.0,
	netamount currency  0.0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	sumhomeamount1 currency  0.0,
	sumhomeamount2 currency  0.0,
	exchangerate double  1.0,
	exchangeprofit currency  0.0,
	isconfirm smallint 0,
);


create index idx_rep3_date on bcreceipt3(docdate);
create index idx_rep3_ar on bcreceipt3(arcode);
create table bcreceiptsub3
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	salecode varchar(10),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	mydescription varchar(100),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	billtype smallint,
	refno varchar(20),
	reftype smallint,
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcreceiptsub3
(
	invbalance currency  0.0,
	payamount currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	billtype smallint 0,
	reftype smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_reps3_no on bcreceiptsub3(docno);
create index idx_reps3_date on bcreceiptsub3(docdate);
create index idx_reps3_ar on bcreceiptsub3(arcode);
create index idx_reps3_ts on bcreceiptsub3(transstate);
create index idx_reps3_invno on bcreceiptsub3(invoiceno);
create table bcapdebttable
(
	
	roworder autoincrement not null, 
	apcode varchar(20) not null,
	periodno smallint,
	currencycode varchar(10) not null,
	debtamount currency ,
	chqonhand currency ,
	chqreturn currency ,
	primary key(apcode,periodno,currencycode)
);

default on bcapdebttable
(
	periodno smallint 0 not null,
	debtamount currency  0.0,
	chqonhand currency  0.0,
	chqreturn currency  0.0,
);


create table bcap
(
	
	roworder autoincrement not null, 
	code varchar(20) not null,
	name1 varchar(200) not null,
	name2 varchar(200),
	defdeliveryaddr varchar(10),
	defcontactcode varchar(10),
	address varchar(255),
	transportremark varchar(50),
	deftransport varchar(10),
	telephone varchar(50),
	fax varchar(50),
	accountcode varchar(20),
	idcardno varchar(30),
	bankaccno varchar(30),
	lastcontactdate datetime,
	lastpaydate datetime,
	creditday smallint,
	detaildiscount varchar(35),
	discount varchar(35),
	cashdiscount varchar(35),
	leadtime smallint,
	debtlimit currency ,
	debtamount currency ,
	chqonhand currency ,
	chqreturn currency ,
	defaulttaxrate currency ,
	taxno varchar(20),
	paymentremark varchar(50),
	statementremark varchar(50),
	picfilename varchar(50),
	typecode varchar(10),
	emailaddress varchar(40),
	groupcode varchar(10),
	groupofdebt varchar(10),
	persontype smallint,
	ismaketrans smallint,
	activestatus smallint,
	mapcode varchar(10),
	mapposition_x smallint,
	mapposition_y smallint,
	itemdescgroup smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(code)
);

default on bcap
(
	creditday smallint 0,
	leadtime smallint 0,
	debtlimit currency  0.0,
	debtamount currency  0.0,
	chqonhand currency  0.0,
	chqreturn currency  0.0,
	defaulttaxrate currency  7.0,
	ismaketrans smallint 0,
	activestatus smallint 1,
	mapposition_x smallint 0,
	mapposition_y smallint 0,
	itemdescgroup smallint 0,
);


create index idx_ap_act on bcap(activestatus);
create table bcpaymoney
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	apcode varchar(20),
	currencycode varchar(10),
	exchangerate double ,
	payamount currency ,
	homeamount currency ,
	chqtotalamount currency ,
	paymenttype smallint,
	savefrom smallint,
	paychqstate smallint,
	linenumber smallint,
	refno varchar(30),
	bookno varchar(30),
	bankcode varchar(10),
	bankbranchcode varchar(10),
	transbankdate datetime,
	mydescription varchar(100),
	projectcode varchar(10),
	departcode varchar(10),
	refdate datetime
	,primary key(roworder)
);

default on bcpaymoney
(
	exchangerate double  1.0,
	payamount currency  0.0,
	homeamount currency  0.0,
	chqtotalamount currency  0.0,
	paymenttype smallint 0,
	savefrom smallint 0,
	paychqstate smallint 0,
	linenumber smallint 0,
);


create index idx_paym_date on bcpaymoney(docdate);
create index idx_paym_ap on bcpaymoney(apcode);
create index idx_paym_pty on bcpaymoney(paymenttype);
create table bcapperiodstate
(
	
	roworder autoincrement not null, 
	apcode varchar(20) not null,
	periodno smallint,
	beginamount currency ,
	debtamount currency ,
	cnamount currency ,
	debitamount currency ,
	paymentamount currency ,
	endamount currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcapperiodstate
(
	periodno smallint 0,
	beginamount currency  0.0,
	debtamount currency  0.0,
	cnamount currency  0.0,
	debitamount currency  0.0,
	paymentamount currency  0.0,
	endamount currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_appsap on bcapperiodstate(apcode);
create index idx_appspno on bcapperiodstate(periodno);
create table bcapinvbalance
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	apcode varchar(20) not null,
	departcode varchar(10) ,
	creditday smallint,
	duedate datetime,
	statementdate datetime,
	statementstate smallint,
	isconfirm smallint,
	mydescription varchar(255),
	billgroup varchar(10),
	contactcode varchar(10),
	netdebtamount currency ,
	billbalance currency ,
	billtype smallint,
	currencycode varchar(10),
	exchangerate double ,
	allocatecode varchar(10),
	projectcode varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcapinvbalance
(
	creditday smallint 0,
	statementstate smallint 0,
	isconfirm smallint 0,
	netdebtamount currency  0.0,
	billbalance currency  0.0,
	billtype smallint 0,
	exchangerate double  1.0,
);


create index idx_apinvbdate on bcapinvbalance(docdate);
create index idx_apinvbdue on bcapinvbalance(duedate);
create index idx_apinvbarcd on bcapinvbalance(apcode);
create index idx_apinvbdep on bcapinvbalance(departcode);
create index idx_apinvbbal on bcapinvbalance(billbalance);
create index idx_apinvbbs on bcapinvbalance(statementstate);
create table bcapotherdebt
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	apcode varchar(20) not null,
	glbookcode varchar(5),
	ispostgl smallint,
	sumofdebit currency ,
	sumofcredit currency ,
	departcode varchar(10) ,
	creditday smallint,
	duedate datetime,
	paybilldate datetime,
	isconfirm smallint,
	statementstate smallint,
	mydescription varchar(255),
	billgroup varchar(10),
	contactcode varchar(10),
	netdebtamount currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	iscancel smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcapotherdebt
(
	ispostgl smallint 0,
	sumofdebit currency  0.0,
	sumofcredit currency  0.0,
	creditday smallint 0,
	isconfirm smallint 0,
	statementstate smallint 0,
	netdebtamount currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	iscancel smallint 0,
);


create index idx_apodbs on bcapotherdebt(statementstate);
create index idx_apodbal on bcapotherdebt(billbalance);
create index idx_apodap on bcapotherdebt(apcode);
create index idx_apoddue on bcapotherdebt(duedate);
create table bcgoodsreccheck
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	apcode varchar(20) not null,
	mydescription varchar(255),
	serviceremark varchar(255),
	billgroup varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);
create index idx_gdrcdate on bcgoodsreccheck(docdate);
create index idx_gdrcarcd on bcgoodsreccheck(apcode);
create index idx_gdrcrow on bcgoodsreccheck(roworder);
create table bcgoodsrecchksub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	apcode varchar(20),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	perfectqty currency ,
	badqty currency ,
	brokenqty currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	porefno varchar(20),
	linenumber smallint,
	primary key(roworder)
);

default on bcgoodsrecchksub
(
	qty currency  0.0,
	perfectqty currency  0.0,
	badqty currency  0.0,
	brokenqty currency  0.0,
	oppositeqty currency  0.0,
	linenumber smallint 0,
);


create index idx_gdrsdate on bcgoodsrecchksub(docdate);
create index idx_gdrsarcd on bcgoodsrecchksub(apcode);
create index idx_gdrsitem on bcgoodsrecchksub(itemcode);
create table bcapinvoice
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime not null,
	taxtype smallint,
	apcode varchar(20) not null,
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	statementdate datetime,
	statementstate smallint,
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	billtype smallint,
	billgroup varchar(10),
	contactcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(35),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	excepttaxamount currency ,
	zerotaxamount currency ,
	pettycashamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumbankamount currency ,
	depositinctax smallint,
	sumofdeposit1 currency ,
	sumofdeposit2 currency ,
	sumofwtax currency ,
	netdebtamount currency ,
	homeamount currency ,
	otherincome currency ,
	otherexpense currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	grbillstatus smallint,
	grirbillstatus smallint,
	ispostgl smallint,
	iscancel smallint,
	iscreditnote smallint,
	isdebitnote smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	exchangeprofit currency ,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	remark1 varchar(30),
	remark2 varchar(30),
	remark3 varchar(30),
	remark4 varchar(30),
	remark5 varchar(30),
	ownertransport varchar(20)
	,primary key(docno)
);

default on bcapinvoice
(
	taxtype smallint 0,
	departcode varchar 10  '^bc',
	creditday smallint 0,
	statementstate smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billtype smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	pettycashamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumbankamount currency  0.0,
	depositinctax smallint 1,
	sumofdeposit1 currency  0.0,
	sumofdeposit2 currency  0.0,
	sumofwtax currency  0.0,
	netdebtamount currency  0.0,
	homeamount currency  0.0,
	otherincome currency  0.0,
	otherexpense currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	grbillstatus smallint 0,
	grirbillstatus smallint 0,
	ispostgl smallint 0,
	iscancel smallint 0,
	iscreditnote smallint 0,
	isdebitnote smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
	exchangeprofit currency  0.0,
);


create index idx_apinvdate on bcapinvoice(docdate);
create index idx_apinvdue on bcapinvoice(duedate);
create index idx_apinvarcd on bcapinvoice(apcode);
create index idx_apinvdep on bcapinvoice(departcode);
create index idx_apinvbal on bcapinvoice(billbalance);
create index idx_apinvps on bcapinvoice(statementstate);
create index idx_apinvbt on bcapinvoice(billtype);
create index idx_apinvrow on bcapinvoice(roworder);
create table bcapinvoicesub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	cnqty currency ,
	grremainqty currency ,
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	balanceamount currency ,
	sumofexpcost currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	porefno varchar(20),
	irrefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	barcode varchar(20),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	ispromotion smallint,
	poreflinenum smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	statusreceive smallint,
	primary key(roworder)
);

default on bcapinvoicesub
(
	behindindex smallint 1,
	mytype smallint 2,
	taxtype smallint 0,
	cnqty currency  0.0,
	grremainqty currency  0.0,
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	balanceamount currency  0.0,
	sumofexpcost currency  0.0,
	oppositeqty currency  0.0,
	stocktype smallint 0,
	excepttax smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	exchangerate double  1.0,
	ispromotion smallint 0,
	poreflinenum smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
	statusreceive smallint 0,
);


create index idx_apinvsdate on bcapinvoicesub(docdate);
create index idx_apinvsarcd on bcapinvoicesub(apcode);
create index idx_apinvsardep on bcapinvoicesub(departcode);
create index idx_apinvsind on bcapinvoicesub(behindindex);
create index idx_apinvstype on bcapinvoicesub(mytype);
create index idx_apinvsitem on bcapinvoicesub(itemcode);
create index idx_apinvswh on bcapinvoicesub(whcode);
create index idx_apinvsshlf on bcapinvoicesub(shelfcode);
create index idx_apinvsbnd on bcapinvoicesub(brandcode);
create index idx_apinvsgrp on bcapinvoicesub(groupcode);
create index idx_apinvstypec on bcapinvoicesub(typecode);
create index idx_apinvsfrm on bcapinvoicesub(formatcode);
create index idx_apinvsts on bcapinvoicesub(transstate);
create table bcirsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	cnqty currency ,
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	balanceamount currency ,
	sumofexpcost currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	grrefno varchar(20),
	porefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	barcode varchar(20),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	ispromotion smallint,
	poreflinenum smallint,
	grreflinenum smallint,
	itemname varchar(255)
	,primary key(roworder)
);

default on bcirsub
(
	taxtype smallint 0,
	cnqty currency  0.0,
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	balanceamount currency  0.0,
	sumofexpcost currency  0.0,
	oppositeqty currency  0.0,
	stocktype smallint 0,
	excepttax smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	exchangerate double  1.0,
	ispromotion smallint 0,
);


create index idx_irsdate on bcirsub(docdate);
create index idx_irscd on bcirsub(apcode);
create index idx_irsdep on bcirsub(departcode);
create index idx_irsitem on bcirsub(itemcode);
create index idx_irswh on bcirsub(whcode);
create index idx_irsshlf on bcirsub(shelfcode);
create index idx_irsbnd on bcirsub(brandcode);
create index idx_irsgrp on bcirsub(groupcode);
create index idx_irsstypec on bcirsub(typecode);
create index idx_irsfrm on bcirsub(formatcode);
create index idx_irsts on bcirsub(transstate);
create table bcweightcost
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	refdocno varchar(20),
	expdescription varchar(100),
	weightby smallint,
	weightamount currency ,
	makername varchar(100),
	frompo varchar(20),
	topo varchar(20),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime
	,primary key(docno)
);

default on bcweightcost
(
	weightby smallint 0,
	weightamount currency  0.0,
);


create index idx_wcost_date on bcweightcost(docdate);
create table bcweightcostsub
(
	
	roworder autoincrement not null, 
	buydocno varchar(20),
	docdate datetime,
	expcostno varchar(20),
	refdocno varchar(20),
	itemcode varchar(25),
	itemqty currency ,
	itemamount currency ,
	billlinenumber smallint,
	expdescription varchar(100),
	linenumber smallint,
	billroworder int,
	amount currency ,
	primary key(roworder)
);

default on bcweightcostsub
(
	itemqty currency  0.0,
	itemamount currency  0.0,
	billlinenumber smallint 0,
	linenumber smallint 0,
	billroworder int 0,
	amount currency  0.0,
);


create index idx_wcosts_no on bcweightcostsub(buydocno);
create index idx_wcosts_bl on bcweightcostsub(billlinenumber);
create index idx_wcosts_im on bcweightcostsub(itemcode);
create table bcinvstkrefund
(
	
	roworder autoincrement not null, 
	docdate datetime,
	apcode varchar(20),
	stkrefundno varchar(20),
	returnmoney smallint,
	returnstatus smallint,
	invoiceno varchar(20),
	invoicedisc varchar(40),
	invexchangerate double ,
	newexchangerate double ,
	oldamount currency ,
	sumofitemamount currency ,
	discountamount currency ,
	diffamount currency ,
	zerotaxamount currency ,
	excepttaxamount currency ,
	trueamount currency ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	transstate smallint,
	iscancel smallint,
	billtype smallint,
	primary key(roworder)
);

default on bcinvstkrefund
(
	returnmoney smallint 0,
	returnstatus smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	oldamount currency  0.0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	diffamount currency  0.0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	trueamount currency  0.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	billtype smallint 0,
);


create index idx_invstkr_date on bcinvstkrefund(docdate);
create index idx_invstkr_ap on bcinvstkrefund(apcode);
create index idx_invstkr_no on bcinvstkrefund(stkrefundno);
create index idx_invstkr_inv on bcinvstkrefund(invoiceno);
create table bcstkrefund
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	duedate datetime,
	taxtype smallint,
	apcode varchar(20),
	departcode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	sumofitemamount currency ,
	sumoldamount currency ,
	sumtrueamount currency ,
	sumofdiffamount currency ,
	discountword varchar(30),
	discountamount currency ,
	sumofbeforetax currency ,
	sumoftaxamount currency ,
	sumoftotaltax currency ,
	sumofexcepttax currency ,
	sumofzerotax currency ,
	sumofwtax currency ,
	netdebtamount currency ,
	sumexchangeprofit currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	ispostgl smallint,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	returnmoney smallint,
	returnstatus smallint,
	statementstate smallint,
	billtype smallint,
	causetype smallint,
	causecode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkrefund
(
	taxtype smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	sumofitemamount currency  0.0,
	sumoldamount currency  0.0,
	sumtrueamount currency  0.0,
	sumofdiffamount currency  0.0,
	discountamount currency  0.0,
	sumofbeforetax currency  0.0,
	sumoftaxamount currency  0.0,
	sumoftotaltax currency  0.0,
	sumofexcepttax currency  0.0,
	sumofzerotax currency  0.0,
	sumofwtax currency  0.0,
	netdebtamount currency  0.0,
	sumexchangeprofit currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
	returnmoney smallint 0,
	returnstatus smallint 0,
	statementstate smallint 0,
	billtype smallint 0,
	causetype smallint 0,
);


create index idx_stkr_date on bcstkrefund(docdate);
create index idx_stkr_ap on bcstkrefund(apcode);
create index idx_stkr_pbs on bcstkrefund(statementstate);
create index idx_stkr_bal on bcstkrefund(billbalance);
create index idx_stkr_row on bcstkrefund(roworder);
create table bcstkrefundsub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	discqty currency ,
	tempqty currency ,
	billqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	invoiceno varchar(20),
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	stockprocess smallint,
	linenumber smallint,
	reflinenumber smallint,
	barcode varchar(20),
	ispromotion smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcstkrefundsub
(
	behindindex smallint 1,
	mytype smallint 7,
	taxtype smallint 0,
	discqty currency  0.0,
	tempqty currency  0.0,
	billqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	stockprocess smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	ispromotion smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_stkrsdate on bcstkrefundsub(docdate);
create index idx_stkrsitem on bcstkrefundsub(itemcode);
create index idx_stkrswh on bcstkrefundsub(whcode);
create index idx_stkrsshf on bcstkrefundsub(shelfcode);
create index idx_stkrsind on bcstkrefundsub(behindindex);
create index idx_stkrstype on bcstkrefundsub(mytype);
create index idx_stkrsts on bcstkrefundsub(transstate);
create index idx_stkrsap on bcstkrefundsub(apcode);
create table bcinvdebitnote2
(
	
	roworder autoincrement not null, 
	docdate datetime,
	apcode varchar(20),
	debitnoteno varchar(20),
	returnstatus smallint,
	invoiceno varchar(20),
	invoicedisc varchar(40),
	invexchangerate double ,
	newexchangerate double ,
	oldamount currency ,
	sumofitemamount currency ,
	discountamount currency ,
	diffamount currency ,
	zerotaxamount currency ,
	excepttaxamount currency ,
	trueamount currency ,
	homeamount1 currency ,
	homeamount2 currency ,
	transstate smallint,
	iscancel smallint,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcinvdebitnote2
(
	returnstatus smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	oldamount currency  0.0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	diffamount currency  0.0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	trueamount currency  0.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	exchangeprofit currency  0.0,
);


create index idx_invdb2_date on bcinvdebitnote2(docdate);
create index idx_invdb2_ap on bcinvdebitnote2(apcode);
create index idx_invdb2_no on bcinvdebitnote2(debitnoteno);
create index idx_invdb2_inv on bcinvdebitnote2(invoiceno);
create table bcdebitnote2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	creditday smallint,
	duedate datetime,
	taxtype smallint,
	apcode varchar(20),
	departcode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	sumofitemamount currency ,
	sumoldamount currency ,
	sumtrueamount currency ,
	sumofdiffamount currency ,
	sumofbeforetax currency ,
	sumoftaxamount currency ,
	sumoftotaltax currency ,
	sumofexcepttax currency ,
	sumofzerotax currency ,
	sumofwtax currency ,
	discountword varchar(30),
	discountamount currency ,
	netdebtamount currency ,
	sumexchangeprofit currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	ispostgl smallint,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	gltransdata smallint,
	returnstatus smallint,
	statementstate smallint,
	causetype smallint,
	causecode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcdebitnote2
(
	creditday smallint 0,
	taxtype smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	sumofitemamount currency  0.0,
	sumoldamount currency  0.0,
	sumtrueamount currency  0.0,
	sumofdiffamount currency  0.0,
	sumofbeforetax currency  0.0,
	sumoftaxamount currency  0.0,
	sumoftotaltax currency  0.0,
	sumofexcepttax currency  0.0,
	sumofzerotax currency  0.0,
	sumofwtax currency  0.0,
	discountamount currency  0.0,
	netdebtamount currency  0.0,
	sumexchangeprofit currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	gltransdata smallint 0,
	returnstatus smallint 0,
	statementstate smallint 0,
	causetype smallint 0,
);


create index idx_db2_date on bcdebitnote2(docdate);
create index idx_db2_ap on bcdebitnote2(apcode);
create index idx_db2_pbs on bcdebitnote2(statementstate);
create index idx_db2_bal on bcdebitnote2(billbalance);
create index idx_db2_row on bcdebitnote2(roworder);
create table bcdebitnotesub2
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	mydescription varchar(100),
	whcode varchar(10),
	shelfcode varchar(15),
	discqty currency ,
	tempqty currency ,
	billqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	invoiceno varchar(20),
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	stockprocess smallint,
	linenumber smallint,
	reflinenumber smallint,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	ispromotion smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	averagecost currency ,
	primary key(roworder)
);

default on bcdebitnotesub2
(
	behindindex smallint 1,
	mytype smallint 3,
	taxtype smallint 0,
	discqty currency  0.0,
	tempqty currency  0.0,
	billqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	stockprocess smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	ispromotion smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
	averagecost currency  0.0,
);


create index idx_db2sdate on bcdebitnotesub2(docdate);
create index idx_db2sitem on bcdebitnotesub2(itemcode);
create index idx_db2swh on bcdebitnotesub2(whcode);
create index idx_db2sshf on bcdebitnotesub2(shelfcode);
create index idx_db2sind on bcdebitnotesub2(behindindex);
create index idx_db2stype on bcdebitnotesub2(mytype);
create index idx_db2sts on bcdebitnotesub2(transstate);
create index idx_db2sap on bcdebitnotesub2(apcode);
create table bcpurchaseorder
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxtype smallint,
	apcode varchar(20),
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	leadtime smallint,
	leaddate datetime,
	expirecredit smallint,
	expiredate datetime ,
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	postatus smallint,
	billstatus smallint,
	iscancel smallint,
	iscompletesave smallint,
	isprocessok smallint,
	billgroup varchar(15),
	contactcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(30),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	excepttaxamount currency ,
	zerotaxamount currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	isconditionsend smallint,
	ordertoarcode varchar(20)
	,primary key(docno)
);

default on bcpurchaseorder
(
	taxtype smallint 0,
	creditday smallint 0,
	leadtime smallint 0,
	expirecredit smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	postatus smallint 0,
	billstatus smallint 0,
	iscancel smallint 0,
	iscompletesave smallint 0,
	isprocessok smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	isconditionsend smallint 0,
);


create index idx_po_date on bcpurchaseorder(docdate);
create index idx_po_ap on bcpurchaseorder(apcode);
create index idx_po_due on bcpurchaseorder(duedate);
create index idx_po_bs on bcpurchaseorder(billstatus);
create index idx_po_row on bcpurchaseorder(roworder);
create table bcpurchaseordersub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	mydescription varchar(100),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	remainqty currency ,
	price currency ,
	discountword varchar(30),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	stkreqno varchar(20),
	confirmno varchar(20),
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	barcode varchar(20),
	ispromotion smallint,
	primary key(roworder)
);

default on bcpurchaseordersub
(
	taxtype smallint 0,
	qty currency  0.0,
	remainqty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	ispromotion smallint 0,
);


create index idx_pos_date on bcpurchaseordersub(docdate);
create index idx_pos_ap on bcpurchaseordersub(apcode);
create index idx_pos_rqty on bcpurchaseordersub(remainqty);
create index idx_pos_ts on bcpurchaseordersub(transstate);
create index idx_pos_ref on bcpurchaseordersub(stkreqno);
create table bcstkrequest
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxtype smallint,
	departcode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	workman varchar(100),
	billstatus smallint,
	iscancel smallint,
	billgroup varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstkrequest
(
	taxtype smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billstatus smallint 0,
	iscancel smallint 0,
);


create index idx_srq_date on bcstkrequest(docdate);
create index idx_srq_bs on bcstkrequest(billstatus);
create index idx_srq_row on bcstkrequest(roworder);
create table bcstkrequestsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(100),
	qty currency ,
	remainqty currency ,
	transstate smallint,
	iscancel smallint,
	priority smallint,
	wantday smallint,
	wantdate datetime,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	itemtype smallint,
	excepttax smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	linenumber smallint,
	barcode varchar(20)
	,primary key(roworder)
);

default on bcstkrequestsub
(
	taxtype smallint 0,
	qty currency  0.0,
	remainqty currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	priority smallint 0,
	wantday smallint 0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	exchangerate double  1.0,
	linenumber smallint 0,
);


create index idx_srqs_date on bcstkrequestsub(docdate);
create index idx_srqs_doc on bcstkrequestsub(docno);
create index idx_srqs_rqty on bcstkrequestsub(remainqty);
create table bcreqconfirm
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	confirmname varchar(100),
	mydescription varchar(255),
	billstatus smallint,
	creatorcode varchar(10),
	createdatetime datetime
	,primary key(docno)
);

default on bcreqconfirm
(
	billstatus smallint 0,
);


create table bcreqconfirmsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	itemcode varchar(25),
	stkrequestno varchar(20),
	departcode varchar(10),
	mydescription varchar(100),
	qty currency ,
	confirmqty currency ,
	remainqty currency ,
	unitcode varchar(10),
	transstate smallint,
	oppositeunit varchar(10),
	oppositeqty currency ,
	itemtype smallint,
	excepttax smallint,
	linenumber smallint,
	barcode varchar(20)
	,primary key(roworder)
);

default on bcreqconfirmsub
(
	qty currency  0.0,
	confirmqty currency  0.0,
	remainqty currency  0.0,
	transstate smallint 0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	linenumber smallint 0,
);


create table bcenquireprice
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	reqconfirmno varchar(20) ,
	billstatus smallint,
	docdate datetime,
	mydescription varchar(255),
	creatorcode varchar(10),
	createdatetime datetime
	,primary key(docno)
);

default on bcenquireprice
(
	billstatus smallint 0,
);


create table bcenquirepricesub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	stkrequestno varchar(20),
	departcode varchar(10),
	suppliercode varchar(20),
	itemcode varchar(25),
	mydescription varchar(100),
	qty currency ,
	unitcode varchar(10),
	transstate smallint,
	oppositeunit varchar(10),
	oppositeqty currency ,
	itemtype smallint,
	excepttax smallint,
	linenumber smallint,
	barcode varchar(20)
	,primary key(roworder)
);

default on bcenquirepricesub
(
	qty currency  0.0,
	transstate smallint 0,
	oppositeqty currency  0.0,
	itemtype smallint 0,
	excepttax smallint 0,
	linenumber smallint 0,
);


create table bcapdeposit
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	taxdate datetime,
	taxtype smallint,
	taxno varchar(20),
	apcode varchar(20),
	departcode varchar(10),
	creditday smallint,
	duedate datetime,
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	netamount currency ,
	sumofwtax currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	billbalance currency ,
	refno varchar(20),
	currencycode varchar(10),
	exchangerate double ,
	pettycashamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	sumbankamount currency ,
	glformat varchar(5),
	ispostgl smallint,
	iscancel smallint,
	isreturnmoney smallint,
	gltransdata smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcapdeposit
(
	taxtype smallint 0,
	creditday smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	netamount currency  0.0,
	sumofwtax currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	pettycashamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	sumbankamount currency  0.0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isreturnmoney smallint 0,
	gltransdata smallint 0,
);


create index idx_apdep_date on bcapdeposit(docdate);
create index idx_apdep_ap on bcapdeposit(apcode);
create index idx_apdep_bal on bcapdeposit(billbalance);
create table bcstatement
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	mydescription varchar(255),
	billgroup varchar(10),
	billstatus smallint,
	creditday smallint,
	iscompletesave smallint,
	isprocessok smallint,
	duedate datetime,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcstatement
(
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	billstatus smallint 0,
	creditday smallint 0,
	iscompletesave smallint 0,
	isprocessok smallint 0,
	isconfirm smallint 0,
);


create index idx_stm_date on bcstatement(docdate);
create index idx_stm_ap on bcstatement(apcode);
create index idx_stm_bs on bcstatement(billstatus);
create table bcstatementsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	apcode varchar(20),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	paybalance currency ,
	mydescription varchar(100),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	billtype smallint
	,primary key(roworder)
);

default on bcstatementsub
(
	invbalance currency  0.0,
	payamount currency  0.0,
	paybalance currency  0.0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
);


create index idx_stms_no on bcstatementsub(docno);
create index idx_stms_date on bcstatementsub(docdate);
create index idx_stms_ap on bcstatementsub(apcode);
create index idx_stms_pbal on bcstatementsub(paybalance);
create index idx_stms_invn on bcstatementsub(invoiceno);
create table bcpayment
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountamount currency ,
	netamount currency ,
	pettycashamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumbankamount currency ,
	sumofwtax currency ,
	glformat varchar(5),
	iscancel smallint,
	ispostgl smallint,
	gltransdata smallint,
	mydescription varchar(255),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	sumhomeamount1 currency ,
	sumhomeamount2 currency ,
	otherincome currency ,
	otherexpense currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	currencycode varchar(10),
	exchangerate double ,
	exchangeprofit currency ,
	isprocessok smallint,
	iscompletesave smallint,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcpayment
(
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountamount currency  0.0,
	netamount currency  0.0,
	pettycashamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumbankamount currency  0.0,
	sumofwtax currency  0.0,
	iscancel smallint 0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumhomeamount1 currency  0.0,
	sumhomeamount2 currency  0.0,
	otherincome currency  0.0,
	otherexpense currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	exchangerate double  1.0,
	exchangeprofit currency  0.0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	isconfirm smallint 0,
);


create index idx_pym_date on bcpayment(docdate);
create index idx_pym_ap on bcpayment(apcode);
create table bcpaymentsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	apcode varchar(20),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	mydescription varchar(100),
	billtype smallint,
	paybillno varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcpaymentsub
(
	invbalance currency  0.0,
	payamount currency  0.0,
	billtype smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_pyms_no on bcpaymentsub(docno);
create index idx_pyms_date on bcpaymentsub(docdate);
create index idx_pyms_ap on bcpaymentsub(apcode);
create index idx_pyms_ts on bcpaymentsub(transstate);
create index idx_pyms_invno on bcpaymentsub(invoiceno);
create table bcpaysubtemp
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	apcode varchar(20),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	mydescription varchar(100),
	billtype smallint,
	paybillno varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcpaysubtemp
(
	invbalance currency  0.0,
	payamount currency  0.0,
	billtype smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_pymst_no on bcpaysubtemp(docno);
create table bcpayment2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	taxno varchar(20),
	docdate datetime,
	apcode varchar(20),
	departcode varchar(10),
	sumofinvoice currency ,
	sumofdebitnote currency ,
	sumofcreditnote currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountamount currency ,
	netamount currency ,
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	mydescription varchar(255),
	allocatecode varchar(10),
	projectcode varchar(10),
	billgroup varchar(10),
	sumhomeamount1 currency ,
	sumhomeamount2 currency ,
	currencycode varchar(10),
	exchangerate double ,
	exchangeprofit currency ,
	isprocessok smallint,
	iscompletesave smallint,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcpayment2
(
	sumofinvoice currency  0.0,
	sumofdebitnote currency  0.0,
	sumofcreditnote currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountamount currency  0.0,
	netamount currency  0.0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumhomeamount1 currency  0.0,
	sumhomeamount2 currency  0.0,
	exchangerate double  1.0,
	exchangeprofit currency  0.0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	isconfirm smallint 0,
);


create index idx_pym2_date on bcpayment2(docdate);
create index idx_pym2_ap on bcpayment2(apcode);
create table bcpaymentsub2
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	apcode varchar(20),
	invoicedate datetime,
	invoiceno varchar(20),
	invbalance currency ,
	payamount currency ,
	mydescription varchar(100),
	billtype smallint,
	paybillno varchar(20),
	transstate smallint,
	iscancel smallint,
	linenumber smallint,
	invcurrency varchar(10),
	invexchangerate double ,
	newexchangerate double ,
	homeamount1 currency ,
	homeamount2 currency ,
	exchangeprofit currency ,
	primary key(roworder)
);

default on bcpaymentsub2
(
	invbalance currency  0.0,
	payamount currency  0.0,
	billtype smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	invexchangerate double  1.0,
	newexchangerate double  1.0,
	homeamount1 currency  0.0,
	homeamount2 currency  0.0,
	exchangeprofit currency  0.0,
);


create index idx_pyms2_no on bcpaymentsub2(docno);
create index idx_pyms2_date on bcpaymentsub2(docdate);
create index idx_pyms2_ap on bcpaymentsub2(apcode);
create index idx_pyms2_ts on bcpaymentsub2(transstate);
create index idx_pyms2_invno on bcpaymentsub2(invoiceno);
create table bcchqin
(
	
	roworder autoincrement not null, 
	bankcode varchar(10),
	chqnumber varchar(20),
	docno varchar(20),
	arcode varchar(20),
	extendstatus varchar(10),
	salecode varchar(10),
	receivedate datetime,
	duedate datetime,
	bookno varchar(30),
	status smallint,
	savefrom smallint,
	statusdate datetime,
	statusdocno varchar(20),
	departcode varchar(10),
	bankbranchcode varchar(10),
	amount currency ,
	balance currency ,
	mydescription varchar(100),
	chqusestatus smallint,
	currencycode varchar(10),
	exchangerate double ,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(roworder)
);

default on bcchqin
(
	status smallint 0,
	savefrom smallint 0,
	amount currency  0.0,
	balance currency  0.0,
	chqusestatus smallint 0,
	exchangerate double  1.0,
);


create index idx_chqi_bank on bcchqin(bankcode);
create index idx_chqi_no on bcchqin(chqnumber);
create index idx_chqi_dno on bcchqin(docno);
create index idx_chqi_ar on bcchqin(arcode);
create index idx_chqi_sale on bcchqin(salecode);
create index idx_chqi_red on bcchqin(receivedate);
create index idx_chqi_due on bcchqin(duedate);
create index idx_chqi_bno on bcchqin(bookno);
create index idx_chqi_st on bcchqin(status);
create table bcchqout
(
	
	roworder autoincrement not null, 
	bankcode varchar(10),
	chqnumber varchar(20),
	docno varchar(20),
	apcode varchar(20),
	extendstatus varchar(10),
	paymentdate datetime,
	duedate datetime,
	bookno varchar(30),
	status smallint,
	savefrom smallint,
	statusdate datetime,
	statusdocno varchar(20),
	departcode varchar(10),
	bankbranchcode varchar(10),
	amount currency ,
	balance currency ,
	mydescription varchar(100),
	chqusestatus smallint,
	currencycode varchar(10),
	exchangerate double ,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(roworder)
);

default on bcchqout
(
	status smallint 0,
	savefrom smallint 0,
	amount currency  0.0,
	balance currency  0.0,
	chqusestatus smallint 0,
	exchangerate double  1.0,
);


create index idx_chqo_bank on bcchqout(bankcode);
create index idx_chqo_no on bcchqout(chqnumber);
create index idx_chqo_dno on bcchqout(docno);
create index idx_chqo_ap on bcchqout(apcode);
create index idx_chqo_pyd on bcchqout(paymentdate);
create index idx_chqo_due on bcchqout(duedate);
create index idx_chqo_bno on bcchqout(bookno);
create index idx_chqo_st on bcchqout(status);
create table bccreditcard
(
	
	roworder autoincrement not null, 
	bankcode varchar(10),
	creditcardno varchar(20),
	docno varchar(20),
	arcode varchar(20),
	salecode varchar(10),
	receivedate datetime,
	duedate datetime,
	bookno varchar(30),
	status smallint,
	savefrom smallint,
	statusdate datetime,
	statusdocno varchar(20),
	departcode varchar(10),
	bankbranchcode varchar(10),
	amount currency ,
	mydescription varchar(100),
	currencycode varchar(10),
	exchangerate double ,
	credittype varchar(10),
	confirmno varchar(20),
	chargeamount currency ,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	creditvatrate currency ,
	creditvat currency ,
	creditsumvat currency ,
	primary key(roworder)
);

default on bccreditcard
(
	status smallint 0,
	savefrom smallint 0,
	amount currency  0.0,
	exchangerate double  1.0,
	chargeamount currency  0.0,
	creditvatrate currency  0.0,
	creditvat currency  0.0,
	creditsumvat currency  0.0,
);


create index idx_crd_bank on bccreditcard(bankcode);
create index idx_crd_no on bccreditcard(creditcardno);
create index idx_crd_dno on bccreditcard(docno);
create index idx_crd_ar on bccreditcard(arcode);
create index idx_crd_sale on bccreditcard(salecode);
create index idx_crd_red on bccreditcard(receivedate);
create index idx_crd_due on bccreditcard(duedate);
create index idx_crd_bno on bccreditcard(bookno);
create index idx_crd_st on bccreditcard(status);
create table bcotherincome
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	glbookcode varchar(5),
	ispostgl smallint,
	departcode varchar(10),
	mydescription varchar(255),
	sumofdebit currency ,
	sumofcredit currency ,
	netamount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	arcode varchar(20),
	pettycashamount currency ,
	sumofwtax currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	sumbankamount currency ,
	billgroup varchar(10),
	isconfirm smallint,
	iscancel smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcotherincome
(
	ispostgl smallint 0,
	sumofdebit currency  0.0,
	sumofcredit currency  0.0,
	netamount currency  0.0,
	pettycashamount currency  0.0,
	sumofwtax currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	sumbankamount currency  0.0,
	isconfirm smallint 0,
	iscancel smallint 0,
);


create index idx_othi_date on bcotherincome(docdate);
create index idx_othi_ar on bcotherincome(arcode);
create table bcotherexpense2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(255),
	sumofamount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	apcode varchar(20),
	glformat varchar(5),
	gltransdata smallint,
	ispostgl smallint,
	personcode varchar(10),
	billstatus smallint,
	pettycashamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumbankamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	iscancel smallint,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcotherexpense2
(
	sumofamount currency  0.0,
	gltransdata smallint 0,
	ispostgl smallint 0,
	billstatus smallint 0,
	pettycashamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumbankamount currency  0.0,
	isconfirm smallint 0,
	iscancel smallint 0,
);


create index idx_othe2_date on bcotherexpense2(docdate);
create index idx_othe2_ap on bcotherexpense2(apcode);
create table bcotherexpsub2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	departcode varchar(10),
	mydescription varchar(200),
	amount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	apcode varchar(20)
	,primary key(roworder)
);

default on bcotherexpsub2
(
	amount currency  0.0,
);


create index idx_othes2_date on bcotherexpsub2(docdate);
create index idx_othes2_ap on bcotherexpsub2(apcode);
create table bcotherexpense
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	refdocno varchar(20),
	glbookcode varchar(5),
	ispostgl smallint,
	departcode varchar(10),
	mydescription varchar(255),
	sumofdebit currency ,
	sumofcredit currency ,
	netamount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	apcode varchar(20),
	pettycashamount currency ,
	sumofwtax currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	sumbankamount currency ,
	billgroup varchar(10),
	isconfirm smallint,
	iscancel smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcotherexpense
(
	ispostgl smallint 0,
	sumofdebit currency  0.0,
	sumofcredit currency  0.0,
	netamount currency  0.0,
	pettycashamount currency  0.0,
	sumofwtax currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	sumbankamount currency  0.0,
	isconfirm smallint 0,
	iscancel smallint 0,
);


create index idx_othe_date on bcotherexpense(docdate);
create index idx_othe_ap on bcotherexpense(apcode);
create table bcbanktransfer
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	frombook varchar(30),
	tobook varchar(30),
	glbookcode varchar(5),
	ispostgl smallint,
	iscancel smallint,
	mydescription varchar(255),
	amount currency ,
	recurname varchar(40),
	isconfirm smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcbanktransfer
(
	ispostgl smallint 0,
	iscancel smallint 0,
	amount currency  0.0,
	isconfirm smallint 0,
);


create index idx_bntf_date on bcbanktransfer(docdate);
create index idx_bntf_fb on bcbanktransfer(frombook);
create index idx_bntf_tb on bcbanktransfer(tobook);
create table bccashbankin
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	bookno varchar(30),
	accountcode varchar(20),
	glbookcode varchar(5),
	isbankbalance smallint,
	ispostgl smallint,
	departcode varchar(10),
	mydescription varchar(100),
	amount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	iscancel smallint,
	isconfirm smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bccashbankin
(
	isbankbalance smallint 0,
	ispostgl smallint 0,
	amount currency  0.0,
	iscancel smallint 0,
	isconfirm smallint 0,
);


create index idx_cshbi_date on bccashbankin(docdate);
create index idx_cshbi_bno on bccashbankin(bookno);
create table bccashbankout
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	bookno varchar(30),
	accountcode varchar(20),
	glbookcode varchar(5),
	isbankbalance smallint,
	ispostgl smallint,
	departcode varchar(10),
	mydescription varchar(100),
	amount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	iscancel smallint,
	isconfirm smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bccashbankout
(
	isbankbalance smallint 0,
	ispostgl smallint 0,
	iscancel smallint 0,
	isconfirm smallint 0,
);


create index idx_cshbo_date on bccashbankout(docdate);
create index idx_cshbo_bno on bccashbankout(bookno);
create table bcbankexpense
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	bookno varchar(30),
	accountcode varchar(20),
	glbookcode varchar(5),
	ispostgl smallint,
	departcode varchar(10),
	mydescription varchar(100),
	amount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	iscancel smallint,
	isconfirm smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcbankexpense
(
	ispostgl smallint 0,
	iscancel smallint 0,
	isconfirm smallint 0,
);


create index idx_bnke_date on bcbankexpense(docdate);
create index idx_bnke_bno on bcbankexpense(bookno);
create table bcbankincome
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	bookno varchar(30),
	accountcode varchar(20),
	glbookcode varchar(5),
	ispostgl smallint,
	departcode varchar(10),
	mydescription varchar(100),
	amount currency ,
	allocatecode varchar(10),
	projectcode varchar(10),
	iscancel smallint,
	isconfirm smallint,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcbankincome
(
	ispostgl smallint 0,
	iscancel smallint 0,
	isconfirm smallint 0,
);


create index idx_bnki_date on bcbankincome(docdate);
create index idx_bnki_bno on bcbankincome(bookno);
create table bcchqindeposit
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqindeposit
(
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chid_date on bcchqindeposit(docdate);
create index idx_chid_bno on bcchqindeposit(bookno);
create table bcchqindepossub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	orgchqstatus smallint,
	primary key(roworder)
);

default on bcchqindepossub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
	orgchqstatus smallint 0,
);


create index idx_chids_no on bcchqindepossub(docno);
create index idx_chids_date on bcchqindepossub(docdate);
create index idx_chids_bno on bcchqindepossub(bookno);
create index idx_chids_cno on bcchqindepossub(chqnumber);
create index idx_chids_ts on bcchqindepossub(transstate);
create table bcchqindeposit2
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqindeposit2
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chid2_date on bcchqindeposit2(docdate);
create index idx_chid2_bno on bcchqindeposit2(bookno);
create table bcchqindepo2sub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bcchqindepo2sub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_chid2s_no on bcchqindepo2sub(docno);
create index idx_chid2s_date on bcchqindepo2sub(docdate);
create index idx_chid2s_bno on bcchqindepo2sub(bookno);
create index idx_chid2s_cno on bcchqindepo2sub(chqnumber);
create index idx_chid2s_ts on bcchqindepo2sub(transstate);
create table bcchqinpass
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqinpass
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chip_date on bcchqinpass(docdate);
create index idx_chip_bno on bcchqinpass(bookno);
create table bcchqinpasssub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	orgchqstatus smallint,
	primary key(roworder)
);

default on bcchqinpasssub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
	orgchqstatus smallint 0,
);


create index idx_chips_no on bcchqinpasssub(docno);
create index idx_chips_date on bcchqinpasssub(docdate);
create index idx_chips_bno on bcchqinpasssub(bookno);
create index idx_chips_cno on bcchqinpasssub(chqnumber);
create index idx_chips_ts on bcchqinpasssub(transstate);
create table bcchqincancel
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	cancelstatus smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqincancel
(
	ispostgl smallint 0,
	cancelstatus smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chic_date on bcchqincancel(docdate);
create index idx_chic_bno on bcchqincancel(bookno);
create table bcchqincancelsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	cancelstatus smallint,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bcchqincancelsub
(
	cancelstatus smallint 0,
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_chics_no on bcchqincancelsub(docno);
create index idx_chics_date on bcchqincancelsub(docdate);
create index idx_chics_bno on bcchqincancelsub(bookno);
create index idx_chics_cno on bcchqincancelsub(chqnumber);
create index idx_chics_ts on bcchqincancelsub(transstate);
create table bcchqinreturn
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqinreturn
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chir_date on bcchqinreturn(docdate);
create index idx_chir_bno on bcchqinreturn(bookno);
create table bcchqinretsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bcchqinretsub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_chirs_no on bcchqinretsub(docno);
create index idx_chirs_date on bcchqinretsub(docdate);
create index idx_chirs_bno on bcchqinretsub(bookno);
create index idx_chirs_cno on bcchqinretsub(chqnumber);
create index idx_chirs_ts on bcchqinretsub(transstate);
create table bcchqinsale
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqinsale
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chis_date on bcchqinsale(docdate);
create index idx_chis_bno on bcchqinsale(bookno);
create table bcchqinsalesub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bcchqinsalesub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_chiss_no on bcchqinsalesub(docno);
create index idx_chiss_date on bcchqinsalesub(docdate);
create index idx_chiss_bno on bcchqinsalesub(bookno);
create index idx_chiss_cno on bcchqinsalesub(chqnumber);
create index idx_chiss_ts on bcchqinsalesub(transstate);
create table bcchqoutpass
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqoutpass
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_chop_date on bcchqoutpass(docdate);
create index idx_chop_bno on bcchqoutpass(bookno);
create table bcchqoutpasssub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bcchqoutpasssub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_chops_no on bcchqoutpasssub(docno);
create index idx_chops_date on bcchqoutpasssub(docdate);
create index idx_chops_bno on bcchqoutpasssub(bookno);
create index idx_chops_cno on bcchqoutpasssub(chqnumber);
create index idx_chops_ts on bcchqoutpasssub(transstate);
create table bcchqoutcancel
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	cancelstatus smallint,
	ispostgl smallint,
	gltransdata smallint,
	sumchqamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bcchqoutcancel
(
	cancelstatus smallint 0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumchqamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_choc_date on bcchqoutcancel(docdate);
create index idx_choc_bno on bcchqoutcancel(bookno);
create table bcchqoutcancelsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	chqroworder int,
	cancelstatus smallint,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	chqnumber varchar(20),
	chqamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bcchqoutcancelsub
(
	cancelstatus smallint 0,
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	chqamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_chocs_no on bcchqoutcancelsub(docno);
create index idx_chocs_date on bcchqoutcancelsub(docdate);
create index idx_chocs_bno on bcchqoutcancelsub(bookno);
create index idx_chocs_cno on bcchqoutcancelsub(chqnumber);
create index idx_chocs_ts on bcchqoutcancelsub(transstate);
create table bccreditpass
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumcreditamount currency ,
	taxrate currency ,
	beforetaxamount currency ,
	taxamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bccreditpass
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumcreditamount currency  0.0,
	taxrate currency  7.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_crp_date on bccreditpass(docdate);
create index idx_crp_bno on bccreditpass(bookno);
create table bccreditpasssub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	creditroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	creditnumber varchar(20),
	creditamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bccreditpasssub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	creditamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_ccrps_no on bccreditpasssub(docno);
create index idx_ccrps_date on bccreditpasssub(docdate);
create index idx_ccrps_bno on bccreditpasssub(bookno);
create index idx_ccrps_cno on bccreditpasssub(creditnumber);
create index idx_ccrps_ts on bccreditpasssub(transstate);
create table bccreditcancel
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	mydescription varchar(255),
	bookno varchar(30),
	glformat varchar(5),
	ispostgl smallint,
	gltransdata smallint,
	sumcreditamount currency ,
	sumexpend currency ,
	netamount currency ,
	isconfirm smallint,
	recurname varchar(40),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bccreditcancel
(
	ispostgl smallint 0,
	gltransdata smallint 0,
	sumcreditamount currency  0.0,
	sumexpend currency  0.0,
	netamount currency  0.0,
	isconfirm smallint 0,
);


create index idx_crc_date on bccreditcancel(docdate);
create index idx_crc_bno on bccreditcancel(bookno);
create table bccreditcancelsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	bookno varchar(30),
	creditroworder int,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	creditnumber varchar(20),
	creditamount currency ,
	expend currency ,
	netamount currency ,
	currencycode varchar(10),
	exchangerate double ,
	homeamount currency ,
	primary key(roworder)
);

default on bccreditcancelsub
(
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	creditamount currency  0.0,
	expend currency  0.0,
	netamount currency  0.0,
	exchangerate double  1.0,
	homeamount currency  0.0,
);


create index idx_ccrcs_no on bccreditcancelsub(docno);
create index idx_ccrcs_date on bccreditcancelsub(docdate);
create index idx_ccrcs_bno on bccreditcancelsub(bookno);
create index idx_ccrcs_cno on bccreditcancelsub(creditnumber);
create index idx_ccrcs_ts on bccreditcancelsub(transstate);
create table bcpettycash
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(100),
	amount currency ,
	beginamount currency ,
	balance currency ,
	primary key(code)
);

default on bcpettycash
(
	amount currency  0.0,
	beginamount currency  0.0,
	balance currency  0.0,
);


create table bcoutputtax
(
	
	roworder autoincrement not null, 
	savefrom smallint,
	docno varchar(20),
	bookcode varchar(15),
	source smallint,
	docdate datetime,
	taxdate datetime,
	taxno varchar(20),
	arcode varchar(20),
	shorttaxdesc varchar(100),
	taxrate currency ,
	process smallint,
	beforetaxamount currency ,
	taxamount currency ,
	excepttaxamount currency ,
	zerotaxamount currency ,
	linenumber smallint,
	ismulticurrency smallint,
	famount currency ,
	exchangerate currency ,
	taxgroup varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	iscancel smallint,
	canceloutperiod smallint,
	canceldocno varchar(20),
	ispos smallint,
	primary key(roworder)
);

default on bcoutputtax
(
	savefrom smallint 0,
	source smallint 0,
	taxrate currency  7.0,
	process smallint 0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	linenumber smallint 0,
	ismulticurrency smallint 0,
	famount currency  0.0,
	exchangerate currency  0.0,
	iscancel smallint 0,
	canceloutperiod smallint 0,
	ispos smallint 0,
);


create index idx_opt_book on bcoutputtax(bookcode);
create index idx_opt_source on bcoutputtax(source);
create index idx_opt_date on bcoutputtax(docdate);
create index idx_opt_dno on bcoutputtax(docno);
create index idx_opt_tdate on bcoutputtax(taxdate);
create index idx_opt_tno on bcoutputtax(taxno);
create table bcinputtax
(
	
	roworder autoincrement not null, 
	savefrom smallint,
	docno varchar(20),
	bookcode varchar(15),
	source smallint,
	docdate datetime,
	taxdate datetime,
	taxdate2 datetime,
	taxno varchar(20),
	apcode varchar(20),
	shorttaxdesc varchar(100),
	taxrate currency ,
	process smallint,
	beforetaxamount currency ,
	taxamount currency ,
	excepttaxamount currency ,
	zerotaxamount currency ,
	linenumber smallint,
	ismulticurrency smallint,
	famount currency ,
	exchangerate currency ,
	returntax smallint,
	taxgroup varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	canceloutperiod smallint,
	canceldocno varchar(20),
	iscancel smallint,
	primary key(roworder)
);

default on bcinputtax
(
	savefrom smallint 0,
	source smallint 0,
	taxrate currency  7.0,
	process smallint 0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	excepttaxamount currency  0.0,
	zerotaxamount currency  0.0,
	linenumber smallint 0,
	ismulticurrency smallint 0,
	famount currency  0.0,
	exchangerate currency  0.0,
	returntax smallint 0,
	canceloutperiod smallint 0,
	iscancel smallint 0,
);


create index idx_ipt_book on bcinputtax(bookcode);
create index idx_ipt_source on bcinputtax(source);
create index idx_ipt_date on bcinputtax(docdate);
create index idx_ipt_dno on bcinputtax(docno);
create index idx_ipt_tdate on bcinputtax(taxdate);
create index idx_ipt_tno on bcinputtax(taxno);
create table bcarwtaxlist
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	arcode varchar(20),
	baseoftax currency ,
	wtaxrate currency ,
	wtaxamount currency ,
	linenumber smallint,
	shortdesc varchar(100),
	taxgroup varchar(10),
	savefrom smallint,
	primary key(roworder)
);

default on bcarwtaxlist
(
	baseoftax currency  0.0,
	wtaxrate currency  0.0,
	wtaxamount currency  0.0,
	linenumber smallint 0,
	savefrom smallint 0,
);


create index idx_arwl_dno on bcarwtaxlist(docno);
create index idx_arwl_date on bcarwtaxlist(docdate);
create index idx_arwl_ar on bcarwtaxlist(arcode);
create index idx_arwl_sf on bcarwtaxlist(savefrom);
create table bcapwtaxlist
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	docdate datetime,
	apcode varchar(20),
	baseoftax currency ,
	wtaxrate currency ,
	wtaxamount currency ,
	linenumber smallint,
	shortdesc varchar(100),
	taxgroup varchar(10),
	savefrom smallint,
	primary key(roworder)
);

default on bcapwtaxlist
(
	baseoftax currency  0.0,
	wtaxrate currency  0.0,
	wtaxamount currency  0.0,
	linenumber smallint 0,
	savefrom smallint 0,
);


create index idx_apwl_dno on bcapwtaxlist(docno);
create index idx_apwl_date on bcapwtaxlist(docdate);
create index idx_apwl_ap on bcapwtaxlist(apcode);
create index idx_apwl_sf on bcapwtaxlist(savefrom);
create table bcglcondition
(
	
	roworder autoincrement not null, 
	formatgroup smallint,
	myid smallint,
	name varchar(100),
	linenumber smallint,
	inventorymethod smallint,
	primary key(roworder)
);

default on bcglcondition
(
	formatgroup smallint 0,
	myid smallint 0,
	linenumber smallint 0,
	inventorymethod smallint -1,
);


create index idx_glc_g on bcglcondition(formatgroup);
create index idx_glc_id on bcglcondition(myid);
create table bcglformat
(
	
	roworder autoincrement not null, 
	code varchar(5) not null,
	name varchar(50),
	formatgroup smallint,
	glbookcode varchar(5),
	recurname varchar(40),
	gldescription varchar(255)
	,primary key(code)
);

default on bcglformat
(
	formatgroup smallint 0,
);


create table bcglformatsub
(
	
	roworder autoincrement not null, 
	code varchar(5),
	accountcode varchar(20),
	isdebit smallint,
	condition smallint,
	linenumber smallint,
	primary key(roworder)
);

default on bcglformatsub
(
	isdebit smallint 0,
	condition smallint 0,
	linenumber smallint 0,
);


create index idx_glcs_cd on bcglformatsub(code);
create index idx_glcs_ln on bcglformatsub(linenumber);
create table bcchartofaccount
(
	
	roworder autoincrement not null, 
	code varchar(20) not null,
	name1 varchar(70),
	name2 varchar(70),
	accountgroup smallint,
	departseparate smallint,
	projectseparate smallint,
	allocateseparate smallint,
	jobseparate smallint,
	partseparate smallint,
	sideseparate smallint,
	branchseparate smallint,
	acclevel smallint,
	isglaccess smallint,
	isheader smallint,
	primary key(code)
);

default on bcchartofaccount
(
	accountgroup smallint 0,
	departseparate smallint 0,
	projectseparate smallint 0,
	allocateseparate smallint 0,
	jobseparate smallint 0,
	partseparate smallint 0,
	sideseparate smallint 0,
	branchseparate smallint 0,
	acclevel smallint 0,
	isglaccess smallint 0,
	isheader smallint 0,
);


create index idx_cht_accn on bcchartofaccount(name1);
create table bcglbook
(
	
	roworder autoincrement not null, 
	code varchar(15) not null,
	name varchar(50),
	titlename varchar(50),
	printslip smallint,
	fomfilename varchar(100)
	,primary key(code)
);
create table bcglchq
(
	
	roworder autoincrement not null, 
	bookcode varchar(15) not null,
	docdate datetime not null,
	docno varchar(20) not null,
	source smallint,
	bankcode varchar(10) not null,
	chqno varchar(30) not null,
	amount currency ,
	duedate datetime not null,
	mydescription varchar(100),
	bookno varchar(30),
	chqtype smallint,
	exchangerate double ,
	branchid varchar(10)
	,primary key(roworder)
);

default on bcglchq
(
	source smallint 0,
	amount currency  0.0,
	chqtype smallint 0,
	exchangerate double  1.0,
);


create index idx_chqno on bcglchq (chqno);
create index idx_duedate on bcglchq(duedate);
create table bcperiod
(
	
	roworder autoincrement not null, 
	periodno smallint not null,
	startdate datetime not null,
	stopdate datetime not null,
	itemremain currency ,
	netprofitloss currency ,
	summprofitloss currency ,
	status smallint,
	primary key(periodno)
);

default on bcperiod
(
	itemremain currency  0.0,
	netprofitloss currency  0.0,
	summprofitloss currency  0.0,
	status smallint 1,
);


create index idx_pno_strd on bcperiod(startdate);
create index idx_pno_stpd on bcperiod(stopdate);
create table bcpart
(
	
	roworder autoincrement not null, 
	code varchar(15) not null,
	name varchar(100)
	,primary key(code)
);
create table bcside
(
	
	roworder autoincrement not null, 
	code varchar(15) not null,
	name varchar(100)
	,primary key(code)
);
create table bcjob
(
	
	roworder autoincrement not null, 
	code varchar(15) not null,
	name varchar(100)
	,primary key(code)
);
create table bcbranch
(
	
	roworder autoincrement not null, 
	code varchar(15) not null,
	name varchar(100)
	,primary key(code)
);
create table bcglbudget
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(100) not null,
	accountcode varchar(15) not null,
	branchcode varchar(10),
	departcode varchar(10),
	projectcode varchar(10),
	allocatecode varchar(10),
	jobcode varchar(20),
	partcode varchar(10),
	sidecode varchar(10),
	startdate datetime,
	stopdate datetime,
	amount currency ,
	remark varchar(100),
	status smallint,
	primary key(code)
);

default on bcglbudget
(
	amount currency  0.0,
	status smallint 0,
);


create index idx_bgg_acccode on bcglbudget(accountcode);
create index idx_bgg_name on bcglbudget(name);
create table bcposttrans
(
	batchno varchar(20) not null,
	workstation varchar(100),
	mydescription varchar(100),
	batchdate datetime not null,
	batchstatus smallint not null,
	transcount smallint not null,
	taxcount smallint,
	chqcount smallint,
	batchowner varchar(50) not null,
	batchcheck1 varchar(50),
	batchcheck2 varchar(50),
	batchapprove varchar(50)
	,primary key (batchno)
);

default on bcposttrans
(
	taxcount smallint 0,
	chqcount smallint 0,
);


create index idx_bcpostdate on bcposttrans(batchdate);
create index idx_bcpostowner_tr on bcposttrans(batchowner);
create table bcposthistory
(
	
	roworder autoincrement not null, 
	batchno varchar(20) not null,
	eventdate datetime not null,
	eventtype smallint,
	workstation varchar(100)
	,primary key(roworder)
);

default on bcposthistory
(
	eventtype smallint 1,
);


create table bccloseperiod
(
	batchno varchar(20) not null,
	workstation varchar(100),
	mydescription varchar(100),
	batchdate datetime not null,
	batchstatus smallint not null,
	transcount smallint not null,
	taxcount smallint,
	chqcount smallint,
	batchowner varchar(50) not null,
	batchcheck1 varchar(50),
	batchcheck2 varchar(50),
	batchapprove varchar(50)
	,primary key (batchno)
);

default on bccloseperiod
(
	taxcount smallint 0,
	chqcount smallint 0,
);


create index idx_bcclosedate on bccloseperiod(batchdate);
create index idx_bccloseowner_tr on bccloseperiod(batchowner);
create table bcclspdhistory
(
	
	roworder autoincrement not null, 
	batchno varchar(20) not null,
	eventdate datetime not null,
	eventtype smallint,
	workstation varchar(100)
	,primary key(roworder)
);

default on bcclspdhistory
(
	eventtype smallint 1,
);


create table bcperiodbalance
(
	
	roworder autoincrement not null, 
	periodno smallint not null,
	branchcode varchar(10),
	accountcode varchar(20) not null,
	departcode varchar(10),
	projectcode varchar(10),
	allocatecode varchar(10),
	partcode varchar(10),
	sidecode varchar(10),
	jobcode varchar(20),
	startdate datetime,
	stopdate datetime,
	debit currency ,
	credit currency ,
	primary key(roworder)
);

default on bcperiodbalance
(
	debit currency  0.0,
	credit currency  0.0,
);


create index idx_pb_pno on bcperiodbalance(periodno);
create index idx_pb_acc on bcperiodbalance(accountcode);
create index idx_pb_bc on bcperiodbalance(branchcode);
create index idx_pb_dp on bcperiodbalance(departcode);
create index idx_pb_pc on bcperiodbalance(projectcode);
create index idx_pb_ac on bcperiodbalance(allocatecode);
create index idx_pb_jc on bcperiodbalance(jobcode);
create index idx_pb_prc on bcperiodbalance(partcode);
create index idx_pb_sc on bcperiodbalance(sidecode);
create table bcyearperiodbal
(
	
	roworder autoincrement not null, 
	yearcode varchar(10),
	branchcode varchar(10),
	accountcode varchar(20) not null,
	departcode varchar(10),
	projectcode varchar(10),
	allocatecode varchar(10),
	partcode varchar(10),
	sidecode varchar(10),
	jobcode varchar(20),
	startdate datetime,
	stopdate datetime,
	debit currency ,
	credit currency ,
	primary key(roworder)
);

default on bcyearperiodbal
(
	debit currency  0.0,
	credit currency  0.0,
);


create index idx_ypb_yc on bcyearperiodbal(yearcode);
create index idx_ypb_acc on bcyearperiodbal(accountcode);
create index idx_ypb_bc on bcyearperiodbal(branchcode);
create index idx_ypb_dp on bcyearperiodbal(departcode);
create index idx_ypb_pc on bcyearperiodbal(projectcode);
create index idx_ypb_ac on bcyearperiodbal(allocatecode);
create index idx_ypb_jc on bcyearperiodbal(jobcode);
create index idx_ypb_prc on bcyearperiodbal(partcode);
create index idx_ypb_sc on bcyearperiodbal(sidecode);
create table bctrans
(
	
	roworder autoincrement not null, 
	batchno varchar(20),
	bookcode varchar(15) not null,
	docdate datetime not null,
	docno varchar(20) not null,
	refdocno varchar(20),
	refdate datetime,
	amount currency ,
	famount currency ,
	fcurrency varchar(10),
	fexchangerate double ,
	source smallint,
	transtype smallint,
	ismanualkey smallint,
	mydescription varchar(250),
	recurname varchar(40),
	isconfirm smallint,
	iscancel smallint,
	ispasserror smallint,
	taxcount smallint,
	cheqcount smallint,
	primary key(docno,source,bookcode)
);

default on bctrans
(
	amount currency  0.0,
	famount currency  0.0,
	fexchangerate double  1.0,
	source smallint 0 not null,
	transtype smallint 0,
	ismanualkey smallint 0,
	isconfirm smallint 0,
	iscancel smallint 0,
	ispasserror smallint 0,
	taxcount smallint 0,
	cheqcount smallint 0,
);


create index idx_bctransdocno on bctrans(docno);
create index idx_bctransdocdate on bctrans(docdate);
create index idx_bctransbook on bctrans(bookcode);
create table bctranssub
(
	
	roworder autoincrement not null, 
	batchno varchar(20),
	linenumber smallint,
	bookcode varchar(15) not null,
	docdate datetime not null,
	docno varchar(20) not null,
	accountcode varchar(20) not null,
	extdescription varchar(255),
	departcode varchar(10),
	projectcode varchar(10),
	allocatecode varchar(10),
	partcode varchar(10),
	sidecode varchar(10),
	jobcode varchar(20),
	branchcode varchar(15),
	debit currency ,
	credit currency ,
	fdebit currency ,
	fcredit currency ,
	source smallint,
	ismanualkey smallint,
	iscancel smallint,
	isconfirm smallint,
	primary key (roworder)
);

default on bctranssub
(
	linenumber smallint 0,
	debit currency  0.0,
	credit currency  0.0,
	fdebit currency  0.0,
	fcredit currency  0.0,
	source smallint 0,
	ismanualkey smallint 0,
	iscancel smallint 0,
	isconfirm smallint 0,
);


create index idx_gts_acc on bctranssub(accountcode);
create index idx_gts_sou on bctranssub(source);
create index idx_gts_doc on bctranssub(docno);
create index idx_gts_boo on bctranssub(bookcode);
create index idx_gts_bc on bctranssub(branchcode);
create index idx_gts_dp on bctranssub(departcode);
create index idx_gts_pc on bctranssub(projectcode);
create index idx_gts_ac on bctranssub(allocatecode);
create index idx_gts_jc on bctranssub(jobcode);
create index idx_gts_prc on bctranssub(partcode);
create index idx_gts_sc on bctranssub(sidecode);
create table bcaccseparate
(
	
	roworder autoincrement not null, 
	separatetype smallint,
	accountcode varchar(20) not null,
	separatecode varchar(200) not null
	,primary key (roworder)
);

default on bcaccseparate
(
	separatetype smallint 0,
);


create table bcassetsmaster
(
	
	roworder autoincrement not null, 
	code varchar(25) not null,
	name varchar(100),
	unitcode varchar(10),
	assetstype varchar(10),
	departcode varchar(10),
	locatecode varchar(10),
	picturefilename varchar(100),
	buydate datetime,
	buyprice currency ,
	buydocno varchar(20),
	buydocdate datetime,
	buyform varchar(100),
	startcalcdate datetime,
	amountcalc currency ,
	calctype smallint,
	assetsrate currency ,
	assetsage smallint,
	stopcalcdate datetime,
	assetsbalance currency ,
	sumofassetsbal currency ,
	saledate datetime,
	saleprice currency ,
	saleassetsbal currency ,
	saledocno varchar(20),
	saledocdate datetime,
	custname varchar(100),
	insuranceno varchar(20),
	saftyno varchar(20),
	saftyname varchar(100),
	insurepremium currency ,
	insureage smallint,
	insurestartdate datetime,
	insurestopdate datetime,
	mydescription varchar(250),
	remain currency ,
	primary key (code)
);

default on bcassetsmaster
(
	buyprice currency  0.0,
	amountcalc currency  0.0,
	calctype smallint 0,
	assetsrate currency  0.0,
	assetsage smallint 0,
	assetsbalance currency  0.0,
	sumofassetsbal currency  0.0,
	saleprice currency  0.0,
	saleassetsbal currency  0.0,
	insurepremium currency  0.0,
	insureage smallint 0,
	remain currency  0.0,
);


create table bcassetslocate
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50)
	,primary key (code)
);
create table bcassetstype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50),
	draccountcode varchar(20),
	craccountcode varchar(20)
	,primary key (code)
);
create table bcassetsofyear
(
	
	roworder autoincrement not null, 
	assetscode varchar(25) ,
	startcalcdate datetime,
	stopcalcdate datetime,
	departcode varchar(10),
	assetstype varchar(10),
	locatecode varchar(10),
	daycalc smallint,
	beginbalance currency ,
	assetsamount currency ,
	assetsamass currency ,
	endbalance currency ,
	primary key (roworder)
);

default on bcassetsofyear
(
	daycalc smallint 0,
	beginbalance currency  0.0,
	assetsamount currency  0.0,
	assetsamass currency  0.0,
	endbalance currency  0.0,
);


create index idx_asy_asc on bcassetsofyear(assetscode);
create index idx_asy_strd on bcassetsofyear(startcalcdate);
create index idx_asy_stpd on bcassetsofyear(stopcalcdate);
create index idx_asy_dep on bcassetsofyear(departcode);
create index idx_asy_typ on bcassetsofyear(assetstype);
create index idx_asy_loc on bcassetsofyear(locatecode);
create table bcassetsofperiod
(
	
	roworder autoincrement not null, 
	assetscode varchar(25) ,
	startcalcdate datetime,
	stopcalcdate datetime,
	departcode varchar(10),
	assetstype varchar(10),
	locatecode varchar(10),
	beginbalance currency ,
	assetsamount currency ,
	assetsperiod1 currency ,
	assetsperiod2 currency ,
	assetsperiod3 currency ,
	assetsperiod4 currency ,
	assetsperiod5 currency ,
	assetsperiod6 currency ,
	assetsperiod7 currency ,
	assetsperiod8 currency ,
	assetsperiod9 currency ,
	assetsperiod10 currency ,
	assetsperiod11 currency ,
	assetsperiod12 currency ,
	assetsperiod13 currency ,
	endbalance currency ,
	primary key (roworder)
);

default on bcassetsofperiod
(
	beginbalance currency  0.0,
	assetsamount currency  0.0,
	assetsperiod1 currency  0.0,
	assetsperiod2 currency  0.0,
	assetsperiod3 currency  0.0,
	assetsperiod4 currency  0.0,
	assetsperiod5 currency  0.0,
	assetsperiod6 currency  0.0,
	assetsperiod7 currency  0.0,
	assetsperiod8 currency  0.0,
	assetsperiod9 currency  0.0,
	assetsperiod10 currency  0.0,
	assetsperiod11 currency  0.0,
	assetsperiod12 currency  0.0,
	assetsperiod13 currency  0.0,
	endbalance currency  0.0,
);


create index idx_asp_asc on bcassetsofperiod(assetscode);
create index idx_asp_strd on bcassetsofperiod(startcalcdate);
create index idx_asp_stpd on bcassetsofperiod(stopcalcdate);
create index idx_asp_dep on bcassetsofperiod(departcode);
create index idx_asp_typ on bcassetsofperiod(assetstype);
create index idx_asp_loc on bcassetsofperiod(locatecode);
create table bcassetsofbuild
(
	
	roworder autoincrement not null, 
	assetscode varchar(25) not null,
	mydescription varchar(100),
	amount currency ,
	primary key (assetscode)
);

default on bcassetsofbuild
(
	amount currency  0.0,
);


create index idx_asblddes on bcassetsofbuild ( mydescription );
create table bcassetsofbldsub
(
	
	roworder autoincrement not null, 
	linenumber smallint,
	assetscode varchar(25) ,
	docdate datetime,
	docno varchar(20),
	desc1 varchar(100),
	desc2 varchar(100),
	amount currency ,
	primary key (roworder)
);

default on bcassetsofbldsub
(
	linenumber smallint 0,
	amount currency  0.0,
);


create index idx_asblds_as on bcassetsofbldsub ( assetscode );
create index idx_asblds_li on bcassetsofbldsub ( linenumber );
create table bcrenovate
(
	
	roworder autoincrement not null, 
	assetscode varchar(25) not null,
	amount currency ,
	primary key (assetscode)
);

default on bcrenovate
(
	amount currency  0.0,
);


create table bcrenovatesub
(
	
	roworder autoincrement not null, 
	linenumber smallint,
	assetscode varchar(25) ,
	docdate datetime,
	docno varchar(20),
	desc1 varchar(100),
	desc2 varchar(100),
	amount currency ,
	primary key (roworder)
);

default on bcrenovatesub
(
	linenumber smallint 0,
	amount currency  0.0,
);


create index idx_asrevs_as on bcrenovatesub ( assetscode );
create index idx_asrevs_li on bcrenovatesub ( linenumber );
create table bcaccgroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50),
	accgroup varchar(255)
	,primary key (code)
);
create table bpsconfig
(
	
	roworder autoincrement not null, 
	printslipmode smallint,
	cashiermode smallint,
	afterdecimalmode smallint,
	groupitemstatus smallint,
	stockprocess smallint,
	soundfolder varchar(100),
	sliptype smallint,
	printerport varchar(50),
	printertype smallint,
	cashdrawer smallint,
	cashdrawerport varchar(50),
	printerportrate smallint,
	cashdrawerportrate smallint,
	machineno varchar(10),
	machinecode varchar(30),
	billgroup varchar(4),
	defaultcustcode varchar(15),
	defaultdepart varchar(10),
	membermode smallint,
	salebarterpoint smallint,
	promotiontype smallint,
	marktype smallint,
	markmode smallint,
	valuepermark1 currency ,
	valuepermark2 currency ,
	primary key(roworder)
);

default on bpsconfig
(
	printslipmode smallint 0,
	cashiermode smallint 0,
	afterdecimalmode smallint 0,
	groupitemstatus smallint 0,
	stockprocess smallint 0,
	sliptype smallint 0,
	printertype smallint 0,
	cashdrawer smallint 0,
	printerportrate smallint 9600,
	cashdrawerportrate smallint 9600,
	membermode smallint 0,
	salebarterpoint smallint 0,
	promotiontype smallint 0,
	marktype smallint 0,
	markmode smallint 0,
	valuepermark1 currency  0.0,
	valuepermark2 currency  0.0,
);


create table bpscredittype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50),
	chargeword varchar(30)
	,primary key(code)
);
create table bpsitempromotion
(
	
	roworder autoincrement not null, 
	groupcode varchar(10) not null,
	startdate datetime,
	stopdate datetime,
	promotionprice currency ,
	promotionitem varchar(20),
	promotionqty currency ,
	promotiondiscount varchar(25),
	qtychk currency ,
	amountchk currency ,
	groupname varchar(50),
	promotionfor smallint,
	promotiontype smallint,
	exchangeitem varchar(20),
	exchangediscount varchar(25),
	promotionitem2 varchar(25),
	exchangeitem2 varchar(25),
	startitemgroup varchar(10),
	stopitemgroup varchar(10)
	,primary key(groupcode)
);

default on bpsitempromotion
(
	promotionprice currency  0.0,
	promotionqty currency  0.0,
	qtychk currency  0.0,
	amountchk currency  0.0,
);


create table bpscashiershift
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime,
	shiftno smallint,
	cashiercode varchar(10),
	mydescription varchar(100),
	machineno varchar(10),
	machinecode varchar(30),
	shiftstatus smallint,
	beginamount currency ,
	cashamount currency ,
	creditamount currency ,
	changeamount currency ,
	cashincase currency ,
	chqamount currency ,
	draftamount currency ,
	sumofqty currency ,
	salecount smallint,
	discount smallint,
	cashpaycount smallint,
	otherpaycount smallint,
	taxinvstart varchar(20),
	taxinvstop varchar(20),
	sumofitemamount currency ,
	sumoftaxamount currency ,
	zerotaxamount currency ,
	excepttaxamount currency ,
	netamount currency ,
	disamount currency ,
	primary key(docno)
);

default on bpscashiershift
(
	beginamount currency  0.0,
	cashamount currency  0.0,
	creditamount currency  0.0,
	changeamount currency  0.0,
	cashincase currency  0.0,
	chqamount currency  0.0,
	draftamount currency  0.0,
	sumofqty currency  0.0,
	salecount smallint 0,
	discount smallint 0,
	cashpaycount smallint 0,
	otherpaycount smallint 0,
	sumofitemamount currency  0.0,
	sumoftaxamount currency  0.0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	netamount currency  0.0,
	disamount currency  0.0,
);


create table bpsreturndesc
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50)
	,primary key(code)
);
create table bpsholdingbill
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	expirecredit smallint,
	expiredate datetime ,
	arcode varchar(20) not null,
	cashiercode varchar(10),
	shiftno smallint,
	machineno varchar(10),
	machinecode varchar(30),
	billtime varchar(15),
	departcode varchar(10),
	salecode varchar(10),
	taxrate currency ,
	mydescription varchar(255),
	billgroup varchar(10),
	sumofitemamount currency ,
	discountword varchar(35),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	zerotaxamount currency ,
	excepttaxamount currency ,
	netdebtamount currency ,
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime
	,primary key(docno)
);

default on bpsholdingbill
(
	expirecredit smallint 0,
	shiftno smallint 0,
	taxrate currency  7.0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	netdebtamount currency  0.0,
);


create table bpsholdingbillsub
(
	
	roworder autoincrement not null, 
	docno varchar(20),
	itemcode varchar(25),
	docdate datetime,
	whcode varchar(10),
	shelfcode varchar(15),
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	sorefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	linenumber smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	barcode varchar(20),
	custtypecode varchar(10),
	custgroupcode varchar(10),
	saleareacode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	machineno varchar(10),
	machinecode varchar(30),
	billtime varchar(15),
	cashiercode varchar(10),
	posstatus smallint,
	pricestatus smallint,
	primary key(roworder)
);

default on bpsholdingbillsub
(
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	oppositeqty currency  0.0,
	stocktype smallint 0,
	excepttax smallint 0,
	linenumber smallint 0,
	posstatus smallint 0,
	pricestatus smallint 0,
);


create table bcmemberreward
(
	
	roworder autoincrement not null, 
	docno varchar(25) not null,
	docdate datetime not null,
	arcode varchar(20),
	description varchar(100)
	,primary key(docno)
);
create table bcmmbrewardsub
(
	
	roworder autoincrement not null, 
	docno varchar(25) not null,
	docdate datetime not null,
	arcode varchar(20),
	description varchar(200),
	linenumber smallint,
	rewardtype smallint,
	markuse currency ,
	primary key(roworder)
);

default on bcmmbrewardsub
(
	linenumber smallint 0,
	rewardtype smallint 0,
	markuse currency  0.0,
);


create table bccatchproccess
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime not null,
	curdatetime datetime not null,
	itemcode varchar(25),
	transtype smallint,
	whcode varchar(10),
	shelfcode varchar(15),
	unitcode varchar(10),
	transqty currency ,
	procqty currency ,
	stockqty currency ,
	procresult smallint,
	deletemode smallint,
	periodno smallint,
	computername varchar(100),
	queryupdate varchar(255)
	,primary key(roworder)
);

default on bccatchproccess
(
	transtype smallint 0,
	transqty currency  0.0,
	procqty currency  0.0,
	stockqty currency  0.0,
	procresult smallint 0,
	deletemode smallint 0,
	periodno smallint 0,
);


create table bcitemstandardcost
(
	
	roworder autoincrement not null, 
	itemcode varchar(25) not null,
	unitcode varchar(10),
	startdate datetime ,
	stopdate datetime ,
	standardcost currency ,
	transstate smallint,
	primary key(roworder)
);

default on bcitemstandardcost
(
	standardcost currency  0.0,
	transstate smallint 0,
);


create table bcrecurtemp
(
	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	docdate datetime ,
	mytype smallint,
	taxno varchar(20),
	taxtype smallint,
	arcode varchar(20) not null,
	passbillto varchar(20) ,
	departcode varchar(10),
	creditday smallint,
	deliveryday smallint,
	deliverydate datetime,
	duedate datetime,
	paybilldate datetime,
	salecode varchar(10),
	saleareacode varchar(10),
	taxrate currency ,
	isconfirm smallint,
	mydescription varchar(255),
	billtype smallint,
	billgroup varchar(10),
	refdocno varchar(20),
	crauthorizeman varchar(20),
	deliveryaddr varchar(10),
	contactcode varchar(10),
	transportcode varchar(10),
	sumofitemamount currency ,
	discountword varchar(35),
	discountamount currency ,
	afterdiscount currency ,
	beforetaxamount currency ,
	taxamount currency ,
	totalamount currency ,
	discountcase smallint,
	zerotaxamount currency ,
	excepttaxamount currency ,
	sumcashamount currency ,
	sumchqamount currency ,
	sumcreditamount currency ,
	sumbankamount currency ,
	depositinctax smallint,
	sumofdeposit1 currency ,
	sumofdeposit2 currency ,
	sumofwtax currency ,
	netamount currency ,
	netdebtamount currency ,
	otherincome currency ,
	otherexpense currency ,
	excessamount1 currency ,
	excessamount2 currency ,
	billbalance currency ,
	currencycode varchar(10),
	exchangerate double ,
	glformat varchar(5),
	iscancel smallint,
	iscreditnote smallint,
	isdebitnote smallint,
	isprocessok smallint,
	iscompletesave smallint,
	ispostgl smallint,
	gltransdata smallint,
	paybillstatus smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	recurname varchar(40),
	exchangeprofit currency ,
	custtypecode varchar(10),
	custgroupcode varchar(10),
	creatorcode varchar(10),
	createdatetime datetime,
	isconditionsend smallint,
	ownreceive varchar(100),
	carlicense varchar(30),
	sostatus smallint,
	holdingstatus smallint,
	primary key(roworder)
);

default on bcrecurtemp
(
	mytype smallint 0,
	taxtype smallint 0,
	creditday smallint 0,
	deliveryday smallint 0,
	taxrate currency  7.0,
	isconfirm smallint 0,
	billtype smallint 0,
	sumofitemamount currency  0.0,
	discountamount currency  0.0,
	afterdiscount currency  0.0,
	beforetaxamount currency  0.0,
	taxamount currency  0.0,
	totalamount currency  0.0,
	discountcase smallint 0,
	zerotaxamount currency  0.0,
	excepttaxamount currency  0.0,
	sumcashamount currency  0.0,
	sumchqamount currency  0.0,
	sumcreditamount currency  0.0,
	sumbankamount currency  0.0,
	depositinctax smallint 1,
	sumofdeposit1 currency  0.0,
	sumofdeposit2 currency  0.0,
	sumofwtax currency  0.0,
	netamount currency  0.0,
	netdebtamount currency  0.0,
	otherincome currency  0.0,
	otherexpense currency  0.0,
	excessamount1 currency  0.0,
	excessamount2 currency  0.0,
	billbalance currency  0.0,
	exchangerate double  1.0,
	iscancel smallint 0,
	iscreditnote smallint 0,
	isdebitnote smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
	ispostgl smallint 0,
	gltransdata smallint 0,
	paybillstatus smallint 0,
	exchangeprofit currency  0.0,
	isconditionsend smallint 0,
	sostatus smallint 0,
	holdingstatus smallint 0,
);


create table bcrecurtempsub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	recurname varchar(40),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	arcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(255),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(15),
	remainqty currency ,
	cnqty currency ,
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	sumofcost currency ,
	balanceamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	oppositeprice2 currency ,
	sorefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	linenumber smallint,
	reflinenumber smallint,
	transstate smallint,
	iscancel smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	sostatus smallint,
	holdingstatus smallint,
	barcode varchar(20),
	custtypecode varchar(10),
	custgroupcode varchar(10),
	saleareacode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	posstatus smallint,
	ispromotion smallint,
	premiumstatus smallint,
	fixunitcost currency ,
	fixunitqty currency ,
	primary key(roworder)
);

default on bcrecurtempsub
(
	behindindex smallint 1,
	mytype smallint 0,
	taxtype smallint 0,
	remainqty currency  0.0,
	cnqty currency  0.0,
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	sumofcost currency  0.0,
	balanceamount currency  0.0,
	oppositeqty currency  0.0,
	oppositeprice2 currency  0.0,
	stocktype smallint 0,
	excepttax smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	exchangerate double  1.0,
	sostatus smallint 0,
	holdingstatus smallint 0,
	posstatus smallint 0,
	ispromotion smallint 0,
	premiumstatus smallint 0,
	fixunitcost currency  0.0,
	fixunitqty currency  0.0,
);


create table bcquotationstatus
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bccontactlist
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	address varchar(255),
	telephone varchar(30),
	parentcode varchar(20) not null,
	mytype smallint,
	picturefilename varchar(100),
	cardpicfilename varchar(100),
	personposition varchar(50),
	defaultstatus smallint,
	myjob varchar(50)
	,primary key(code,parentcode,mytype)
);

default on bccontactlist
(
	mytype smallint 0 not null,
);


create index idx_cclname on bccontactlist(name);
create index idx_cclpcode on bccontactlist(parentcode);
create index idx_ccltype on bccontactlist(mytype);
create table bcbank
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcbankbranch
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcbankbook
(
	
	roworder autoincrement not null, 
	bookno varchar(30) not null,
	name varchar(50),
	accounttype varchar(10) not null,
	bankcode varchar(50),
	branchcode varchar(10),
	accountcode varchar(20),
	balance currency ,
	primary key(bookno)
);

default on bcbankbook
(
	balance currency  0.0,
);


create table bcbankconhd
(
	
	roworder autoincrement not null, 
	bankcode varchar(50),
	branchcode varchar(10)
	,primary key(roworder)
);
create table bcbankcontact
(
	
	roworder autoincrement not null, 
	bankcode varchar(50),
	branchcode varchar(10),
	bookno varchar(30) not null,
	code varchar(10) not null,
	name varchar(50) not null,
	address varchar(255),
	telephone varchar(30),
	picturefilename varchar(100),
	cardpicfilename varchar(100),
	personposition varchar(50),
	defaultstatus smallint,
	primary key(roworder)
);

default on bcbankcontact
(
	defaultstatus smallint 1,
);


create table bcbankaccount
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcbankinterests
(
	
	roworder autoincrement not null, 
	bankcode varchar(10) not null,
	accounttype varchar(10) not null,
	interests double ,
	createdatetime datetime,
	mydescription varchar(255)
	,primary key(roworder)
);

default on bcbankinterests
(
	interests double  0.0,
);


create index idx_interests_1 on bcbankinterests ( bankcode );
create index idx_interests_2 on bcbankinterests ( accounttype );
create table bcinterestslog
(
	
	roworder autoincrement not null, 
	bankcode varchar(10) not null,
	accounttype varchar(10) not null,
	interests double ,
	createdatetime datetime,
	mydescription varchar(100),
	creatorcode varchar(10)
	,primary key(roworder)
);

default on bcinterestslog
(
	interests double  0.0,
);


create index idx_interestsl_1 on bcinterestslog ( bankcode );
create index idx_interestsl_2 on bcinterestslog ( accounttype );
create index idx_interestsl_3 on bcinterestslog ( createdatetime );
create table bccurrency
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	exchangerate double ,
	exchangedate datetime,
	symbol varchar(2),
	primary key(code)
);

default on bccurrency
(
	exchangerate double  1.0,
	symbol varchar 2  'ß',
);


create table bcbankcurrency
(
	
	roworder autoincrement not null, 
	bankcode varchar(10) not null,
	currencycode varchar(10) not null,
	exchangerate double ,
	exchangedate datetime,
	mydescription varchar(255)
	,primary key(roworder)
);

default on bcbankcurrency
(
	exchangerate double  1.0,
);


create table bccurrencylog
(
	
	roworder autoincrement not null, 
	bankcode varchar(10) not null,
	currencycode varchar(10) not null,
	exchangerate double ,
	exchangedate datetime,
	mydescription varchar(100),
	creatorcode varchar(10),
	createdatetime datetime
	,primary key(roworder)
);

default on bccurrencylog
(
	exchangerate double  1.0,
);


create table bcbankservice
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcservicefee
(
	
	roworder autoincrement not null, 
	servicecode varchar(10) not null,
	bankcode varchar(10) not null,
	servicefee currency ,
	mydescription varchar(255)
	,primary key(roworder )
);

default on bcservicefee
(
	servicefee currency  0.0,
);


create index idx_servicef_1 on bcservicefee ( servicecode );
create index idx_servicef_2 on bcservicefee ( bankcode );
create table bcchqstatus
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null
	,primary key(code)
);
create table bcchqstatuslog
(
	
	roworder autoincrement not null, 
	chqtype smallint,
	chqnumber varchar(20),
	bankcode varchar(10),
	bankbranchcode varchar(10),
	statuscode varchar(10),
	creatorcode varchar(10),
	createdatetime datetime
	,primary key(roworder)
);

default on bcchqstatuslog
(
	chqtype smallint 0,
);


create table bccreditlimit
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50),
	creditcheck smallint,
	chqreturncheck smallint,
	overduecheck smallint,
	overday smallint,
	creditexpirecheck smallint,
	expireday smallint,
	primary key(code)
);

default on bccreditlimit
(
	creditcheck smallint 0,
	chqreturncheck smallint 0,
	overduecheck smallint 0,
	overday smallint 0,
	creditexpirecheck smallint 0,
	expireday smallint 0,
);


create index idx_bccrelim_1 on bccreditlimit( code);
create table bcarcreditgroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(255),
	limitcode varchar(10),
	isgroup smallint,
	amount currency ,
	expire_date datetime,
	startdate datetime,
	cleanvalue currency ,
	mydescription varchar(255),
	maxamount currency ,
	primary key(code)
);

default on bcarcreditgroup
(
	isgroup smallint 0,
	amount currency  0.0,
	cleanvalue currency  0.0,
	maxamount currency  0.0,
);


create index idx_bccregrp_1 on bcarcreditgroup( code);
create table bcarcreditgrpde
(
	
	roworder autoincrement not null, 
	linenumber smallint,
	mastercode varchar(10) not null,
	refdocno varchar(20) ,
	startdate datetime,
	expire_date datetime,
	mydescription varchar(255),
	amount currency ,
	insuretype varchar(10)
	,primary key(roworder)
);

default on bcarcreditgrpde
(
	linenumber smallint 0,
	amount currency  0.0,
);


create table bccondmaster
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	creatorcode varchar(10),
	docdate datetime,
	systemname varchar(20) not null
	,primary key(code)
);
create table bcconddocdate
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	systemname varchar(20) not null,
	creatorcode varchar(10),
	linenumber smallint,
	typename varchar(20),
	startformuladate varchar(20),
	stopformuladate varchar(20),
	startdate datetime,
	stopdate datetime
	,primary key(roworder)
);

default on bcconddocdate
(
	linenumber smallint 0,
);


create table bccondlinkcode
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	systemname varchar(20) not null,
	creatorcode varchar(10),
	linenumber smallint,
	typename varchar(20),
	startcode varchar(20),
	stopcode varchar(20)
	,primary key(roworder)
);

default on bccondlinkcode
(
	linenumber smallint 0,
);


create table bccondorderby
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	systemname varchar(20) not null,
	creatorcode varchar(10),
	linenumber smallint,
	ordercode varchar(20)
	,primary key(roworder)
);

default on bccondorderby
(
	linenumber smallint 0,
);


create table bcinsuretype
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50)
	,primary key(code)
);
create table bcprocesslog
(
	
	roworder autoincrement not null, 
	docno varchar(30),
	mode smallint,
	transtype smallint,
	transstate smallint,
	inserttime datetime ,
	processtime datetime
	,primary key(roworder)
);

default on bcprocesslog
(
	mode smallint 0,
	transstate smallint 0,
);


create table processbarcode
(
	
	roworder autoincrement not null, 
	itemcode varchar(50)
	,primary key(roworder)
);
create table processstatus
(
	
	roworder autoincrement not null, 
	itemcode varchar(50),
	docdate datetime
	,primary key(roworder)
);
create table processstatus2
(
	
	roworder autoincrement not null, 
	itemcode varchar(50),
	docdate datetime
	,primary key(roworder)
);
create table processstock
(
	
	roworder autoincrement not null, 
	itemcode varchar(50),
	docdate datetime
	,primary key(roworder)
);
create table processdoc
(
	
	roworder autoincrement not null, 
	docno varchar(50),
	doctype int,
	primary key(roworder)
);

default on processdoc
(
	doctype int 0,
);


create table reportstockitemqty
(
	roworder int not null identity (0,1),
	code varchar(25),
	name1 varchar(200),
	name2 varchar(200),
	shortname varchar(100),
	caterycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10) ,
	colorcode varchar(10),
	mygrade varchar(40),
	myclass varchar(20),
	genericcode varchar(10),
	unittype smallint,
	defstkunitcode varchar(10),
	defsaleunitcode varchar(10),
	defbuyunitcode varchar(10),
	oppositeunit varchar(10),
	oppositeunit2 varchar(10),
	opposite1price currency ,
	oppositerate currency  ,
	mysize varchar(40),
	weight currency  ,
	lastupdate datetime ,
	stocktype smallint ,
	stockprocess smallint,
	vendercode varchar(20),
	depositcondit varchar(35),
	deliverycharge varchar(35),
	installcharge varchar(35),
	returnremark varchar(100),
	returnstatus smallint ,
	returncharge varchar(30),
	itemstatus varchar(10),
	newitemstatus smallint,
	renovatestatus smallint,
	excepttax smallint,
	promotiontype smallint,
	wtaxrate currency  ,
	wavefile varchar(50),
	costtype smallint,
	orderpoint currency  ,
	stockmin currency ,
	stockmax currency ,
	stockqty currency ,
	averagecost currency ,
	amount currency ,
	costofarea currency ,
	lastbuyprice currency ,
	standardcost currency ,
	picfilename1 varchar(100),
	picfilename2 varchar(100),
	picfilename3 varchar(100),
	picfilename4 varchar(100),
	specfilename varchar(100),
	avifilename varchar(100),
	accgroupcode varchar(10),
	mydescription varchar(255),
	defbuywhcode varchar(10),
	defbuyshelf varchar(15),
	defsalewhcode varchar(10),
	defsaleshelf varchar(15),
	defbadwhcode varchar(10),
	defbadshelf varchar(15),
	deffgwhcode varchar(10),
	deffgshelf varchar(15),
	defrepairwhcode varchar(10),
	defrepairshelf varchar(15),
	defrawwhcode varchar(10),
	defrawshelf varchar(15),
	formula1 varchar(10),
	formula2 varchar(10),
	formula3 varchar(10),
	discount varchar(35),
	reserveqty currency ,
	remainoutqty currency ,
	remaininqty currency ,
	baseprice currency ,
	activestatus smallint,
	creatorcode varchar(10),
	createdatetime datetime ,
	lasteditorcode varchar(10),
	lasteditdatet datetime ,
	confirmcode varchar(10),
	confirmdatetime datetime ,
	cancelcode varchar(10),
	canceldatetime datetime ,
	saleprice1 currency ,
	saleprice2 currency ,
	saleprice3 currency ,
	deffixunitcode varchar(10),
	deffixunitcost currency ,
	fixqty currency ,
	fixcost currency ,
	salepricenv1 currency ,
	salepricenv2 currency ,
	salepricenv3 currency ,
	processstatus smallint,
	isgift smallint,
	promomember smallint,
	promotype smallint,
	averagecostreal currency ,
	overreceive currency ,
	primary key(roworder)
);

default on reportstockitemqty
(
	reserveqty currency  0.0,
	remainoutqty currency  0.0,
	remaininqty currency  0.0,
	baseprice currency  0.0,
	saleprice1 currency  0.0,
	saleprice2 currency  0.0,
	saleprice3 currency  0.0,
	deffixunitcost currency  0.0,
	fixqty currency  0.0,
	fixcost currency  0.0,
	salepricenv1 currency  0.0,
	salepricenv2 currency  0.0,
	salepricenv3 currency  0.0,
	averagecostreal currency  0.0,
	overreceive currency  0.0,
);


create table reportstockqty
(
	roworder int not null identity (0, 1),
	code varchar(25) ,
	name1 varchar(200),
	name2 varchar(200),
	shortname varchar(100),
	caterycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	colorcode varchar(10),
	mygrade varchar(40),
	myclass varchar(20),
	genericcode varchar(10),
	unittype smallint,
	defstkunitcode varchar(10),
	defsaleunitcode varchar(10),
	defbuyunitcode varchar(10),
	oppositeunit varchar(10),
	oppositeunit2 varchar(10),
	opposite1price currency ,
	oppositerate currency ,
	mysize varchar(40),
	weight currency ,
	lastupdate datetime ,
	stocktype smallint,
	stockprocess smallint,
	vendercode varchar(20),
	depositcondit varchar(35),
	deliverycharge varchar(35),
	installcharge varchar(35),
	returnremark varchar(100),
	returnstatus smallint,
	returncharge varchar(30),
	itemstatus varchar(10),
	newitemstatus smallint,
	renovatestatus smallint,
	excepttax smallint,
	promotiontype smallint,
	wtaxrate currency ,
	wavefile varchar(50),
	costtype smallint,
	orderpoint currency ,
	stockmin currency ,
	stockmax currency ,
	stockqty currency ,
	averagecost currency ,
	amount currency ,
	costofarea currency ,
	lastbuyprice currency ,
	standardcost currency ,
	picfilename1 varchar(100),
	picfilename2 varchar(100),
	picfilename3 varchar(100),
	picfilename4 varchar(100),
	specfilename varchar(100),
	avifilename varchar(100),
	accgroupcode varchar(10),
	mydescription varchar(255),
	defbuywhcode varchar(10),
	defbuyshelf varchar(15),
	defsalewhcode varchar(10),
	defsaleshelf varchar(15),
	defbadwhcode varchar(10),
	defbadshelf varchar(15),
	deffgwhcode varchar(10),
	deffgshelf varchar(15),
	defrepairwhcode varchar(10),
	defrepairshelf varchar(15),
	defrawwhcode varchar(10),
	defrawshelf varchar(15),
	formula1 varchar(10),
	formula2 varchar(10),
	formula3 varchar(10),
	discount varchar(35),
	reserveqty currency ,
	remainoutqty currency ,
	remaininqty currency ,
	baseprice currency ,
	activestatus smallint,
	creatorcode varchar(10),
	createdatetime datetime ,
	lasteditorcode varchar(10),
	lasteditdatet datetime ,
	confirmcode varchar(10),
	confirmdatetime datetime ,
	cancelcode varchar(10),
	canceldatetime datetime ,
	saleprice1 currency ,
	saleprice2 currency ,
	saleprice3 currency ,
	deffixunitcode varchar(10),
	deffixunitcost currency ,
	fixqty currency ,
	fixcost currency ,
	salepricenv1 currency ,
	salepricenv2 currency ,
	salepricenv3 currency ,
	processstatus smallint,
	isgift smallint,
	promomember smallint,
	promotype smallint,
	averagecostreal currency ,
	overreceive currency ,
	primary key(roworder)
);

default on reportstockqty
(
	opposite1price currency  0.0,
	oppositerate currency  0.0,
	weight currency  0.0,
	wtaxrate currency  0.0,
	orderpoint currency  0.0,
	stockmin currency  0.0,
	stockmax currency  0.0,
	stockqty currency  0.0,
	averagecost currency  0.0,
	amount currency  0.0,
	costofarea currency  0.0,
	lastbuyprice currency  0.0,
	standardcost currency  0.0,
	reserveqty currency  0.0,
	remainoutqty currency  0.0,
	remaininqty currency  0.0,
	baseprice currency  0.0,
	saleprice1 currency  0.0,
	saleprice2 currency  0.0,
	saleprice3 currency  0.0,
	deffixunitcost currency  0.0,
	fixqty currency  0.0,
	fixcost currency  0.0,
	salepricenv1 currency  0.0,
	salepricenv2 currency  0.0,
	salepricenv3 currency  0.0,
	averagecostreal currency  0.0,
	overreceive currency  0.0,
);


create table reportstockqtysub
(
	roworder int not null identity (0, 1),
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime ,
	custcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(255),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(10),
	cnqty currency ,
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	sumofcost currency ,
	balanceamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	oppositeprice2 currency ,
	sorefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double  null ,
	barcode varchar(20),
	custtypecode varchar(10),
	custgroupcode varchar(10),
	saleareacode varchar(10),
	caterycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	machineno varchar(10),
	machinecode varchar(30),
	billtime varchar(15),
	cashiercode varchar(10),
	shiftno smallint,
	posstatus smallint,
	pricestatus smallint,
	ispromotion smallint,
	isexport smallint,
	packingrate1 currency ,
	packingrate2 currency ,
	packingratio currency ,
	packingqty currency ,
	packingcost currency ,
	roworder2 int,
	isprocesstype int,
	defstkunitcode varchar(10),
	unitname varchar(50),
	balanceqty currency ,
	averagecost currency ,
	standardrate currency ,
	primary key(roworder)
);

default on reportstockqtysub
(
	cnqty currency  0.0,
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	sumofcost currency  0.0,
	balanceamount currency  0.0,
	oppositeqty currency  0.0,
	oppositeprice2 currency  0.0,
	packingrate1 currency  0.0,
	packingrate2 currency  0.0,
	packingratio currency  0.0,
	packingqty currency  0.0,
	packingcost currency  0.0,
	balanceqty currency  0.0,
	averagecost currency  0.0,
	standardrate currency  0.0,
);


create table bcallitemsub
(
	
	roworder autoincrement not null, 
	behindindex smallint,
	mytype smallint,
	docno varchar(20),
	taxno varchar(20),
	taxtype smallint,
	itemcode varchar(25),
	docdate datetime,
	custcode varchar(20),
	departcode varchar(10),
	salecode varchar(10),
	mydescription varchar(255),
	itemname varchar(255),
	whcode varchar(10),
	shelfcode varchar(10),
	cnqty currency ,
	qty currency ,
	price currency ,
	discountword varchar(35),
	discountamount currency ,
	amount currency ,
	netamount currency ,
	homeamount currency ,
	sumofcost currency ,
	balanceamount currency ,
	unitcode varchar(10),
	oppositeunit varchar(10),
	oppositeqty currency ,
	oppositeprice2 currency ,
	sorefno varchar(20),
	stocktype smallint,
	excepttax smallint,
	linenumber smallint,
	transstate smallint,
	iscancel smallint,
	allocatecode varchar(10),
	projectcode varchar(10),
	currencycode varchar(10),
	exchangerate double ,
	barcode varchar(20),
	custtypecode varchar(10),
	custgroupcode varchar(10),
	saleareacode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	machineno varchar(10),
	machinecode varchar(30),
	billtime varchar(15),
	cashiercode varchar(10),
	shiftno smallint,
	posstatus smallint,
	pricestatus smallint,
	ispromotion smallint,
	isexport smallint,
	packingrate1 currency ,
	packingrate2 currency ,
	packingratio currency ,
	packingqty currency ,
	packingcost currency ,
	roworder2 int,
	isprocesstype smallint,
	balanceqty currency ,
	averagecost currency ,
	rowindex int,
	refinvoiceno varchar(50)
	,primary key(roworder)
);

default on bcallitemsub
(
	behindindex smallint 0,
	mytype smallint 0,
	taxtype smallint 0,
	cnqty currency  0.0,
	qty currency  0.0,
	price currency  0.0,
	discountamount currency  0.0,
	amount currency  0.0,
	netamount currency  0.0,
	homeamount currency  0.0,
	sumofcost currency  0.0,
	balanceamount currency  0.0,
	oppositeqty currency  0.0,
	oppositeprice2 currency  0.0,
	stocktype smallint 0,
	excepttax smallint 0,
	linenumber smallint 0,
	transstate smallint 0,
	iscancel smallint 0,
	exchangerate double  1.0,
	shiftno smallint 0,
	posstatus smallint 0,
	pricestatus smallint 0,
	ispromotion smallint 0,
	isexport smallint 0,
	packingrate1 currency  0.0,
	packingrate2 currency  0.0,
	packingratio currency  0.0,
	packingqty currency  0.0,
	packingcost currency  0.0,
	balanceqty currency  0.0,
	averagecost currency  0.0,
);


create table bccomoil
(
	
	roworder autoincrement not null, 
	atmonth smallint,
	atyear smallint,
	atdate datetime,
	carperkm currency ,
	bikeperkm currency ,
	remark varchar(255),
	amount currency ,
	primary key (roworder)
);

default on bccomoil
(
	atmonth smallint 0,
	atyear smallint 0,
	carperkm currency  0.0,
	bikeperkm currency  0.0,
	amount currency  0.0,
);


create index idx_co_am on bccomoil ( atmonth );
create table bccomoilsub
(
	
	roworder autoincrement not null, 
	atmonth smallint,
	atyear smallint,
	salecode varchar(30),
	targetamount currency ,
	receiptamount currency ,
	saleamount currency ,
	percenttarget currency ,
	esaleamount currency ,
	saletotalamount currency ,
	comrate currency ,
	comcalamount currency ,
	truereceiptamount currency ,
	carlicense varchar(20),
	km currency ,
	oilcalold currency ,
	oilcalsale currency ,
	comamount currency ,
	debitamount currency ,
	discountamount currency ,
	returnamount currency ,
	primary key (roworder)
);

default on bccomoilsub
(
	atmonth smallint 0,
	atyear smallint 0,
	targetamount currency  0.0,
	receiptamount currency  0.0,
	saleamount currency  0.0,
	percenttarget currency  0.0,
	esaleamount currency  0.0,
	saletotalamount currency  0.0,
	comrate currency  0.0,
	comcalamount currency  0.0,
	truereceiptamount currency  0.0,
	km currency  0.0,
	oilcalold currency  0.0,
	oilcalsale currency  0.0,
	comamount currency  0.0,
	debitamount currency  0.0,
	discountamount currency  0.0,
	returnamount currency  0.0,
);


create index idx_co_ams on bccomoilsub ( atmonth );
create index idx_co_scs on bccomoilsub ( salecode );
create table bcusergroup
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(100) not null
	,primary key(code)
);
create table bcpriceerect
(
	
	roworder autoincrement not null, 
	itemcode varchar(25) not null,
	unitcode varchar(10) ,
	priceerect varchar(50),
	mydescription varchar(255)
	,primary key(roworder)
);
create table bcitemwarehouse
(
	
	roworder autoincrement not null, 
	itemcode varchar(25) not null,
	whcode varchar(10) not null,
	shelfcode varchar(10)
	,primary key(roworder)
);
create table reportstatus
(
	
	roworder autoincrement not null, 
	sessionid varchar(50) not null,
	reportid varchar(25) not null,
	isfinish smallint,
	reqtime datetime,
	finishtime datetime,
	startdate datetime,
	stopdate datetime,
	groupby varchar(50),
	outfilename varchar(255),
	condition varchar(2000),
	condition2 varchar(2000),
	condition3 varchar(2000),
	progress int,
	primary key (sessionid)
);

default on reportstatus
(
	isfinish smallint 0,
	progress int 0,
);


create table fielddetail
(
	
	roworder autoincrement not null, 
	idcode varchar(100),
	tablename varchar(255),
	fielddata varchar(255),
	mydescription varchar(255),
	fieldtype varchar(100),
	linktable varchar(255)
	,primary key (roworder)
);
create table fieldconfig
(
	
	roworder autoincrement not null, 
	idcode varchar(100),
	tablename varchar(255),
	fielddata varchar(255),
	mydescription varchar(255),
	fieldtype varchar(100),
	linktable varchar(255)
	,primary key (roworder)
);
create table bcpovoid
(
	
	roworder autoincrement not null, 
	docno varchar(30) not null,
	docdate datetime not null,
	departcode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	requestuid varchar(10),
	approveuid varchar(10),
	totalamount currency ,
	voidreasoncode varchar(10),
	remark varchar(250),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	primary key(docno)
);

default on bcpovoid
(
	totalamount currency  0.0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create index idx_povoid_docdate on bcpovoid (docdate);
create table bcpovoidsub
(
	
	roworder autoincrement not null, 
	docno varchar(30) not null,
	docdate datetime not null,
	apcode varchar(20),
	pono varchar(30) not null,
	departcode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	itemcode varchar(35) not null,
	mydescription varchar(100),
	price currency ,
	unitcode varchar(10) not null,
	whcode varchar(15),
	shelfcode varchar(15),
	qty currency ,
	voidqty currency ,
	podate datetime,
	poduedate datetime,
	amount currency ,
	cancelall smallint,
	iscancel smallint,
	linenumber smallint,
	reflinenumber smallint,
	transstate smallint,
	primary key(roworder)
);

default on bcpovoidsub
(
	price currency  0.0,
	qty currency  0.0,
	voidqty currency  0.0,
	amount currency  0.0,
	cancelall smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	transstate smallint 0,
);


create index idx_povoids_docdate on bcpovoidsub (docdate);
create index idx_povoids_apcode on bcpovoidsub (apcode);
create index idx_povoids_po on bcpovoidsub (pono);
create index idx_povoids_itemcode on bcpovoidsub (itemcode);
create table bcsovoid
(
	
	roworder autoincrement not null, 
	docno varchar(30) not null,
	docdate datetime not null,
	departcode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	requestuid varchar(10),
	approveuid varchar(10),
	totalamount currency ,
	voidreasoncode varchar(10),
	remark varchar(250),
	creatorcode varchar(10),
	createdatetime datetime,
	lasteditorcode varchar(10),
	lasteditdatet datetime,
	confirmcode varchar(10),
	confirmdatetime datetime,
	cancelcode varchar(10),
	canceldatetime datetime,
	iscancel smallint,
	isprocessok smallint,
	iscompletesave smallint,
	primary key(docno)
);

default on bcsovoid
(
	totalamount currency  0.0,
	iscancel smallint 0,
	isprocessok smallint 0,
	iscompletesave smallint 0,
);


create index idx_sovoid_docdate on bcsovoid (docdate);
create table bcsovoidsub
(
	
	roworder autoincrement not null, 
	docno varchar(30) not null,
	docdate datetime not null,
	arcode varchar(20),
	sono varchar(30) not null,
	departcode varchar(10),
	allocatecode varchar(10),
	projectcode varchar(10),
	categorycode varchar(10),
	groupcode varchar(10),
	brandcode varchar(10),
	typecode varchar(10),
	formatcode varchar(10),
	itemcode varchar(35) not null,
	mydescription varchar(100),
	price currency ,
	unitcode varchar(10) not null,
	whcode varchar(15),
	shelfcode varchar(15),
	qty currency ,
	voidqty currency ,
	sodate datetime,
	soduedate datetime,
	amount currency ,
	cancelall smallint,
	iscancel smallint,
	linenumber smallint,
	reflinenumber smallint,
	transstate smallint,
	primary key(roworder)
);

default on bcsovoidsub
(
	price currency  0.0,
	qty currency  0.0,
	voidqty currency  0.0,
	amount currency  0.0,
	cancelall smallint 0,
	iscancel smallint 0,
	linenumber smallint 0,
	reflinenumber smallint 0,
	transstate smallint 0,
);


create index idx_sovoids_docdate on bcsovoidsub (docdate);
create index idx_sovoids_apcode on bcsovoidsub (arcode);
create index idx_sovoids_so on bcsovoidsub (sono);
create index idx_sovoids_itemcode on bcsovoidsub (itemcode);
create table processitemreport
(
	
	roworder autoincrement not null, 
	itemcode varchar(50),
	docdate datetime,
	sessionid varchar(50)
	,primary key(roworder)
);
create table bccancelreason
(
	
	roworder autoincrement not null, 
	code varchar(100),
	name varchar(100)
	,primary key(roworder)
);
create table bccar
(
	
	roworder autoincrement not null, 
	code varchar(10) not null,
	name varchar(50) not null,
	primary key(code)
);
create table bccaridforpo
(
	
	roworder autoincrement not null, 
	docno varchar(30),
	carid varchar(20),
	transcode varchar(10),
	docdate datetime,
	pointreceive varchar(10),
	mydescription varchar(255),
	linenumber smallint,
	companyid varchar(20)
	,primary key(roworder)
);

default on bccaridforpo
(
	linenumber smallint 0,
);


create table bchistoryadjustprice
(
	
	roworder autoincrement not null, 
	itemcode varchar(25),
	unitcode varchar(10),
	startqty currency ,
	stopqty currency ,
	startdate datetime,
	stopdate datetime,
	saletype smallint,
	transporttype smallint,
	saleprice1 varchar(50),
	saleprice2 varchar(50),
	saleprice3 varchar(50),
	saleprice4 varchar(50),
	saleprice5 varchar(50),
	saleprice6 varchar(50),
	saleprice7 varchar(50),
	saleprice8 varchar(50),
	taxtype smallint,
	linenumber smallint,
	transstate smallint,
	adjustdesc varchar(20),
	creatorcode varchar(10),
	docno varchar(20),
	createdatetime datetime
	,primary key(roworder)
);

default on bchistoryadjustprice
(
	startqty currency  0.0,
	stopqty currency  0.0,
	saletype smallint 0,
	transporttype smallint 0,
	taxtype smallint 0,
	linenumber smallint 0,
	transstate smallint 0,
);


create table bcpricelist2head (	
	roworder autoincrement not null, 
	docno varchar(20) not null,
	startqty currency ,
	stopqty currency ,
	startdate datetime,
	stopdate datetime,
	saletype smallint,
	saletypename varchar(50),
	transportname varchar(50),
	taxname varchar(50),
	transporttype smallint,
	taxtype smallint,
	transstate smallint,
	primary key(docno)
);

default on bcpricelist2head
(
	startqty currency  0.0,
	stopqty currency  0.0,
	saletype smallint 0,
	transporttype smallint 0,
	taxtype smallint 0,
	transstate smallint 0,
);


create table bcsysupdateprice (	
	roworder autoincrement not null, 
	fieldname varchar(200) not null,
	settemplate smallint,
	length varchar(10),
	usertype varchar(50),
	mydescription varchar(255),
	useflag smallint,
	linktable varchar(100),
	datatype varchar(50),
	templatename varchar(50)
	,primary key(roworder,settemplate)
);

default on bcsysupdateprice
(
	settemplate smallint 0 not null,
	useflag smallint 0,
);


create table bcrecpoint
(
	
	roworder autoincrement not null, 
	productcode varchar(20),
	code varchar(10) not null,
	priority smallint,
	iswarehouse smallint,
	linenumber smallint,
	primary key(roworder)
);

default on bcrecpoint
(
	priority smallint 0,
	iswarehouse smallint 0,
	linenumber smallint 0,
);


create index idx_recpoint_1 on bcrecpoint(roworder);
create table bcrecproduct
(
	
	roworder autoincrement not null, 
	productcode varchar(20),
	whcode varchar(10),
	shelfcode varchar(15),
	unitcode varchar(10),
	priority smallint,
	minamount currency ,
	maxamount currency ,
	linenumber smallint,
	primary key(roworder)
);

default on bcrecproduct
(
	priority smallint 0,
	minamount currency  0.0,
	maxamount currency  0.0,
	linenumber smallint 0,
);


create index idx_recprodt_1 on bcrecproduct(roworder);
create table bchistorymaster
(
	
	roworder autoincrement not null, 
	oldcode varchar(25) not null,
	newcode varchar(25),
	transkey varchar(100)
	,primary key(roworder)
);
