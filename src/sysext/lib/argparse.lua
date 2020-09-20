-- argument parsing library by Alexandria Pettit (GNU GPLv3)
-- for usage example, see argparse_calc_demo.lua

argparse = {}
argparse.__index = argparse


function argparse.parseArgs(arglist)
    -- future_callback is written to if we have
    -- a function we want to call on the next arg
    -- For instance -- if we have `--list x`,
    -- `future_callback will be set to the callback for x,
    -- then will be called on the next argument -- when we're parsing the value for x.
    -- This only happens if wants_next is non-nil/true for x's argument_table.
    local future_callback = nil


    if arglist.help == nil then
        arglist.help = {abbr='h', help='Display help', callback = function()
            -- begin function for handling --help
            for argument_str, argument_table in pairs(arglist) do
                if argument_table.help then
                    print(argument_str, '\t:\t', argument_table.help)
                else
                    print(argument_str)
                end
            end
        end -- end function for handling --help
    }
    end

    -- iterate over all arguments
    for pos=1,#arg do
        if future_callback then
            future_callback(pos, arg[pos])
            future_callback = nil
        else
            local known_arg = false

            -- iterate over all known arguments
            for argument_str, argument_table in pairs(arglist) do
                -- if our abbreviation or main argument string matches...
                if (arg[pos] == ('--' .. argument_str)) or
                (arg[pos] == ('-' .. argument_table['abbr'])) then
                    -- handle callback logic for this argument
                    if argument_table.wants_next == false or
                    argument_table.wants_next == nil then
                        argument_table.callback(pos, nil)
                        known_arg = true
                    else
                        future_callback = argument_table.callback
                        known_arg = true
                    end
                end
            end
            -- Warn the user that their arg was invalid.
            if not known_arg then
                print('Warning! Ignoring unknown arg:', arg[pos])
            end

        end
    end
end
