#include <a_samp>
#include <core>
#include <float>
#include <FCNPC>
#pragma tabsize 0

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define PocketMoney 50000 // Amount player recieves on spawn.
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.

#define NUMVALUES 4

forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();
forward SendPlayerFormattedText(playerid, const str[], define);
forward public SendAllFormattedText(playerid, const str[], define);

//------------------------------------------------------------------------------------------------------

new CashScoreOld;
new iSpawnSet[MAX_PLAYERS];

new Float:gRandomPlayerSpawns[23][3] = {
{1958.3783,1343.1572,15.3746},
{2199.6531,1393.3678,10.8203},
{2483.5977,1222.0825,10.8203},
{2637.2712,1129.2743,11.1797},
{2000.0106,1521.1111,17.0625},
{2024.8190,1917.9425,12.3386},
{2261.9048,2035.9547,10.8203},
{2262.0986,2398.6572,10.8203},
{2244.2566,2523.7280,10.8203},
{2335.3228,2786.4478,10.8203},
{2150.0186,2734.2297,11.1763},
{2158.0811,2797.5488,10.8203},
{1969.8301,2722.8564,10.8203},
{1652.0555,2709.4072,10.8265},
{1564.0052,2756.9463,10.8203},
{1271.5452,2554.0227,10.8203},
{1441.5894,2567.9099,10.8203},
{1480.6473,2213.5718,11.0234},
{1400.5906,2225.6960,11.0234},
{1598.8419,2221.5676,11.0625},
{1318.7759,1251.3580,10.8203},
{1558.0731,1007.8292,10.8125},
//{-857.0551,1536.6832,22.5870},   Out of Town Spawns
//{817.3494,856.5039,12.7891},
//{116.9315,1110.1823,13.6094},
//{-18.8529,1176.0159,19.5634},
//{-315.0575,1774.0636,43.6406},
{1705.2347,1025.6808,10.8203}
};

new Float:gCopPlayerSpawns[2][3] = {
{2297.1064,2452.0115,10.8203},
{2297.0452,2468.6743,10.8203}
};

//Round code stolen from mike's Manhunt :P
//new gRoundTime = 3600000;                   // Round time - 1 hour
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
//new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min

new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

main()
{
		print("\n----------------------------------");
		print("  Running LVDM ~MoneyGrub\n");
		print("         Coded By");
		print("            Jax");
		print("----------------------------------\n");
		print("----------------------------------\n");
}

//------------------------------------------------------------------------------------------------------

public OnPlayerRequestSpawn(playerid)
{
	//printf("OnPlayerRequestSpawn(%d)",playerid);
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerPickUpPickup(playerid, pickupid)
{
	//new s[256];
	//format(s,256,"Picked up %d",pickupid);
	//SendClientMessage(playerid,0xFFFFFFFF,s);
}

//------------------------------------------------------------------------------------------------------




public MoneyGrubScoreUpdate()
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
				//format(string, sizeof(string), "$$$ %s is now in the lead $$$", name);
				//SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

/*public GrubModeReset()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			SetPlayerScore(i, PocketMoney);
			SetPlayerRandomSpawn(i, classid);
		}
	}

}*/

//------------------------------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Las Venturas ~g~MoneyGrub",5000,5);
	SendPlayerFormattedText(playerid, "Welcome to Las Venturas MoneyGrub, For help type /help.", 0);
	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();
	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	gActivePlayers[playerid]--;
}
//------------------------------------------------------------------------------------------------------
new Jenkins = INVALID_PLAYER_ID;
new JenkinsFollow = false;
const MAX_SECURITY = 2;
new seguridad[MAX_PLAYERS][MAX_SECURITY];

public OnPlayerCommandText(playerid, cmdtext[])
{


	if (strcmp("/seguridad", cmdtext, true, 10) == 0)
{


	for (new i = 0; i < MAX_SECURITY; i++) {
		if(seguridad[playerid][i] == INVALID_PLAYER_ID){
			new name[80];
			new Float:playerPosX, Float:playerPosY, Float:playerPosZ;
			GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);
			new guard_name[80];
			GetPlayerName(playerid,name , sizeof(name));
			format(guard_name,sizeof(guard_name), "%s_GUARD_%i.",name,i);

			seguridad[playerid][i] = FCNPC_Create(guard_name);
			FCNPC_Spawn(seguridad[playerid][i], 164, playerPosX, playerPosY, playerPosZ);




	CreatePlayer3DTextLabel(playerid, guard_name ,0x008080FF, playerPosX, playerPosY, playerPosZ,40.0);


			FCNPC_SetWeapon(seguridad[playerid][i], WEAPON_DEAGLE);
			FCNPC_SetAmmo(seguridad[playerid][i], 10000)
		//	FCNPC_AimAtPlayer(seguridad[playerid][i], playerid, true);

		//	FCNPC_AimAtPlayer(npcid, playerid, bool:shoot = false, shoot_delay = -1, bool:set_angle = true, Float:offset_x = 0.0, Float:offset_y = 0.0, Float:offset_z = 0.0, Float:offset_from_x = 0.0, Float:offset_from_y = 0.0, Float:offset_from_z = 0.0, between_check_mode = FCNPC_ENTITY_MODE_AUTO, between_check_flags = FCNPC_ENTITY_CHECK_ALL)
			return 1;
		}
}

return 1;

}

if (strcmp("/jenkins", cmdtext, true, 10) == 0)
{
	new Float:playerPosX, Float:playerPosY, Float:playerPosZ;
	GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);


	Jenkins = FCNPC_Create("jenkins");


	FCNPC_Spawn(Jenkins, 171, playerPosX, playerPosY, playerPosZ);

return 1;
}
	
if (strcmp("/veni", cmdtext, true, 10) == 0)
{
	if(Jenkins == INVALID_PLAYER_ID){
		
	 SendClientMessage(playerid, COLOR_WHITE, "Jenkins is not spawned");
	 return 1;

	}
	new Float:playerPosX, Float:playerPosY, Float:playerPosZ;
	GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);
	FCNPC_GoTo(Jenkins, playerPosX + 0.5, playerPosY + 0.5, playerPosZ, FCNPC_MOVE_TYPE_RUN);
return 1;
}


if (strcmp("/seguime", cmdtext, true, 10) == 0)
{
	if(Jenkins == INVALID_PLAYER_ID){
		
	 SendClientMessage(playerid, COLOR_WHITE, "Jenkins is not spawned");
	 return 1;

	} 

JenkinsFollow = !JenkinsFollow;

return 1;
}
	
	return 0;
}

//------------------------------------------------------------------------------------------------------

public GetPlayersDistance(player1,player2){   /// Obtener la distancia entre 2 jugadores 


	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(player2, X,Y,Z);



	new Float:distance;
	distance = GetPlayerDistanceFromPoint(player1, X,Y,Z);

	return distance;

}

// ------------------------------------------------------------

public OnPlayerUpdate(playerid){
	
	if(Jenkins != INVALID_PLAYER_ID){

	new Float:playerPosX, Float:playerPosY, Float:playerPosZ,Float:distance;
	GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);

	distance = GetPlayersDistance(Jenkins, playerid);
	if(distance > 15.0 && JenkinsFollow) {
//	FCNPC_GoTo(Jenkins, playerPosX + 0.5, playerPosY + 0.5, playerPosZ, FCNPC_MOVE_TYPE_RUN);
		FCNPC_GoToPlayer(Jenkins, playerid, FCNPC_MOVE_TYPE_AUTO, FCNPC_MOVE_SPEED_AUTO,FCNPC_MOVE_MODE_AUTO, FCNPC_MOVE_PATHFINDING_AUTO, 0.0, true, 5.0,  10.0,250);
	}
	}

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){

	if(Jenkins != INVALID_PLAYER_ID){
 	FCNPC_EnterVehicle(Jenkins, vehicleid, 1, FCNPC_MOVE_TYPE_WALK);
	

	}
	return 1;
}


public OnPlayerExitVehicle(playerid, vehicleid){
	if(Jenkins != INVALID_PLAYER_ID){
 	
	FCNPC_ExitVehicle(Jenkins)
	}
}




public OnPlayerSpawn(playerid)
{


	GivePlayerMoney(playerid, PocketMoney);
	SetPlayerInterior(playerid,0);
	SetPlayerRandomSpawn(playerid);
	TogglePlayerClock(playerid,1);
	return 1;
}

public SetPlayerRandomSpawn(playerid)
{
	if (iSpawnSet[playerid] == 1)
	{
		new rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
    }
    else if (iSpawnSet[playerid] == 0)
    {
		new rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        ResetPlayerMoney(playerid);
	} else {
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
			playercash = GetPlayerMoney(playerid);
			if (playercash > 0)  {
				GivePlayerMoney(killerid, playercash);
				ResetPlayerMoney(playerid);
			}
			else
			{
			}
     	}
 	return 1;
}



//------------------------------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	iSpawnSet[playerid] = 0;
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public GameModeExitFunc()
{
	GameModeExit();
}
/*new myFirstNPC = INVALID_PLAYER_ID;

public FCNPC_OnInit()
{
	myFirstNPC = FCNPC_Create("FirstNPC");
	FCNPC_Spawn(myFirstNPC, 0, 2027.6785,1344.4966,10.8203);
	return 1;
}*/



public OnGameModeInit()
{
	SetGameModeText("Ventura's DM~MG");

	ShowPlayerMarkers(1);
	ShowNameTags(1);
	EnableStuntBonusForAll(0);

	for(new i = 0; i < 310; i++){
			AddPlayerClass(i,1958.3783,1343.1572,15.3746,270.1425,0,0,24,300,-1,-1);
	}

	for(new i = 0; i < MAX_SECURITY; i++){
			for(new j = 0; j < 2; j++){
			seguridad[i][j] = INVALID_PLAYER_ID
			}
	}



	// Player Class's
	

	// Car Spawns

	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(429,2040.5247,1359.2783,10.3516,177.1306,13,13);
	AddStaticVehicle(421,2110.4102,1398.3672,10.7552,359.5964,13,13);
	AddStaticVehicle(411,2074.9624,1479.2120,10.3990,359.6861,64,64);
	AddStaticVehicle(477,2075.6038,1666.9750,10.4252,359.7507,94,94);
	AddStaticVehicle(541,2119.5845,1938.5969,10.2967,181.9064,22,22);
	AddStaticVehicle(541,1843.7881,1216.0122,10.4556,270.8793,60,1);
	AddStaticVehicle(402,1944.1003,1344.7717,8.9411,0.8168,30,30);
	AddStaticVehicle(402,1679.2278,1316.6287,10.6520,180.4150,90,90);
	AddStaticVehicle(415,1685.4872,1751.9667,10.5990,268.1183,25,1);
	AddStaticVehicle(411,2034.5016,1912.5874,11.9048,0.2909,123,1);
	AddStaticVehicle(411,2172.1682,1988.8643,10.5474,89.9151,116,1);
	AddStaticVehicle(429,2245.5759,2042.4166,10.5000,270.7350,14,14);
	AddStaticVehicle(477,2361.1538,1993.9761,10.4260,178.3929,101,1);
	AddStaticVehicle(550,2221.9946,1998.7787,9.6815,92.6188,53,53);
	AddStaticVehicle(558,2243.3833,1952.4221,14.9761,359.4796,116,1);
	AddStaticVehicle(587,2276.7085,1938.7263,31.5046,359.2321,40,1);
	AddStaticVehicle(587,2602.7769,1853.0667,10.5468,91.4813,43,1);
	AddStaticVehicle(603,2610.7600,1694.2588,10.6585,89.3303,69,1);
	AddStaticVehicle(587,2635.2419,1075.7726,10.5472,89.9571,53,1);
	AddStaticVehicle(437,2577.2354,1038.8063,10.4777,181.7069,35,1);
	AddStaticVehicle(535,2039.1257,1545.0879,10.3481,359.6690,123,1);
	AddStaticVehicle(535,2009.8782,2411.7524,10.5828,178.9618,66,1);
	AddStaticVehicle(429,2010.0841,2489.5510,10.5003,268.7720,1,2);
	AddStaticVehicle(415,2076.4033,2468.7947,10.5923,359.9186,36,1);
	AddStaticVehicle(487,2093.2754,2414.9421,74.7556,89.0247,26,57);
	AddStaticVehicle(506,2352.9026,2577.9768,10.5201,0.4091,7,7);
	AddStaticVehicle(506,2166.6963,2741.0413,10.5245,89.7816,52,52);
	AddStaticVehicle(411,1960.9989,2754.9072,10.5473,200.4316,112,1);
	AddStaticVehicle(429,1919.5863,2760.7595,10.5079,100.0753,2,1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,40,1);
	AddStaticVehicle(402,1591.0482,2746.3982,10.6519,172.5125,30,30);
	AddStaticVehicle(603,1580.4537,2838.2886,10.6614,181.4573,75,77);
	AddStaticVehicle(550,1555.2734,2750.5261,10.6388,91.7773,62,62);
	AddStaticVehicle(535,1455.9305,2878.5288,10.5837,181.0987,118,1);
	AddStaticVehicle(477,1537.8425,2578.0525,10.5662,0.0650,121,1);
	AddStaticVehicle(451,1433.1594,2607.3762,10.3781,88.0013,16,16);
	AddStaticVehicle(603,2223.5898,1288.1464,10.5104,182.0297,18,1);
	AddStaticVehicle(558,2451.6707,1207.1179,10.4510,179.8960,24,1);
	AddStaticVehicle(550,2461.7253,1357.9705,10.6389,180.2927,62,62);
	AddStaticVehicle(558,2461.8162,1629.2268,10.4496,181.4625,117,1);
	AddStaticVehicle(477,2395.7554,1658.9591,10.5740,359.7374,0,1);
	AddStaticVehicle(404,1553.3696,1020.2884,10.5532,270.6825,119,50);
	AddStaticVehicle(400,1380.8304,1159.1782,10.9128,355.7117,123,1);
	AddStaticVehicle(418,1383.4630,1035.0420,10.9131,91.2515,117,227);
	AddStaticVehicle(404,1445.4526,974.2831,10.5534,1.6213,109,100);
	AddStaticVehicle(400,1704.2365,940.1490,10.9127,91.9048,113,1);
	AddStaticVehicle(404,1658.5463,1028.5432,10.5533,359.8419,101,101);
	AddStaticVehicle(581,1677.6628,1040.1930,10.4136,178.7038,58,1);
	AddStaticVehicle(581,1383.6959,1042.2114,10.4121,85.7269,66,1);
	AddStaticVehicle(581,1064.2332,1215.4158,10.4157,177.2942,72,1);
	AddStaticVehicle(581,1111.4536,1788.3893,10.4158,92.4627,72,1);
	AddStaticVehicle(522,953.2818,1806.1392,8.2188,235.0706,3,8);
	AddStaticVehicle(522,995.5328,1886.6055,10.5359,90.1048,3,8);
	AddStaticVehicle(521,993.7083,2267.4133,11.0315,1.5610,75,13);
	AddStaticVehicle(535,1439.5662,1999.9822,10.5843,0.4194,66,1);
	AddStaticVehicle(522,1430.2354,1999.0144,10.3896,352.0951,6,25);
	AddStaticVehicle(522,2156.3540,2188.6572,10.2414,22.6504,6,25);
	AddStaticVehicle(598,2277.6846,2477.1096,10.5652,180.1090,0,1);
	AddStaticVehicle(598,2268.9888,2443.1697,10.5662,181.8062,0,1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,0,1);
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,0,1);
	AddStaticVehicle(523,2294.7305,2441.2651,10.3860,9.3764,0,0);
	AddStaticVehicle(523,2290.7268,2441.3323,10.3944,16.4594,0,0);
	AddStaticVehicle(523,2295.5503,2455.9656,2.8444,272.6913,0,0);
	AddStaticVehicle(522,2476.7900,2532.2222,21.4416,0.5081,8,82);
	AddStaticVehicle(522,2580.5320,2267.9595,10.3917,271.2372,8,82);
	AddStaticVehicle(522,2814.4331,2364.6641,10.3907,89.6752,36,105);
	AddStaticVehicle(535,2827.4143,2345.6953,10.5768,270.0668,97,1);
	AddStaticVehicle(521,1670.1089,1297.8322,10.3864,359.4936,87,118);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,58,8);
	AddStaticVehicle(487,1647.7902,1538.9934,11.2433,51.8071,0,8);
	AddStaticVehicle(487,1608.3851,1630.7268,11.2840,174.5517,58,8);
	AddStaticVehicle(476,1283.0006,1324.8849,9.5332,275.0468,7,6); //11.5332
	AddStaticVehicle(476,1283.5107,1361.3171,9.5382,271.1684,1,6); //11.5382
	AddStaticVehicle(476,1283.6847,1386.5137,11.5300,272.1003,89,91);
	AddStaticVehicle(476,1288.0499,1403.6605,11.5295,243.5028,119,117);
	AddStaticVehicle(415,1319.1038,1279.1791,10.5931,0.9661,62,1);
	AddStaticVehicle(521,1710.5763,1805.9275,10.3911,176.5028,92,3);
	AddStaticVehicle(521,2805.1650,2027.0028,10.3920,357.5978,92,3);
	AddStaticVehicle(535,2822.3628,2240.3594,10.5812,89.7540,123,1);
	AddStaticVehicle(521,2876.8013,2326.8418,10.3914,267.8946,115,118);
	AddStaticVehicle(429,2842.0554,2637.0105,10.5000,182.2949,1,3);
	AddStaticVehicle(549,2494.4214,2813.9348,10.5172,316.9462,72,39);
	AddStaticVehicle(549,2327.6484,2787.7327,10.5174,179.5639,75,39);
	AddStaticVehicle(549,2142.6970,2806.6758,10.5176,89.8970,79,39);
	AddStaticVehicle(521,2139.7012,2799.2114,10.3917,229.6327,25,118);
	AddStaticVehicle(521,2104.9446,2658.1331,10.3834,82.2700,36,0);
	AddStaticVehicle(521,1914.2322,2148.2590,10.3906,267.7297,36,0);
	AddStaticVehicle(549,1904.7527,2157.4312,10.5175,183.7728,83,36);
	AddStaticVehicle(549,1532.6139,2258.0173,10.5176,359.1516,84,36);
	AddStaticVehicle(521,1534.3204,2202.8970,10.3644,4.9108,118,118);
	AddStaticVehicle(549,1613.1553,2200.2664,10.5176,89.6204,89,35);
	AddStaticVehicle(400,1552.1292,2341.7854,10.9126,274.0815,101,1);
	AddStaticVehicle(404,1637.6285,2329.8774,10.5538,89.6408,101,101);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,62,1);
	AddStaticVehicle(411,1281.7458,2571.6719,10.5472,270.6128,106,1);
	AddStaticVehicle(522,1305.5295,2528.3076,10.3955,88.7249,3,8);
	AddStaticVehicle(521,993.9020,2159.4194,10.3905,88.8805,74,74);
	AddStaticVehicle(415,1512.7134,787.6931,10.5921,359.5796,75,1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,3,8);
	AddStaticVehicle(522,2133.6428,1012.8537,10.3789,87.1290,3,8);

	//Monday 13th Additions ~ Jax
	AddStaticVehicle(415,2266.7336,648.4756,11.0053,177.8517,0,1); //
	AddStaticVehicle(461,2404.6636,647.9255,10.7919,183.7688,53,1); //
	AddStaticVehicle(506,2628.1047,746.8704,10.5246,352.7574,3,3); //
	AddStaticVehicle(549,2817.6445,928.3469,10.4470,359.5235,72,39); //
	// --- uncommented
	AddStaticVehicle(562,1919.8829,947.1886,10.4715,359.4453,11,1); //
	AddStaticVehicle(562,1881.6346,1006.7653,10.4783,86.9967,11,1); //
	AddStaticVehicle(562,2038.1044,1006.4022,10.4040,179.2641,11,1); //
	AddStaticVehicle(562,2038.1614,1014.8566,10.4057,179.8665,11,1); //
	AddStaticVehicle(562,2038.0966,1026.7987,10.4040,180.6107,11,1); //
	// --- uncommented end

	//Uber haxed
	AddStaticVehicle(422,9.1065,1165.5066,19.5855,2.1281,101,25); //
	AddStaticVehicle(463,19.8059,1163.7103,19.1504,346.3326,11,11); //
	AddStaticVehicle(463,12.5740,1232.2848,18.8822,121.8670,22,22); //
	//AddStaticVehicle(434,-110.8473,1133.7113,19.7091,359.7000,2,2); //hotknife
	AddStaticVehicle(586,69.4633,1217.0189,18.3304,158.9345,10,1); //
	AddStaticVehicle(586,-199.4185,1223.0405,19.2624,176.7001,25,1); //
	//AddStaticVehicle(605,-340.2598,1177.4846,19.5565,182.6176,43,8); // SMASHED UP CAR
	AddStaticVehicle(476,325.4121,2538.5999,17.5184,181.2964,71,77); //
	AddStaticVehicle(476,291.0975,2540.0410,17.5276,182.7206,7,6); //
	AddStaticVehicle(576,384.2365,2602.1763,16.0926,192.4858,72,1); //
	AddStaticVehicle(586,423.8012,2541.6870,15.9708,338.2426,10,1); //
	AddStaticVehicle(586,-244.0047,2724.5439,62.2077,51.5825,10,1); //
	AddStaticVehicle(586,-311.1414,2659.4329,62.4513,310.9601,27,1); //

	//uber haxed x 50
	//AddStaticVehicle(406,547.4633,843.0204,-39.8406,285.2948,1,1); // DUMPER
	//AddStaticVehicle(406,625.1979,828.9873,-41.4497,71.3360,1,1); // DUMPER
	//AddStaticVehicle(486,680.7997,919.0510,-40.4735,105.9145,1,1); // DOZER
	//AddStaticVehicle(486,674.3994,927.7518,-40.6087,128.6116,1,1); // DOZER
	AddStaticVehicle(543,596.8064,866.2578,-43.2617,186.8359,67,8); //
	AddStaticVehicle(543,835.0838,836.8370,11.8739,14.8920,8,90); //
	AddStaticVehicle(549,843.1893,838.8093,12.5177,18.2348,79,39); //
	//AddStaticVehicle(605,319.3803,740.2404,6.7814,271.2593,8,90); // SMASHED UP CAR
	AddStaticVehicle(400,-235.9767,1045.8623,19.8158,180.0806,75,1); //
	AddStaticVehicle(599,-211.5940,998.9857,19.8437,265.4935,0,1); //
	AddStaticVehicle(422,-304.0620,1024.1111,19.5714,94.1812,96,25); //
	AddStaticVehicle(588,-290.2229,1317.0276,54.1871,81.7529,1,1); //
	//AddStaticVehicle(424,-330.2399,1514.3022,75.1388,179.1514,2,2); //BF INJECT
	AddStaticVehicle(451,-290.3145,1567.1534,75.0654,133.1694,61,61); //
	AddStaticVehicle(470,280.4914,1945.6143,17.6317,310.3278,43,0); //
	AddStaticVehicle(470,272.2862,1949.4713,17.6367,285.9714,43,0); //
	AddStaticVehicle(470,271.6122,1961.2386,17.6373,251.9081,43,0); //
	AddStaticVehicle(470,279.8705,1966.2362,17.6436,228.4709,43,0); //
	//AddStaticVehicle(548,292.2317,1923.6440,19.2898,235.3379,1,1); // CARGOBOB
	AddStaticVehicle(433,277.6437,1985.7559,18.0772,270.4079,43,0); //
	AddStaticVehicle(433,277.4477,1994.8329,18.0773,267.7378,43,0); //
	//AddStaticVehicle(432,275.9634,2024.3629,17.6516,270.6823,43,0); // Tank (can cause scary shit to go down)
	AddStaticVehicle(568,-441.3438,2215.7026,42.2489,191.7953,41,29); //
	AddStaticVehicle(568,-422.2956,2225.2612,42.2465,0.0616,41,29); //
	AddStaticVehicle(568,-371.7973,2234.5527,42.3497,285.9481,41,29); //
	AddStaticVehicle(568,-360.1159,2203.4272,42.3039,113.6446,41,29); //
	AddStaticVehicle(468,-660.7385,2315.2642,138.3866,358.7643,6,6); //
	AddStaticVehicle(460,-1029.2648,2237.2217,42.2679,260.5732,1,3); //

	//Uber haxed x 100

    // --- uncommented
	AddStaticVehicle(419,95.0568,1056.5530,13.4068,192.1461,13,76); //
	AddStaticVehicle(429,114.7416,1048.3517,13.2890,174.9752,1,2); //
	//AddStaticVehicle(466,124.2480,1075.1835,13.3512,174.5334,78,76); // exceeds model limit
	AddStaticVehicle(411,-290.0065,1759.4958,42.4154,89.7571,116,1); //
	// --- uncommented end
	AddStaticVehicle(522,-302.5649,1777.7349,42.2514,238.5039,6,25); //
	AddStaticVehicle(522,-302.9650,1776.1152,42.2588,239.9874,8,82); //
	AddStaticVehicle(533,-301.0404,1750.8517,42.3966,268.7585,75,1); //
	AddStaticVehicle(535,-866.1774,1557.2700,23.8319,269.3263,31,1); //
	AddStaticVehicle(550,-799.3062,1518.1556,26.7488,88.5295,53,53); //
	AddStaticVehicle(521,-749.9730,1589.8435,26.5311,125.6508,92,3); //
	AddStaticVehicle(522,-867.8612,1544.5282,22.5419,296.0923,3,3); //
	AddStaticVehicle(554,-904.2978,1553.8269,25.9229,266.6985,34,30); //
	AddStaticVehicle(521,-944.2642,1424.1603,29.6783,148.5582,92,3); //
	// Exceeds model limit, cars need model adjustments
	// --- uncommented
	AddStaticVehicle(429,-237.7157,2594.8804,62.3828,178.6802,1,2); //
	//AddStaticVehicle(431,-160.5815,2693.7185,62.2031,89.4133,47,74); //
	AddStaticVehicle(463,-196.3012,2774.4395,61.4775,303.8402,22,22); //
	//AddStaticVehicle(483,-204.1827,2608.7368,62.6956,179.9914,1,5); //
	//AddStaticVehicle(490,-295.4756,2674.9141,62.7434,359.3378,0,0); //
	//AddStaticVehicle(500,-301.5293,2687.6013,62.7723,87.9509,28,119); //
	//AddStaticVehicle(500,-301.6699,2680.3293,62.7393,89.7925,13,119); //
	AddStaticVehicle(519,-1341.1079,-254.3787,15.0701,321.6338,1,1); //
	AddStaticVehicle(519,-1371.1775,-232.3967,15.0676,315.6091,1,1); //
	//AddStaticVehicle(552,-1396.2028,-196.8298,13.8434,286.2720,56,56); //
	//AddStaticVehicle(552,-1312.4509,-284.4692,13.8417,354.3546,56,56); //
	//AddStaticVehicle(552,-1393.5995,-521.0770,13.8441,187.1324,56,56); //
	//AddStaticVehicle(513,-1355.6632,-488.9562,14.7157,191.2547,48,18); //
	//AddStaticVehicle(513,-1374.4580,-499.1462,14.7482,220.4057,54,34); //
	//AddStaticVehicle(553,-1197.8773,-489.6715,15.4841,0.4029,91,87); //
	//AddStaticVehicle(553,1852.9989,-2385.4009,14.8827,200.0707,102,119); //
	//AddStaticVehicle(583,1879.9594,-2349.1919,13.0875,11.0992,1,1); //
	//AddStaticVehicle(583,1620.9697,-2431.0752,13.0951,126.3341,1,1); //
	//AddStaticVehicle(583,1545.1564,-2409.2114,13.0953,23.5581,1,1); //
	//AddStaticVehicle(583,1656.3702,-2651.7913,13.0874,352.7619,1,1); //
	AddStaticVehicle(519,1642.9850,-2425.2063,14.4744,159.8745,1,1); //
	AddStaticVehicle(519,1734.1311,-2426.7563,14.4734,172.2036,1,1); //
	// --- uncommented end
	
	AddStaticVehicle(415,-680.9882,955.4495,11.9032,84.2754,36,1); //
	AddStaticVehicle(460,-816.3951,2222.7375,43.0045,268.1861,1,3); //
	AddStaticVehicle(460,-94.6885,455.4018,1.5719,250.5473,1,3); //
	AddStaticVehicle(460,1624.5901,565.8568,1.7817,200.5292,1,3); //
	AddStaticVehicle(460,1639.3567,572.2720,1.5311,206.6160,1,3); //
	AddStaticVehicle(460,2293.4219,517.5514,1.7537,270.7889,1,3); //
	AddStaticVehicle(460,2354.4690,518.5284,1.7450,270.2214,1,3); //
	AddStaticVehicle(460,772.4293,2912.5579,1.0753,69.6706,1,3); //

	// 22/4 UPDATE
	AddStaticVehicle(560,2133.0769,1019.2366,10.5259,90.5265,9,39); //
	AddStaticVehicle(560,2142.4023,1408.5675,10.5258,0.3660,17,1); //
	AddStaticVehicle(560,2196.3340,1856.8469,10.5257,179.8070,21,1); //
	AddStaticVehicle(560,2103.4146,2069.1514,10.5249,270.1451,33,0); //
	AddStaticVehicle(560,2361.8042,2210.9951,10.3848,178.7366,37,0); //
	AddStaticVehicle(560,-1993.2465,241.5329,34.8774,310.0117,41,29); //
	AddStaticVehicle(559,-1989.3235,270.1447,34.8321,88.6822,58,8); //
	AddStaticVehicle(559,-1946.2416,273.2482,35.1302,126.4200,60,1); //
	AddStaticVehicle(558,-1956.8257,271.4941,35.0984,71.7499,24,1); //
	AddStaticVehicle(562,-1952.8894,258.8604,40.7082,51.7172,17,1); //
	AddStaticVehicle(411,-1949.8689,266.5759,40.7776,216.4882,112,1); //
	AddStaticVehicle(429,-1988.0347,305.4242,34.8553,87.0725,2,1); //
	AddStaticVehicle(559,-1657.6660,1213.6195,6.9062,282.6953,13,8); //
	AddStaticVehicle(560,-1658.3722,1213.2236,13.3806,37.9052,52,39); //
	AddStaticVehicle(558,-1660.8994,1210.7589,20.7875,317.6098,36,1); //
	AddStaticVehicle(550,-1645.2401,1303.9883,6.8482,133.6013,7,7); //
	AddStaticVehicle(460,-1333.1960,903.7660,1.5568,0.5095,46,32); //
	
	// 25/4 UPDATE
	AddStaticVehicle(411,113.8611,1068.6182,13.3395,177.1330,116,1); //
	AddStaticVehicle(429,159.5199,1185.1160,14.7324,85.5769,1,2); //
	AddStaticVehicle(411,612.4678,1694.4126,6.7192,302.5539,75,1); //
	AddStaticVehicle(522,661.7609,1720.9894,6.5641,19.1231,6,25); //
	AddStaticVehicle(522,660.0554,1719.1187,6.5642,12.7699,8,82); //
	AddStaticVehicle(567,711.4207,1947.5208,5.4056,179.3810,90,96); //
	AddStaticVehicle(567,1031.8435,1920.3726,11.3369,89.4978,97,96); //
	AddStaticVehicle(567,1112.3754,1747.8737,10.6923,270.9278,102,114); //
	AddStaticVehicle(567,1641.6802,1299.2113,10.6869,271.4891,97,96); //
	AddStaticVehicle(567,2135.8757,1408.4512,10.6867,180.4562,90,96); //
	AddStaticVehicle(567,2262.2639,1469.2202,14.9177,91.1919,99,81); //
	AddStaticVehicle(567,2461.7380,1345.5385,10.6975,0.9317,114,1); //
	AddStaticVehicle(567,2804.4365,1332.5348,10.6283,271.7682,88,64); //
	AddStaticVehicle(560,2805.1685,1361.4004,10.4548,270.2340,17,1); //
	AddStaticVehicle(506,2853.5378,1361.4677,10.5149,269.6648,7,7); //
	AddStaticVehicle(567,2633.9832,2205.7061,10.6868,180.0076,93,64); //
	AddStaticVehicle(567,2119.9751,2049.3127,10.5423,180.1963,93,64); //
	AddStaticVehicle(567,2785.0261,-1835.0374,9.6874,226.9852,93,64); //
	AddStaticVehicle(567,2787.8975,-1876.2583,9.6966,0.5804,99,81); //
	AddStaticVehicle(411,2771.2993,-1841.5620,9.4870,20.7678,116,1); //
	AddStaticVehicle(420,1713.9319,1467.8354,10.5219,342.8006,6,1); // taxi

	AddStaticPickup(371, 15, 1710.3359,1614.3585,10.1191); //para
	AddStaticPickup(371, 15, 1964.4523,1917.0341,130.9375); //para
	AddStaticPickup(371, 15, 2055.7258,2395.8589,150.4766); //para
	AddStaticPickup(371, 15, 2265.0120,1672.3837,94.9219); //para
	AddStaticPickup(371, 15, 2265.9739,1623.4060,94.9219); //para

	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	//SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;
}



public SendPlayerFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, 0xFF004040, tmpbuf);
}

public SendAllFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(0xFFFF00AA, tmpbuf);
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}






public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if (bodypart == 9)
    {
        // El disparo fue en la cabeza, el jugador muere instantáneamente
        SetPlayerHealth(playerid, 0.0);
    
    }

    return 1;
}