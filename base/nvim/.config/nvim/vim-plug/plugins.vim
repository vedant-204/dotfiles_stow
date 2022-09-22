" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support"
    Plug 'sheerun/vim-polyglot'
    " File Explorer"
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Discord Presence"
    Plug 'andweeb/presence.nvim'
    "lightline"
    Plug 'itchyny/lightline.vim'
    "Color Picker"
    Plug 'KabbAmine/vCoolor.vim'
    "fzf"
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    "Auto-complete"
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    "Themes"
    Plug 'Mangeshrex/everblush.vim'
    "Copilot"
    Plug 'github/copilot.vim'
    "Theme"
    Plug 'dracula/vim', { 'as': 'dracula' }
    "icons"
    Plug 'ryanoasis/vim-devicons'
    Plug 'tpope/vim-fugitive'
    "HTML"
    Plug 'mattn/emmet-vim'
    "Window Management"
    "Rust Support
    Plug 'rust-lang/rust.vim'    
    Plug 'elkowar/yuck.vim'
    Plug 'romgrk/barbar.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    "Git management
    Plug 'tpope/vim-fugitive'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'airblade/vim-rooter'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'chrisbra/csv.vim'

call plug#end()

"Config Section

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

