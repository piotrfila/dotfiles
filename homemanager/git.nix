{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      commit.gpgsign = true;
      init.defaultBranch = "main";
      user.name = "Piotr Fila";
      user.email = "piotr.fila.stud@pw.edu.pl";
    };
  };
}
