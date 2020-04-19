
methodmap JailGameMode < StringMap
{
	property int iRoundState
	{
		public get()
		{
			int i; this.GetValue("iRoundState", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iRoundState", i);
		}
	}
	property int iPlaying
	{
		public get()
		{
			int playing;
			for (int i = MaxClients; i; --i) 
			{
				if (!IsClientInGame(i))
					continue;
				if (!IsPlayerAlive(i))
					continue;
				++playing;
			}
			return playing;
		}
	}
	property int iTimeLeft
	{
		public get()
		{
			int i; this.GetValue("iTimeLeft", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iTimeLeft", i);
		}
	}
	property int iRoundCount
	{
		public get()
		{
			int i; this.GetValue("iRoundCount", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iRoundCount", i);
		}
	}
	property int iLRPresetType
	{
		public get()
		{
			int i; this.GetValue("iLRPresetType", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iLRPresetType", i);
		}
	}
	property int iLRType
	{
		public get()
		{
			int i; this.GetValue("iLRType", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iLRType", i);
		}
	}
	property int iMuteType
	{
		public get()
		{
			int i; this.GetValue("iMuteType", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iMuteType", i);
		}
	}
	property int iLivingMuteType
	{
		public get()
		{
			int i; this.GetValue("iLivingMuteType", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iLivingMuteType", i);
		}
	}
	property int iVoters
	{
		public get()
		{
			int i; this.GetValue("iVoters", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iVoters", i);
		}
	}
	property int iVotes
	{
		public get()
		{
			int i; this.GetValue("iVotes", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iVotes", i);
		}
	}
	property int iVotesNeeded
	{
		public get()
		{
			int i; this.GetValue("iVotesNeeded", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iVotesNeeded", i);
		}
	}
	property int iLRs
	{
		public get()
		{
			int i; this.GetValue("iLRs", i);
			return i;
		}
		public set( const int i )
		{
			this.SetValue("iLRs", i);
		}
	}

#if defined _SteamWorks_Included
	property bool bSteam
	{
		public get()
		{
			bool i; this.GetValue("bSteam", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bSteam", i);
		}
	}
#endif
#if defined _sourcebans_included || defined _sourcebanspp_included
	property bool bSB
	{
		public get()
		{
			bool i; this.GetValue("bSB", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bSB", i);
		}
	}
#endif
	property bool bSC
	{
		public get()
		{
			bool i; this.GetValue("bSC", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bSC", i);
		}
	}
#if defined _voiceannounce_ex_included
	property bool bVA
	{
		public get()
		{
			bool i; this.GetValue("bVA", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bVA", i);
		}
	}
#endif
	property bool bTF2Attribs
	{
		public get()
		{
			bool i; this.GetValue("bTF2Attribs", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bTF2Attribs", i);
		}
	}
	property bool bIsMapCompatible
	{
		public get()
		{
			bool i; this.GetValue("bIsMapCompatible", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIsMapCompatible", i);
		}
	}
	property bool bFreedayTeleportSet
	{
		public get()
		{
			bool i; this.GetValue("bFreedayTeleportSet", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bFreedayTeleportSet", i);
		}
	}
	property bool bWardayTeleportSetBlue
	{
		public get()
		{
			bool i; this.GetValue("bWardayTeleportSetBlue", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bWardayTeleportSetBlue", i);
		}
	}
	property bool bWardayTeleportSetRed
	{
		public get()
		{
			bool i; this.GetValue("bWardayTeleportSetRed", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bWardayTeleportSetRed", i);
		}
	}
	property bool bCellsOpened
	{
		public get()
		{
			bool i; this.GetValue("bCellsOpened", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bCellsOpened", i);
		}
	}
	property bool b1stRoundFreeday
	{
		public get()
		{
			bool i; this.GetValue("b1stRoundFreeday", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("b1stRoundFreeday", i);
		}
	}
	property bool bIsLRInUse
	{
		public get()
		{
			bool i; this.GetValue("bIsLRInUse", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIsLRInUse", i);
		}
	}
	property bool bIsWardenLocked
	{
		public get()
		{
			bool i; this.GetValue("bIsWardenLocked", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIsWardenLocked", i);
		}
	}
	property bool bOneGuardLeft
	{
		public get()
		{
			bool i; this.GetValue("bOneGuardLeft", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bOneGuardLeft", i);
		}
	}
	property bool bOnePrisonerLeft
	{
		public get()
		{
			bool i; this.GetValue("bOnePrisonerLeft", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bOnePrisonerLeft", i);
		}
	}
	property bool bAdminLockedLR
	{
		public get()
		{
			bool i; this.GetValue("bAdminLockedLR", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bAdminLockedLR", i);
		}
	}
	property bool bDisableCriticals
	{
		public get()
		{
			bool i; this.GetValue("bDisableCriticals", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bDisableCriticals", i);
		}
	}
	property bool bIsFreedayRound
	{
		public get()
		{
			bool i; this.GetValue("bIsFreedayRound", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIsFreedayRound", i);
		}
	}
	property bool bWardenExists
	{
		public get()
		{
			bool i; this.GetValue("bWardenExists", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bWardenExists", i);
		}
	}
	property bool bFirstDoorOpening
	{
		public get()
		{
			bool i; this.GetValue("bFirstDoorOpening", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bFirstDoorOpening", i);
		}
	}
	property bool bIsWarday
	{
		public get()
		{
			bool i; this.GetValue("bIsWarday", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIsWarday", i);
		}
	}
	property bool bMarkerExists
	{
		public get()
		{
			bool i; this.GetValue("bMarkerExists", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bMarkerExists", i);
		}
	}
	property bool bAllowBuilding
	{
		public get()
		{
			bool i; this.GetValue("bAllowBuilding", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bAllowBuilding", i);
		}
	}
	property bool bSilentWardenKills
	{
		public get()
		{
			bool i; this.GetValue("bSilentWardenKills", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bSilentWardenKills", i);
		}
	}
	property bool bMedicDisabled
	{
		public get()
		{
			bool i; this.GetValue("bMedicDisabled", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bMedicDisabled", i);
		}
	}
	property bool bDisableMuting
	{
		public get()
		{
			bool i; this.GetValue("bDisableMuting", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bDisableMuting", i);
		}
	}
	property bool bDisableKillSpree
	{
		public get()
		{
			bool i; this.GetValue("bDisableKillSpree", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bDisableKillSpree", i);
		}
	}
	property bool bIgnoreRebels
	{
		public get()
		{
			bool i; this.GetValue("bIgnoreRebels", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIgnoreRebels", i);
		}
	}
	property bool bIsLRRound
	{
		public get()
		{
			bool i; this.GetValue("bIsLRRound", i);
			return i;
		}
		public set( const bool i )
		{
			this.SetValue("bIsLRRound", i);
		}
	}

	property float flMusicTime
	{
		public get()
		{
			float i; this.GetValue("flMusicTime", i);
			return i;
		}
		public set( const float i )
		{
			this.SetValue("flMusicTime", i);
		}
	}

	property JailFighter iWarden
	{
		public get()
		{
			if (!this.bWardenExists)
				return view_as< JailFighter >(0);

			JailFighter i; this.GetValue("iWarden", i);
			return i;
		}
		public set( const JailFighter i )
		{
			this.SetValue("iWarden", i);
		}
	}

	/**
	 *	Purpose: Store the plugin handles from registered sub-plugins.
	*/
	property ArrayList hPlugins
	{
		public get()
		{
			ArrayList i; this.GetValue("hPlugins", i);
			return i;
		}
		public set( const ArrayList i )
		{
			this.SetValue("hPlugins", i);
		}
	}

	/**
	 *	Purpose: Store the plugin handles from registered sub-plugin LR packs.
	 *	Add a setter if you need. Don't see why you'd need one though.
	*/
	/*property ArrayList hPacks
	{
		public get()
		{
			ArrayList i; this.GetValue("hPacks", i);
			return i;
		}
	}*/

	/**
	 *	Purpose: Store the Warden Menu, but keep it exposed to sub-plugins.
	*/
	property Menu hWardenMenu
	{
		public get()
		{
			Menu i; this.GetValue("hWardenMenu", i);
			return i;
		}
		public set( const Menu i )
		{
			this.SetValue("hWardenMenu", i);
		}
	}

	/**
	 *	ArrayList of LR usage
	 *	You can determine the maximum picks per round under AddLRsToMenu()
	 *	Size is automatically managed
	*/
	property ArrayList hLRS
	{
		public get()
		{
			ArrayList i; this.GetValue("hLRS", i);
			return i;
		}
		public set ( const ArrayList i )
		{
			this.SetValue("hLRS", i);
		}
	}

	/**
	 *	Purpose: Store the list of targetfilters allocated by map config
	 *	Contains strings of target filter names to create and delete
	 *	for each map
	*/
	property StringMap hTargetFilters
	{
		public get()
		{
			StringMap i; this.GetValue("hTargetFilters", i);
			return i;
		}
		public set ( const StringMap i )
		{
			this.SetValue("hTargetFilters", i);
		}
	}
	// When adding a new property, make sure you initialize it to a default
	public JailGameMode()
	{
		JailGameMode gm = view_as< JailGameMode >(new StringMap());
		gm.iRoundState = 0;
		gm.iTimeLeft = 0;
		gm.iRoundCount = 0;
		gm.iLRPresetType = -1;
		gm.iLRType = -1;
		gm.iMuteType = 0;
		gm.iLivingMuteType = 0;
		gm.iVoters = 0;
		gm.iVotes = 0;
		gm.iVotesNeeded = 0;
		gm.iLRs = 0;
		gm.iWarden = view_as< JailFighter >(0);
		gm.bFreedayTeleportSet = false;
		gm.bTF2Attribs = false;
		gm.bIsFreedayRound = false;
		gm.bDisableCriticals = false;
		gm.bWardenExists = false;
		gm.bFirstDoorOpening = false;
		gm.bIsWardenLocked = false;
		gm.bAdminLockedLR = false;
		gm.bIsWarday = false;
		gm.bOneGuardLeft = false;
		gm.bOnePrisonerLeft = false;
		gm.bIsLRInUse = false;
		gm.b1stRoundFreeday = false;
		gm.bCellsOpened = false;
		gm.bIsMapCompatible = false;
		gm.bAllowBuilding = false;
		gm.bSilentWardenKills = false;
		gm.bMedicDisabled = false;
		gm.bDisableMuting = false;
		gm.bDisableKillSpree = false;
		gm.bIgnoreRebels = false;
#if defined _SteamWorks_Included
		gm.bSteam = false;
#endif
#if defined _sourcebans_included || defined _sourcebanspp_included
		gm.bSB = false;
#endif
		gm.bSC = false;
#if defined _voiceannounce_ex_included
		gm.bVA = false;
#endif
		gm.bMarkerExists = false;
		gm.bIsLRRound = false;
		gm.flMusicTime = 0.0;
		gm.hPlugins = new ArrayList();
		gm.hTargetFilters = new StringMap();
		return gm;
	}
	/**
	 *	Find and Initialize a random player as the Warden.
	 *
	 *	@return 				JailFighter instance of the new Warden.
	*/
	public JailFighter FindRandomWarden()
	{
		if (this.bIsWardenLocked)
			return view_as< JailFighter >(0);
		int client = GetRandomPlayer(BLU, true);
		if (client == -1)
			return view_as< JailFighter >(0);

		JailFighter player = JailFighter(client);
		return player.WardenSet() ? player : view_as< JailFighter >(0);
	}
	/**
	 *	Handle the cell doors.
	 *
	 *	@param status 			Type of cell door usage found in the eDoorsMode enum.
	 *	@param announce 		Announce message to all clients.
	 *	@param fromwarden 		If true, current warden will be the client announced who activated cells. 
	 *							If false, undisclosed admin is the announced activator.
	 *							Do NOT set this param to true if there is no current Warden.
	 *	@param overridefwds 	If true, forwards will not be called for the according action.
	 *
	 *	@noreturn
	*/
	public void DoorHandler( const eDoorsMode status, bool announce = false, bool fromwarden = true, bool overridefwds = false )
	{
		if (strCellNames[0] != '\0')
		{
			char name[32];
			switch (status)
			{
				case OPEN:
				{
					if (!overridefwds)
						if (Call_OnDoorsOpen() != Plugin_Continue) 
							return;
					FormatEx(name, sizeof(name), "%t", "Opened");
					this.bCellsOpened = true;
					if (!this.bFirstDoorOpening)
						this.bFirstDoorOpening = true;
				}
				case CLOSE:
				{
					if (!overridefwds)
						if (Call_OnDoorsClose() != Plugin_Continue) 
							return;
					FormatEx(name, sizeof(name), "%t", "Closed");
					this.bCellsOpened = false;
				}
				case LOCK:
				{
					if (!overridefwds)
						if (Call_OnDoorsLock() != Plugin_Continue) 
							return;
					FormatEx(name, sizeof(name), "%t", "Locked");
				}
				case UNLOCK:
				{
					if (!overridefwds)
						if (Call_OnDoorsUnlock() != Plugin_Continue) 
							return;
					FormatEx(name, sizeof(name), "%t", "Unlocked");
				}
			}

			if (announce)
				if (fromwarden)
					CPrintToChatAll("%t %t", "Plugin Tag", "Warden Work Cells", this.iWarden.index, name);
				else CPrintToChatAll("%t %t", "Admin Tag", "Admin Work Cells", name);

			int i, ent = -1;
			for (i = 0; i < sizeof(strDoorsList); i++)
			{
				ent = -1;
				while ((ent = FindEntityByClassnameSafe(ent, strDoorsList[i])) != -1)
				{
					GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
					if (StrEqual(name, strCellNames, false))
					{
						switch (status)
						{
							case OPEN:AcceptEntityInput(ent, "Open");
							case CLOSE:AcceptEntityInput(ent, "Close");
							case LOCK:AcceptEntityInput(ent, "Lock");
							case UNLOCK:AcceptEntityInput(ent, "Unlock");
						}
					}
				}
			}
		}
	}
	/**
	 *	Reset the Warden-firing votes.
	 *
	 *	@noreturn
	*/
	public void ResetVotes()
	{
		this.iVotes = 0;

		for (int i = MaxClients; i; --i)
			if (IsClientConnected(i))
				JailFighter(i).bVoted = false;
	}
	/**
	 *	Find and terminate the current Warden.
	 *
	 *	@param prevent 			Prevent the player from becoming Warden again.
	 * 	@param announce 		Display to all players that the Warden was fired.
	 *
	 *	@noreturn
	*/
	public void FireWarden( bool prevent = true, bool announce = true )
	{
		JailFighter player = this.iWarden;
		if (!player)
			return;

		player.WardenUnset();

		if (prevent)
			player.bLockedFromWarden = true;
		if (announce)
		{
			CPrintToChatAll("%t %t", "Plugin Tag", "Warden Fired");
			PrintCenterTextAll("%t", "Warden Fired");
		}

		this.ResetVotes();
	}
	/**
	 *	Open all of the doors on a map.
	 *	@note 					This ignores all name checks and opens every door possible.
	 *							This also has the chance of opening doors that lead outside of the map, be wary of this.
	 *
	 *	@noreturn
	*/
	public void OpenAllDoors()
	{
		int ent;
		for (int i = 0; i < sizeof(strDoorsList); i++)
		{
			ent = -1;
			while ((ent = FindEntityByClassname(ent, strDoorsList[i])) != -1)
			{
				if (IsValidEntity(ent))
				{
					AcceptEntityInput(ent, "Unlock");
					AcceptEntityInput(ent, "Open");
				}
			}
		}
	}
	/**
	 *	Enable/Disable the medic room in a map.
	 *
	 *	@param status 			True to enable it, False otherwise.
	 *
	 *	@noreturn
	*/
	//	Props to Dr.Doctor
	public void ToggleMedic( const bool status )
	{
		int ent = -1;
		while ((ent = FindEntityByClassname(ent, "trigger_hurt")) != -1)
			if (IsValidEntity(ent))
				if (GetEntPropFloat(ent, Prop_Data, "m_flDamage") < 0)
					AcceptEntityInput(ent, status ? "Enable" : "Disable");

		this.bMedicDisabled = !status;
	}
	/**
	 *	Toggle team filtering on the medic room.
	 *
	 *	@param team 			Team to toggle.
	 *
	 *	@noreturn
	*/
	/*public void ToggleMedicTeam( int team = 0 )
	{
		int ent = -1;
		while ((ent = FindEntityByClassname(ent, "trigger_hurt")) != -1)
			if (IsValidEntity(ent))
				if (GetEntPropFloat(ent, Prop_Data, "m_flDamage") < 0)
					SetEntProp(ent, Prop_Data, "m_iTeamNum", team);
	}*/

	/**
	 *	Trigger muting on clients.
	 *
	 *	@param player 			JailFighter instance of player to toggle muting for.
	 *	@param forcedead 		Force the client to be treated as dead, even if they aren't.
	 *	@param teamchange 		Force team-based muting onto the client, even if they aren't
	 *							on that team.
	 *
	 *	@noreturn
	*/
	public void ToggleMuting( const JailFighter player, bool forcedead = false, int teamchange = 0 )
	{
		if (this.iRoundState != StateRunning || this.bDisableMuting)
		{
			player.UnmutePlayer();
			return;
		}

		int type = (!forcedead && IsPlayerAlive(player.index)) ? this.iLivingMuteType : this.iMuteType;
		int team = teamchange ? teamchange : GetClientTeam(player.index);
		bool ismute = player.bIsMuted;

		if (!team)	// If player is in spec, assume red team rules of muting
			team = RED;

		switch (type)
		{
			case 0:player.UnmutePlayer();
			case 1:
				if (team == RED && !player.bIsVIP)
					player.MutePlayer();
				else player.UnmutePlayer();
			case 2:
				if (team == BLU && !player.bIsVIP)
					player.MutePlayer();
				else player.UnmutePlayer();
			case 3:if (!player.bIsVIP) player.MutePlayer();
			case 4:if (team == RED) player.MutePlayer();
			case 5:if (team == BLU) player.MutePlayer();
			default:player.MutePlayer();
		}

		char s[16];
		if (ismute && !player.bIsMuted)
			s = "Unmuted";
		else if (!ismute && player.bIsMuted)
			s = "Muted";

		if (s[0] != '\0')
			CPrintToChat(player.index, "%t %t", "Plugin Tag", s);
	}

	/**
	 *	Get the position of a certain teleportation location.
	 *
	 *	@param location  		Location index to get.
	 *	@param array 			Array to copy to.
	 *
	 *	@return 				True if the location property is valid.
	*/
	public bool GetTelePosition( const int location, float[] array )
	{
		switch (location)
		{
			case FREEDAY:
			{
				array[0] = vecFreedayPosition[0];
				array[1] = vecFreedayPosition[1];
				array[2] = vecFreedayPosition[2];
				return this.bFreedayTeleportSet;
			}
			case WRED:
			{
				array[0] = vecWardayRed[0];
				array[1] = vecWardayRed[1];
				array[2] = vecWardayRed[2];
				return this.bWardayTeleportSetRed;
			}
			case WBLU:
			{
				array[0] = vecWardayBlu[0];
				array[1] = vecWardayBlu[1];
				array[2] = vecWardayBlu[2];
				return this.bWardayTeleportSetBlue;
			}
		}
		return false;
	}

	// No private properties yet >:(
	/**
	 *	Toggle the Warden's lock status.
	 *	@note 					This is recommended rather than setting the raw property due
	 *							to a forward plugins can operate on.
	 *
	 *	@param status  			Location index to get.
	 *	@param unsetwarden 		If true, unset the current warden.
	 *
	 *	@return 				True on success, false otherwise.
	*/
	public bool SetWardenLock(const bool status, bool unsetwarden = false)
	{
		if (Call_OnSetWardenLock(status) != Plugin_Continue)
			return false;

		if (unsetwarden)
			this.iWarden.WardenUnset();
		this.bIsWardenLocked = status;
		return true;
	}

	/**
	 *	Autobalance the teams in accordance with the cvars.
	 *
	 *	@param announce 		Tell the player that they've been autobalanced.
	 *
	 *	@noreturn
	*/
	public void AutobalanceTeams(bool announce = true)
	{
		if (this.iPlaying <= 2)
			return;

		if (Call_OnShouldAutobalance() != Plugin_Continue)
			return;

		int immunity = cvarTF2Jail[AutobalanceImmunity].IntValue;
		float balance = cvarTF2Jail[BalanceRatio].FloatValue;
		float lBlue = float( GetLivingPlayers(BLU) );
		float lRed = float( GetLivingPlayers(RED) );
		JailFighter player;

		float ratio;
		int tries;
		do
		{
			ratio = lBlue / lRed;
			if (ratio <= balance)
				break;

			player = JailFighter(GetRandomPlayer(BLU, true));
			if (player.index == -1)		// Fake news
				break;

			if ((immunity == 2 && !player.bIsAdmin) || (immunity == 1 && !player.bIsVIP) || !immunity)
			{
				if (Call_OnShouldAutobalancePlayer(player) != Plugin_Continue)
					continue;

				KillFlameManager(player.index);
				player.ForceTeamChange(RED);
				if (announce)
					CPrintToChat(player.index, "%t %t", "Plugin Tag", "Autobalanced");

				--lBlue;	// Avoid loopception
				++lRed;
			}
		} while ++tries < 50;	// Plenty
	}

	/**
	 *	Autobalance the teams as evenly as possible.
	 *	@note 					Guardbanned players are handled automatically.
	 *
	 *	@param announce			Tell the player that they've been autobalanced.
	 *	@param followimmun 		If true, follow autobalance immunity rules.
	 *
	 *	@noreturn
	*/
	public void EvenTeams(bool announce = true, bool followimmun = true)
	{
		if (this.iPlaying <= 2)		// Shouldn't they already be even then...?
			return;

		int countred, countblu;
		int immunity = cvarTF2Jail[AutobalanceImmunity].IntValue;
		JailFighter player;

		int tries, val;
		do
		{
			val = RoundFloat(FloatAbs(float((countred = GetLivingPlayers(RED)) - (countblu = GetLivingPlayers(BLU)))) / 2);

			if (val <= 1)
				break;

			if (tries > 50)
				break;

			player = JailFighter(GetRandomPlayer(countred > countblu ? RED : BLU, true));

			if (player.index == -1)
				break;

			// Could possibly hit an infinite loop here
			// Rare, however. Would take low player count and/or a lot of donors/admins
			// Which is why 'tries' exists
			if (followimmun && !((immunity == 2 && !player.bIsAdmin) || (immunity == 1 && !player.bIsVIP) || !immunity))
				continue;

			KillFlameManager(player.index);
			player.ForceTeamChange(countred > countblu ? BLU : RED);
			if (announce)
				CPrintToChat(player.index, "%t %t", "Plugin Tag", "Autobalanced");
		} while ++tries <= 50;
	}
};
