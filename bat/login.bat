Net use * /delete /y


Net use Q: \\qnap\Doc(Q) 
Net use V: \\nebula\external 
Net use W: \\nebula\bcaccount 
net use x: \\mars\faxin /user:cr01 expert  
net use y: \\nebula\bcs 




cd\
regedit /s \\nebula\bcs\bat\bc-s01.reg
regedit /s \\nebula\bat\kb.reg
regedit /s \\nebula\bat\datetime.reg

c:\bcs\bc5app\bc5app.exe


