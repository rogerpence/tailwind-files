# Tailwind install files

This repo includes files needed for a scripted Tailwind install on either Windows or Ubuntu.

This install uses PostCSS to install and purge Tailwind.

## Files in this repository

### Powershell script to install Tailwind on Windows

    install-tailwind.ps1

### Bash script to install Tailwind on Ubuntu

    install-tailwind.sh

Run the scripts from the root of your project. Both scripts install all NPM packages as local packages.

### Files for Tailwind install.

These files are all referenced in the install scripts.

* `index.html`
* `postcss.config.js`
* `tailwind.base.css`
* `tailwind.components.css`
* `tailwind.utilities.css`
* `tailwind.main.css`


## Steps to install Tailwind:

This install creates `dist`, `tailwind`, and `src` directories in your project's root. You can change those names if necessary.

(`-->` denotes a new line for publication purpose. Remove the `-->` and the newline for copy/paste).

1. Create a `package.json` file if necessary.

        npm init -y

2. Install these NPM packages as dev dependencies (--save-dev).

        tailwindcss autoprefixer postcss-cli -->
        postcss-import cross-env @rogerpence/edit-package-json

3. Make a `tailwind` directory off the root.

4. Create an empty Tailwind config file in `tailwind` directory.

        npx tailwind init

5. Create a full Tailwind config file for reference in `tailwind` directory.

        npx tailwind init tailwind.config.reference.js --full

6. Create empty Tailwind custom CSS files in the `tailwind` directory.

        my.tailwind.utities.css
        my.tailwind.components.css

    You'll later add most of your custom CSS and your own Tailwind utilities and components in these files.

7. Fetch `tailwind.main.css` (from this repository) into the `tailwind` directory.

8. Fetch `postcss.config.js` (from this repository) into the project root.

9. Create a `src` directory in the project root.

10. Fetch `index.html` (from this repository) into the `src` directory.

11. Add a `tailwind:dev` key to the `package.json` `scripts` key to compile Tailwind for dev work.

        cross-env NODE_ENV=development postcss -->
        ./tailwind/tailwind.main.css -->
        -o ./dist/css/tailwind.css

12. Compile Tailwind for development:

        npm run tailwind:dev

    The full `tailwind.css` is created in the `dist` directory.

