{
  plugins.lspsaga = {
    enable = true;
    extraOptions = {
      max_preview_lines = 10;
    };
    codeAction = {
      # extendGitSigns = true;
      numShortcut = true;
      showServerName = true;
    };
    lightbulb = {
      enable = true;
      sign = false;
    };
    beacon.enable = false;
    diagnostic = {
      showCodeAction = false;
    };
  };
  keymaps = [
    {
      key = "[d";
      options.desc = "Previous diagnostic";
      action = ''<CMD>Lspsaga diagnostic_jump_prev<CR>'';
    }
    {
      key = "]d";
      options.desc = "Next diagnostic";
      action = ''<CMD>Lspsaga diagnostic_jump_next<CR>'';
    }
    {
      key = "<leader>la";
      options.desc = "Lsp Action";
      action = ''<CMD>Lspsaga code_action<CR>'';
    }
    {
      key = "gd";
      options.desc = "Goto Definition";
      action = ''<CMD>Lspsaga goto_definition<CR>'';
    }
    {
      key = "<leader>lS";
      options.desc = "Lsp Outline";
      action = ''<CMD>Lspsaga outline<CR>'';
    }
    {
      key = "<leader>lr";
      options.desc = "Lsp Rename";
      action = "<CMD>Lspsaga rename<CR>";
    }
    {
      key = "<leader>lR";
      options.desc = "Lsp Project Rename";
      action = "<CMD>Lspsaga rename ++project<CR>";
    }
  ];
}
