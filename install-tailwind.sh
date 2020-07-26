if [ ! -f package.json ]; then
    npm init -y
fi

npm install --save-dev tailwindcss autoprefixer postcss-cli postcss-import cross-env @rogerpence/edit-package-json

if [ ! -d tailwind ]; then
    mkdir tailwind
fi
cd tailwind
npx tailwind init
npx tailwind init tailwind.config.reference.js
touch my.tailwind.utilities.css my.tailwind.components.css
curl "https://raw.githubusercontent.com/rogerpence/tailwind-files/main/tailwind.main.css" --output tailwind.main.css
cd ..

curl "https://raw.githubusercontent.com/rogerpence/tailwind-files/main/postcss.config.js" --output postcss.config.js

if [ ! -d src ]; then
    mkdir src
fi
curl "https://raw.githubusercontent.com/rogerpence/tailwind-files/main/index.html" --output src/index.html

npx editPackageJson -k "tailwind:dev" -v '"cross-env NODE_ENV=development postcss ./tailwind/tailwind.main.css -o ./dist/css/tailwind.css"'

npm run tailwind:dev

# Change firefox referenc to launch browser on your system.
/opt/firefox-dev/firefox file:///home/roger/Projects/install-tailwind/test-install/src/index.html