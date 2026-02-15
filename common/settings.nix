{ config, lib, ... }:

with lib;

{
  # TODO: use this
  options = {
    settings = {
      # User login
      userLogin = mkOption {
        type = with types; uniq str;
        default = "mhardy";
        description = ''
          The user login value.
        '';
        example = ''
          config.settings.userLogin = "foo";
        '';
      };

      # Path of Git repositories
      repos = mkOption {
        type = with types; uniq str;
        default = "dev";
        description = ''
          The path (from $HOME) where the Git repositories are stored.
        '';
        example = ''
          config.settings.repos = "/path/to/repos";
        '';
      };
    };
  };
}
