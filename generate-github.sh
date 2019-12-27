#!/bin/bash --login
set -e -x

if [ ${GITHUB_REF##*/} = "gh-pages" ]
then
  exit
fi

rm -rf tmp/
mkdir tmp
mkdir tmp/assets

export RAILS_ENV=production

gem install bundler -v"1.17.3"

cd rails3
bundle install --jobs 4 --retry 3
bundle exec rake assets:precompile
bundle exec rake db:reset
bundle exec rake db:setup
bundle exec rails s &
sleep 10
wget -p http://localhost:3000/examples
kill %1
cp localhost\:3000/examples ../tmp/rails3.html
cp -rf localhost\:3000/assets/* ../tmp/assets/
rm -rf localhost\:3000
cd ..

echo "NOW RAILS 4"

cd rails4
bundle install --jobs 4 --retry 3
bundle exec rake assets:precompile
bundle exec rake db:reset
bundle exec rake db:setup
bundle exec rails s &
sleep 10
wget -p http://localhost:3000/examples
kill %1
cp localhost\:3000/examples ../tmp/rails4.html
cp -rf localhost\:3000/assets/* ../tmp/assets/
rm -rf localhost\:3000
cd ..

echo "NOW RAILS 5"

cd rails5
bundle install --jobs 4 --retry 3

export DISABLE_DATABASE_ENVIRONMENT_CHECK=1
RAILS_ENV=production bundle exec rails assets:clobber
RAILS_ENV=production bundle exec rails assets:precompile
rails db:environment:set RAILS_ENV=production
RAILS_ENV=production bundle exec rails db:reset
RAILS_ENV=production bundle exec rails db:setup
RAILS_ENV=production bundle exec rails s &
sleep 10
wget -p http://localhost:3000/examples
kill %1
cp localhost\:3000/examples ../tmp/rails5.html
cp localhost\:3000/examples ../tmp/index.html
cp -rf localhost\:3000/assets/* ../tmp/assets/
rm -rf localhost\:3000
cd ..

echo "Checking results"
test -f tmp/index.html
test -f tmp/rails3.html
test -f tmp/rails4.html
test -f tmp/rails5.html

if [ ${GITHUB_REF##*/} = "master" ]
then
  git reset --hard
  git checkout gh-pages
  rm -rf assets
  mv tmp/* .
  rm -rf tmp

  git config --local user.email "action@github.com"
  git config --local user.name "GitHub Action"

  git add index.html rails3.html rails4.html rails5.html assets/
  git -c user.name="GitHub Actions" -c user.email="noreply@github.com" commit \
          --author="github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>" \
          -m "Automated build at $(date -u)"

  repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${$GITHUB_REPOSITORY}.git"
  git push $repo gh-pages

  echo "Pushed changes to site"
else
  echo "Build appears to have succeeded"
fi
