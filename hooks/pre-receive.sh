#!/bin/bash

while read line
do
  oldrev=$(echo $line | awk '{print $1}')
  newrev=$(echo $line | awk '{print $2}')
done

revs=$(git rev-list ${oldrev}..${newrev})

for rev in $revs
do
  msg=$(git log -1 --format="%s" $rev)

  if echo $msg | grep -iqE "^Merge "; then
    continue
  fi;

  if echo $msg | grep -iqE "^Merge "; then
    continue
  fi;

  if echo $msg | grep -iqE "^\d{1,2}[.]\d{1,2}[.]\d{1,2}$"; then
    continue
  fi;

  if echo $msg | grep -qE "^(feat|fix|docs|style|refactor|perf|test|chore|ci)(\([^()]{1,}\)){0,1}: [a-z].*"; then
    continue
  fi;

  echo
  echo -e "INVALID COMMIT MSG: "${msg}" Does not match \"<type>(<scope>): <subject>\" !"
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

done

exit 0
