{ config, pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  # Users
  # ----------------------------------------------------------------------------

  users = {
    #mutableUsers = false;

    extraUsers =
      let
        makeUser = { username, name, email, groups, uid, shell, password, ... }: {
          "name" = "${username}";
          "value" = {
            description = name;
            isNormalUser = true;

            uid = uid;
            extraGroups = groups;

            home = "/home/${username}";
            createHome = true;

            shell = shell;

            #TODO: set back password
            #hashedPassword = password;
            password = "password";
          };
        };
      in builtins.listToAttrs (map makeUser config.settings.users);
  };
}
