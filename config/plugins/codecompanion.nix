{
  plugins.codecompanion = {
    enable = true;
    settings = {
      strategies = {
        agent = {
          adapter = "copilot";
        };
        chat = {
          adapter = "copilot";
        };
        inline = {
          adapter = "copilot";
        };
      };
    };
  };
  keymaps = [
    {
      key = "<leader>ac";
      action = "<CMD>CodeCompanionChat Toggle<CR>";
      options.desc = "Ai Chat";
    }
  ];
}
