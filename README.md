# jenkins-git-credential-helper

create `GIT_ASKPASS` file for easier cloning https private repo.


## Usage

``` sh

# optional, default use `$USERNAME` and `$PASSWORD`
# CRED_USERNAME=<username>
# CRED_PASSWORD=<password>

git clone --depth 1 --branch v0.1.0 https://github.com/ctuu/jenkins-git-credential-helper.git
. ./jenkins-git-credential-helper/run.sh

# git clone some https private repo
```


## Reference

[[JENKINS-28335] - Git username and password binding (GSoC 2021)](https://github.com/jenkinsci/git-plugin/pull/1104)
