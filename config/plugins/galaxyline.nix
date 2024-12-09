{
  pkgs,
  inputs,
  ...
}: {
  plugins.none-ls.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "galaxyline.nvim";
      version = "latest";
      src = inputs.galaxyline;
      meta.homepage = "https://github.com/NTBBloodbath/galaxyline.nvim";
    })
    (pkgs.vimUtils.buildVimPlugin {
      pname = "plenary.nvim";
      version = "latest";
      src = inputs.plenary;
      meta.homepage = "https://github.com/nvim-lua/plenary.nvim";
    })
    (pkgs.vimUtils.buildVimPlugin {
      pname = "github-notifications.nvim";
      version = "latest";
      src = inputs.githubNotifications;
      meta.homepage = "https://github.com/rlch/github-notifications.nvim";
    })
  ];
  extraConfigLua = ''
    local fn = vim.fn
    local api = vim.api

    local M = {}

    -- possible values are 'arrow' | 'rounded' | 'blank'
    local active_sep = "blank"

    -- change them if you want to different separator
    M.separators = {
     arrow = { "", "" },
     rounded = { "", "" },
     blank = { "", "" },
    }

    -- highlight groups
    M.colors = {
     active = "%#StatusLine#",
     inactive = "%#StatuslineNC#",
     mode = "%#Mode#",
     mode_alt = "%#ModeAlt#",
     git = "%#Git#",
     git_alt = "%#GitAlt#",
     filetype = "%#Filetype#",
     filetype_alt = "%#FiletypeAlt#",
     line_col = "%#LineCol#",
     line_col_alt = "%#LineColAlt#",
    }

    M.trunc_width = setmetatable({
     mode = 80,
     git_status = 90,
     filename = 140,
     line_col = 60,
    }, {
     __index = function()
      return 80
     end,
    })

    M.is_truncated = function(_, width)
     local current_width = api.nvim_win_get_width(0)
     return current_width < width
    end

    M.modes = setmetatable({
     ["n"] = { "Normal", "N" },
     ["no"] = { "N·Pending", "N·P" },
     ["v"] = { "Visual", "V" },
     ["V"] = { "V·Line", "V·L" },
     [""] = { "V·Block", "V·B" }, -- this is not ^V, but it's , they're different
     ["s"] = { "Select", "S" },
     ["S"] = { "S·Line", "S·L" },
     [""] = { "S·Block", "S·B" }, -- same with this one, it's not ^S but it's 
     ["i"] = { "Insert", "I" },
     ["ic"] = { "Insert", "I" },
     ["R"] = { "Replace", "R" },
     ["Rv"] = { "V·Replace", "V·R" },
     ["c"] = { "Command", "C" },
     ["cv"] = { "Vim·Ex ", "V·E" },
     ["ce"] = { "Ex ", "E" },
     ["r"] = { "Prompt ", "P" },
     ["rm"] = { "More ", "M" },
     ["r?"] = { "Confirm ", "C" },
     ["!"] = { "Shell ", "S" },
     ["t"] = { "Terminal ", "T" },
    }, {
     __index = function()
      return { "Unknown", "U" } -- handle edge cases
     end,
    })

    M.get_current_mode = function(self)
     local current_mode = api.nvim_get_mode().mode
     if self:is_truncated(self.trunc_width.mode) then
      return string.format(" %s ", self.modes[current_mode][2]):upper()
     end
     return string.format(" %s ", self.modes[current_mode][1]):upper()
    end

    M.get_git_status = function(self)
     -- use fallback because it doesn't set this variable on the initial `BufEnter`
     local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
     local is_head_empty = signs.head ~= ""

     if self:is_truncated(self.trunc_width.git_status) then
      return is_head_empty and string.format("  %s ", signs.head or "") or ""
     end

     return is_head_empty
       and string.format(" +%s ~%s -%s |  %s ", signs.added, signs.changed, signs.removed, signs.head)
      or ""
    end

    M.get_filename = function(self)
     if self:is_truncated(self.trunc_width.filename) then
      return " %<%f "
     end
     return " %<%F "
    end

    M.get_filetype = function()
     local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
     local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
     local filetype = vim.bo.filetype

     if filetype == "" then
      return ""
     end
     return string.format(" %s %s ", icon, filetype):lower()
    end

    M.get_line_col = function(self)
     if self:is_truncated(self.trunc_width.line_col) then
      return " %l:%c "
     end
     return " Ln %l, Col %c "
    end

    M.set_active = function(self)
     local colors = self.colors

     local mode = colors.mode .. self:get_current_mode()
     local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
     local git = colors.git .. self:get_git_status()
     local git_alt = colors.git_alt .. self.separators[active_sep][1]
     local filename = colors.inactive .. self:get_filename()
     local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
     local filetype = colors.filetype .. self:get_filetype()
     local line_col = colors.line_col .. self:get_line_col()
     local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

     return table.concat({
      colors.active,
    --  mode,
    --  mode_alt,
    --  git,
    --  git_alt,
    --  "%=",
    --  filename,
    --  "%=",
    --  filetype_alt,
    --  filetype,
    --  line_col_alt,
    --  line_col,
     })
    end

    M.set_inactive = function(self)
     return self.colors.inactive .. "%= %F %="
    end

    M.set_explorer = function(self)
     local title = self.colors.mode .. "   "
     local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]
     return table.concat({ self.colors.active, title, title_alt })
    end

    Statusline = setmetatable(M, {
     __call = function(statusline, mode)
      if mode == "active" then
       return statusline:set_active()
      end
      if mode == "inactive" then
       return statusline:set_inactive()
      end
      if mode == "explorer" then
       return statusline:set_explorer()
      end
     end,
    })

    -- set statusline
    -- TODO: replace this once we can define autocmd using lua
    api.nvim_exec(
     [[
      augroup Statusline
      au!
      au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
      au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
      au WinEnter,BufEnter,FileType neo-tree setlocal statusline=%!v:lua.Statusline('explorer')
      augroup END
    ]],
     false
    )

    ----[[
    --  NOTE: I don't use this since the statusline already has
    --  so much stuff going on. Feel free to use it!
    --  credit: https://github.com/nvim-lua/lsp-status.nvim
    --
    --  I now use `tabline` to display these errors, go to `_bufferline.lua` if you
    --  want to check that out
    ----]]
    Statusline.get_lsp_diagnostic = function(self)
     local result = {}
     local levels = {
      errors = "Error",
      warnings = "Warning",
      info = "Information",
      hints = "Hint",
     }

     for k, level in pairs(levels) do
      result[k] = vim.lsp.diagnostic.get_count(0, level)
     end

     if self:is_truncated(120) then
      return ""
     else
      return string.format(
       "| :%s :%s :%s :%s ",
       result["errors"] or 0,
       result["warnings"] or 0,
       result["info"] or 0,
       result["hints"] or 0
      )
     end
    end


    local gl = require("galaxyline")
    local condition = require("galaxyline.condition")
    local colors = {
     bg_dark = "#1f2335",
     bg = "#24283b",
     bg_highlight = "#292e42",
     terminal_black = "#414868",
     fg = "#c0caf5",
     fg_dark = "#a9b1d6",
     fg_gutter = "#3b4261",
     dark3 = "#545c7e",
     comment = "#565f89",
     dark5 = "#737aa2",
     blue0 = "#3d59a1",
     blue = "#7aa2f7",
     cyan = "#7dcfff",
     blue1 = "#2ac3de",
     blue2 = "#0db9d7",
     blue5 = "#89ddff",
     blue6 = "#B4F9F8",
     blue7 = "#394b70",
     magenta = "#bb9af7",
     magenta2 = "#ff007c",
     purple = "#9d7cd8",
     orange = "#ff9e64",
     yellow = "#e0af68",
     green = "#9ece6a",
     green1 = "#73daca",
     green2 = "#41a6b5",
     teal = "#1abc9c",
     red = "#f7768e",
     red1 = "#db4b4b",
     replacecolor = "#E06C75",

     gitBg = "#304B2E",
     lspBg = "#364463",
     fileinfoBg = "#5C2C2E",
    }
    local gls = gl.section
    local size
    local ok, Job = pcall(require, "plenary.job")
    if not ok then
    	return ""
    end
    local status_ok, notifications = pcall(require, "github-notifications")
    if not status_ok then
    	return ""
    end

    gl.short_line_list = { "neo-tree" }

    --[[
    -- Useful functions
    --]]

    local function mode_color(m)
    	local mode_colors = {
    		n = colors.blue,
    		i = colors.green,
    		v = colors.purple,
    		[""] = colors.purple,
    		V = colors.purple,
    		c = colors.magenta,
    		no = colors.blue,
    		s = colors.orange,
    		S = colors.orange,
    		ic = colors.yellow,
    		R = colors.red,
    		Rv = colors.red,
    		cv = colors.blue,
    		ce = colors.blue,
    		r = colors.replacecolor,
    		rm = colors.replacecolor,
    		["r?"] = colors.cyan,
    		["!"] = colors.blue,
    		t = colors.blue,
    	}
    	return mode_colors[m]
    end

    local function CommonCondition()
    	local tbl = { ["dashboard"] = true, [""] = true, ["neo-tree"] = true }
    	if tbl[vim.bo.filetype] then
    		return false
    	end
    	return true
    end

    local function NvimTreeLineCondition()
    	if vim.bo.filetype == "neo-tree" then
    		return true
    	else
    		return false
    	end
    end

    local function DirSize()
    	local cwd = vim.fn.getcwd()
    	Job
    		:new({
    			"du",
    			cwd,
    			"-sh",
    			on_exit = function(job)
    				local result = job:result()
    				size = string.match(result[1], "(.*)\t")
    				size = size .. "B"
    			end,
    		})
    		:start()
    	return size
    end

    local function GetNulllsClient()
    	local ft = vim.bo.filetype
    	local sources = require("null-ls.sources").get_available(ft)
    	local source = ""
    	for _, provider in pairs(sources) do
    		if string.len(source) < 1 then
    			source = source .. provider.name
    		else
    			source = source .. "," .. provider.name
    		end
    	end
    	return source
    end

    local function GetLspClient()
    	local lsp_clients = require("galaxyline.providers.lsp").get_lsp_client("", { "null-ls" })
    	local null_ls_clients = GetNulllsClient()
    	if string.len(lsp_clients) > 0 then
    		return lsp_clients .. "," .. null_ls_clients
    	else
    		return null_ls_clients
    	end
    end

    local function LspCondition()
    	local lsp_clients = GetLspClient()
    	if string.len(lsp_clients) > 1 then
    		return true
    	else
    		return false
    	end
    end

    local function GetGitBranch()
    	if vim.bo.filetype == "dashboard" then
    		return ""
    	else
    		return require("galaxyline.providers.vcs").get_git_branch()
    	end
    end

    local function GetGitNotifications()
    	if notifications.statusline_notification_count() == "" then
    		return ""
    	else
    		return notifications.statusline_notification_count() .. " "
    	end
    end

    local function GetCursorPostion()
    	local line = vim.fn.line(".")
    	local column = vim.fn.col(".")
    	return string.format("%3d:%2d", line, column)
    end

    local function GetModeColor()
    	local m = vim.fn.mode() or vim.fn.visualmode()
    	local color = mode_color(m)
    	vim.api.nvim_command("hi GalaxyModeColor guibg=" .. color)
    	vim.api.nvim_command("hi GalaxyModeColorReverse guifg=" .. color)
    	return " "
    end

    local function GetLeftBracket()
    	if vim.bo.filetype == "dashboard" then
    		return ""
    	else
    		return " " .. ""
    	end
    end

    local function GetRightBracket()
    	if vim.bo.filetype == "dashboard" then
    		return ""
    	else
    		return "" .. " "
    	end
    end

    -- Left Section

    local a = 1
    gls.left[a] = {
    	ModeColor = {
    		separator = "",
    		separator_highlight = "GalaxyModeColorReverse",
    		highlight = { colors.bg, mode_color() },
    		provider = GetModeColor,
    		condition = CommonCondition,
    	},
    }

    a = a + 1
    gls.left[a] = {
    	GitSectionBracket1 = {
    		provider = GetLeftBracket,
    		highlight = { colors.green, colors.bg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	GitIcon = {
    		provider = function()
    			if vim.bo.filetype == "dashboard" then
    				return ""
    			else
    				return ""
    			end
    		end,
    		highlight = { colors.bg, colors.green },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	GitSectionBracket2 = {
    		provider = GetRightBracket,
    		highlight = { colors.green, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }

    a = a + 1
    gls.left[a] = {
    	GithubNotifications = {
    		provider = GetGitNotifications,
    		highlight = { colors.orange, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	GitBranch = {
    		provider = GetGitBranch,
    		highlight = { colors.fg, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	GitSectionExtraSpace = {
    		provider = function()
    			if vim.bo.filetype == "dashboard" then
    				return ""
    			else
    				return " "
    			end
    		end,
    		highlight = { colors.green, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	DiffAdd = {
    		provider = "DiffAdd",
    		icon = "  ",
    		highlight = { colors.green, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	DiffModified = {
    		provider = "DiffModified",
    		icon = " 柳 ",
    		highlight = { colors.yellow, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	DiffRemove = {
    		provider = "DiffRemove",
    		icon = "  ",
    		highlight = { colors.red, colors.gitBg },
    		condition = condition.check_git_workspace,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	GitSectionBracket3 = {
    		provider = GetRightBracket,
    		highlight = { colors.gitBg, colors.bg },
    		condition = condition.check_git_workspace,
    	},
    }

    a = a + 1
    gls.left[a] = {
    	LspSectionBracket1 = {
    		provider = GetLeftBracket,
    		highlight = { colors.blue, colors.bg },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	LspIcon = {
    		provider = function()
    			return ""
    		end,
    		highlight = { colors.bg, colors.blue },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	LspSectionBracket2 = {
    		provider = GetRightBracket,
    		highlight = { colors.blue, colors.lspBg },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	LspName = {
    		provider = GetLspClient,
    		highlight = { colors.fg, colors.lspBg },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	DiagnosticError = {
    		provider = "DiagnosticError",
    		icon = "   ",
    		highlight = { colors.red, colors.lspBg },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	DiagnosticWarn = {
    		provider = "DiagnosticWarn",
    		icon = "   ",
    		highlight = { colors.yellow, colors.lspBg },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	DiagnosticHint = {
    		provider = "DiagnosticHint",
    		icon = "   ",
    		highlight = { colors.cyan, colors.lspBg },
    		condition = LspCondition,
    	},
    }

    a = a + 1
    gls.left[a] = {
    	DiagnosticInfo = {
    		provider = "DiagnosticInfo",
    		icon = "   ",
    		highlight = { colors.blue, colors.lspBg },
    		condition = LspCondition,
    	},
    }
    a = a + 1
    gls.left[a] = {
    	LspSectionBracket3 = {
    		provider = GetRightBracket,
    		highlight = { colors.lspBg, colors.bg },
    		condition = LspCondition,
    	},
    }

    -- Right Section

    local b = 1
    gls.right[b] = {
    	FileInfoSectionBracket1 = {
    		provider = GetLeftBracket,
    		highlight = { colors.orange, colors.bg },
    		condition = CommonCondition,
    	},
    }
    b = b + 1
    gls.right[b] = {
    	FileIcon = {
    		provider = "FileIcon",
    		highlight = { colors.bg, colors.orange },
    		condition = CommonCondition,
    	},
    }
    b = b + 1
    gls.right[b] = {
    	FileInfoSectionBracket2 = {
    		provider = GetRightBracket,
    		highlight = { colors.orange, colors.fileinfoBg },
    		condition = CommonCondition,
    	},
    }
    b = b + 1
    gls.right[b] = {
    	CursorPosition = {
    		provider = GetCursorPostion,
    		highlight = { colors.fg, colors.fileinfoBg },
    		condition = CommonCondition,
    	},
    }
    b = b + 1
    gls.right[b] = {
    	FileInfoSectionBracket3 = {
    		provider = GetRightBracket,
    		highlight = { colors.fileinfoBg, colors.bg },
    		condition = CommonCondition,
    	},
    }

    -- Short statusline left
    local c = 1
    gls.short_line_left[c] = {
    	ShortLineBracket1 = {
    		provider = GetLeftBracket,
    		highlight = { colors.blue, colors.bg },
    		condition = NvimTreeLineCondition,
    	},
    }

    c = c + 1
    gls.short_line_left[c] = {
    	ShortLineIcon = {
    		provider = function()
    			return " "
    		end,
    		highlight = { colors.bg, colors.blue },
    		condition = NvimTreeLineCondition,
    	},
    }

    c = c + 1
    gls.short_line_left[c] = {
    	ShortLineBracket2 = {
    		provider = GetRightBracket,
    		highlight = { colors.blue, colors.lspBg },
    		condition = NvimTreeLineCondition,
    	},
    }

    c = c + 1
    gls.short_line_left[c] = {
    	ShortLineCurrentCWD = {
    		provider = function()
    			return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    		end,
    		highlight = { colors.fg, colors.lspBg },
    		condition = NvimTreeLineCondition,
    	},
    }

    c = c + 1
    gls.short_line_left[c] = {
    	ShortLineBracket3 = {
    		provider = GetRightBracket,
    		highlight = { colors.lspBg, colors.bg },
    		condition = NvimTreeLineCondition,
    	},
    }

    -- Short line right
    local d = 1
    gls.short_line_right[d] = {
    	ShortLineBracket4 = {
    		provider = GetLeftBracket,
    		highlight = { colors.blue, colors.bg },
    		condition = NvimTreeLineCondition,
    	},
    }

    d = d + 1
    gls.short_line_right[d] = {
    	DirectorySize = {
    		provider = DirSize,
    		highlight = { colors.bg, colors.blue },
    		condition = NvimTreeLineCondition,
    	},
    }

    d = d + 1
    gls.short_line_right[d] = {
    	ShortLineBracket5 = {
    		provider = GetRightBracket,
    		highlight = { colors.blue, colors.bg },
    		condition = NvimTreeLineCondition,
    	},
    }
  '';
}
