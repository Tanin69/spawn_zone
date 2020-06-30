//Récupère la liste de tous les marqueurs Lucy (commençant par la chaine 'mrk') pour les masquer
private _tbMrk = allMapMarkers select {["mrk", _x, true] call BIS_fnc_inString};

//Masque les marqueurs
{_x setMarkerAlpha 0.0} forEach _tbMrk;

//Initialisation de Lucy
[0.5,"mkr_spawn_static_unit",true,600.0,false,3600.0,true,true,"COLONEL"] call GDC_fnc_lucyInit;
