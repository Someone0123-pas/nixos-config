{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Aliases
    shellAliases = {
      rm = "rm -i";
      vi = "nvim";
    };

    # Environmental Variables
    sessionVariables = {
    };

    # Further ~/.bashrc Configs
    # __git_ps1 only works if git is also enabled systemwide (and with git.prompt.enable = true)
    bashrcExtra = ''
      export GIT_PS1_SHOWSTASHSTATE=TRUE
      export PROMPT_COMMAND='PS1="\n \[\e[1;36m\]\u\[\e[m\] > \[\e[0;90m\]\D{%d.%m.%Y %R}\[\e[m\] > \[\e[0;32m\]$(__git_ps1 "%s:")\[\e[m\]\[\e[0;35m\](\w)\[\e[m\]\n \[\e[1;36m\]$ \[\e[m\]"'
    '';
  };
}
