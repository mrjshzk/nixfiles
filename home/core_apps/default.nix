{ ... }: {
  # './terminal' is a directory and resolves to './terminal/default.nix';
  # './rider.nix' is a standalone file — both are valid Nix import forms.
  imports = [ ./terminal ./rider.nix ];
}
