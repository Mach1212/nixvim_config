{
  plugins.gitlinker = {
    enable = true;
    mappings = null;
    callbacks = {
      "github.ibm.com".__raw = "require('gitlinker.hosts').get_github_type_url";
    };
  };
  keymaps = [
    {
      key = "<leader>gy";
      action = "<CMD>lua require('gitlinker').get_buf_range_url('n')<CR>";
      options.desc = "Git Link Copy";
    }
    {
      key = "<leader>gY";
      action = "<CMD>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<CR>";
      options.desc = "Git Link Goto";
    }
    {
      key = "<leader>g<A-y>";
      action = "<CMD>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker.actions').open_in_browser})<CR>";
      options.desc = "Git Homepage Goto";
    }
  ];
}
