//Le nom de la zone qui sera utilisé pour tous les spawns 
private _zn = "QG";

switch (true) do {
	case (nbJoueurs <= 16): {
		//Spawn des patrouilles
		[_zn,[1],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;
		//Spawn des garnisons
		//[_zn,GROUPE_OPFOR_PETIT,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;
	};
	case (nbJoueurs > 16): {
		//Spawn des patrouilles
		[_zn,[1],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;
		//Spawn des garnisons
		//[_zn,GROUPE_OPFOR_MOYEN,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;
	};
};

//Spawn des armes fixes
//[_zn,nil,nil,nil,1,1,0.8] spawn fn_spawnFixedWeapons;


