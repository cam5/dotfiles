Padawan.vim
===========

Padawan.vim is a vim plugin for [padawan.php server
](https://github.com/mkusher/padawan.php), a smart PHP code
completion server for Composer projects.

This plugin includes:
- Omnifunc
- Commands for index generation and index saving
- Commands for starting, stopping and restarting the server

### Demo video

Currently Padawan.vim offers basic completion for methods and classes based on doc comments
and method signatures.

Click the image below to watch a short video on what Padawan.vim can already do.
[![ScreenShot](http://i1.ytimg.com/vi/Y54P2N1T6-I/maxresdefault.jpg)](https://www.youtube.com/watch?v=Y54P2N1T6-I)

Requirements
------------

Padawan.vim requires:

1. PHP 5.5+
2. Composer
3. Vim with +python

Installation
------------

You can install Padawan.vim using any of the popular plugin managers like
Pathogen, Vundle, Neobundle or Plug.

- Make sure you have installed padawan.php package:
```bash
$ composer global require mkusher/padawan
```
- Configure $PATH variable. You may add $PATH to your vimrc:
```vim
let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
```
- Configure composer command:
```vim
let g:padawan#composer_command = "php /path/to/composer.phar"
```

### Pathogen

To install Padawan.vim with Pathogen do the following steps:
```bash
$ cd ~/.vim/bundle
$ git clone https://github.com/mkusher/padawan.vim.git
```

### Plug
Add this to your vimrc
```vim
Plug 'mkusher/padawan.vim'
```

### Vundle
Add this to your vimrc
```vim
Plugin 'mkusher/padawan.vim'
```

### NeoBundle
Add this to your vimrc
```vim
NeoBundle 'mkusher/padawan.vim'
```

How to use
==========

- In your php composer project folder, run the following
vim command to generate an index:
```vim
:PadawanGenerateIndex
```
- Start Padawan.php server with:
```vim
:PadawanStartServer
```
- Enjoy smart completion

Index generation can take a while, but needs to be performed only once per project.

Autocomplete engines
-------------------

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

You should set semantic triggers like
```vim
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php =
\ ['->', '::', '(', 'use ', 'namespace ', '\']
```

### [Neocomplete](https://github.com/Shougo/neocomplete.vim)

You should set omni input patterns like
```vim
let g:neocomplete#force_omni_input_patterns = {}
let g:neocomplete#force_omni_input_patterns.php =
\ '\h\w*\|[^- \t]->\w*'
```

Plugins(Extensions)
-------------------

You can extend Padawan.php by installing different plugins.
See [Plugins List](https://github.com/mkusher/padawan.php/wiki/Plugins-list)
for more info.

### Installing
To install a plugin, run `:PadawanAddPlugin PLUGIN_NAME`, for example:
```vim
:PadawanAddPlugin mkusher/padawan-symfony
```

### Removing
To remove a plugin, run `:PadawanRemovePlugin PLUGIN_NAME`, for example:
```vim
:PadawanRemovePlugin mkusher/padawan-symfony
```

Configuring
-----------

You may want to change Composer to the one already installed on your system.
You can do so by with the following line:
```vim
let g:padawan#composer_command = 'php /usr/bin/composer.phar'
```
Another configurable option is http request timeout. The following
example sets it to 100 ms:
```vim
let g:padawan#timeout = 0.1
```
If you don't want to use `composer global` for installing padawan, then you
should configure commands for running padawan:
```vim
let g:padawan#cli = '/path/to/padawan.php/bin/padawan'
let g:padawan#server_command = '/path/to/padawan.php/bin/padawan-server'
```

Vim functions
-------------

For quick access to the functions below, map them to keys of your choice.

### Index generation
Use `padawan#GenerateIndex()` function:
```vim
:call padawan#GenerateIndex()
```

### Index saving
Use `padawan#SaveIndex()` function:
```vim
:call padawan#SaveIndex()
```

### Starting server
Use `padawan#StartServer()` function:
```vim
:call padawan#StartServer()
```

### Stopping server
Use `padawan#StopServer()` function:
```vim
:call padawan#StopServer()
```

### Restarting server
Use `padawan#RestartServer()` function:
```vim
:call padawan#RestartServer()
```

