-----------------------------------
-- Area: Davoi
--  NPC: Village Well
-- Involved in Quest: Under Oath
-----------------------------------
package.loaded["scripts/zones/Davoi/TextIDs"] = nil
-----------------------------------
require("scripts/zones/Davoi/TextIDs")
require("scripts/zones/Davoi/MobIDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
    if player:getVar("UnderOathCS") == 5 and npcUtil.tradeHas(trade, 1095) then
        player:startEvent(113)
    else
        player:messageSpecial(A_WELL)
    end
end

function onTrigger(player,npc)
    if
        player:getVar("UnderOathCS") == 5 and
        player:hasKeyItem(dsp.ki.STRANGE_SHEET_OF_PAPER) and
        not player:hasItem(1095) and
        not GetMobByID(ONE_EYED_GWAJBOJ):isSpawned() and
        not GetMobByID(THREE_EYED_PROZPUZ):isSpawned()
    then
        SpawnMob(ONE_EYED_GWAJBOJ):updateClaim(player)
        SpawnMob(THREE_EYED_PROZPUZ):updateClaim(player)
    elseif player:getVar("UnderOathCS") == 6 and player:hasKeyItem(dsp.ki.KNIGHTS_CONFESSION) then
        player:startEvent(112) -- read contents of letter
    else
        player:messageSpecial(A_WELL)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 113 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, dsp.ki.KNIGHTS_CONFESSION)
        player:setVar("UnderOathCS", 6)
        player:delKeyItem(dsp.ki.STRANGE_SHEET_OF_PAPER)
    end
end