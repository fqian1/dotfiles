-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	-- vis:command('set number')
end)

local plug = (function() if not pcall(require, 'plugins/vis-plug') then
	os.execute('git clone --quiet https://github.com/erf/vis-plug ' ..
		(os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config')
		.. '/vis/plugins/vis-plug')
end return require('plugins/vis-plug') end)()

local plugins = {
	{ 'erf/vis-cursors' },
	{ '~mcepl/vis-fugitive' },
}

plug.init(plugins, true)
