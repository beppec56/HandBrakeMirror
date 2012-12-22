#!/bin/bash

URL=`git remote -v | grep fetch | awk '{print $2}'`
SVNREL=`git log -1 | grep git-svn-id |sed 's/^.*@//g' | sed 's/ .*$//g'` 
GITREL=`git log -1  --pretty=format:" %h"` 
UUID=`git log -1 | grep git-svn-id | awk '{print $3}'`
AUTHOR=`git log -1 --pretty=format:"%an"`
DATE=`git log -1 --pretty=format:" %ci (%cd)"`
BRANCH=`git branch --contains $GITREL | grep "\*" |awk '{print $2}'`

echo "Path: ."
echo "URL: $URL"
echo "Repository Root: $URL"
echo "Repository UUID: $UUID"
echo "Revision: $GITREL"
echo "Node Kind: directory"
echo "Schedule: normal"
echo "Last Changed Author: $AUTHOR"
echo "Last Changed Rev: $SVNREL"
echo "Last Changed Date: $DATE"
echo "Branch: $BRANCH"
