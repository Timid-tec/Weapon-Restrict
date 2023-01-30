#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>
#include <timid>

public Plugin myinfo = 
{
	name = "Weapnon Restrict", 
	author = "Timid", 
	description = "Disabled Weapon pickup/buy", 
	version = "4.2.0", 
	url = "https://steamcommunity.com/id/MrTimid/"
};

char currentMap[PLATFORM_MAX_PATH];
bool FoundMap;

char g_disabledWeapons[][PLATFORM_MAX_PATH] = {
	"", /* leave this empty when adding more weapons */
	"decoy", 
	"flashbang", 
	"molotov", 
	"incgrenade", 
	"smokegrenade"
};

char WeaponName[128];

public void OnPluginStart()
{
	HookEvent("item_equip", Event_ItemEquip)
}


public Action Event_ItemEquip(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int primary = GetPlayerWeaponSlot(client, 0);
	
	GetEventString(event, "item", WeaponName, sizeof(WeaponName));
	
	if (!IsValidClient(client))
		return Plugin_Handled;
	
	for (int x = 1; x < sizeof(g_disabledWeapons); x++)
	{
		if (StrEqual(WeaponName, g_disabledWeapons[x], false))
		{
			//PrintToChatAll(" \x10[WR] Debug\x0A - Weapon: %s", g_disabledWeapons[x]);
			RemovePlayerItem(client, primary);
		}
	}
	return Plugin_Continue;
}

public Action CS_OnBuyCommand(int client, const char[] sWeapon)
{
	
	for (int x = 1; x < sizeof(g_disabledWeapons); x++)
	{
		if (StrEqual(sWeapon, g_disabledWeapons[x], false))
		{
			//PrintToChatAll(" \x10[WR] Debug\x0A - Weapon: %s", g_disabledWeapons[x]);
			return Plugin_Handled;
		}
	}
	return Plugin_Continue;
} 