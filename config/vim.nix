{ config, pkgs, ... }:

{
  environment.systemPackages = 
    let
      vim_minimal = pkgs.vim_configurable.override {
        features = "normal";
        guiSupport = "no";
        luaSupport = false;
        pythonSupport = false;
        rubySupport = false;
        multibyteSupport = true;
        netbeansSupport = false;
      };
    in
    with pkgs; [ (with import <nixpkgs> {}; 
    vim_minimal.customize {
        # Specifies the vim binary name.
        # E.g. set this to "my-vim" and you need to type "my-vim" to open this vim
        # This allows to have multiple vim packages installed (e.g. with a different set of plugins)
        name = "vim-minimal";
      	vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
      	  # loaded on launch
      	  start = [ vim-nix vim-sensible ];
      	  # manually loadable by calling `:packadd $plugin-name`
      	  #opt = [ phpCompletion elm-vim ];
      	  # To automatically load a plugin when opening a filetype, add vimrc lines like:
      	  # autocmd FileType php :packadd phpCompletion
      	};
      }
    )
  ];
}

