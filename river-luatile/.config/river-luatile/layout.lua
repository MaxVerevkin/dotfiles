-- You can define your global state here
local main_ratio = 0.65
local gaps = 8
smart_gaps = false

-- The most important function - the actual layout generator
--
-- The argument is a table with:
--  * Focused tags
--  * Window count
--  * Output width
--  * Output height
--
-- The return value must be a table with exactly `count` entries. Each entry is a table with four
-- numbers:
--  * X coordinate
--  * Y coordinate
--  * Window width
--  * Window height
--
-- This example is a simplified version of `rivertile`
function handle_layout(args)
	local retval = {}
	if args.count == 1 then
		if smart_gaps then
			table.insert(retval, { 0, 0, args.width, args.height })
		else
			table.insert(retval, { gaps, gaps, args.width - gaps * 2, args.height - gaps * 2 })
		end
	elseif args.count > 1 then
		local main_w = (args.width - gaps * 3) * main_ratio
		local side_w = (args.width - gaps * 3) - main_w
		local main_h = args.height - gaps * 2
		local side_h = (args.height - gaps) / (args.count - 1) - gaps
		table.insert(retval, {
			gaps,
			gaps,
			main_w,
			main_h,
		})
		for i = 0, (args.count - 2) do
			table.insert(retval, {
				main_w + gaps * 2,
				gaps + i * (side_h + gaps),
				side_w,
				side_h,
			})
		end
	end
	return retval
end

local function clamp(min, val, max)
	if val < min then
		return min
	elseif val > max then
		return max
	end
	return val
end

function set_gaps(value)
	gaps = math.max(0, value)
end

function set_main_ratio(value)
	main_ratio = clamp(0.15, value, 0.85)
end

function gaps_inc(delta)
	set_gaps(gaps + delta)
end

function main_ratio_inc(delta)
	set_main_ratio(main_ratio + delta)
end

local gaps_alt = 0
function toggle_gaps()
	local tmp = gaps
	gaps = gaps_alt
	gaps_alt = tmp
end
