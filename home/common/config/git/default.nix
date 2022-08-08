{
  programs = {
    git = {
      enable = true;
      userName = "nokogiri";
      userEmail = "nokogiri@gefjon.org";
      signing.key = "3064C39BEA915CE6";
      diff-so-fancy.enable = true;
      ignores = [
        "*~"
        "*.swp"
      ];
    };
    gitui.enable = true;
  };
}
