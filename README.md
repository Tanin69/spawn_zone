# Scripts de spawns de zone de tanin69

## Qu'est-ce que c'est

Des scripts de "surcouche" sur Lucy et Pluto qui permettent de faire spawner des groupes d'IA "en masse" dans des zones ou sur des marqueurs sans avoir à faire spawner groupe par groupe. Simplifie grandement la création de mission via Lucy et Pluto.

* Des patrouilles : on détermine le nombre de patrouilles dans la zone, on place un nombre de marqueurs au choix et les patrouilles spawnent dans la zone, avec un chemin aléatoire pour chaque patrouille
* Des garnisons : sur un marqueur, une garnison spawne, en s'appuyant sur ```CBA_fnc_taskDefend```
* Des armes fixes : sur un marqueur, une arme fixe spawne, avec ou sans servant selon un paramétre aléatoire réglable. Les IA dans un certain rayon peuvent occuper l'arme fixe ainsi spawnée, selon un paramètre aléatoire réglable.

## Principe général

On place les marqueurs dans Eden, on les nomme selon une convention, puis on copie/colle quelques lignes de script en adaptant les paramètres selon son besoin.

## Intérêt et limites

### Prendre en main ces scripts est intéressant si

* Je fais spawner de nombreux groupes dans de nombreuses zones. Si c'est pour mettre 3 ou 4 patrouilles sur toute la carte et 2 ou 3 garnisons, l'intérêt est limité et vous aurez aussi vite fait d'appeler Lucy directement. Ces scripts ont été testés sur une mission où plus de 500 IA peuvent être spawnées (avec spawn conditionnel et ZBE_cache) avec un impact négligeable sur les performances.
* Je veux beaucoup d'aléatoire sans me faire chier
* Je réutilise souvent des "bibliothèques" de groupes d'IA
* Je veux adapter dynamiquement le nombre d'IA en fonction du nombre de joueurs démarrant la partie (voir conseils)

### Ca n'est pas intéressant si

* Je veux contrôler finement ce que font les IA (je veux controler très précisément le placement des IA, les chemins de patrouille, etc.). Autrement dit, je ne cherche pas d'aléatoire.
* Je spawne peu d'unités (pour 15 ou 20, ça n'est pas très intéressant)

## Un exemple : 3 à 5 patrouilles dans une zone nommée "QG"

### Dans Eden

1. Je place sur le carte un marqueur de zone (elipse ou rectangle) et le nomme ```mrkZnQG``` : le préfixe ```mrkZn``` est obligatoire, ce qui suit est le libellé de la zone et est libre (on aurait pu mettre _QG ou blabla ou n'importe quoi d'autre).
2. Je place un marqueur à l'endroit où je veux que ma patrouille spawne (par exemple un marqueur "point"). Je nomme ce marqueur ```mrkPlQG_1``` : le préfixe ```mrkPl``` est obligatoire et il doit immédiatement être suivi du nom de la zone défini précédemment (```QG``` dans notre exemple). La suite ```_1``` est conseillée car si vous faites ensuite un copier/coller de ce marqueur, Eden nommera automatiquement les marqueurs suivants ```mrkPlQG_2```, ```mrkPlQG_3```, etc.
3. Ensuite, donc, je copie/colle autant de fois le premier marqueur que je veux de points de spawn pour les patrouilles, en les répartissant à mon gré dans le marqueur de zone ```mrkZnQG```. Il peut y avoir un nombre de marqueurs très limité (voire un seul), auquel cas les patrouilles spawneront sur ces points, ou au contraire un très grand nombre de marqueurs, supèrieur aux nombre de patrouilles à spawner, ce qui renforce l'aléatoire.

### Les scripts

1. Je place les bonnes lignes dans les différents fichiers d'init (voir plus bas la référence)
2. J'ajoute la ligne suivante dans mon initServer.sqf :

```
["QG",[3,4,5],["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light"],opfor] spawn fn_spawnRdmPatrols;
```

## Installation et paramétrage de base

### Dépendances

Lucy, Pluto et CBA. Ces scripts sont présents dans le modset Grèce de canards, donc si vous jouez chez nous, vous n'avez rien à faire. Sinon, contactez-moi (Lucy et Pluto sont des mods de Grèce de canards)

### Les fichiers à récupérer

Tout ce qui se trouve dans le répertoire ```functions``` :

* ```fn_spawnFixedWeapons.sqf```
* ```fn_spawnGarnisons.sqf```
* ```fn_spawnRdmPatrols.sqf```

### A ajouter dans les scripts d'initialisation de mission

#### Dans le ```init.sqf```

```
//Récupère la liste de tous les marqueurs LUCY pour les masquer
private _tbMrk = allMapMarkers select {["mrk", _x, true] call BIS_fnc_inString};

//Masque les marqueurs
{_x setMarkerAlpha 0.0} forEach _tbMrk;

//Initalisation de Lucy
[0.5,"mkr_spawn_static_unit",true,600.0,false,3600.0,true,true,"COLONEL"] call GDC_fnc_lucyInit;
```

#### Dans le ```initServer.sqf```

```
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

// Compilation des fonctions de spawn de zone
fn_spawnRdmPatrols   = compile preprocessFile "functions\fn_spawnRdmPatrols.sqf";
fn_spawnFixedWeapons = compile preprocessFile "functions\fn_spawnFixedWeapons.sqf";
fn_spawnGarnisons    = compile preprocessFile "functions\fn_spawnGarnisons.sqf";
```

## Appel des scripts

### Patrouilles

```
/*

Author :
tanin69

Version :
1.0

Date :
05/12/2019

Description :
Spawn des patrouilles à WP aléatoires dans une zone donnée et sur des marqueurs randomisés

Parameter(s) :
0 : STRING - le nom de la zone
1 : ARRAY  - nombre de patrouilles. Ex. [2,3,4,5] pour un nombre de patrouilles comprises entre 2 et 5
2 : ARRAY  - composition du groupe à spawner. Ex. : ["rhsgref_ins_squadleader", "rhsgref_ins_rifleman_aks74","rhsgref_ins_militiaman_mosin"]
3 : SIDE (optional, default opfor) - side du groupe (opfor, blufor, independent)

Returns :
Nothing

*/
```

Une fois spawnée, chaque patrouille suit un chemin aléatoire infini dans la zone qui lui a été affectée (```GDC_fnc_lucyGroupRandomPatrol```). De plus, le contrôle des patrouilles est donné à Pluto et elles sont paramétrées en QRF. Il est donc important pour l'équilibrage de la mission de bien régler les paramètres de Pluto correspondant (cf. ci-dessus, paramètres 3 à 5).

### Garnisons

```
/*

Author :
tanin69

Version :
1.0 : version initiale
1.1 : ajout des paramètres optionnels de CBA_fnc_taskDefend

Date :
15/12/2019

Description :
Spawn des garnisons dans une zone donnée, sur chaque marqueur respectant la convention mrkGn[Nom de la zone][suffixe]

Parameter(s) :
0 : STRING - le nom de la zone
1 : ARRAY  - composition du groupe à spawner. Ex. : ["rhsgref_ins_squadleader", "rhsgref_ins_rifleman_aks74","rhsgref_ins_militiaman_mosin"]
2 : SIDE (optional, default opfor) - side du groupe (opfor, blufor, independent)
3 : NUMBER (optional, default 40) - rayon dans lequel les soldats se mettent en garnison (CBA_fnc_taskDefend)
4 : NUMBER (optional, default 2) - seuil minimal de positions de fortification pour que les IA se fortifient (CBA_fnc_taskDefend)
5 : NUMBER (optional, default 0) - probabilité pour que l'unité patrouille au lieu de se fortifier (CBA_fnc_taskDefend)
6 : NUMBER (optional, default 0.7) - probabilité pour que les unités restent fortifiées si elles sont attaquées (CBA_fnc_taskDefend)

Returns :
Nothing

*/
```

La fonction ```CBA_fnc_taskDefend``` donne la plupart du temps un résultat tout-à-fait satisfaisant sans avoir à placer d'unité à la main : elle va envoyer automatiquement les IA se fortifeir dans les batiments ou fortifications dans un rayon donné (paramètre 3), pour autant que ces assets soient correctement configurés. De plus, elle évite que toutes les unités en garnison restent bêtement à attendre qu'on vienne les cueillir une à une dans les bâtiments : une fois attaquées, certaines d'entre elles vont se porter au combat, d'autre rester à couvert (paramètre 6). Ceci rend les combats en CQB très dynamiques. La fonction a deux défauts :

* Si de très longs combats se déroulent à une distance relativement proche (quelques centaines de mètres), les IA qui patrouillent la garnison (cf. paramètre 5) vont finir par se détacher, parfois une à une, parfois en petits groupes et rejoindre le combat.
* Si les assets ne fournissent pas de position de fortification dans leur configuration, les IA ne pourront bien entendu pas se fortifier. Cela n'est pas dû à la fonction, mais bien à une mauvaise configuration de l'asset. C'est malheureusement le cas de certains blockhaus (ex. la classe Land_Fort_Watchtower_*).

**Attention !** Il ne vous aura pas échappé que, contrairement aux marqueurs de patrouille, un groupe est spawné sur *chaque* marqueur de garnison.

### Armes fixes

```
/*

Author :
tanin69

Version :
1.0

Date :
14/12/2019

Description :
Spawn les armes fixes d'une zone, selon une probabilité et permet à des IA de monter dans l'arme fixe sous certaines conditions

Parameter(s) : 
0 : STRING - le nom de la zone contenant les armes fixes
1 : SIDE   (optional, default opfor) - side de l'arme fixe (opfor, blufor, independent)
2 : STRING (optional, default "rhsgref_ins_DSHKM") - classname de l'arme fixe
3 : STRING (optional, default "rhsgref_ins_rifleman") - classname du gunner
4 : NUMBER (optional, default 0.5) - Probabilité que l'arme fixe soit spawnée
5 : NUMBER (optional, default 0.5) - Probabilité que l'arme fixe soit spawnée avec un gunner
6 : NUMBER (optional, default 0.8) - Probabilité pour qu'un ordre de monter dans l'arme fixe soit donné à une IA hostile (si les conditions sont remplies)

ex. : ["Nord3"] spawn fn_spawnFixedWeapons;
ex. : ["Nord3",opfor,"rhsgref_ins_DSHKM","rhsgref_ins_rifleman",1,0.1,1] spawn fn_spawnFixedWeapons;

Returns :
Nothing

*/
```

Nota bene : le nom de la zone ne sert en fait pas à grand chose (voire à rien) : les armes fixes peuvent être spawnées en dehors d'un marqueur de zone. 

**Attention** ! le nom du marqueur est important ! (voir référence ci-dessous)

## Référence de nommage des marqueurs

* ```mrkZn[intitulé_zone]...``` = marqueur de zone. Utilisé pour délimiter des zones comprenant les autres marqueurs. Ex. mrkZnNord, mrkZnNord1, mrkZnOpforKivia, mrkZn_1, etc.
* ```mrkPl[intitulé_zone][libre]...``` = marqueur pour une position de spawn de patrouille. L'intitulé de la zone doit suivre immédiatement la racine mrkPl. Ex. mrkPlNord_1, mrkPlNord1A, mrkPlNord1_1a ou mrkPlOpforKivia1, etc.
* ```mrkGn[intitulé_zone][libre]...``` = marqueur pour une position de spawn de groupe de défense. L'intitulé de la zone doit suivre immédiatement la racine mrkGn.
* ```mrkFW[intitulé_zone][libre][NNN]...``` = marqueur pour une arme fixe. Tous les marqueurs de ce type sont associés à un pseudo trigger généré par code. La fin du nom du marqueur doit impérativement contenir l'azimut vers lequel pointe l'arme fixe spawnée, codé sur trois caractères. Ex. mrkFWNord_A1_270 (pointera au 270), mrkFWNord_1270 (idem) ou mrkFWNord270 (idem)

## Conseils

### La philosophie de Lucy et ses conséquences

Faire une mission avec Lucy a ceci de particulier que tout se passe par les marqueurs : vous ne posez pas les IA dans Eden. Par conséquent, vous devez avoir une excellente organisation de vos marqueurs et des règles de nommage claires pour vous y retrouver. Voici quelques conseils :

* Créez un calque (layer) dédié dans Eden et placez-y tous vos marqueurs Lucy. Cela facilite grandement la navigation dans les marqueurs, vous permet de tous les masquer si nécessaire, etc. D'ailleurs, en règle général, les calques facilitent une bonne gestion de la mission (un calque pour le build, un calque pour les marqueurs Lucy, etc.).
* Donnez-vous une règle de nommage des zones dès le début : si vous avez une ou deux zones, ce n'est pas très grave. Mais vous allez rapidement créer 4, 5 voire 10 zones sur une mission un peu charnue. Vous pouvez adopter par exemple les points cardinaux (mrkZn_Ouest, mrkZn_Nord_1, etc.) ou des noms signifiants (ex. mrkZnQG, mrkZnVilleMachin, etc.). Dans tous les cas, faites un choix au début et tenez-vous y. S'i vous faut renommer tous les marqueurs de spawn de patrouille ou de garnison parce que vous changez de règle de nommage en cours de route, c'est vraiment pénible (je parle d'expérience...).

### Créez un tableau contenant la définition des groupes d'IA

Vous n'allez pas, sauf exception, vous amuser à écrire le tableau du groupe d'IA dans chaque appel de fonction comme dans l'exemple cité au début. Il est beaucoup plus efficace de définir vos groupes dans le ```initServer.sqf```, par exemple ainsi :

```
GROUPE_OPFOR = ["rhsgref_ins_squadleader", "rhsgref_ins_rifleman_aks74","rhsgref_ins_militiaman_mosin"];
```

Vous pourrez ainsi appeler cette composition dans les scripts comme par exemple :

```
["QG",[3,5,7],GROUPE_OPFOR,opfor] spawn fn_spawnRdmPatrols;
```

Lucy et cette surcouche étant aussi (voire surtout) créés pour avoir une forte dose d'aléatoire, vous pouvez même composer des groupes aléatoires. Par exemple :

```
GROUPE_OPFOR = [
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"]
];

```
Le script de spawn de patrouille choisira aléatoirement un groupe au sein de ce tableau. Vous avez ainsi la possibilité de faire varier et la composition du groupe (donc son équipement) et sa taille.

Evidemment, l'équilibrage devra être réalisé avec beaucoup d'attention. Vous pouvez ainsi créer des groupes de taille différente, par exemple :

```
// Groupe de 3 à 5 pax
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

//Groupe de 7 à 10 pax
GROUPE_OPFOR_GRAND = [
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_MG"],
	["CPC_ME_O_KAM_soldier_TL", "CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_GL","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_1","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_light","CPC_ME_O_KAM_soldier_2","CPC_ME_O_KAM_soldier_AMG"]
];
```

Et ensuite, les appeler par exemple via :

```
//Spawn des patrouilles
["QG",[1,2],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;

//Spawn des garnisons
["QG",GROUPE_OPFOR_GRAND,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;
```

### Organisez vos scripts de spawn

Une bonne méthode (mais ce n'est sûrement pas la seule) est de créer un script de spawn pour chaque zone. Vous avez ainsi une relation entre la conception de votre mission, forcément structurée par zone de combat, et l'organisation de vos scripts.

#### Exemple

Dans Eden, j'ai 4 marqueurs de zone nommés ```mrkZnQG```, ```mrkZnVillage```, ```mrkZnDepot``` et ```mrkZnPort```. Dans ce cas, créez 4 scripts nommés par exemple : ```spawnQG.sqf```, ```spawnVillage.sqf```, etc.

Regroupez vos commandes de spawn pour la zone en question dans chacun de ces scripts. Vous pouvez utiliser un squelette comme suit :

```
//Le nom de la zone qui sera utilisé pour tous les spawns
private _zn = "QG";

//Spawn des patrouilles
[_zn,[1,2],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;

//Spawn des garnisons
[_zn,GROUPE_OPFOR_PETIT,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;

//Spawn des armes fixes
[_zn,nil,nil,nil,0.75,0.7,0.8] spawn fn_spawnFixedWeapons;
```

Il vous suffit ensuite de copier/coller ce script pour chacune de vos zones et de changer la valeur de la première variable ```private _zn = "QG";```. Si besoin, adaptez ensuite les paramètres des fonctions (nombre de patrouilles, taille de groupe, etc.)

Attention, si vous n'avez pas de marqueur d'un certain type dans la zone (patrouille ou garnison ou arme fixe), pensez à commenter la ligne de code concernée sous peine d'erreur du script.

Vous appellerez ensuite ces scripts via le fichier ```initServer.sqf``` :

```
//Spawn des hostiles
[] spawn {
    execVM "spawnQG.sqf";
	execVM "spawnVillage.sqf";
};
```
**Attention** ! Si vous utilisez des tableaux pour déclarer vos groupes comme (très fortement suggéré) dans le point précédent, pensez à lancer les scripts de spawn *après* la déclaration des groupes...

### La (première) cerise sur le gâteau : adapter le nombre d'IA par rapport au nombre de joueurs en début de mission

Il vous suffit 1) d'obtenir le nombre de joueurs au lancement de la mission et 2) de faire varier les paramètres des scripts de spawn.

#### Obtenir le nombre de joueurs au lancement de la mission

```
//Obtenir le nombre de joueurs au lancement de la mission
//A placer dans le fichier initServer.sqf
//Adapter le paramètre side si besoin
nbJoueurs = playersNumber west;
```

Cette variable doit être initialisée *avant* de lancer les scripts de spawn

#### Faire varier les paramètres des scripts de spawn en fonction du nombre de joueurs en début de mission

Le squelette de script de spawn peut, par exemple, être le suivant :

```
//Le nom de la zone qui sera utilisé pour tous les spawns 
private _zn = "QG";

switch (true) do {
	case (nbJoueurs <= 16): {
		//Spawn des patrouilles : une seule petite patrouille
		[_zn,[1],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;
		//Spawn des garnisons : un petit groupe
		//[_zn,GROUPE_OPFOR_PETIT,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;
	};
	case (nbJoueurs > 16): {
		//Spawn des patrouilles : 2 ou 3 petites patrouilles
		[_zn,[2,3],GROUPE_OPFOR_PETIT,opfor] spawn fn_spawnRdmPatrols;
		//Spawn des garnisons : un groupe moyen
		[_zn,GROUPE_OPFOR_MOYEN,nil,nil,nil,nil,0.7,0.7] spawn fn_spawnGarnisons;
        //Spawn d'armes fixes
        [_zn,nil,nil,nil,1,1,0.8] spawn fn_spawnFixedWeapons;
	};
};
```

**Attention ! Ne prenez pas cet équilibrage à la légère.** Une grande partie de l'expérience de la mission va dépendre de ça. Il y a de très nombreux paramètres sur lesquels vous pouvez jouer (taille de chaque groupe, équipement, nombre de groupes, présence d'arme fixe, etc., avec sur chacun de ces paramètres *un ou plusieurs* niveaux d'aléatoire, ) : **apportez le plus grand soin à cet équilibrage et réduisez l'aléatoire si nécessaire.**

### La (seconde) cerise sur le gâteau : spawn de zone conditionnel

Vous pouvez lancer les scripts de spawn de façon conditionnelle, par exemple via un déclencheur (trigger). Cela est notamment indispensable si vous peuplez l'intégralité d'une map : faire spawner des centaines d'IA en début de partie (et les simuler ensuite) est, commment dire... Criminel ;-). Par pour les IA, mais pour les joueurs, bien-sûr. Testez les performances sur le serveur de jeu. Au besoin, ZBE cache est très efficace si vous commencez à avoir de gros volumes d'IA, mais ce n'est pas la solution miracle non plus.
