#!/usr/bin/env sh
# abort on errors
set -e

# build
git clone --branch gh-pages "https://${BOT_USER}:${BOT_TOKEN}@github.com/usnistgov/viz-nist-portal.git" /tmp/dist

npm install -g @vue/cli
yarn run build
# navigate into the build output directory
cp -r dist/* /tmp/dist/
# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME
cd /tmp/dist
git add -A
git commit -m "deployed at ${DATA_TIMESTAMP}"
git push -f origin master:gh-pages
cd -
