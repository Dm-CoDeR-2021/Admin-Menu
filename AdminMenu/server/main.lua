ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('get:perm:menu')
AddEventHandler('get:perm:menu', function()
	local xP = ESX.GetPlayerFromId(source)
	if Config.permission_level then
		if xP.permission_level >= Config.menu_perm then
			TriggerClientEvent('open:admin:menu', source)
		end
	end
end)
RegisterNetEvent('announce:admin:menu')
AddEventHandler('announce:admin:menu', function(msg)
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.4); border-radius: 3px;"><i class="far fa-newspaper"></i> Announce:<br>  {1}</div>',
        args = { GetPlayerName(source), msg }
    })
end)
RegisterNetEvent('kick:admin:menu')
AddEventHandler('kick:admin:menu', function(id, reason)
	DropPlayer(id, reason)
end)
ESX.RegisterServerCallback('getplayeronline:admin:menu', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}
 	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name
		})
	end
 	cb(players)
end)
RegisterNetEvent('tp:admin:menu')
AddEventHandler('tp:admin:menu', function(src)
	local xPlayer = ESX.GetPlayerFromId(src)
	TriggerClientEvent('bringandtp:admin:menu', source, xPlayer.coords.x, xPlayer.coords.y, xPlayer.coords.z)
end)
RegisterNetEvent('bring:admin:menu')
AddEventHandler('bring:admin:menu', function(src)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('bringandtp:admin:menu', src, xPlayer.coords.x, xPlayer.coords.y, xPlayer.coords.z)
end)
ESX.RegisterServerCallback('get:perm:svmng:admenu', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > Config.hight_rank_menu_perm then
		cb(true)
	else
		cb(false)
	end
end)
RegisterNetEvent('resource:mng:admenu')
AddEventHandler('resource:mng:admenu', function(data, res)
	if data == 'start' then
		StartResource(res)
	end
	if data == 'stop' then
		StopResource(res)
	end
end)
RegisterNetEvent('revive:adminmenu')
AddEventHandler('revive:adminmenu', function(plid)
	TriggerClientEvent('revive:slay:admenu',  plid, 'revive', plid)
end)
RegisterNetEvent('slay:adminmenu')
AddEventHandler('slay:adminmenu', function(plid)
	TriggerClientEvent('revive:slay:admenu', plid, 'slay', plid)
end)
RegisterNetEvent('sp:veh:on:id:admenu')
AddEventHandler('sp:veh:on:id:admenu', function(pid, vehid)
	TriggerClientEvent('car:sp:onid:veh:admenu', pid, vehid)
end)