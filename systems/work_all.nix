{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
    graphviz
    httpie
    jq
    kubecolor
    kubectx
  ];

  homebrew.casks = [
    "bruno"
    "linear-linear"
    "notion"
    "slack"
    "virtualbox"
  ];
}
