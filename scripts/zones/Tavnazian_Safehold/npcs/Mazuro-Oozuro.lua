-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Mazuro-Oozuro
-- Standard Merchant NPC
-----------------------------------
package.loaded["scripts/zones/Tavnazian_Safehold/TextIDs"] = nil
-----------------------------------
require("scripts/zones/Tavnazian_Safehold/TextIDs")
require("scripts/globals/shop")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local stock =
    {
        17005,   108,    -- Lufaise Fly
        17383,  2640,    -- Clothespole
        688,     200,    -- Arrowwood Log
        690,    7800,    -- Elm Log
        2871,  10000,    -- Safehold Waystone
        4913, 175827,    -- Scroll of Distract II
        4915, 217000,    -- Scroll of Frazzle II
    }

    player:showText(npc, MAZUROOOZURO_SHOP_DIALOG)
    dsp.shop.general(player, stock)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end

