ESX.RegisterUsableItem('hackerphone', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.triggerEvent('um-hackerphone:client:openphone', xPlayer.name)
end)

ESX.RegisterUsableItem('tracker', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.triggerEvent('um-hackerphone:client:vehicletracker')
end)

ESX.RegisterUsableItem('centralchip', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.triggerEvent('um-hackerphone:client:centralchip')
end)

RegisterNetEvent('um-hackerphone:server:removeitem', function(item)
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   xPlayer.removeInventoryItem(item, 1)
end)

RegisterNetEvent('um-hackerphone:server:targetinformation', function()
   local src = source
   local PlayerPed = GetPlayerPed(src)
   local pCoords = GetEntityCoords(PlayerPed)
   local found = false
   local xPlayers = ESX.GetExtendedPlayers()
   for i = 1, #xPlayers do
      local xPlayer = xPlayers[i]
      local TargetPed = GetPlayerPed(xPlayer.source)
      local tCoords = GetEntityCoords(TargetPed)
      local dist = #(pCoords - tCoords)
      if PlayerPed ~= TargetPed and dist < 3.0 then
         found = true
         xTarget = xPlayer
      end
   end  
   if found then 
      local targetinfo = {
         ['targetname'] = xTarget.get("firstName"),
         ['targetlastname'] = xTarget.get("lastName"),
         ['targetdob'] = xTarget.get("dateofbirth"),
         ['targetphone'] = xTarget.get("phoneNumber"),
         ['targetbank'] = xTarget.getAccount('bank').money
      }
      TriggerClientEvent('um-hackerphone:client:targetinfornui', src, targetinfo)
   else
      TriggerClientEvent('um-hackerphone:client:notify',src)
   end
end)

