# My Dotvim

Since Version 8 of Vim, the *package* (*pack*) feature has made it easy to
install plugins without relying on a plugin manager such as *vundle*.
Nevertheless managing the plugins by hand or manually written scripts to keep
all the git repos up-to-date is tedious. Therefore the plugin **minpac** (*minimal
package manager*) has been introduced, which adds more convenient handling.

This fact has been incorporated within the last update.

Please have a look into the **.vimrc** file for more information.

## Installation

Unix based:
```
git clone git://github.com/git-man/dotvim.git ~/.vim
```
Windows based:
```
git clone git://github.com/git-man/dotvim.git %HOME%\.vim
```

### Setup minpac

Before starting (G)Vim some "bootstrapping" for *minpac* need to be done.

In the just created `.vim` directory:

```
mkdir -p pack/minpac/opt
cd pack/minpac/opt
git clone https://github.com/k-takata/minpac.git
```

### Create symlinks to finalize the installation

Unix based:
```
ln -s ~/.vim/.vimrc ~/.vimrc
(Optional) ln -s ~/.vim/.gvimrc ~/.gvimrc
```
Windows based:
```
mklink <link to .vimrc> <target .vimrc>
```

## FAQs

> Problems on connection --\> Proxy?

Set it in git:
```
git config --global http.proxy http://<proxyhost>:<proxyport>
git config --global https.proxy http://<proxyhost>:<proxyport>
```

Set it in cmd and start gVim after it in this session:
```
set http_proxy=http://proxy.<company>.de:81
set set https_proxy=http://proxy.<company>.de:81
```

https instead of git urls:
```
git config --global url.https://github.com/.insteadOf git://github.com/
```


## License

Distributed under the same terms as Vim itself.
See `:help license` in Vim.
