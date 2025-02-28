{
  plugins.notify = {
    enable = true;
    settings = {
      timeout = 3000;
      minimum_width = 30;
      max_width = 80;
      max_height = 10;
      # render = "wrapped-compact";
      stages = "fade";
    };
  };
  keymaps = [
    {
      key = "<leader>uN";
      action = "<CMD>lua require('notify').dismiss({pending=true,silent=true})<CR>";
      options.desc = "Notif Clear";
    }
  ];
}
