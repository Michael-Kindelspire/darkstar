-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Emoussine
-- Type: Chocobo Renter
-- !pos -11 1 -100
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/chocobo");
require("scripts/globals/status");

require("scripts/zones/Southern_San_dOria/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
    if (FlyerForRegine == 1) then
        count = trade:getItemCount();
        MagicFlyer = trade:hasItemQty(532,1);
        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(FLYER_REFUSED);
        end
    end
end;

function onTrigger(player,npc)
    local level = player:getMainLvl();
    local gil = player:getGil();

    if (player:hasKeyItem(dsp.ki.CHOCOBO_LICENSE) and level >= 15) then
        local price = getChocoboPrice(player);
        player:setLocalVar("chocoboPriceOffer",price);

        if (level >= 20) then
            level = 0;
        end

        player:startEvent(600,price,gil,level);
    else
        player:startEvent(603);
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    local price = player:getLocalVar("chocoboPriceOffer");

    if (csid == 600 and option == 0) then
        if (player:delGil(price)) then
            updateChocoboPrice(player, price);

            if (player:getMainLvl() >= 20) then
                local duration = 1800 + (player:getMod(dsp.mod.CHOCOBO_RIDING_TIME) * 60)

                player:addStatusEffectEx(dsp.effect.MOUNTED,dsp.effect.MOUNTED,0,0,duration,true);
            else
                player:addStatusEffectEx(dsp.effect.MOUNTED,dsp.effect.MOUNTED,0,0,900,true);
            end

            player:setPos(-126,-62,274,101,100);
        end
    end
end;