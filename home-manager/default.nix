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
      awscli2
      difftastic
      httpie
      ripgrep
      watchman
    ];
  };

  home.file.".config/ghostty/config" = {
    text = ''
      font-family = "Maple Mono NF"
      font-size = 16
      theme = "catppuccin-mocha"
      confirm-close-surface = false
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings

      if not set -q ZELLIJ
        zellij attach --create default
      end
    '';
    shellAbbrs = {
      drs = "darwin-rebuild switch --flake ~/.config/nix-darwin";
      j = "jj";
    };
  };
  home.file.".config/fish/completions/jj.fish" = {
    source = ./dotfiles/fish/completions/jj.fish;
  };
  home.file.".config/fish/functions/fish_prompt.fish" = {
    source = ./dotfiles/fish/functions/fish_prompt.fish;
  };
  home.file.".config/fish/functions/fish_vcs_prompt.fish" = {
    source = ./dotfiles/fish/functions/fish_vcs_prompt.fish;
  };
  home.file.".config/fish/functions/fish_jj_prompt.fish" = {
    source = ./dotfiles/fish/functions/fish_jj_prompt.fish;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv.enable = true;

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    globalConfig = {
      tools = {
        usage = "latest";
        erlang = "27.2.3";
        elixir = "1.18.2-otp-27";
      };
    };
    settings.experimental = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  home.file.".config/zellij/config.kdl" = {
    text = ''
      pane_frames false
      theme "catppuccin-mocha"
      session_serialization false

      ui {
        pane_frames {
          hide_session_name true
        }
      }

      keybinds clear-defaults=true {
        normal {
          bind "Ctrl a" { SwitchToMode "tmux"; }
        }
        tmux {
          bind "Esc" { SwitchToMode "Normal"; }

          bind "1" { GoToTab 1; SwitchToMode "Normal"; }
          bind "2" { GoToTab 2; SwitchToMode "Normal"; }
          bind "3" { GoToTab 3; SwitchToMode "Normal"; }
          bind "4" { GoToTab 4; SwitchToMode "Normal"; }
          bind "5" { GoToTab 5; SwitchToMode "Normal"; }
          bind "6" { GoToTab 6; SwitchToMode "Normal"; }
          bind "7" { GoToTab 7; SwitchToMode "Normal"; }
          bind "8" { GoToTab 8; SwitchToMode "Normal"; }
          bind "9" { GoToTab 9; SwitchToMode "Normal"; }

          bind "c" { NewTab; SwitchToMode "Normal"; }
          bind "n" { GoToNextTab; SwitchToMode "Normal"; }
          bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }

          bind "h" { MoveFocus "Left"; }
          bind "j" { MoveFocus "Down"; }
          bind "k" { MoveFocus "Up"; }
          bind "l" { MoveFocus "Right"; }

          bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }

          bind "d" { Detach; }

          bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
        }

        shared_except "locked" {
          bind "Ctrl h" {
            MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.2.1/vim-zellij-navigator.wasm" {
              name "move_focus_or_tab";
              payload "left";
              move_mod "ctrl";
            };
          }

          bind "Ctrl j" {
            MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.2.1/vim-zellij-navigator.wasm" {
              name "move_focus";
              payload "down";
              move_mod "ctrl";
            };
          }

          bind "Ctrl k" {
            MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.2.1/vim-zellij-navigator.wasm" {
              name "move_focus";
              payload "up";
              move_mod "ctrl";
            };
          }

          bind "Ctrl l" {
            MessagePlugin "https://github.com/hiasr/vim-zellij-navigator/releases/download/0.2.1/vim-zellij-navigator.wasm" {
              name "move_focus_or_tab";
              payload "right";
              move_mod "ctrl";
            };
          }
        }
      }
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
