-- info.lua by Alexandria Pettit (GNU GPLv3)
-- contains information on various categories of blocks & items
-- includes practical value assignments, wrapper functions, and a bit of logic

info = {}
info.__index = info

------ CONSTANTS ------

-- the sort of things we ALWAYS want our robots to discard
ITEM_TYPE_TRASH = 0

-- In some programs we get a lot of this stuff, and it isn't worth keeping
-- in others, it might be worth storing
ITEM_TYPE_MINIMAL_VALUE = 1

-- NEVER EVER THROW AWAY!
ITEM_TYPE_RELEVANT = 2

-- Things I might ragequit if we lost them
ITEM_TYPE_CRITICAL = 3

------ LOOKUP TABLES ------

info.id_item_value = {}
info.id_item_value_substr = {}

info.id_item_value['minecraft:granite'] = ITEM_TYPE_TRASH
info.id_item_value['minecraft:diorite'] = ITEM_TYPE_TRASH
info.id_item_value['minecraft:andesite'] = ITEM_TYPE_TRASH


info.id_item_value['minecraft:cobblestone'] = ITEM_TYPE_MINIMAL_VALUE
info.id_item_value['minecraft:dirt'] = ITEM_TYPE_MINIMAL_VALUE
info.id_item_value['minecraft:coarse_dirt'] = ITEM_TYPE_MINIMAL_VALUE
info.id_item_value['minecraft:sand'] = ITEM_TYPE_MINIMAL_VALUE
info.id_item_value['minecraft:gravel'] = ITEM_TYPE_MINIMAL_VALUE
info.id_item_value['minecraft:flint'] = ITEM_TYPE_MINIMAL_VALUE
info.id_item_value['minecraft:red_sand'] = ITEM_TYPE_MINIMAL_VALUE


info.id_item_value['minecraft:coal'] = ITEM_TYPE_RELEVANT
info.id_item_value['minecraft:oak_planks'] = ITEM_TYPE_RELEVANT
info.id_item_value['minecraft:spruce_planks'] = ITEM_TYPE_RELEVANT
info.id_item_value['minecraft:torch'] = ITEM_TYPE_RELEVANT
info.id_item_value['minecraft:chest'] = ITEM_TYPE_RELEVANT
info.id_item_value_substr[ITEM_TYPE_RELEVANT] = {'coal', 'iron', 'gold'}


info.id_item_value['minecraft:diamond_block'] = ITEM_TYPE_RELEVANT
info.id_item_value['minecraft:diamond'] = ITEM_TYPE_RELEVANT
info.id_item_value['minecraft:nether_star'] = ITEM_TYPE_RELEVANT
info.id_heuristic_substrs[ITEM_TYPE_CRITICAL] = {'diamond'}

------ WRAPPER FUNCTIONS ------

function info.itemNameContains(item, substr)
    if item then
        return (item.name):find(substr)
    else
        return false
    end
end

function info.blockNameContains(block_id, substr)
    if block_id then
        return (block_id):find(substr)
    else
        return false
    end
end

