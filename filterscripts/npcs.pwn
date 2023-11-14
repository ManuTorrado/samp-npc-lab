#define FILTERSCRIPT
#include <a_samp>
#include <FCNPC>


new myFirstNPC = INVALID_PLAYER_ID;

public FCNPC_OnInit()
{
	myFirstNPC = FCNPC_Create("FirstNPC");
	FCNPC_Spawn(myFirstNPC, 0, 2027.6785,1344.4966,10.8203);
	return 1;
}

#if defined FILTERSCRIPT
public OnFilterScriptInit(){
	print("\n---------------------------------------");
	print("Corriendo el script NPC\n");
	print("---------------------------------------\n");
	
 FCNPC_OnInit();
	
	return 1;
}



public OnFilterScriptExit()
{
	FCNPC_Destroy(myFirstNPC);
	myFirstNPC = INVALID_PLAYER_ID;
	return 1;
}
#endif
