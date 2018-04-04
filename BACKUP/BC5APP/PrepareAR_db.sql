--dbversion=1
--progstring=preparear_db

--Update exchangerate
update bcarinvbalance set exchangerate = 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;
update bcarinvoice set exchangerate = 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;
update bcarotherdebt set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null; 
update bcdebitnote1 set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null; 
update bccreditnote set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;
update bcreceiptsub3 set invExchangerate= 1.00 where invExchangerate = 0 or invExchangerate is null or invcurrency is null;
update bcreceiptsub1 set invExchangerate= 1.00 where invExchangerate = 0 or invExchangerate is null or invcurrency is null;
update bcardepositspecial set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;  
update bcreturndepspecial set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null; 


