# MLops_CI-CD_AWS_Lambda_Kinesis

# Introduction

 this project contains two parts:
 - CI(continue integration:model test)
 - CD(continue development:model development)

 These two parts are controle by Github Actions

1.
```bash
pip install pre-commit
```
2.
```bash
pre-commit sample-config > .pre-commit-config.yaml
```
3.
```bash
pre-commit install
```
4.
```bash
pre-commit run --all-files
```

In the git directory,run `git status`, it will show the all the commits, and you could add one or more files into `.ignore` for avoiding commitment

when you are in the step`git commit -m 'initial commit'`, it will run pre-commit automatically.

`git diff` to see what has been changed
`git add .`
`git commit -m 'fixes from pre-commit default' `
