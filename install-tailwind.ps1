#!/usr/bin/env pwsh
# On Linux:
# Put install-tailwind.ps1 in
# sudo cp install-tailwind.sh /usr/local/bin
# sudo cp install-tailwind.ps1 /usr/local/bin
# sudo chmod +x /usr/local/bin/install-tailwind.sh
# sudo chmod +x /usr/local/bin/install-tailwind.ps1
# $ install-tailwind.ps1

# Change this value if you want tailwind.css and the index.html file
# in a different folder.
$devDirectory = 'dev'

write-host Installing Tailwind -foregroundcolor green
# Create package.json if necessary.
if (-not (Test-Path package.json -PathType Leaf)) {
    npm init -y | out-null
}
# Install Node modules.
npm install --save-dev tailwindcss autoprefixer postcss-cli postcss-import cross-env @rogerpence/edit-package-json
# Create Tailwind directory if necessary.
if (-not(Test-Path -Path "tailwind")) {
    new-item tailwind -itemtype directory | out-null
}
# Change to tailwind directory.
set-location tailwind
# Create emtpy Tailwind config file.
npx tailwind init | out-null
# Create fully-populated Tailwind config file for reference use.
npx tailwind init tailwind.config.reference.js ---full | out-null
# Create empty tailwind.base.css, tail.components.css, and tailwind.utilities.css files.
new-item my.tailwind.utilities.css, my.tailwind.components.css | out-null
# Fetch tailwind.main.css file.
invoke-webrequest -Uri "https://raw.githubusercontent.com/rogerpence/tailwind-files/main/tailwind.main.css" -Outfile tailwind.main.css
# Back to root.
set-location ..
# Fetch postcss.config.js file.
invoke-webrequest -Uri "https://raw.githubusercontent.com/rogerpence/tailwind-files/main/postcss.config.js" -Outfile .\postcss.config.js
# Create $devDirectory directory if necessary.
if (-not(Test-Path -Path $devDirectory)) {
    new-item $devDirectory -itemtype directory | out-null
}
# Fetch index.html file.
invoke-webrequest -Uri "https://raw.githubusercontent.com/rogerpence/tailwind-files/main/index.html" -Outfile .\$devDirectory\index.html

# Add script key to compile tailwind.
# editPackageJson swaps out plus signs (+) for spaces.
$scriptValue = "cross-env+NODE_ENV=development+postcss+./tailwind/tailwind.main.css+-o+./$($devDirectory)/css/tailwind.css"
npx editPackageJson -k "tailwind:dev" -v $scriptValue --out-null

# Create tailwind css file.
npm run tailwind:dev
write-host ------------------------------------------------ -foregroundcolor green
write-host Tailwind installed. Version shown below. -foregroundcolor green
write-host tailwind.css created in dist/css. -foregroundcolor green
write-host Launch $devDirectory/index.html to see Tailwind in action. -foregroundcolor green
write-host ------------------------------------------------ -foregroundcolor green
npx tailwind --version
# Launch index.html with default browser.
# $IsWindows and $IsLinux are PowerShell 7 only.

if ($IsWindows) {
    write-host running windows browser
    Start-Process "$($pwd)/$($devDirectory)/index.html"
}
elseif ($IsLinux) {
    xdg-open "$($pwd)/$($devDirectory)/index.html"
}
else {
    # On the Mac. Do something here.
}

# Use just these two lines for PowerShell 5.
# write-host running windows browser
# Start-Process "$($pwd)/$($devDirectory)/index.html"
