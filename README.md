# # tVipStore
A Sourcemod-Store module for tVip

![Downloads](https://img.shields.io/github/downloads/Sarrus1/tVIPstore/total) ![Last commit](https://img.shields.io/github/last-commit/Sarrus1/tVIPstore "Last commit") ![Open issues](https://img.shields.io/github/issues/Sarrus1/tVIPstore "Open Issues") ![Closed issues](https://img.shields.io/github/issues-closed/Sarrus1/tVIPstore "Closed Issues") ![Size](https://img.shields.io/github/repo-size/Sarrus1/tVIPstore "Size")

## Description ##
This plugin allows you to add tVip options for players to buy with store credits.
You can define the price of the tVip and the duration.

## Requirements ##
- Sourcemod & Metamod
- [Sourcemod-store v1.2](https://github.com/SourceMod-Store/Sourcemod-Store/releases/tag/1.2-Final) (not tested with v1.3)
- [tVip](https://forums.alliedmods.net/showthread.php?t=292183)

## Installation ##
1. This plugin requires Sourcemod and Metamod.
2. Grab the latest release from the release page and unzip it in your csgo folder.
3. Add your items to the .json file located in configs/store/json-import.
4. Import that file with the webpanel, or add the category and items manually to the database.
5. Restart the server or type `sm plugins load tVipStore` in the console to load the plugin.

## Configuration ##
1. Add your items to the .json file located in configs/store/json-import.
2. Import that file with the webpanel, or add the category and items manually to the database.
3. Then reload the items with `!store_itemsreload`

## Usage ##
### Adding items ###
To add an item to the store, edit the .json file located in configs/store/json-import.
```json
{
	"type": "tVip",   //Don't edit this
	"categories": [
			{
					"display_name": "VIP",  //You can edit this
					"description": "Buy VIP for a limited time.",   //You can edit this
					"require_plugin": "tVip",   //Don't edit this
					"web_description": null,    //You can edit this
					"web_color": "A90000",    //You can edit this
					"items": [
					{
						"name": "tVip_one_day",
						"display_name": "One day VIP",
						"description": "Get VIP for one day.",
						"web_description": "Get VIP for one day.",
						"type": "tVip",     //Don't edit this
						"price": "500",     //You can edit this
						"attrs": {
							"duration": "1",  //This is the duration of the VIP you are going to grant.
							"format": "1"     //This is the format of the time you've input above. 1 for minutes, 0 for months.
						},
						"is_buyable": "1",  //You can edit this
						"is_tradeable": "1",  //You can edit this
						"is_refundable": "1", //You can edit this
						"expiry_time": null //You can edit this
					}
					]
			}
	]
}
```

## Contacts ##
If you have questions, you can add me on Discord: Sarrus#9090


