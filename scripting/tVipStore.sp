#include <sourcemod>
#include <store>
#include <tVip>
#include <smjansson>
#pragma newdecls required
#pragma semicolon 1

#define MAX_VIPTEMS 64

enum tVipItem
{
	String:tVipItemName[STORE_MAX_NAME_LENGTH],
	String:tVipItemDuration[4],
	String:tVipItemFormat[4],
}

Handle g_tVipNameIndex;

int g_tVipItemCount;

tVipItem g_tVipItems[MAX_VIPTEMS][tVipItem];


public Plugin myinfo =
{
	name = "tVipStore",
	author = "Sarrus",
	description = "Allows players to buy VIP status from sourcemod store using tVIP.",
	version = "1.0",
	url = "https://github.com/Sarrus1/"
};

public void OnPluginStart()
{
	Store_RegisterItemType("tVip", tVipUseCallback, tVipAttributesLoad);
}


//Called when a new API library is loaded.
public void OnLibraryAdded(const char[] name)
{
	if (StrEqual(name, "store-inventory"))
	{
		Store_RegisterItemType("tVip", tVipUseCallback, tVipAttributesLoad);
	}	
}

public void Store_OnReloadItems() 
{
	delete(g_tVipNameIndex);
	g_tVipNameIndex = CreateTrie();
	g_tVipItemCount = 0;
}

public void tVipAttributesLoad(const char[] itemName, const char[] attrs)
{
	strcopy(g_tVipItems[g_tVipItemCount][tVipItemName], STORE_MAX_NAME_LENGTH, itemName);
		
	SetTrieValue(g_tVipNameIndex, g_tVipItems[g_tVipItemCount][tVipItemName], g_tVipItemCount);
	
	Handle json = json_load(attrs);
	json_object_get_string(json, "duration", g_tVipItems[g_tVipItemCount][tVipItemDuration], 4);
	json_object_get_string(json, "format", g_tVipItems[g_tVipItemCount][tVipItemFormat], 4);
	CloseHandle(json);

	g_tVipItemCount++;
}

public Store_ItemUseAction tVipUseCallback(int client, int itemId, bool equipped)
{
	if (!IsClientInGame(client))
	{
		return Store_DoNothing;
	}

	char itemName[STORE_MAX_NAME_LENGTH];
	Store_GetItemName(itemId, itemName, sizeof(itemName));

	int itVipItem = -1;
	if (!GetTrieValue(g_tVipNameIndex, itemName, itVipItem))
	{
		PrintToChat(client, "No item attributes");
		return Store_DoNothing;
	}

	char tVipDuration[16];
	strcopy(tVipDuration, sizeof(tVipDuration), g_tVipItems[itVipItem][tVipItemDuration]);

	char tVipFormat[16];
	strcopy(tVipFormat, sizeof(tVipFormat), g_tVipItems[itVipItem][tVipItemFormat]);

	int iDuration, iFormat;
	iDuration = StringToInt(tVipDuration);
	iFormat = StringToInt(tVipFormat);
	tVip_GrantVip(client, client, iDuration, iFormat);
	return Store_DeleteItem;
}