-----------------------------------
--  NPC: ??? (QM3)
-- Type: Saltvix (dice roll game part 1)
--  @zone 191
--  Involved in quest "As Thick As Thieves"
-----------------------------------
package.loaded["scripts/zones/Dangruf_Wadi/TextIDs"] = nil
-----------------------------------
require("scripts/zones/Dangruf_Wadi/TextIDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player,npc,trade)

    local thickAsThievesGamblingCS = player:getVar("thickAsThievesGamblingCS")

    if npcUtil.tradeHas(trade, 936) then -- Trade 1x rock slat
        if thickAsThievesGamblingCS == 2 then
            local rand1 = math.random(1,999)
            local rand2 = math.random(1,999)

            if (rand1 > rand2) then
                player:messageSpecial(YOU_PLACE_ITEM,0,936)
                player:startEvent(136,1092,0,rand1,rand2) -- complete 1/3 gamble mini quest
            else
                player:messageSpecial(YOU_PLACE_ITEM,0,936)
                player:startEvent(139,0,0,rand1,rand2) -- player looses
            end
        elseif thickAsThievesGamblingCS == -1 then  -- player previously lost to this goblin
            local rand1 = math.random(1,999)
            local rand2 = math.random(1,999)

            if (rand1 > rand2) then
                player:messageSpecial(YOU_PLACE_ITEM,0,936)
                player:startEvent(142,1092,0,rand1,rand2) -- complete 1/3 gamble mini quest
            else
                player:messageSpecial(YOU_PLACE_ITEM,0,936)
                player:startEvent(145,0,0,rand1,rand2) -- player looses
            end
        elseif thickAsThievesGamblingCS > 2 then
            player:messageSpecial(BEAT_SALTVIX)
        end
    end

end

function onTrigger(player,npc)
    player:messageSpecial(CRYSTALLINE_DUST)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)

    if (csid == 139 or csid == 136 or csid == 142 or csid == 145) and option == 2 then -- player gives up
        player:confirmTrade()
        player:messageSpecial(YOU_GAVE_UP)
        player:setVar("thickAsThievesGamblingCS",-1)
    elseif (csid == 139 or csid == 145) and option == 1 then -- player looses dice game
        player:confirmTrade()
        player:messageSpecial(GOBLIN_BEAT_YOU)
        player:setVar("thickAsThievesGamblingCS",-1)
    elseif (csid == 136 or csid == 142) and option == 0 then -- player wins dice game
        player:confirmTrade()
        player:messageSpecial(YOU_BEAT_GOBLIN)
        player:setVar("thickAsThievesGamblingCS",3)
    end

end