{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tyasheliy";
  home.homeDirectory = "/home/tyasheliy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
      htop
      neofetch
      nekoray
      (nerdfonts.override { fonts = ["JetBrainsMono"]; })
      pinentry-curses
      go
  ];

  programs.alacritty.enable = true;

  programs.zsh = {
	enable = true;
	profileExtra = "startx";
  };

  xsession = {
	enable = true;
	windowManager.bspwm = {
		enable = true;
		extraConfigEarly = "bspc monitor -d 1 2 3 4 5 6 7 8 9";
		extraConfig = "polybar-msg cmd quit\npolybar && disown";
		settings = {
			border_width = 2;
		};
	};
  };

  services.sxhkd = {
	enable = true;
	keybindings = {
		"alt + Return" = "alacritty";
		"ctrl + alt + Return" = "firefox --browser";
		"alt + q" = "bspc node --kill";
		"alt + shift + {q,r}" = "bspc {quit,wm -r}";
		"alt + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
		"XF86AudioRaiseVolume" = "pactl set-sink-volume 0 +5%";
		"XF86AudioLowerVolume" = "pactl set-sink-volume 0 -5%";
		"XF86AudioMute" = "pactl set-sink-mute 0 toggle";
	};
  };

  services.polybar = {
	enable = true;
	script = "polybar top &";
	settings = {
		"bar/top" = {
			modules-left = "tray";
			modules-right = "cpu bspwm time battery";
			module-margin = 2;
			font = ["JetBrainsMono Nerd Font Propo:size=13;1"];
		};

		"module/cpu" = {
			type = "internal/cpu";
			label = "CPU %percentage%%";
			interval = 1;
		};

		"module/bspwm" = {
			type = "internal/bspwm";
			label-focused-background = "#606060";
		};

		"module/battery" = {
			type = "internal/battery";
			battery = "BAT0";
			poll-interval = 5;
		};

		"module/tray" = {
			type = "internal/tray";
			tray-size = "126%";
		};

		"module/time" = {
			type = "internal/date";
			interval = "1.0";
			time = "%H:%M";
			date = "%Y-%m-%d";
			label = "%time%";
		};
	};
  };

  home.file = {
	".xinitrc".text = "sxhkd & exec bspwm";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
	enable = true;
	enableSshSupport = true;
	enableZshIntegration = true;
	pinentryPackage = pkgs.pinentry-curses;
  };

  programs.password-store = {
	enable = true;
	package = pkgs.pass.withExtensions (exts:
		with exts; [
		pass-otp
	]);
  };

  programs.git = {
	enable = true;
	userName = "tyasheliy";
	userEmail = "egorgerasimov@tuta.io";
	extraConfig = {
		push = {
			autoSetupRemote = true;
		};
	};
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tyasheliy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
