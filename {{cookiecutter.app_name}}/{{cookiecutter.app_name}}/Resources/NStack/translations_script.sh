TL_PROJ_ROOT_FOLDER="App"
TL_GEN_PATH="${SRCROOT}/${TL_PROJ_ROOT_FOLDER}/Resources/NStack/nstack-localizations-generator.bundle"
TL_CONFIG_PATH="${SRCROOT}/${TL_PROJ_ROOT_FOLDER}/Resources/NStack/NStack.plist"
TL_OUT_PATH="${SRCROOT}/${TL_PROJ_ROOT_FOLDER}/Resources/NStack/Translations"

# Check if doing a clean build
if test -f "${DERIVED_FILE_DIR}/LocalizationsGenerator.lock"; then
echo "Not clean build, won't fetch localizations this time."
else
echo "Clean build. Getting localizations..."
"${TL_GEN_PATH}/Contents/MacOS/nstack-localizations-generator" -plist "${TL_CONFIG_PATH}" -output "${TL_OUT_PATH}"
touch "${DERIVED_FILE_DIR}/LocalizationsGenerator.lock" # create lock file
fi
