const postcssimport = require('postcss-import');
const autoprefixer = require('autoprefixer');
const tailwindcss = require('tailwindcss')

module.exports  = {
    plugins: [
        postcssimport,
        tailwindcss,
        autoprefixer,
    ],
};
