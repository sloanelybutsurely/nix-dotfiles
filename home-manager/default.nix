{ pkgs, nixvim, ... }:
{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./nixvim
  ];
  
  home = {
    stateVersion = "24.11";

    sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    packages = with pkgs; [
      watchman
      difftastic
      maple-mono-NF
    ];
  };

  home.file.".config/ghostty/config" = {
    enable = true;
    text = ''
      font-family = "Maple Mono NF"
      font-size = 16
      theme = "catppuccin-mocha"
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
    shellAbbrs = {
      j = "jj";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv.enable = true;

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      prefix-highlight
      vim-tmux-navigator
      catppuccin
    ];
    extraConfig = ''
      set -g @catppuccin_flavor 'frappe'

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions.IdentityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      core.fsmonitor = "watchman";
      user = {
        name = "sloane";
        email = "git@sloanelybutsurely.com";
      };
      signing = {
        sign-all = true;
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID0TH2GezEx8+zlKBqUb7rBsbmghnd1u4nX6YpQr28Zw";
        backends.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      ui = {
        paginate = "never";
        default-command = "log";
        editor = "nvim";
        diff.tool = ["difft" "--color=always" "$left" "$right"];
      };
      revsets.log = "trunk() | ancestors(reachable(@ | mine(), mutable()), 2) | @";
      git = {
        push-bookmark-prefix = "sloane/push-";
        private-commits = "wip | nocommit | dev-only";
      };
      revset-aliases = {
        wip = ''description(regex:"^\\[(wip|WIP|todo|TODO)\\]|(wip|WIP|todo|TODO):?")'';
        nocommit = ''description(regex:"^\\[(nocommit|NOCOMMIT)\\]|(nocommit|NOCOMMIT):?")'';
        dev-only = ''description(regex:"^\\[(dev-only|DEV-ONLY)\\]|(dev-only|DEV-ONLY):?")'';
        current = ''(bookmarks() | wip | dev-only) & mine()'';
      };
    };
  };
}
