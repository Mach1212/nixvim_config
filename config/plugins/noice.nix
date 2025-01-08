# {pkgs-old, ...}:
{
  plugins.noice = {
    # package = pkgs-old.vimPlugins.noice-nvim;
    enable = true;
    settings = {
      lsp.override = {
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
      };
      presets = {
        inc_rename = true;
        lsp_doc_border = true;
        command_palette = true;
      };
    };
  };
}
