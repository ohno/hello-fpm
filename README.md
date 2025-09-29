# hello-fpm
[![CI](https://github.com/ohno/hello-fpm/actions/workflows/ci.yml/badge.svg)](https://github.com/ohno/hello-fpm/actions/workflows/ci.yml)

Install [Git](https://git-scm.com/downloads/linux), [GitHub CLI](https://github.com/cli/cli#installation), [fpm](https://fpm.fortran-lang.org/install/index.html#install)
on Ubuntu (WSL, Windows) and configure the following:
```sh
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config --global init.defaultBranch main
gh auth login
```

Check that these are installed:
```sh
git --version
gh --version
fpm --version
```

Create a new fpm project:
```sh
fpm new hello-fpm
cd hello-fpm
# Fix fpm.toml by hand
git add .
git commit -m "Initial commit"
git branch -m master main
gh repo create hello-fpm --public --source=. --remote=origin --push
```

Fix fpm.toml, Add .gitignore, Add LICENSE, Add .github/workflows/ci.yml, Add a workflow status badge:
```sh
sed -i '/default/d' fpm.toml
git add fpm.toml
git commit -m "Fix fpm.toml"

gh api /gitignore/templates/Fortran --jq '.source' > .gitignore
git add .gitignore
git commit -m "Add .gitignore"

gh api /licenses/mit --jq .body > LICENSE
# Fix LICENSE by hand
git add LICENSE
git commit -m "Add LICENSE"

mkdir -p .github/workflows && printf '%b' 'name: CI\non: [push, pull_request]\njobs:\n  test:\n    runs-on: ubuntu-latest\n    steps:\n      - uses: actions/checkout@v4\n      - uses: fortran-lang/setup-fpm@v7\n        with:\n          github-token: ${{ secrets.GITHUB_TOKEN }}\n      - run: fpm test\n' > .github/workflows/ci.yml
git add .github/workflows/ci.yml
git commit -m "Add ci.yml"

sed -i '/My cool new project!/d' README.md
echo "[![CI](https://github.com/$(gh api user --jq .login)/$(basename -s .git $(git config --get remote.origin.url))/actions/workflows/ci.yml/badge.svg)](https://github.com/$(gh api user --jq .login)/$(basename -s .git $(git config --get remote.origin.url))/actions/workflows/ci.yml)" >> README.md
# Fix URL by hand
git add README.md
git commit -m "Update README.md"

git push
```

Rewrite some lines yourself:
https://github.com/ohno/hello-fpm/blob/e09cd27911cb56c1991450e0e9396be990cd7b21/README.md?plain=1#L2
https://github.com/ohno/hello-fpm/blob/54a753d390a02cfeafa796a1aeb9d66778c0bc40/LICENSE#L3
https://github.com/ohno/hello-fpm/blob/54a753d390a02cfeafa796a1aeb9d66778c0bc40/fpm.toml#L2-L6
