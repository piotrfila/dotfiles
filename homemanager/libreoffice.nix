{
  config,
  pkgs,
  ...
}: {
  xdg.mimeApps.defaultApplications = let
    writer = ["writer.desktop"];
    calc = ["calc.desktop"];
    impress = ["impress.desktop"];
  in {
    "application/excel" = calc; # .xl .xla .xlb .xlc .xld .xlk .xll .xlm .xls .xlt .xlv .xlw
    "application/mspowerpoint" = impress; # .pot .pps .ppt .ppz
    "application/msword" = writer; # .doc .dot .w6w .wiz .word
    "application/powerpoint" = impress; # .ppt
    "application/vnd.oasis.opendocument.text" = writer; # .odt
    "application/vnd.oasis.opendocument.spreadsheet" = calc; # .ods
    "application/vnd.oasis.opendocument.presentation" = impress; # .odp
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = writer; # .docx
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = calc; # .xlsx
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = impress; # .pptx
    "text/richtext" = writer; # .rt .rtf .rtx
  };
  home.packages = [pkgs.libreoffice];
}
