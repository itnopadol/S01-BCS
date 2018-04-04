--dbversion=1
--progstring=prepare_db
--Update warehouse and shelf from sale invoice
update bclotout,bcarinvoicesub set 
 bclotout.whcode = bcarinvoicesub.whcode
,bclotout.shelfcode = bcarinvoicesub.shelfcode
where bclotout.transtype = 4 
and (bclotout.whcode is null or bclotout.shelfcode is null)
and bclotout.docno =bcarinvoicesub.docno 
and bclotout.billlinenumber=bcarinvoicesub.linenumber;

--Update warehouse and shelf from customer debitnote
update bclotout,bcdebitnotesub1 set 
 bclotout.whcode = bcdebitnotesub1.whcode
,bclotout.shelfcode = bcdebitnotesub1.shelfcode
where bclotout.transtype = 6 
and (bclotout.whcode is null or bclotout.shelfcode is null)
and bclotout.docno =bcdebitnotesub1.docno 
and bclotout.billlinenumber=bcdebitnotesub1.linenumber;

--Update warehouse and shelf from supplier return
update bclotout,bcstkrefundsub set 
 bclotout.whcode = bcstkrefundsub.whcode
,bclotout.shelfcode = bcstkrefundsub.shelfcode
where bclotout.transtype = 7 
and (bclotout.whcode is null or bclotout.shelfcode is null)
and bclotout.docno =bcstkrefundsub.docno 
and bclotout.billlinenumber=bcstkrefundsub.linenumber;

--Update warehouse and shelf from issue
update bclotout,bcstkissuesub set 
 bclotout.whcode = bcstkissuesub.whcode
,bclotout.shelfcode = bcstkissuesub.shelfcode
where bclotout.transtype = 8 
and (bclotout.whcode is null or bclotout.shelfcode is null)
and bclotout.docno =bcstkissuesub.docno 
and bclotout.billlinenumber=bcstkissuesub.linenumber;

--Update warehouse and shelf from Adjust descrease
update bclotout,bcstkadjustsub set 
 bclotout.whcode = bcstkadjustsub.whcode
,bclotout.shelfcode = bcstkadjustsub.shelfcode
where bclotout.transtype = 11
and (bclotout.whcode is null or bclotout.shelfcode is null)
and bclotout.docno =bcstkadjustsub.docno 
and bclotout.billlinenumber=bcstkadjustsub.linenumber
and bcstkadjustsub.adjmark = 1;

--Update warehouse and shelf from Adjust minute
update bclotout,bcstktransfsub set 
 bclotout.whcode = bcstktransfsub.whcode
,bclotout.shelfcode = bcstktransfsub.shelfcode
where bclotout.transtype = 13
and (bclotout.whcode is null or bclotout.shelfcode is null)
and bclotout.docno =bcstktransfsub.docno 
and bclotout.billlinenumber=bcstktransfsub.linenumber
