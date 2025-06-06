{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Piotr Fila";
    userEmail = "piotr.fila.stud@pw.edu.pl";
    extraConfig = {
      commit.gpgsign = true;
      init.defaultBranch = "main";
    };
  };
}
