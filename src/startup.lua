-- startup.lua by Alexandria Pettit (GNU GPLv3)
-- The idea behind this is to make a universal startup program for automatically launching various 'default programs'.

require "/sysext/lib/ui"

local bin_dir = '/sysext/defaults/'

local force_selection_menu = false

local continue = true

local function handleHelp()
    print('Usage:\
    --menu: force to display menu for selecting program.\
    --select [program name]: select program name without displaying menu.')
end

local startup_program = nil
local prev_arg = nil


-- TODO: replace this with argparse lib code
for i=1,#arg do
    if prev_arg then
        if prev_arg == '--select' then
            startup_program = arg[i]
        end
        prev_arg = nil
    else
        -- Handle each posssible argument
        if arg[i] == '--help' then
            -- display usage info
            handleHelp()
            continue = false
        elseif arg[i] == '--menu' then
            -- force menu to appear
            force_selection_menu = true
        -- arguments to store for later for handling subarg
        elseif arg[i] == '--select' then
            prev_arg = arg[i]
        else
            -- catch-all
            print('Unknown arg:', arg[i])
            handleHelp()
            continue = false;
        end
    end
end

if continue then
    settings.load('sysext.config')
    if startup_program == nil then
        startup_program = settings.get('startup_program')
    end

    if force_selection_menu or startup_program == nil then
        local menu_options = fs.list(bin_dir)
        local choice_num = ui.fancyMenu(menu_options)
        startup_program = menu_options[choice_num]
    end

    settings.set('startup_program', startup_program)
    settings.save('sysext.config')

    print('Running:', startup_program)
    shell.run(bin_dir .. startup_program)
end