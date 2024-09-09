{...}: {
  services.logind = {
    hibernateKey = "ignore";
    hibernateKeyLongPress = "ignore";
    powerKey = "ignore";
    powerKeyLongPress = "ignore";
    suspendKey = "ignore";
    suspendKeyLongPress = "ignore";
    rebootKey = "ignore";
    rebootKeyLongPress = "ignore";

    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "suspend";
  };
}
