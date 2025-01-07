{helpers, ...}: {
  plugins.better-escape = {
    enable = true;
    settings.mappings = {
      t = {j = helpers.listToUnkeyedAttrs [false];};
      v = {j = helpers.listToUnkeyedAttrs [false];};
    };
  };
}
