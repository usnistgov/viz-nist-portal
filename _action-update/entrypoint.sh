#!/bin/sh -l

set -eu

# Check hub installation
hub version

# Requires BRANCH_NAME, BOT_USER, BOT_TOKEN to be included by workflow
export GITHUB_API_TOKEN=$BOT_TOKEN
export DATA_TIMESTAMP=$(date -u "+%F-%H")

# Configure git + hub
git config --global user.name "${BOT_USER}"
git config --global user.email "${BOT_USER}@users.noreply.github.com"
git config --global hub.protocol https

# Get latest copy of repository
# git clone --no-single-branch "https://${BOT_USER}:${BOT_TOKEN}@github.com/usnistgov/viz-nist-portal.git"
# cd viz-nist-portal
# REPO_ROOT=$(pwd)

# Checkout data update branch, creating new if necessary
# git checkout $BRANCH_NAME || git checkout -b $BRANCH_NAME
# git merge --no-edit master

# Run MASTER script
#./deploy.sh

git clone --branch master "https://${BOT_USER}:${BOT_TOKEN}@github.com/usnistgov/viz-nist-portal.git" /tmp/repo
git clone --branch gh-pages "https://${BOT_USER}:${BOT_TOKEN}@github.com/usnistgov/viz-nist-portal.git" /tmp/dist

cd /tmp/repo
ls -al /tmp/repo

#npm install -g @vue/cli
yarn install
yarn run build > /dev/null
# navigate into the build output directory
sed -i "s#href=/#href=./#g" dist/index.html
sed -i "s#src=/#src=./#g" dist/index.html
cp -r dist/* /tmp/dist/
cp data.json /tmp/dist/
# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

cd /tmp/dist
git add -A
git commit -m "deployed at ${DATA_TIMESTAMP}"
git push -f origin gh-pages
cd -

exit 0
