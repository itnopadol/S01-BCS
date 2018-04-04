//******************************************
//	Ban Chiang Soft Co.,Ltd
//	prepare registry for product from BCS
//
//	by Pateegon Budcha 15:51 03/11/2548
//******************************************

var WshShell = new ActiveXObject("WScript.Shell");
var regKey  = "HKCU\\Software\\Banchiang Soft\\BC5POS";
var regKey2 = "HKLM\\Software\\Banchiang Soft\\BC5APP";
var installFolder;
//	check registry key
//	if not exist import it from registry.reg
try
{
	//WshShell.CurrentDirectory;
	//get install folder from registry
	installFolder = WshShell.RegRead (regKey2+"\\installfolder")+"BCPOSAPP\\posregistry.reg";
	//WshShell.Popup(installFolder+"\\registry.reg from try box");
	var bKey = WshShell.RegRead (regKey+"\\BC5APPInstallFolder");
	if(bKey == "")
	{
		//import registry
		WshShell.Run("regedit /s "+installFolder,0,true);
	}
}
catch(e)
{
		//import registry
		WshShell.Run("regedit /s "+installFolder,0,true);

}