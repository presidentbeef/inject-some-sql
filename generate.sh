#!/bin/bash --login
set -e

#git checkout master
rm -rf tmp/
mkdir tmp
mkdir tmp/assets
rvm default gemset create iss
export RAILS_ENV=production

rvm --force default@iss gemset empty
rvm default@iss do gem install bundler
cd rails3
rvm default@iss do bundle install
rvm default@iss do bundle exec rake assets:precompile
rvm default@iss do bundle exec rake db:reset
rvm default@iss do bundle exec rake db:setup
rvm default@iss do bundle exec rails s &
sleep 10
wget -p http://localhost:3000/examples
kill %1
cp localhost\:3000/examples ../tmp/rails3.html
cp -rf localhost\:3000/assets/* ../tmp/assets/
rm -rf localhost\:3000
cd ..

echo "NOW RAILS 4"

rvm --force default@iss gemset empty
rvm default@iss do gem install bundler
cd rails4
rvm default@iss do bundle install
rvm default@iss do bundle exec rake assets:precompile
rvm default@iss do bundle exec rake db:reset
rvm default@iss do bundle exec rake db:setup
rvm default@iss do bundle exec rails s &
sleep 10
wget -p http://localhost:3000/examples
kill %1
cp localhost\:3000/examples ../tmp/rails4.html
cp -rf localhost\:3000/assets/* ../tmp/assets/
rm -rf localhost\:3000
cd ..

echo "NOW RAILS 5"

rvm --force default@iss gemset empty
rvm default@iss do gem install bundler
cd rails5
rvm default@iss do bundle install
rvm default@iss do bundle exec rails assets:precompile
rvm default@iss do bundle exec rails db:reset
rvm default@iss do bundle exec rails db:setup
rvm default@iss do bundle exec rails s &
sleep 10
wget -p http://localhost:3000/examples
kill %1
cp localhost\:3000/examples ../tmp/rails5.html
cp localhost\:3000/examples ../tmp/index.html
cp -rf localhost\:3000/assets/* ../tmp/assets/
rm -rf localhost\:3000
cd ..


git reset --hard
git checkout gh-pages
rm -rf assets
mv tmp/* .
rm -rf tmp

git add rails3.html rails4.html rails5.html assets/
echo "To deploy, add GA then:"
echo "git add rails4.html rails3.html index.html && git commit && git push"
