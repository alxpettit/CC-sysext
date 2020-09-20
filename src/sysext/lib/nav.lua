nav = {}
nav.__index = nav

ORIENT_NORTH = 0
ORIENT_EAST = 1
ORIENT_SOUTH = 2
ORIENT_WEST = 3

nav.last_update_time = nil

function nav:update(timeout)
    if timeout == nil then
        timeout = 5
    end
    nav.x, nav.y, nav.z = gps.locate(timeout)
    local successful = not (nav.x == nil)
    if successful then
        nav.last_update_time = os.time()
    end
    return successful;
end

function nav:get()
    return nav.x, nav.y, nav.z;
end
