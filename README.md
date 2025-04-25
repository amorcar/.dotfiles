# .dotfiles
My personal configuration files

## Use
1. Clone this repo
```shell
cd ~
git clone https://github.com/amorcar/.dotfiles.git
```
2. Install [dotter](https://github.com/SuperCuber/dotter/releases)
```shell
cd ~/.dotfiles
wget -O dotter <dotter-binary-from-url-above>
chmod +x dotter
```
3. Create `local.toml` and configure accordingly
```shell
cp .dotter/template_local.toml .dotter/local.toml
```
4. Deploy the files
```shell
./dotter deploy -v
```

## Homebrew

- Update Brewfile:
```shell
brew bundle dump --file=mac/Brewfile --force
```
- Installed packages
```shell
brew leaves
```
- Dependencies
```shell
brew deps --tree <brewformula>
brew deps --tree -1 <brewformula>
brew deps --include-build --tree $(brew leaves)
brew leaves | xargs brew deps --include-build --tree
brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
# get packages that depend on <FORMULA>
brew uses <FORMULA> --installed
brew deps -1 --installed | grep ':.*FORMULA' | awk -F':' '{print $1}'
```
- Dependency graph
```shell
brew graph --installed | fdp -Tpng -omac/graph.png
```
- Package sizes
```shell
brew list | xargs brew info | grep Cellar
# better format
brew_sizes.sh
```
