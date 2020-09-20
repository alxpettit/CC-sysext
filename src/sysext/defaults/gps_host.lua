require '/sysext/lib/argparse'

settings.load('sysext.config')
local coords = {}
coords.x = settings.get('host_coords.x')
coords.y = settings.get('host_coords.y')
coords.z = settings.get('host_coords.z')

local function handleX(_, value)
    coords.x = value
end

local function handleY(_, value)
    coords.y = value
end

local function handleZ(_, value)
    coords.z = value
end

local arglist = {
    x={abbr='x', callback=handleX, help='set X to [value]', wants_next = true},
    y={abbr='y', callback=handleY, help='set Y to [value]', wants_next = true},
    z={abbr='z', callback=handleZ, help='set Z to [value]', wants_next = true},
}

argparse.parseArgs(arglist)

if coords.x == nil or coords.y == nil or coords.z == nil then
    print('Missing coordinate data! See --help for more info.')
else
    settings.set('host_coords.x', coords.x)
    settings.set('host_coords.y', coords.y)
    settings.set('host_coords.z', coords.z)
    settings.save('sysext.config')
    print('Attempting to run GPS HOST program...')
    shell.run('gps host', coords.x, coords.y, coords.z)
end