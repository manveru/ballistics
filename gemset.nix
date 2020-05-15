{
  buildar = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0161zrwrj67k0dy9z4chbdxi20apxkr7lxhn2gmy7fr7ykxcqmhi";
      type = "gem";
    };
    version = "3.0.0.2";
  };
  minitest = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0g73x65hmjph8dg1h3rkzfg7ys3ffxm35hj35grw75fixmq53qyz";
      type = "gem";
    };
    version = "5.14.0";
  };
  rake = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0w6qza25bq1s825faaglkx1k6d59aiyjjk3yw3ip5sb463mhhai9";
      type = "gem";
    };
    version = "13.0.1";
  };
  rake-compiler = {
    dependencies = ["rake"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l4hg21v0phfrfsc2hilgmwvn2imxr0byqh8dv16bya1s5d3km0q";
      type = "gem";
    };
    version = "1.1.0";
  };
}