{ pkgs, ... }: {
  services.throttled.enable = true;
  programs.dconf.enable = true;

  environment.variables = {
  	QT_SCALE_FACTOR = "1.3";
  };
}
