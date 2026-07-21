-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	-- vis:command('set number')
end)

local plug
if vis:module_exist('plugins/vis-plug') then
    plug = require('plugins/vis-plug')
else
    local config_dir = os.getenv('XDG_CONFIG_HOME') or (os.getenv('HOME') .. '/.config')
    os.execute('git clone --quiet https://github.com/erf/vis-plug ' .. config_dir .. '/vis/plugins/vis-plug')
    plug = require('plugins/vis-plug')
end

local plugins = {
    { 'erf/vis-cursors' },
    { 'https://git.sr.ht/~mcepl/vis-fugitive' },
    { 'https://repo.or.cz/vis-quickfix.git' }, -- need vpn in uk
}

plug.init(plugins, false)
