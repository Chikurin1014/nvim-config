{
  description = "Nvim configuration files";

  inputs = { };

  outputs =
    { self }:
    {
      file = {
        ".config/nvim" = {
          source = ./nvim;
          recursive = true;
        };
        ".config/neovide" = {
          source = ./neovide;
          recursive = true;
        };
      };
    };
}
