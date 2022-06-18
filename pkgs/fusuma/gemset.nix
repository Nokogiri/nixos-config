{
  fusuma = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rq64grp98w7msjmj24hlxy1jqzqn96r81x4z09aq2v532cgqy4f";
      type = "gem";
    };
    version = "2.4.1";
  };
  fusuma-plugin-sendkey = {
    dependencies = ["fusuma" "revdev"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "091w1mjankn5iymawqjsn23qmjl7alvlrjsy602d77xsmakbv582";
      type = "gem";
    };
    version = "0.6.4";
  };
  fusuma-plugin-tap = {
    dependencies = ["fusuma"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jlw08iw20fpykjglzj4c2fy3z13zsnmi63zbfpn0gmvs05869ys";
      type = "gem";
    };
    version = "0.4.2";
  };
  revdev = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1b6zg6vqlaik13fqxxcxhd4qnkfgdjnl4wy3a1q67281bl0qpsz9";
      type = "gem";
    };
    version = "0.2.1";
  };
}
