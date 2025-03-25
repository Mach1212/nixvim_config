{pkgs, ...}: {
  performance.combinePlugins.standalonePlugins = ["quarto-nvim"];
  plugins = {
    molten = {
      enable = true;
      settings = {
        auto_open_output = false;
        output_show_more = true;
        virt_text_max_lines = 8;
        image_provider = "image.nvim";
        # output_win_cover_gutter = true;
        # output_win_hide_on_leave = true;
        # output_win_style = false;
        # save_path.__raw = "vim.fn.stdpath('data')..'/molten'";
        # show_mimetype_debug = false;
        use_border_highlights = true;
        virt_lines_off_by_1 = true;
        virt_text_output = true;
        wrap_output = true;
      };
    };
    quarto = {
      enable = true;
      settings = {
        lspFeatures = {
          languages = ["python" "rust"];
          chunks = "all";
          diagnostics = {
            enabled = true;
            triggers = ["InsertLeave" "BufWritePost"];
          };
          completion = {
            enabled = true;
          };
        };
        keymap = {
          # hover = "H";
          # definition = "gd";
          # rename = "<leader>rn";
          # references = "gr";
          # format = "<leader>gf";
        };
        codeRunner = {
          enabled = true;
          default_method = "molten";
        };
      };
    };
    jupytext = {
      enable = true;
      settings = {
        custom_language_formatting = {
          python = {
            style = "markdown";
            extension = "md";
            force_ft = "markdown";
          };
        };
      };
    };
    treesitter-textobjects = {
      move = {
        enable = true;
        gotoNextStart = {
          "]b" = "@code_cell.inner";
        };
        gotoPreviousStart = {
          "[b" = "@code_cell.inner";
        };
      };
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "ib" = "@code_cell.inner";
          "ab" = "@code_cell.outer";
        };
      };
      swap = {
        enable = true;
        swapNext = {
          "<leader>sbl" = "@code_cell.outer";
        };
        swapPrevious = {
          "<leader>sbh" = "@code_cell.outer";
        };
      };
    };
  };
  extraFiles = {
    "after/queries/markdown/textobjects.scm".text = ''
      ;; extends

      (fenced_code_block (code_fence_content) @code_cell.inner) @code_cell.outer
    '';
  };
  extraConfigLua =
    #lua
    ''
      -- automatically import output chunks from a jupyter notebook
      -- tries to find a kernel that matches the kernel in the jupyter notebook
      -- falls back to a kernel that matches the name of the active venv (if any)
      local imb = function(e) -- init molten buffer
      	vim.schedule(function()
      		local kernels = vim.fn.MoltenAvailableKernels()
      		local try_kernel_name = function()
      			local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
      			return metadata.kernelspec.name
      		end
      		local ok, kernel_name = pcall(try_kernel_name)
      		if not ok or not vim.tbl_contains(kernels, kernel_name) then
      			kernel_name = nil
      			local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
      			if venv ~= nil then
      				kernel_name = string.match(venv, "/.+/(.+)")
      			end
      		end
      		if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      			vim.cmd(("MoltenInit %s"):format(kernel_name))
      		end
      		vim.cmd("MoltenImportOutput")
      	end)
      end

      -- automatically import output chunks from a jupyter notebook
      vim.api.nvim_create_autocmd("BufAdd", {
      	pattern = { "*.ipynb" },
      	callback = imb,
      })

      -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      vim.api.nvim_create_autocmd("BufEnter", {
      	pattern = { "*.ipynb" },
      	callback = function(e)
      		if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
      			imb(e)
      		end
      	end,
      })

      -- automatically export output chunks to a jupyter notebook on write
      vim.api.nvim_create_autocmd("BufWritePost", {
      	pattern = { "*.ipynb" },
      	callback = function()
      		if require("molten.status").initialized() == "Molten" then
      			vim.cmd("MoltenExportOutput!")
      		end
      	end,
      })

      -- Provide a command to create a blank new Python notebook
      -- note: the metadata is needed for Jupytext to understand how to parse the notebook.
      -- if you use another language than Python, you should change it in the template.
      local default_notebook = [[
        {
          "cells": [
           {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
              "# basedpyright: ignore[reportUnusedCallResult]"
            ]
           }
          ],
          "metadata": {
           "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
           },
           "language_info": {
            "codemirror_mode": {
              "name": "ipython"
            },
            "file_extension": ".py",
            "mimetype": "text/x-python",
            "name": "python",
            "nbconvert_exporter": "python",
            "pygments_lexer": "ipython3"
           }
          },
          "nbformat": 4,
          "nbformat_minor": 5
        }
      ]]

      local function new_notebook(filename)
      	local path = filename .. ".ipynb"
      	local file = io.open(path, "w")
      	if file then
      		file:write(default_notebook)
      		file:close()
      		vim.cmd("edit " .. path)
      	else
      		print("Error: Could not open new notebook file for writing.")
      	end
      end

      vim.api.nvim_create_user_command("NewNotebook", function(opts)
      	new_notebook(opts.args)
      	vim.cmd("QuartoActivate")
      end, {
      	nargs = 1,
      	complete = "file",
      })
    '';
  keymaps = [
    {
      key = "<leader>ji";
      action = ''<CMD>MoltenInit<CR>'';
      options.desc = "Kernel Boot";
    }
    {
      key = "<leader>jI";
      action = ''<CMD>MoltenRestart<CR>'';
      options.desc = "Kernel Restart";
    }
    {
      key = "<leader>jS";
      action = ''<CMD>MoltenDeinit<CR>'';
      options.desc = "Kernel Shutdown";
    }
    {
      key = "<leader>js";
      action = ''<CMD>MoltenInterrupt<CR>'';
      options.desc = "Kernel Stop";
    }
    {
      key = "<leader>jo";
      action = ''<CMD>noautocmd MoltenEnterOutput<CR>'';
      options.desc = "Output Open";
    }
    {
      key = "<leader>jO";
      action = ''<CMD>MoltenHideOutput<CR>'';
      options.desc = "Output Close";
    }
    {
      key = "<leader>jj";
      action = ''<CMD>lua require("quarto.runner").run_cell()<CR>'';
      options.desc = "Run Cell";
    }
    {
      key = "<leader>jJ";
      action = ''<CMD>lua require("quarto.runner").run_line()<CR>'';
      options.desc = "Run Line";
    }
    {
      mode = "v";
      key = "<leader>jJ";
      action = ''<CMD>lua require("quarto.runner").run_range()<CR>'';
      options.desc = "Run Range";
    }
    {
      key = "<leader>ja";
      action = ''<CMD>lua require("quarto.runner").run_below()<CR>'';
      options.desc = "Run cells Below";
    }
    {
      key = "<leader>jA";
      action = ''<CMD>lua require("quarto.runner").run_above()<CR>'';
      options.desc = "Run cells Above";
    }
  ];
}
