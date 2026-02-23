{ config, lib, ... }:

with lib;

{
  options = {
    settings = {
      # State version (installed version)
      stateVersion = mkOption {
        type = with types; uniq str;
        default = "25.11";
        description = ''
          The version of the file stored on disk.
        '';
        example = ''
          config.settings.stateVersion = "25.11";
        '';
      };

      # User full name
      userName = mkOption {
        type = with types; uniq str;
        default = "Mathieu Hardy";
        description = ''
          The user name.
        '';
        example = ''
          config.settings.userName = "foo";
        '';
      };

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

      # User email
      userEmail = mkOption {
        type = with types; uniq str;
        default = "mhardy2008@gmail.com";
        description = ''
          The user email.
        '';
        example = ''
          config.settings.userEmail = "foo";
        '';
      };

      # User full name for Git
      gitUserName = mkOption {
        type = with types; uniq str;
        default = "Mathieu Hardy";
        description = ''
          The user name used for Git.
        '';
        example = ''
          config.settings.gitUserName = "foo";
        '';
      };

      # User email for Git
      gitUserEmail = mkOption {
        type = with types; uniq str;
        default = "mhardy2008@gmail.com";
        description = ''
          The user email used for Git.
        '';
        example = ''
          config.settings.gitUserEmail = "foo";
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
