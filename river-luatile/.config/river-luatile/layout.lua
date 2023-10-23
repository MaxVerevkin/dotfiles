local bit = require("bit")

-- Global State

local overrides = {}

local function tag_fingerprint(args)
	local tags = CMD_TAGS or args.tags
	local output = CMD_OUTPUT or args.output
	local least_tag = 1
	while bit.band(bit.rshift(tags, least_tag - 1), 1) == 0 do
		least_tag = least_tag + 1
	end
	return output .. "#" .. tostring(least_tag)
end

local function get_tag_state(args)
	local key = tag_fingerprint(args)
	local overriden = overrides[key]
	if overriden then
		return overriden
	end
	local default = {
		{ name = "tile", symbol = "[]=", gaps = 6, main_ratio = 0.60 },
		{ name = "stack", symbol = "[[]" },
	}
	overrides[key] = default
	return default
end

-- Layout Implementation

local function tile(args, layout)
	local retval = {}
	if args.count == 1 then
		table.insert(retval, { 0, 0, args.width, args.height })
	elseif args.count > 1 then
		local main_w = (args.width - layout.gaps) * layout.main_ratio
		local side_w = args.width - layout.gaps - main_w
		local main_h = args.height
		local side_h = (args.height - layout.gaps * (args.count - 2)) / (args.count - 1)
		table.insert(retval, {
			0,
			0,
			main_w,
			main_h,
		})
		for i = 0, (args.count - 2) do
			table.insert(retval, {
				main_w + layout.gaps,
				i * (side_h + layout.gaps),
				side_w,
				side_h,
			})
		end
	end
	return retval
end

local function stack(args, layout)
	local retval = {}
	local dx, dy = 15, 15
	local width = args.width - dx * (args.count - 1)
	local height = args.height - dx * (args.count - 1)
	for i = 0, (args.count - 1) do
		table.insert(retval, { dx * i, dy * i, width, height })
	end
	return retval
end

-- Interface Implementation

function handle_metadata(args)
	local layout = get_tag_state(args)[1]
	return { name = layout.symbol .. " on " .. args.output }
end

function handle_layout(args)
	local layout = get_tag_state(args)[1]
	if layout.name == "tile" then
		return tile(args, layout)
	elseif layout.name == "stack" then
		return stack(args, layout)
	end
end

-- User Commands

function gaps_inc(delta)
	set_gaps(gaps + delta)
	local layout = get_tag_state()[1]
	if layout.name == "tile" then
		layout.gaps = math.max(0, layout.gaps + delta)
	end
end

function main_ratio_inc(delta)
	local layout = get_tag_state()[1]
	if layout.name == "tile" then
		layout.main_ratio = math.min(math.max(layout.main_ratio + delta, 0.15), 0.85)
	end
end

function toggle_layout()
	local layouts = get_tag_state()
	local tmp = layouts[1]
	layouts[1] = layouts[2]
	layouts[2] = tmp
end
