#define FILTERSCRIPT

#include <a_samp>
#include <FCNPC>
#include <colandreas>
#if !defined _FCNPC_included
	#tryinclude <FCNPC>
#endif

#if !defined _FCNPC_included
	#tryinclude "FCNPC"
#endif

#if !defined _FCNPC_included
	#tryinclude "../FCNPC"
#endif

#if !defined _FCNPC_included
	#error Add FCNPC.inc to your scripts directory
#endif



enum NPC_STATS{
    id,
    weapon,
    ammo, 
    skin, 

}

enum gangster{
    team, 
}

new CURRENT_NPCS = 0;
new SERVER_NPCS[256];

new peds_skins[10] = {7, 10, 12,13, 21, 22,36 ,37}



public FCNPC_OnDestroy(npcid){
  //  SERVER_NPCS[CURRENT_NPCS + 1] = npcid;
    CURRENT_NPCS -=1;

    return 1;
}

public FCNPC_OnCreate(npcid){
    SERVER_NPCS[CURRENT_NPCS + 1] = npcid;
    CURRENT_NPCS +=1;

    return 1;
}

public createRandomPED( Float:playerPosX, Float:playerPosY, Float:playerPosZ){
    
		new string:ped_name[80];
    	format(ped_name,sizeof(ped_name), "PED_%i",CURRENT_NPCS+1);

    		new ped = FCNPC_Create(ped_name);
         
			FCNPC_Spawn(ped, peds_skins[random(6)], playerPosX, playerPosY, playerPosZ);
}

public FCNPC_OnDeath(npcid, killerid, reason)
{

    new Float:X, Float:Y, Float:Z;

    GetPlayerPos(npcid,X, Y,Z);
    	for(new i = 0; i < random(9); i++){
                CreatePickup(1212, 19, X + random(2) - random(2),Y+random(2) -random(2),Z - 0.5, 0);
	}

    SetTimerEx("vanish_NPC", 5000, false, "i", npcid);

    return 1;

}

public vanish_NPC(npcid){


     FCNPC_Destroy(npcid)
return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]){
if (strcmp("/crear", cmdtext, true, 10) == 0)
{
	new Float:playerPosX, Float:playerPosY, Float:playerPosZ;
	GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);


	createRandomPED( playerPosX, playerPosY, playerPosZ)

return 1;
}

    return 1;
}

public FCNPC_OnTakeDamage(npcid, issuerid, Float:amount, weaponid, bodypart){

      if (bodypart == 9)
    {
        // El disparo fue en la cabeza, el jugador muere instantáneamente
        FCNPC_SetHealth(npcid, 0.0);
    return 1;
    }
    new npcweapon = GetPlayerWeapon(issuerid);
    if(npcweapon != 0){
        new Float:issuerX, Float:issuerY, Float:issuerZ;
        GetPlayerPos(issuerid, issuerX, issuerY, issuerZ );
        runAwayFrom(npcid, issuerX, issuerY, issuerZ);
    }

return 1;
}

stock runAwayFrom(npcid, Float:issuerX, Float:issuerY, Float:issuerZ);
public runAwayFrom(npcid,Float:issuerX, Float:issuerY, Float:issuerZ){
    new  Float:x, Float:y, Float:z;
    FCNPC_GetPosition(npcid,x,y,z);
    new Float:Distance = floatsqroot(floatpower((issuerX-x),2) + floatpower((issuerY-y),2));
    new distanceVector[2]; 
    distanceVector[0] = issuerX - x;
    distanceVector[1] = issuerY - y;

printf("The number is %f.",Distance);  
/*new  Float:Cx, Float:Cy,Float:Cz;
new colides = CA_RayCastLine(x,y,z, x+0.5,y+0.5,z, Float:Cx, Float:Cy, Float:Cz);
if (colides != 0){
      FCNPC_GoTo(npcid, -distanceVector[0] + random(2),random(4), Float:z, FCNPC_MOVE_TYPE_AUTO, FCNPC_MOVE_SPEED_AUTO,  FCNPC_MOVE_MODE_AUTO,FCNPC_MOVE_PATHFINDING_AUTO);
} */


  if(Distance <=5.0){
    FCNPC_GoTo(npcid, -distanceVector[0] , -distanceVector[1] , Float:z, FCNPC_MOVE_TYPE_AUTO, FCNPC_MOVE_SPEED_AUTO,  FCNPC_MOVE_MODE_AUTO,FCNPC_MOVE_PATHFINDING_AUTO);
    SetTimerEx("runAwayFrom", 1000, false, "ifff", npcid, Float:issuerX, Float:issuerY, Float:issuerZ);

  }

    return 1;
}

/*


CA_ContactTest(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)*/