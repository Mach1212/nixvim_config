{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      # bash

      # clang-tidy
      # cmakelint
      # cppcheck
      # cspell
      # ESLint

      json = [
        "jsonlint"
      ];
      dockerfile = [
        "hadolint"
      ];
      html = [
        "htmlhint"
        "tidy"
      ];
      javascript = [
        "jshint"
      ];
      lua = [
        "luacheck"
      ];
      markup = [
        "markuplint"
      ];
      nix = [
        "nix"
      ];
      python = [
        "ruff"
      ];
      css = [
        "stylelint"
      ];
      yaml = [
        "yamllint"
      ];
    };
  };
}
