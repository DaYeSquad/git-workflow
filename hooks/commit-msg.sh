#!/bin/bash

# 将文件置于.git/hooks/下, 去掉.sh后缀，并修改权限为755

msg=$(head -n 1 $1)

if echo $msg | grep -iqE "^Merge "; then
  exit 0
fi;

if echo $msg | grep -iqE "^Revert "; then
  exit 0
fi;

if echo $msg | grep -iqE "^\d{1,2}[.]\d{1,2}[.]\d{1,2}$"; then
  exit 0
fi;

if echo $msg | grep -iqE "^(feat|fix|docs|style|refactor|perf|test|chore|ci)(\([^()]{1,}\)){0,1}: [a-z].*"; then
  exit 0
fi;

echo
echo -e "\033[41mINVALID COMMIT MSG:\033[0m Does not match \"<type>(<scope>): <subject>\" !"
echo
cat <<EOF
Available types and what it mean are list here

  feat:     A new feature
  fix:      A bug fix
  docs:     Documentation only changes
  style:    Changes that do not affect the meaning of the code
            (white-space, formatting, missing semi-colons, etc)
  refactor: A code change that neither fixes a bug or adds a feature
  perf:     A code change that improves performance
  test:     Adding missing tests
  chore:    Changes to the build process or auxiliary tools
            and libraries such as documentation generation
  ci:       Changes to our CI configuration files and scripts 
            (example scopes: Travis, Circle, BrowserStack, SauceLabs)

EOF
echo -e "Please read https://github.com/DaYeSquad/git-workflow/blob/master/commit.md"
echo

exit 1
