require 'argparse'

local total = 0

-- functions include two args: pos (argument position) and value.
-- In the case of arguments defined without wants_next,
-- value will be nil.

local function handleAdd(_, value)
    total = total + value
end

local function handleSubtract(_, value)
    total = total - value
end

local function handleDivide(_, value)
    total = total/value
end

local function handleMultiply(_, value)
    total = total * value
end

local function handlePrint()
    print('Total:', total)
end

local arglist = {add={abbr='a', callback=handleAdd, help='add [value]', wants_next = true},
                subtract={abbr='s', callback=handleSubtract, help='subtract [value]', wants_next = true},
                divide={abbr='d', callback=handleDivide, help='divide [value]', wants_next = true},
                multiply={abbr='m', callback=handleMultiply, help='multiply [value]', wants_next = true},
                print={abbr='p', callback=handlePrint, help='print'}
}

print('Calculating...')
argparse.parseArgs(arglist)
print('Done')