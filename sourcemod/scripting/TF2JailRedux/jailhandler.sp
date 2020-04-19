#define GravSound 		"vo/scout_sf12_badmagic11.mp3"
#define SuicideSound	"weapons/csgo_awp_shoot.wav"
#define GunSound		"vo/heavy_meleedare02.mp3"
#define TinySound		"vo/scout_sf12_badmagic28.mp3"
#define NO 				"vo/heavy_no02.mp3"

/** 
 *	Simply add your new lr name to the enum to register it with function calls and switch statements
 *	Add them to the calls accordingly 
*/
enum /** LRs **/
{
	// RegularGameplay = -1,
	Suicide = 0,	//
	Custom = 1,		// These 2 shouldn't register with gameplay orientation and are kept out of randlr
	FreedaySelf = 2,
	FreedayOther = 3,
	FreedayAll = 4,
	GuardMelee = 5,
	HHHDay = 6,
	TinyRound = 7,
	HotPrisoner = 8,
	Gravity = 9,
	SWA = 10,
	Warday = 11,
	ClassWars = 12,
	// VSH = 13,
	// PH = 14,
};
/**
 *	When adding a new lr, increase the LRMAX to the proper/latest enum value
 *	Reminder that random lr grabs a random int from 2 to LRMAX
 *	gamemode.iLRs increases by 1 every time you successfully 'TF2JailRedux_RegisterPlugin()' with a sub-plugin
 *	and decreases by 1 everytime you successfully 'TF2JailRedux_UnRegisterPlugin()'
 *	Sub-Plugins are completely manageable on their own, with no need to touch this one
*/
#define LRMAX		(ClassWars + gamemode.iLRs)

#include "TF2JailRedux/lastrequests.sp"

/** 
 *	Add your LR name to the array, referred back to in AddLRsToMenu()
*/
char strLRNames[][] = {
	"Suicide",
	"Custom",
	"Freeday for Yourself",
	"Freeday for Others",
	"Freeday for All",
	"Guards Melee Only",
	"Headless Horsemann Day",
	"Tiny Round",
	"Hot Prisoner",
	"Low Gravity",
	"Stealy Wheely Automobiley",
	"Warday",
	"Class Wars"
	// "",	// VSH/PH
	// Be aware of sub-plugin indices
};

/* All non-gamemode oriented functions are at the bottom! */

/** 
 *	Calls on map start, don't forget 'Prepare' stocks precache and set downloads at the same time! 
*/
public void ManageDownloads()
{
	PrecacheSound("vo/announcer_ends_60sec.mp3", true);
	PrecacheSound("vo/announcer_ends_30sec.mp3", true);
	PrecacheSound("vo/announcer_ends_10sec.mp3", true);

	char s[PLATFORM_MAX_PATH];
	for (int i = 1; i <= 5; i++)
	{
		if (i <= 5)
		{
			Format(s, PLATFORM_MAX_PATH, "vo/announcer_ends_%isec.mp3", i);
			PrecacheSound(s, true);
		}
	}

	PrecacheSound(GravSound, true);
	PrecacheSound(SuicideSound, true);
	PrecacheSound(GunSound, true);
	PrecacheSound(TinySound, true);
	PrecacheSound(NO, true);
	PrecacheSound("misc/rd_finale_beep01.wav", true);

	iLaserBeam = PrecacheModel("materials/sprites/laserbeam.vmt", true);
	iHalo = PrecacheModel("materials/sprites/glow01.vmt", true);
	iHalo2 = PrecacheModel("materials/sprites/halo01.vmt", true);

	CSWA.SetDownloads();
	CHHHDay.SetDownloads();
	CHotPrisoner.SetDownloads();

	Call_OnDownloads();
}
/**
 *	Displays lr HUD text during the round, format the name accordingly
*/
public void ManageHUDText()
{
	char strHudName[128];
	switch (gamemode.iLRType)
	{
		case -1: {	}
		case Custom:		strcopy(strHudName, sizeof(strHudName), strCustomLR);
		case FreedayAll:	strcopy(strHudName, sizeof(strHudName), "Freeday For All");
		case GuardMelee:	strcopy(strHudName, sizeof(strHudName), "Guards Melee Only");
		case HHHDay:		strcopy(strHudName, sizeof(strHudName), "Headless Horsemann Day");
		case TinyRound:		strcopy(strHudName, sizeof(strHudName), "Tiny Round");
		case HotPrisoner:	strcopy(strHudName, sizeof(strHudName), "Hot Prisoners");
		case Gravity:		strcopy(strHudName, sizeof(strHudName), "Low Gravity");
		case SWA:			strcopy(strHudName, sizeof(strHudName), "Stealy Wheely Automobiley");
		case Warday:		strcopy(strHudName, sizeof(strHudName), "Warday");
		case ClassWars:		strcopy(strHudName, sizeof(strHudName), "Class Warfare");
	}
	Call_OnHudShow(strHudName);

	if (strHudName[0] != '\0')
		SetTextNode(hTextNodes[1], strHudName, EnumTNPS[1].fCoord_X, EnumTNPS[1].fCoord_Y, EnumTNPS[1].fHoldTime, EnumTNPS[1].iRed, EnumTNPS[1].iGreen, EnumTNPS[1].iBlue, EnumTNPS[1].iAlpha, EnumTNPS[1].iEffect, EnumTNPS[1].fFXTime, EnumTNPS[1].fFadeIn, EnumTNPS[1].fFadeOut);
}
/**
 *	Called directly when a player spawns, be sure to note iRoundState(s) if being specific
*/
public void ManageSpawn(const JailFighter base, Event event)
{
	// int client = base.index;

	Call_OnPlayerSpawned(base, event);
}
/**
 *	Manage each player just after spawn or regeneration
*/
public void PrepPlayer(int userid)
{
	int client = GetClientOfUserId(userid);
	if (!IsClientValid(client) || !IsPlayerAlive(client))
		return;

	JailFighter base = JailFighter(client);

	switch (gamemode.iLRType)
	{
		case ClassWars, Warday:return;	// Prevent ammo removal
		case HHHDay:return;				// Prevent clearing everything
		case -1:{	}
	}

	if (Call_OnPlayerPreppedPre(base) != Plugin_Continue)
		return;

	//SetEntityModel(client, "");

	int team = GetClientTeam(client);
	bool killpda;

	if (TF2_GetPlayerClass(client) == TFClass_Engineer)
	{
		switch (cvarTF2Jail[EngieBuildings].IntValue)
		{
			case 0:killpda = true;
			case 1:if (team != RED) killpda = true;
			case 2:if (team != BLU) killpda = true;
		}
	}
	else killpda = true;

	if (killpda)
	{
		TF2_RemoveWeaponSlot(client, TFWeaponSlot_Building);
		TF2_RemoveWeaponSlot(client, TFWeaponSlot_Grenade);
	}

	TF2_RemoveWeaponSlot(client, TFWeaponSlot_PDA);
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Item1);
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Item2);

	if (team == RED)
		base.EmptyWeaponSlots();

	Call_OnPlayerPrepped(base);
}
/**
 *	Calls without including players, so we don't fire the same thing for every player
*/
public void ManageRoundStart(Event event)
{
	switch (gamemode.iLRType)
	{
		case FreedayAll:
		{
			gamemode.bIsWardenLocked = true;
			gamemode.bIsFreedayRound = true;
			CPrintToChatAll("%t %t", "Plugin Tag", "Freeday All Start");
		}
		case GuardMelee:EmitSoundToAll(GunSound);
		case TinyRound:
		{
			EmitSoundToAll(TinySound);
			CPrintToChatAll("%t %t", "Plugin Tag", "Tiny Round Start");
			gamemode.bIsWardenLocked = true;
		}
		case Gravity:
		{
			CPrintToChatAll("%t %t", "Plugin Tag", "Gravity Start");
			EmitSoundToAll(GravSound);
			hEngineConVars[2].SetInt(100);
		}
		case SWA:CSWA.Initialize();
		case Warday:
		{
			CPrintToChatAll("%t %t", "Plugin Tag", "Warday Start");
			gamemode.bIsWarday = true;
			gamemode.bIsWardenLocked = true;
		}
		case ClassWars:
		{
			TFClassType iClassRED = view_as< TFClassType >(GetRandomInt(1, 9));
			TFClassType iClassBLU = view_as< TFClassType >(GetRandomInt(1, 9));
			for (int i = MaxClients; i; --i)
				if (IsClientInGame(i) && IsPlayerAlive(i))
					TF2_SetPlayerClass(i, GetClientTeam(i) == RED ? iClassRED : iClassBLU);

			gamemode.bIsWarday = true;
			gamemode.bIsWardenLocked = true;
			gamemode.bAllowBuilding = true;
		}
		case HHHDay:CHHHDay.Initialize();
		case HotPrisoner:CHotPrisoner.Initialize();
	}
	Call_OnRoundStart(event);	// Why the fuck did I do this
	Call_OnRoundStart2();		// Too late, need to keep bcompat
}
/**
 *	Calls on round start for each living player
*/
public void ManageRoundStartPlayer(const JailFighter player, Event event)
{
	int client = player.index;

	switch (gamemode.iLRType)
	{
		case FreedaySelf, FreedayOther:if (player.bIsFreeday) CPrintToChatAll("%t %t", "Plugin Tag", "Freeday Active", client);
		case GuardMelee:
		{
			if (GetClientTeam(client) == BLU)
			{
				player.StripToMelee();
				int wep = GetPlayerWeaponSlot(client, 2);
				if (wep > MaxClients && IsValidEdict(wep))
				{
					int idx = GetItemIndex(wep);
					if (idx == 44 || idx == 648)
					{
						TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
						player.SpawnWeapon("tf_weapon_bat", 0, 1, 0, "");
						SetEntityHealth(client, 125);
					}
				}
			}
		}
		case TinyRound:SetEntPropFloat(client, Prop_Send, "m_flModelScale", 0.3);
		case Warday, ClassWars:SetPawnTimer(ResetPlayer, 0.2, client);
		case SWA:CSWA.Activate(player);
		case HHHDay:CHHHDay.Activate(player);
		case HotPrisoner:CHotPrisoner.Activate(player);
	}
	Call_OnRoundStartPlayer(player, event);
	Call_OnRoundStartPlayer2(player);
}
/**
 *	Self explanatory, set the gamemode.iTimeLeft to whatever time (in seconds) you desire
*/
public void ManageTimeLeft()
{
	int time = cvarTF2Jail[RoundTime].IntValue;
	switch (gamemode.iLRType)
	{
		case -1:{	}
		case SWA:time = 180;
	}
	Call_OnTimeLeft(time);

	gamemode.iTimeLeft = time;
}
/**
 *	Calls on round end without players so we don't fire again for every player
*/
public void ManageOnRoundEnd(Event event)
{
	switch (gamemode.iLRType)
	{
		case Gravity:hEngineConVars[2].SetInt(800);
		case HHHDay:CHHHDay.Terminate(event);
		case HotPrisoner:CHotPrisoner.Terminate(event);
		case SWA:CSWA.Terminate(event);
	}
	Call_OnRoundEnd(event);
}
/** 
 *	Calls on round end obviously, resets should be put here as well 
*/
public void ManageRoundEnd(const JailFighter base, Event event)
{
	switch(gamemode.iLRType)
	{
		case TinyRound:SetPawnTimer(ResetModelProps, 1.0, base.index);
		case HHHDay:CHHHDay.ManageEnd(base);
		case HotPrisoner:CHotPrisoner.ManageEnd(base);
		case SWA:CSWA.ManageEnd(base);
	}
	Call_OnRoundEndPlayer(base, event);
}
/**
 *	Manage jail cell behavior on round start; choose OPEN/CLOSE/LOCK/UNLOCK
*/
public void ManageCells()
{
	switch (gamemode.iLRType)
	{
		case FreedayAll, 
			TinyRound, 
			Warday, 
			ClassWars
			:gamemode.DoorHandler(OPEN);
		/*case example:gamemode.DoorHandler(OPEN or CLOSE or LOCK or UNLOCK);*/
	}
}
/**
 *	If you want something specific to happen to warden on get, stick it here
*/
public void ManageWarden(const JailFighter base)
{
	gamemode.iWarden = base;
	gamemode.bWardenExists = true;
	gamemode.ResetVotes();
	base.WardenMenu();

	switch (gamemode.iLRType)
	{
		case -1: {	}
	}
}
/**
 *	Called on model collision between players, Red player in this case is the 'toucher'
*/
public void ManageRedTouchBlue(const JailFighter toucher, const JailFighter touchee)
{
	switch (gamemode.iLRType)
	{
		case HotPrisoner:CHotPrisoner.ManageTouch(toucher, touchee);
	}
	Call_OnClientTouch(toucher, touchee);
}
/**
 *	Set Friendly Fire timer on round start
*/
public void ManageFFTimer()
{
	float time;
	switch (gamemode.iLRType)
	{
		case 
			HHHDay, 
			TinyRound
		:time = 10.0;
	}
	Call_OnFFTimer(time);

	if (time != 0.0)
		SetPawnTimer(EnableFFTimer, time, gamemode.iRoundCount);
}
/**
 *	Register what happens when a player receives a TFCond condition
*/
public void TF2_OnConditionAdded(int client, TFCond cond)
{	
	switch (cond)
	{
		case TFCond_Disguising, TFCond_Disguised:
		{
			switch (cvarTF2Jail[Disguising].IntValue)
			{
				case 0:TF2_RemoveCondition(client, cond);
				case 1:if (GetClientTeam(client) == BLU) TF2_RemoveCondition(client, cond);
				case 2:if (GetClientTeam(client) == RED) TF2_RemoveCondition(client, cond);
			}
		}
		case TFCond_Charging:
		{
			switch (cvarTF2Jail[NoCharge].IntValue)
			{
				case 1:if (GetClientTeam(client) == BLU) TF2_RemoveCondition(client, cond);
				case 2:if (GetClientTeam(client) == RED) TF2_RemoveCondition(client, cond);
				case 3:TF2_RemoveCondition(client, cond);
			}
		}
	}
}
/**
 *	Vice versa as above
*/
/*public void TF2_OnConditionRemoved(int client, TFCond cond)
{
	switch (cond)
	{
		case -1: {	}
	}
}*/

/** 
 *	Think: Code called every 0.1 seconds per client
 *	If lr requires the same think properties from both teams, set it under both team thinks
 *	WardenThink and BlueThink can overlap
*/
/**
 *	Red Team think
*/
public void ManageRedThink(const JailFighter player)
{
	switch (gamemode.iLRType)
	{
		case SWA:CSWA.ManageThink(player);
		case -1: {	}
	}
	Call_OnRedThink(player);
}
/**
 *	Manage complete Blue Team think 
*/
public void ManageBlueThink(const JailFighter player)
{
	switch (gamemode.iLRType)
	{
		case SWA:CSWA.ManageThink(player);
		case -1: {	}
	}

	if (!gamemode.bDisableCriticals && cvarTF2Jail[CritType].IntValue == 1)
		TF2_AddCondition(player.index, TFCond_Buffed, 0.2);

	Call_OnBlueThink(player);
}
/**
 *	Warden think only
*/
public void ManageWardenThink(const JailFighter player)
{
	switch (gamemode.iLRType)
	{
		case -1: {	}
	}
	Call_OnWardenThink(player);
}
/**
 *	Sound hooking for certain scenarios
*/
public Action SoundHook(int clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (!bEnabled.BoolValue || !IsClientValid(entity))
		return Plugin_Continue;

	JailFighter base = JailFighter(entity);
	switch (gamemode.iLRType)
	{
		case -1: {	}
		case HHHDay:return CHHHDay.HookSound(base, sample, entity);
	}

	return Call_OnSoundHook(clients, numClients, sample, base, channel, volume, level, pitch, flags, soundEntry, seed);
}
/**
 *	PreThink management, will not fire for dead players
*/
public void ManageOnPreThink(const JailFighter base)
{
	switch (gamemode.iLRType)
	{
		case -1: {	}
	}
	Call_OnPreThink(base);
}
/**
 *	Calls when a a player is hurt without SDKHooks
*/
public void ManageHurtPlayer(const JailFighter attacker, const JailFighter victim, Event event)
{
	// int damage = event.GetInt("damageamount");
	// int custom = event.GetInt("custom");
	// int weapon = event.GetInt("weaponid");
	
	switch (gamemode.iLRType)
	{
		case SWA:CSWA.ManageHurtPlayer(attacker, victim, event);
		case -1: {	}
	}

	Call_OnHurtPlayer(victim, attacker, /*damage, custom, weapon, */event);
}
/** 
 *	Calls when damage is taken/given during lr with SDKHooks
*/
public Action ManageOnTakeDamage(const JailFighter victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	Action action, action2;
	switch (gamemode.iLRType)
	{
		default:
		{
			if (IsClientValid(attacker))
			{
				JailFighter base = JailFighter(attacker);
				if (base.bIsFreeday && victim.index != attacker)
				{	// Registers with Razorbacks ^^
					base.RemoveFreeday();
					PrintCenterTextAll("%t", "Attack Guard Lose Freeday", attacker);
				}

				if (victim.bIsFreeday && !base.bIsWarden)
				{
					damage *= 0.0;
					action = Plugin_Changed;
				}

				if (GetClientTeam(attacker) == BLU && cvarTF2Jail[CritType].IntValue == 2 && !gamemode.bDisableCriticals)
				{
					damagetype |= DMG_CRIT;
					action = Plugin_Changed;
				}
				else if (GetClientTeam(attacker) == RED && GetClientTeam(victim.index) == BLU && (gamemode.iRoundState == StateRunning || gamemode.iRoundState == StateDisabled))
					base.MarkRebel();
			}
		}
	}
	action2 = Call_OnTakeDamage(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition, damagecustom);

	return (action > action2 ? action : action2);
}
/**
 *	Called when a player dies obviously
*/
public void ManagePlayerDeath(const JailFighter attacker, const JailFighter victim, Event event)
{
	switch (gamemode.iLRType)
	{
		case HHHDay:CHHHDay.ManageDeath(attacker, victim, event);
	}
	Call_OnPlayerDied(victim, attacker, event);
}
/**
 *	Whenever a player dies POST, this is called
*/
public void CheckLivingPlayers()
{
	if (gamemode.iRoundState != StateRunning || gamemode.iTimeLeft < 0)
		return;

	if (!gamemode.bOneGuardLeft)
	{
		if (GetLivingPlayers(BLU) == 1)
		{
			if (cvarTF2Jail[RemoveFreedayOnLastGuard].BoolValue)
			{
				JailFighter base;
				for (int i = MaxClients; i; --i)
				{
					if (!IsClientInGame(i))
						continue;

					base = JailFighter(i);
					if (base.bIsFreeday)
						base.RemoveFreeday();
				}
			}
			gamemode.bOneGuardLeft = true;

			Action action = Call_OnLastGuard();

			if (action == Plugin_Continue)
				PrintCenterTextAll("%t", "One Guard Left");

			else if (action == Plugin_Stop)
				return;	// Avoid multi-calls if necessary
		}
	}
	if (!gamemode.bOnePrisonerLeft)
	{
		if (GetLivingPlayers(RED) == 1)
		{
			gamemode.bOnePrisonerLeft = true;

			if (Call_OnLastPrisoner() != Plugin_Continue)
				return;
		}
	}
	Call_OnCheckLivingPlayers();
}
/** 
 *	This is all VSH stuff. Doing this to make more of a grasp with forwards
 *
 *	Since when can people build buildings? Oh wait map buildings
*/
public void ManageBuildingDestroyed(const JailFighter base, const int building, const int objecttype, Event event)
{
	switch (gamemode.iLRType) 
	{
		case -1: {	}
	}
	Call_OnBuildingDestroyed(base, building, event);
}
/**
 *	If airblast is disabled then leave this alone obviously
*/
public void ManageOnAirblast(const JailFighter airblaster, const JailFighter airblasted, Event event)
{
	switch (gamemode.iLRType) 
	{
		default: {  }
	}
	Call_OnObjectDeflected(airblasted, airblaster, event);
}
/**
 *	Calls when a player is wetted, kinky. Memes aside remember that this also called with Mad Milk and Sydney Sleeper headshots/charged shots
*/
public void ManageOnPlayerJarated(const JailFighter jarateer, const JailFighter jarateed, Event event)
{
	switch (gamemode.iLRType)
	{
		case -1: {	}
	}
	Call_OnPlayerJarated(jarateer, jarateed, event);
}
/**
 *	In my opinion mediguns shouldn't exist in JB, but hey do whatcha want
*/
public void ManageUberDeployed(const JailFighter patient, const JailFighter medic, Event event)
{
	switch (gamemode.iLRType)
	{
		case -1: {	}
	}
	Call_OnUberDeployed(patient, medic, event);
}
/**
 *	Music that can play during your LR, use the commented example as reference.
 *	If you add a song to any LR, you MUST return Plugin_Continue else the music won't work at all
*/
public Action ManageMusic(char song[PLATFORM_MAX_PATH], float & time)
{
	switch (gamemode.iLRType)
	{
		/* case example:
		{
			strcopy(song, sizeof(song), "jailbreak/SomeBadassSong.mp3");
			time = 9001.0;
			return Plugin_Continue;
		}*/
		default:return Call_OnPlayMusic(song, time);	// Defaults to Handled
	}
}
/**
 *	Manage what happens when the round timer hits 0
 *	You can override the basic round end function which forces Blue to win by returning anything but Plugin_Continue
*/
public Action ManageTimeEnd()
{
	switch (gamemode.iLRType)
	{
		case SWA:return CSWA.ManageTimeEnd();
		default:return Call_OnTimeEnd();
	}
}
/**
 *	Determines if a player's attack is to be critical
*/
public Action TF2_CalcIsAttackCritical(int client, int weapon, char[] weaponname, bool &result)
{
	if (!bEnabled.BoolValue)
		return Plugin_Continue;

 	if (!IsClientValid(client))
 		return Plugin_Continue;

 	JailFighter base = JailFighter(client);
 	switch (gamemode.iLRType)
 	{
 		case -1: {	}
 	}
 	return Call_OnCalcAttack(base, weapon, weaponname, result);
}

public void ListDR(int client)
{
	if (IsVoteInProgress())
		return;
		
	Menu menu = new Menu(ListDRsMenu);
	menu.SetTitle("Select a Death Request");
	menu.AddItem("1", "Freeze All Blues");
	menu.AddItem("2", "Unfreeze All Blues");
	menu.AddItem("3", "Slay All Blues");
	menu.AddItem("4", "Teleport All Blues");
	menu.AddItem("5", "Powerplay");
	menu.ExitButton = true;
	menu.Display(client, -1);
}

void GetCollisionPoint(int client, float pos[3])
{
	float vOrigin[3];
	float vAngles[3];
	
	GetClientEyePosition(client, vOrigin);
	GetClientEyeAngles(client, vAngles);
	
	Handle trace = TR_TraceRayFilterEx(vOrigin, vAngles, MASK_SOLID, RayType_Infinite, TraceEntityFilterPlayer);
	
	if (TR_DidHit(trace))
	{
		TR_GetEndPosition(pos, trace);
		delete trace;
		
		return;
	}
	
	delete trace;
}

bool TraceEntityFilterPlayer(int entity, int contentsMask)
{
	return entity > MaxClients;
}

public int ListDRsMenu(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_Start:
		{
			PrintToServer("Displaying menu"); // Log it
		}
		
		case MenuAction_Display:
		{
			PrintToServer("Client %d was sent menu with panel %x", param1, param2);
		}
		
		case MenuAction_Select:
		{
			char info[24];
			GetMenuItem(menu, param2, info, sizeof(info));
			
			switch (param2)
			{
				case 0:
				{
					ListDR(param1);
					CPrintToChatAll("%t %t", "Plugin Tag", "LR Menu Frozen All Blues", param1);
					ServerCommand("sm_freeze @blue -1");
				}
				case 1:
				{
					ListDR(param1);
					CPrintToChatAll("%t %t", "Plugin Tag", "LR Menu Unfroze All Blues", param1);
					ServerCommand("sm_freeze @blue 0");
				}
				case 2:
				{
					ListDR(param1);
					CPrintToChatAll("%t %t", "Plugin Tag", "LR Menu Slay All Blues", param1);
					ServerCommand("sm_slay @blue");
				}
				case 3:
				{
					ListDR(param1);
					CPrintToChatAll("%t %t", "Plugin Tag", "LR Menu Bring All Blues", param1);
					for (int i = 1; i <= MaxClients; i++)
					{
						if (IsClientInGame(i) && IsPlayerAlive(i) && TF2_GetClientTeam(i) == TFTeam_Blue)
						{
							float fTeleportOrigin[3];
							float fPlayerOrigin[3];
							
							GetCollisionPoint(param1, fPlayerOrigin);
							
							fTeleportOrigin[0] = fPlayerOrigin[0];
							fTeleportOrigin[1] = fPlayerOrigin[1];
							fTeleportOrigin[2] = (fPlayerOrigin[2] + 4);
							
							TeleportEntity(i, fTeleportOrigin, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
				case 4:
				{
					ListDR(param1);
					CPrintToChatAll("%t %t", "Plugin Tag", "LR Menu PowerPlay", param1);
					TF2_SetPlayerPowerPlay(param1, true);
				}
			}
		}
		
		case MenuAction_Cancel:
		{
			PrintToServer("Client %d's menu was cancelled for reason %d", param1, param2);
		}
		
		case MenuAction_End:
		{
			delete menu;
		}
		
		case MenuAction_DrawItem:
		{
			int style;
			char info[32];
			menu.GetItem(param2, info, sizeof(info), style);
		}
		
		case MenuAction_DisplayItem:
		{
			char info[32];
			menu.GetItem(param2, info, sizeof(info));
		}
	}
}

/**
 *	Add lrs to the LR menu obviously
*/
public void AddLRsToMenu(Menu menu)
{
	int i, max, value, flags, def = cvarTF2Jail[LRDefault].IntValue, len = LRMAX;
	char name[64], strID[4], strValue[16];

	for (i = 0; i <= len; i++)
	{
		max = def;
		flags = ITEMDRAW_DEFAULT;
		strValue[0] = '\0';
		name[0] = '\0';

		// if (i == Warday)	// If you want to change an LR's max picks, do something like this
			// max = 3;

		Call_OnMenuAdd(i, max, name);

		if (max)
		{
			value = gamemode.hLRS.Get(i);
			Format(strValue, sizeof(strValue), " (%i/%i)", value, max);
			if (value >= max)
				flags = ITEMDRAW_DISABLED;
		}

		if (i < sizeof(strLRNames))	// If not a sub-plugin
			Format(name, sizeof(name), "%s%s", name, strLRNames[i]);	// TODO: dynamically avoid this issue
		Format(name, sizeof(name), "%s%s", name, strValue);	// Forward pre-formats name

		IntToString(i, strID, sizeof(strID));
		menu.AddItem(strID, name, flags); // Disables the LR selection if the max is too high
	}
}
/**
 *	Add a 'short' description to your last request for the !listlrs command
*/
public void AddLRToPanel(Menu &panel)
{
	char id[4], name[64];
	int i, len = LRMAX;
	for (i = 0; i <= len; i++)
	{
		name[0] = '\0';
		switch (i)
		{
			case 0:name = "Suicide- Kill yourself on the spot";
			case 1:name = "Custom- Type your own last request";
			case 2:name = "Freeday for Yourself- Give yourself a freeday";
			case 3:Format(name, sizeof(name), "Freeday for Others- Give up to %d freedays to others", cvarTF2Jail[FreedayLimit].IntValue);
			case 4:name = "Freeday for All- Give everybody a freeday";
			case 5:name = "Guards Melee Only- Those guns are for babies!";
			case 6:name = "Headless Horsemann Day- Turns all players into the HHH";
			case 7:name = "Tiny Round- Honey I shrunk the players";
			case 8:name = "Hot Prisoner- Prisoners are too hot to touch";
			case 9:name = "Low Gravity- Where did the gravity go";
			case 10:name = "Stealy Wheely Automobiley- Learn how the Mercedes bends";
			case 11:name = "Warday- Team Deathmatch";
			case 12:name = "Class Wars- Class versus class Warday";
		}
		Call_OnPanelAdd(i, name);

		IntToString(i, id, sizeof(id));
		panel.AddItem(id, name);
	}
}
/** 
 *	Called when player is given lr and is selecting. Place your lr under the MenuAction_Select case
 *	Use the already given lr's as a guide if you need help
*/
public int ListLRsMenu(Menu menu, MenuAction action, int client, int select)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			if (!IsPlayerAlive(client))
				return;

			JailFighter base;
			char strIndex[4]; menu.GetItem(select, strIndex, sizeof(strIndex));
			if (cvarTF2Jail[RemoveFreedayOnLR].BoolValue)
			{
				for (int i = MaxClients; i; --i)
				{
					if (!IsClientInGame(i))
						continue;
					base = JailFighter(i);
					if (!base.bIsFreeday)
						continue;
						
					base.RemoveFreeday();
				}
				CPrintToChatAll(TAG ... "%t", "LR Chosen");
			}
			base = JailFighter(client);
			gamemode.bIsLRInUse = true;
			int request = StringToInt(strIndex);

			if (Call_OnLRPicked(base, request, gamemode.hLRS) != Plugin_Continue)
				return;

			int value;
			if (request != -1)	// If the selection isn't random
				value = gamemode.hLRS.Get(request);

			switch (request)
			{
				case -1:	// Random
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Random Select", client);
					int randlr = GetRandomInt(2, LRMAX);		// TODO: Make this not pick LRs that have reached their maximum
					gamemode.iLRPresetType = randlr;
					value = gamemode.hLRS.Get(randlr);

					if (randlr == FreedaySelf)
						base.bIsQueuedFreeday = true;
					else if (randlr == FreedayOther)
						for (int i = 0; i < 3; i++)
							JailFighter(GetRandomPlayer(RED)).bIsQueuedFreeday = true;

					gamemode.hLRS.Set( randlr, value+1 );
					return;
				}
				case Suicide:
				{
					CPrintToChatAll("%t %t", "Plugin Tag", "Suicide Select", client);
					SetPawnTimer(PerformSuicide, GetRandomFloat(0.5, 7.0), client);	// Meme lol
					gamemode.hLRS.Set( request, value+1 );
					return;
				}
				case Custom:
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Custom Select", client);
					base.iCustom = base.userid;
				}
				case FreedaySelf:
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Freeday Self Select", client);
					base.bIsQueuedFreeday = true;
				}
				case FreedayOther:
				{
					CPrintToChatAll("%t %t", "Plugin Tag", "Freeday Other Select", client);
					FreedayforClientsMenu(client);
				}
				case FreedayAll:	
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Freeday All Select", client);
				}
				case GuardMelee:
				{	
					ListDR(client);					
					CPrintToChatAll("%t %t", "Plugin Tag", "Guard Melee Select", client);
				}
				case HHHDay:	
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "HHHDay Select", client);
				}
				case TinyRound:	
				{	
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Tiny Round Select", client);
				}
				case HotPrisoner:	
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Hot Prisoner Select", client);
				}
				case Gravity: 
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Gravity Round Select", client);
				}
				case SWA:			
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Automobile Start", client);
				}
				case Warday: 
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "Warday Select", client);
				}
				case ClassWars:	
				{
					ListDR(client);
					CPrintToChatAll("%t %t", "Plugin Tag", "ClassWars Select", client);
				}
			}

			gamemode.iLRPresetType = request;
			gamemode.hLRS.Set( request, value+1 );
		}
		case MenuAction_End:delete menu;
	}
}
/*
 *	Starting variables for clients entering the server
 *	This is just for forwards to get/set with inherited properties without either firing too early with OnClientPutInServer()
 *	Or having to use OnClientPostAdminCheck()
*/
public void ManageClientStartVariables(const JailFighter base)
{
	Call_OnClientInduction(base);
}
/**
 *	Fires on round begin
 *	Yet again another way to make a new forward
*/
public void ResetVariables(const JailFighter base, const bool compl)
{
	base.iCustom = 0;
	base.iKillCount = 0;
	base.iRebelParticle = -1;
	base.iWardenParticle = -1;
	base.iFreedayParticle = -1;
	base.iHealth = 0;
	base.bIsWarden = false;
	base.bLockedFromWarden = false;
	base.bIsHHH = false;
	base.bInJump = false;
	base.bUnableToTeleport = false;
	base.bIsRebel = false;
	base.bIsQueuedFreeday = false;
	base.flSpeed = 0.0;
	base.flKillingSpree = 0.0;
	base.flHealTime = 0.0;
	if (compl)
	{
		base.bIsFreeday = false;
		base.bIsMuted = false;
		base.bIsVIP = false;
		base.bIsAdmin = false;
	}
	Call_OnVariableReset(base);
}
/**
 *	Sticking this in Handler just in case someone wants to be incredibly specific with their lr 
*/
public void ManageEntityCreated(int ent, const char[] classname)
{
	if (Call_OnEntCreated(ent, classname) != Plugin_Continue)
		return;

	if (StrContains(classname, "tf_ammo_pack", false) != -1)
		SDKHook(ent, SDKHook_Spawn, KillOnSpawn);

	if (cvarTF2Jail[KillPointServerCommand].BoolValue && StrContains(classname, "point_servercommand", false) != -1)
		SDKHook(ent, SDKHook_Spawn, KillOnSpawn);
	
	if (cvarTF2Jail[DroppedWeapons].BoolValue && StrEqual(classname, "tf_dropped_weapon"))
		SDKHook(ent, SDKHook_Spawn, KillOnSpawn);

	if (StrEqual(classname, "func_breakable") && cvarTF2Jail[VentHit].BoolValue)
		RequestFrame(HookVent, EntIndexToEntRef(ent));

	if (StrEqual(classname, "obj_dispenser") || StrEqual(classname, "obj_sentrygun") || StrEqual(classname, "obj_teleporter"))
		SDKHook(ent, SDKHook_Spawn, OnBuildingSpawn);
}
/**
 *	Unique to the player Custom lr, formats the global char strCustomLR
*/
public void OnClientSayCommand_Post(int client, const char[] sCommand, const char[] cArgs)
{
	JailFighter base = JailFighter(client);
	if (base.iCustom > 0 && !IsChatTrigger())
	{
		strcopy(strCustomLR, sizeof(strCustomLR), cArgs);
		CPrintToChat(client, "%t %t", "Plugin Tag", "Custom Activate", strCustomLR);
		base.iCustom = 0;
	}
}
/**
 *	Manage the warden menu applications
*/
public void ManageWardenMenu(Menu &menu)
{
	Call_OnWMenuAdd(menu);
}
/**
 *	Handle warden menu selections
*/
 public int WardenMenuHandler(Menu menu, MenuAction action, int client, int select)
 {
 	switch (action)
	{
		case MenuAction_Select:
		{
			JailFighter player = JailFighter(client);
			if (!player.bIsWarden)
			{
				CPrintToChat(client, "%t %t", "Plugin Tag", "Not Warden");
				return;
			}

			char info[32]; menu.GetItem(select, info, sizeof(info));
			if (Call_OnWMenuSelect(player, info) != Plugin_Continue)
				return;

			FakeClientCommandEx(client, info);
			player.WardenMenu();
		}
	}
}