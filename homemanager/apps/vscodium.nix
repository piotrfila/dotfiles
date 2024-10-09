{
  pkgs,
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = let
      ext = pkgs.vscode-extensions;
    in [
      ext.bbenoist.nix
      ext.bungcip.better-toml
      # ext.jeanp413.open-remote-ssh
      ext.ms-python.python
      ext.ms-python.vscode-pylance
      # ext.ms-vscode-remote.remote-ssh
      # ext.polymeilex.wgsl
      ext.rust-lang.rust-analyzer
      ext.tomoki1207.pdf
      # ext.yzane.markdown-pdf
      # ext.ziglang.vscode-zig
    ];
    globalSnippets = {
      fixme = {
        body = [
          "$LINE_COMMENT FIXME: $0"
        ];
        description = "Insert a FIXME remark";
        prefix = [
          "fixme"
        ];
      };
    };
    keybindings = [
      {
        key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
        when = "textInputFocus";
      }
    ];
    languageSnippets = {
      haskell = {
        fixme = {
          body = [
            "$LINE_COMMENT FIXME: $0"
          ];
          description = "Insert a FIXME remark";
          prefix = [
            "fixme"
          ];
        };
      };
    };
    package = pkgs.vscodium;
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "zig"."initialSetupDone" = true;
      "zig"."path" = "zig";
      "zig"."zls.path" = "zls";
      "diffEditor"."maxComputationTime" = 0;
    };
  };

  home.file =
    builtins.listToAttrs (
      builtins.map (x: {
        name = ".config/VSCodium/${x}";
        value = {
          source = config.lib.file.mkOutOfStoreSymlink "/nix/persist${config.home.homeDirectory}/.config/VSCodium/${x}";
        };
      }) [
        "Backups"
        "blob_storage"
        "Cache"
        "CachedData"
        "CachedProfilesData"
        "Code Cache"
        "Crashpad"
        "databases"
        "DawnGraphiteCache"
        "DawnWebGPUCache"
        "Dictionaries"
        "GPUCache"
        "Local Storage"
        "logs"
        "Network Persistent State"
        "Preferences"
        "Service Worker"
        "Shared Dictionary"
        "SharedStorage"
        "TransportSecurity"
        "Trust Tokens"
        "Trust Tokens-journal"
        "User/globalStorage"
        "User/workspaceStorage"
        "User/History"
        "WebStorage"
      ]
    )
    // {
      "/nix/persist${config.home.homeDirectory}/.config/VSCodium/languagepacks.json".text = "{}";
      "/nix/persist${config.home.homeDirectory}/.config/VSCodium/machineid".text = "05ba50a4-8665-403f-a22a-a4a914426063";
    };
}
