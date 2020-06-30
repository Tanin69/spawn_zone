//Initalisation de PLUTO
[
	opfor,		        //0 camp
	[500,2000,6000],	//1 revealRange [man,land,air]
	[1000,2000,3000],	//2 sensorRange [man,land,air]
	120,			    //3 QRFtimeout
	[500,2000,6000],	//4 QRFrange [man,land,air]
	[20,30,60],		    //5 QRFdelay [min,mid,max]
	240,			    //6 ARTYtimeout
	[20,30,60],		    //7 ARTYdelay [min,mid,max]
	[1,2,4],		    //8 ARTYrounds [min,mid,max]
	[0,40,100]		    //9 ARTYerror [min,mid,max]
] call GDC_fnc_pluto;

gdc_plutoDebug = false;


/*******************************************/
/*   Compilation des fonctions             */
/*******************************************/
fn_spawnRdmPatrols   = compile preprocessFile "functions\fn_spawnRdmPatrols.sqf";
fn_spawnFixedWeapons = compile preprocessFile "functions\fn_spawnFixedWeapons.sqf";
fn_spawnGarnisons    = compile preprocessFile "functions\fn_spawnGarnisons.sqf";


/*******************************************/
/*   DEFINITION DES GROUPES POUR SPAWN     */
/*******************************************/

//**  OPFOR   *//

//groupe de 3-5 pax
GROUPE_OPFOR_PETIT = [
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"]
];

//groupe de 7-10 pax
GROUPE_OPFOR_MOYEN = [
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG"]
];

//groupe de 15-20 pax
GROUPE_OPFOR_GRAND = [
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2"]
];


/*******************************************/
/*           SPAWN DES HOSTILES            */
/*******************************************/

[] spawn {
	execVM "spawn_IA\spawnQG.sqf";
	execVM "spawn_IA\spawnVillage.sqf";
};




