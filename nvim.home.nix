{ ... }:
{
  programs.nvchad = {
    enable = true;

    extraConfig = {
      vim.g.clipboard = {
        name = 'Clipboard',
        copy = {
          ['+'] = ['cb', 'copy'],
          ['*'] = ['cb', 'copy'],
        },
        paste = {
          ['+'] = ['cb', 'paste'],
          ['*'] = ['cb', 'paste'],
        },
        cache_enabled = 0,
      }
    };
  };
}
