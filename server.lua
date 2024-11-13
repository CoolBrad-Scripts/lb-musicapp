QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('getSavedTracks', function(source, cb, citizenid)
    local selectQuery = "SELECT url FROM lb_music WHERE citizenID = @citizenid"
    local selectParams = { ['@citizenid'] = citizenid }
    
    MySQL.Async.fetchAll(selectQuery, selectParams, function(results)
        if results then
            cb(results)
        else
            cb({})
        end
    end)
end)

function SaveSongToPlaylist(citizenid, url)
    local insertQuery = "INSERT INTO lb_music (citizenID, url) VALUES (?, ?)"
    local insertParams = { citizenid, url }
    MySQL.query.await(insertQuery, insertParams)
end


-- Implement a function to delete the song from the database
function DeleteSongFromPlaylist(citizenid, trackId)
    -- Update the query to ensure only the first matching row is deleted
    local deleteQuery = "DELETE FROM lb_music WHERE citizenID = ? AND url = ? LIMIT 1"
    local deleteParams = { citizenid, trackId }
    MySQL.query.await(deleteQuery, deleteParams)
end

RegisterNetEvent("phone:youtube_music:soundStatus", function(type, data)
    local src = source
    local musicId = "phone_youtubemusic_id_" ..src
    if type ~= "position" and type ~= "play" and type ~= "volume" and type ~= "stop" then 
        print("Invalid type for phone:youtube_music:soundStatus: " .. type)
    end

    TriggerClientEvent("phone:youtube_music:soundStatus", -1, type, musicId, data)
end)

RegisterNetEvent('saveSong')
AddEventHandler('saveSong', function(data)
    local youtubeUrl = data.url
    local src = source
    local playerId = src
    local Player = QBCore.Functions.GetPlayer(playerId)
    
    if Player then
        local citizenid = Player.PlayerData.citizenid
        SaveSongToPlaylist(citizenid, youtubeUrl)
        TriggerClientEvent('notification', playerId, { type = 'success', title = 'Song saved successfully!' })
    else
        print("Player not found!")
    end
end)

-- Add a new event handler for song deletion
RegisterNetEvent('deleteSong')
AddEventHandler('deleteSong', function(data)
    local src = source
    local playerId = src
    local trackId = data.trackId
    local Player = QBCore.Functions.GetPlayer(playerId)
    
    if Player then
        local citizenid = Player.PlayerData.citizenid
        DeleteSongFromPlaylist(citizenid, trackId)
    end
end)