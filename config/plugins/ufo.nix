{
  plugins.nvim-ufo = {
    enable = true;
    settings = {
      enable_get_fold_virt_text = true;
      fold_virt_text_handler =
        # lua
        ''
          function(virtText, lnum, endLnum, width, truncate)
          	local newVirtText = {}
          	local suffix = ('  %d '):format(endLnum - lnum)
          	local sufWidth = vim.fn.strdisplaywidth(suffix)
                 local targetWidth = width - sufWidth
                 local curWidth = 0
                 for _, chunk in ipairs(virtText) do
                   local chunkText = chunk[1]
                   local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                   if targetWidth > curWidth + chunkWidth then
                     table.insert(newVirtText, chunk)
                   else
                     chunkText = truncate(chunkText, targetWidth - curWidth)
                     local hlGroup = chunk[2]
                     table.insert(newVirtText, {chunkText, hlGroup})
                     chunkWidth = vim.fn.strdisplaywidth(chunkText)
                     -- str width returned from truncate() may less than 2nd argument, need padding
                     if curWidth + chunkWidth < targetWidth then
                       suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                     end
                     break
                   end
                   curWidth = curWidth + chunkWidth
                 end
                 table.insert(newVirtText, {suffix, 'MoreMsg'})
                 return newVirtText
               end
        '';
      provider_selector =
        # lua
        ''
          function(bufnr, filetype, buftype)
            local ftMap = {
              vim = "indent",
              python = {"indent"},
              git = ""
            }

           return ftMap[filetype]
          end
        '';
    };
  };
  opts = {
    fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:";
    foldcolumn = "0";
  };
  keymaps = [
    {
      key = "<";
      mode = "n";
      options = {
        desc = "Toggle Fold";
        remap = true;
      };
      action = "za";
    }
  ];
}
