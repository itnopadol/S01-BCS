--dbversion=1
--progstring=prepare_db
--Update warehouse and shelf from sale invoice
update bclotout set whcode = (select distinct whcode from bcarinvoicesub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
, shelfcode = (select distinct shelfcode from bcarinvoicesub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
where transtype = 4 and (whcode is null or shelfcode is null);

--Update warehouse and shelf from customer debitnote
update bclotout set whcode = (select distinct whcode from bcdebitnotesub1 where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
, shelfcode = (select distinct shelfcode from bcdebitnotesub1 where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
where transtype = 6  and (whcode is null or shelfcode is null);

--Update warehouse and shelf from supplier return
update bclotout set whcode = (select distinct whcode from bcstkrefundsub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
, shelfcode = (select distinct shelfcode from bcstkrefundsub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
where transtype = 7  and (whcode is null or shelfcode is null);

--Update warehouse and shelf from issue
update bclotout set whcode = (select distinct whcode from bcstkissuesub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
, shelfcode = (select distinct shelfcode from bcstkissuesub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
where transtype = 8  and (whcode is null or shelfcode is null);

--Update warehouse and shelf from Adjust descrease
update bclotout set whcode = (select distinct whcode from bcstkadjustsub where adjmark = 1 and docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
, shelfcode = (select distinct shelfcode from bcstkadjustsub where adjmark = 1 and docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
where transtype = 11  and (whcode is null or shelfcode is null);

--Update warehouse and shelf from Adjust minute
update bclotout set whcode = (select distinct fromwh from bcstktransfsub where  docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
, shelfcode = (select distinct fromshelf from bcstktransfsub where docno=bclotout.docno and linenumber=bclotout.billlinenumber) 
where transtype = 13  and (whcode is null or shelfcode is null);

