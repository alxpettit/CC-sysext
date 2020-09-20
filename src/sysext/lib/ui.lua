ui = {}
ui.__index = ui

ui.prefix_selected = "->"
ui.prefix_unselected = "- "

function ui.fancyMenu(menu_options)
    -- selection starts counting at zero to make math easier
    local selected = 0
    local prefix = nil
    term.clear()
    while true do
        for i=1, #menu_options do
            term.setCursorPos(1, i)
            if (selected+1) == i then
                prefix = ui.prefix_selected
            else
                prefix = ui.prefix_unselected
            end
            term.clearLine()
            local out = string.format("%s %i: %s", prefix, i, menu_options[i])
            term.write(out)
        end

        local _, key = os.pullEvent("key")
        if key == keys.up then
            selected = selected - 1
        elseif key == keys.down then
            selected = selected + 1
        elseif key == keys.enter then
            break
        end
        selected = selected % #menu_options
    end

    term.clear()
    term.setCursorPos(1, 1)
    -- return selection value starting at 1
    return (selected+1)
end