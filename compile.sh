# normal stuff
mkdir -p js
cp package.json js
cp .gitignore js
# app directory
coffee -bco js/app app
cp -r app/views/* js/app/views
# assets and public directory
cp -r assets/* js/assets
cp -r public/* js/public
# bin, config, and lib directories
coffee -bco js/bin bin
coffee -bco js/config config
coffee -bco js/lib lib
