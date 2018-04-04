--dbversion=1
--progstring=bc5service
--Last update 09-04-2003 by Jeab

create table LtdConfig
(
	ROWORDER INT NOT NULL IDENTITY(0,1),
	LtdCode	VARCHAR(50),
	LtdName	VARCHAR(50),
	ServerName	VARCHAR(50),
	DatabaseName	VARCHAR(50),
	UserID	VARCHAR(50),
	UserPassword	VARCHAR(50),
	SelectTop	VARCHAR(50),
	MisShow	VARCHAR(50)
    PRIMARY KEY(ROWORDER)
);
