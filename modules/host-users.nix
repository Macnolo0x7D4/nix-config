{ networking, system, users, nix, ... }:

username:
{
  darwin ? false
}

let
{
  home = if darwin then "/Users/${username}" else "/home/${username}";
}
in
{
  users.users."${username}"= {
    home = home;
    description = username;
  };

  nix.settings.trusted-users = [ username ];
}
