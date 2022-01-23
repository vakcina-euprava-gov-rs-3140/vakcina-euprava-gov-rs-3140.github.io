#!/bin/bash
#github_user=$1
#github_url="https://github.com/vakcina-euprava-gov-rs-3136/vakcina-euprava-gov-rs-3136.github.io"

dirname=${PWD##*/}
github_user=$( echo $dirname | cut -d "." -f1 )
github_url="https://github.com/"$github_user"/"$github_user".github.io/"

sudo rm -r .git
echo 'Please start tor service and enable terminal tor proxying with the following command: '
echo "sudo service tor restart && . torsocks on"
read -p "Is tor enabled on this terminal?"
sudo service tor restart && . torsocks on
sleep 3
curl icanhazip.com

echo "Username: "
echo $github_user
echo "Repository URL: "
echo $github_url
echo "Please input personal token: "
read personal_token

git init
git config user.name $github_user
git config user.password $personal_token
git config credential.helper store

git remote add origin $github_url
git add -A
git branch -M main
git commit -m 'Test'
git push -f -u origin main

echo "Deleting .git folder"
sudo rm -r .git