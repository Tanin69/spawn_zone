//Le nom de la zone qui sera utilisé pour tous les spawns 
private _zn = "Village";

switch (true) do {
	case (nbJoueurs <= 16): {
		//Spawn des patrouilles
		[_zn,[2,3,4],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;
		//Spawn des garnisons
		[_zn,GROUPE_OPFOR_PETIT,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;
	};
	case (nbJoueurs > 16): {
		//Spawn des patrouilles
		[_zn,[3,4,5],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;
		//Spawn des garnisons
		[_zn,GROUPE_OPFOR_MOYEN,nil,nil,nil,0.4,0.7] spawn fn_spawnGarnisons;
	};
};

//Spawn des armes fixes
[_zn,nil,"I_C_HMG_02_high_F",nil,1,1,0.8] spawn fn_spawnFixedWeapons;


