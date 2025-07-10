MASTODON_STYLES_DIR=/home/mastodon/live/app/javascript/styles

#cyberpunk-neon

rm $MASTODON_STYLES_DIR/mastodon-cyberpunk-neon.scss

wget -N --no-check-certificate --no-cache --no-cookies --no-http-keep-alive  https://raw.githubusercontent.com/Roboron3042/Cyberpunk-Neon/refs/heads/master/CSS/mastodon-cyberpunk-neon.css -O $MASTODON_STYLES_DIR/mastodon-cyberpunk-neon.scss

sed -i "1s/^/@use 'application';\n/" $MASTODON_STYLES_DIR/mastodon-cyberpunk-neon.scss

# bird-ui

export MASTODON_VERSION_FOR_BIRD_UI="main"

rm -rf $MASTODON_STYLES_DIR/mastodon-bird-ui

# Create a new folder for the theme
mkdir -p $MASTODON_STYLES_DIR/mastodon-bird-ui

# Download the CSS file for single column layout
wget -N --no-check-certificate --no-cache --no-cookies --no-http-keep-alive https://raw.githubusercontent.com/ronilaukkarinen/mastodon-bird-ui/$MASTODON_VERSION_FOR_BIRD_UI/layout-single-column.css -O $MASTODON_STYLES_DIR/mastodon-bird-ui/layout-single-column.scss

# Download the CSS file for multiple column layout
wget -N --no-check-certificate --no-cache --no-cookies --no-http-keep-alive https://raw.githubusercontent.com/ronilaukkarinen/mastodon-bird-ui/$MASTODON_VERSION_FOR_BIRD_UI/layout-multiple-columns.css -O $MASTODON_STYLES_DIR/mastodon-bird-ui/layout-multiple-columns.scss

# Replace theme-contrast with theme-mastodon-bird-ui-contrast for single column layout
sed -i 's/theme-contrast/theme-mastodon-bird-ui-contrast/g' $MASTODON_STYLES_DIR/mastodon-bird-ui/layout-single-column.scss

# Replace theme-mastodon-light with theme-mastodon-bird-ui-light for single column layout
sed -i 's/theme-mastodon-light/theme-mastodon-bird-ui-light/g' $MASTODON_STYLES_DIR/mastodon-bird-ui/layout-single-column.scss

# Replace theme-contrast with theme-mastodon-bird-ui-contrast for multiple column layout
sed -i 's/theme-contrast/theme-mastodon-bird-ui-contrast/g' $MASTODON_STYLES_DIR/mastodon-bird-ui/layout-multiple-columns.scss

# Replace theme-mastodon-light with theme-mastodon-bird-ui-light for multiple column layout
sed -i 's/theme-mastodon-light/theme-mastodon-bird-ui-light/g' $MASTODON_STYLES_DIR/mastodon-bird-ui/layout-multiple-columns.scss

# Create high contrast theme file
echo -e "@use 'contrast/variables';\n@use 'application';\n@use 'contrast/diff';\n@use 'mastodon-bird-ui/layout-single-column.scss';\n@use 'mastodon-bird-ui/layout-multiple-columns.scss';" > $MASTODON_STYLES_DIR/mastodon-bird-ui-contrast.scss

# Create light theme file
echo -e "@use 'mastodon-light/variables';\n@use 'application';\n@use 'mastodon-light/diff';\n@use 'mastodon-bird-ui/layout-single-column.scss';\n@use 'mastodon-bird-ui/layout-multiple-columns.scss';" > $MASTODON_STYLES_DIR/mastodon-bird-ui-light.scss

# Create dark theme file
echo -e "@use 'application';\n@use 'mastodon-bird-ui/layout-single-column.scss';\n@use 'mastodon-bird-ui/layout-multiple-columns.scss';" > $MASTODON_STYLES_DIR/mastodon-bird-ui-dark.scss

# Overwrite config/themes.yml with new settings, Mastodon Bird UI dark as default
#echo -e "mastodon-bird-ui-light: styles/mastodon-bird-ui-light.scss\nmastodon-bird-ui-contrast: styles/mastodon-bird-ui-contrast.scss\nmastodon-dark: styles/application.scss\nmastodon-light: styles/mastodon-light.scss\ncontrast: styles/contrast.scss" >> config/themes.yml



# tangerine
TANGERINE_VERSION="2.4.1"
cd /home/mastodon/estilos/TangerineUI-for-Mastodon
git checkout main
git pull --rebase
git checkout v$TANGERINE_VERSION
rm -rf $MASTODON_STYLES_DIR/tangerine*
cp -r ~/estilos/TangerineUI-for-Mastodon/mastodon/app/javascript/styles/* $MASTODON_STYLES_DIR

# limpiar estilos generados previamente
cd /home/mastodon/live
rm -rfv public/packs
RAILS_ENV=production bundle exec rails assets:precompile
