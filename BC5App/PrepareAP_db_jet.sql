--dbversion=1
--progstring=prepareap_db

--Update exchangerate
update bcapinvbalance set exchangerate = 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;
update bcapinvbalance set iscancel = 0 where iscancel is null ;
update bcapinvoice set exchangerate = 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;
update bcapotherdebt set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null; 
update bcdebitnote2 set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null; 
update bcstkrefund set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;
update bcpaymentsub set invExchangerate= 1.00 where invExchangerate = 0 or invExchangerate is null or invcurrency is null;
update bcpaymentsub2 set invExchangerate= 1.00 where invExchangerate = 0 or invExchangerate is null or invcurrency is null;
update bcapdepositspecial set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null;  
update bcapreturndepspecial set Exchangerate= 1.00 where exchangerate = 0 or exchangerate is null or currencycode is null; 
