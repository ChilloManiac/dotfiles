local should_profile = os.getenv("NVIM_PROFILE")

local function toggle_profile()
	local prof = require("profile")
	if prof.is_recording() then
		prof.stop()
		vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
			if filename then
				prof.export(filename)
				vim.notify(string.format("Wrote %s", filename))
			end
		end)
	else
		prof.start("*")
	end
end

local _M = {
	"stevearc/profile.nvim",
	keys = {
		{ "<leader><f1>", toggle_profile, mode = "n" },
		{
			"<leader><f2>",
			function()
				print("Loading profiling plugin")
			end,
			mode = "n",
		},
	},
	config = function()
		if should_profile then
			require("profile").instrument_autocmds()
			if should_profile:lower():match("^start") then
				require("profile").start("*")
			else
				require("profile").instrument("*")
			end
		end
	end,
}

return _M
