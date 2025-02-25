{
  plugins.numbertoggle.enable = false;
  keymaps = [
    {
      key = "<leader>un";
      action = "<CMD>call ToggleLineNumbers()<CR>";
      options.desc = "Toggle Line Numbers";
    }
  ];
  extraConfigVim =
    #vim
    ''
      function! ToggleLineNumbers()
          if g:mach12toggleLineNumbers == 0
              let g:mach12toggleLineNumbers=1
              set nonumber norelativenumber
          elseif g:mach12toggleLineNumbers == 1
              let g:mach12toggleLineNumbers=2
              set number
          elseif g:mach12toggleLineNumbers == 2
              let g:mach12toggleLineNumbers=0
              set number relativenumber
          endif
      endfunction
      let g:mach12toggleLineNumbers = 2
      call ToggleLineNumbers()
    '';
}
