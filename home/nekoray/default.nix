let 
	cfgRoot = ".config/nekoray/config";
in {
	home.file = {
		"${cfgRoot}/routes_box/Default" = {
			enable = false;
			source = ./routes_box.json;
		};

		"${cfgRoot}/groups/nekobox.json" = {
			enable = false;
			source = ./nekobox.json;
		}
	};
}
