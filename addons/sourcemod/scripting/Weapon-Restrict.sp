/*  [CS:GO] Weapon-Restrict: Just a fun plugin.
 *
 *  Copyright (C) 2021 Mr.Timid // timidexempt@gmail.com
 * 
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) 
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT 
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with 
 * this program. If not, see http://www.gnu.org/licenses/.
 */

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