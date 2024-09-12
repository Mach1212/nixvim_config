{
  extraConfigLua = ''
    mapleader = " "
  '';
   
  keymaps = [ 
    {
      key = "<leader>c";
      action = "find_files";
      options = {
        desc = "Close buffer";
      };
    }
    {
      action = "<cmd>q<CR>";
      key = "<leader>q";
      mode = "n";
      options = {
        desc = "Close nvim";
      };
    }
  ];
}
