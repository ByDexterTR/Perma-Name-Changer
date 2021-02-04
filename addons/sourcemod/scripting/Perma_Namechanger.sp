#include <sourcemod>
#include <clientprefs>
#include <sdktools_functions>

#pragma semicolon 1
#pragma newdecls required

Cookie g_Permaname = null, g_Oldname = null;

public Plugin myinfo = 
{
	name = "Kalıcı İsim Değiştirme", 
	author = "ByDexter", 
	description = "", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_prename", Command_Prename, ADMFLAG_GENERIC, "sm_prename <Nick>");
	RegAdminCmd("sm_prename0", Command_PrenameSifirla, ADMFLAG_GENERIC, "sm_prename0");
	g_Oldname = new Cookie("Dexter-Oldname", "", CookieAccess_Protected);
	g_Permaname = new Cookie("Dexter-PermaName", "Kalici isim degistirme.", CookieAccess_Protected);
	
}

public Action Command_Prename(int client, int args)
{
	if (args != 1)
	{
		ReplyToCommand(client, "[SM] Kullanım: sm_prename <Nick>");
		ReplyToCommand(client, "[SM] Kullanım: sm_prename0");
		return Plugin_Handled;
	}
	char arg1[128];
	GetCmdArg(1, arg1, 128);
	if (StrEqual(arg1, "", false) || StrEqual(arg1, " ", false))
	{
		ReplyToCommand(client, "[SM] Kullanım: sm_prename <Nick>");
		ReplyToCommand(client, "[SM] Kullanım: sm_prename0");
		return Plugin_Handled;
	}
	char sName[128];
	GetClientName(client, sName, 128);
	g_Permaname.Set(client, arg1);
	g_Oldname.Set(client, sName);
	SetClientName(client, arg1);
	return Plugin_Handled;
}

public Action Command_PrenameSifirla(int client, int args)
{
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] Kullanım: sm_prename <Nick>");
		ReplyToCommand(client, "[SM] Kullanım: sm_prename0");
		return Plugin_Handled;
	}
	char sName[128];
	g_Oldname.Get(client, sName, 128);
	g_Permaname.Set(client, "");
	SetClientName(client, sName);
	return Plugin_Handled;
}

public void OnClientCookiesCached(int client)
{
	char sBuffer[128];
	g_Permaname.Get(client, sBuffer, 128);
	if (!StrEqual(sBuffer, "", false))
	{
		char sName[128];
		GetClientName(client, sName, 128);
		g_Oldname.Set(client, sName);
		SetClientName(client, sBuffer);
	}
} 