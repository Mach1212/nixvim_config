{
  plugins.notify = {
    enable = true;
    timeout = 3000;
    minimumWidth = 30;
    maxWidth = 80;
    maxHeight = 10;
    # render = "wrapped-compact";
    stages = "fade";
  };
  keymaps = [
    {
      key = "<leader>uN";
      action = "<CMD>lua require('notify').dismiss({pending=true,silent=true})<CR>";
      options.desc = "Notif Clear";
    }
  ];
}
