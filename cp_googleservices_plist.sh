# Use appropriate local file as per configuration
GOOGLE_SERVICE_PLIST_FILE=GoogleService-Info.plist
if [ $CONFIGURATION = "Debug" ];  then
    GOOGLE_SERVICE_PLIST_FILE=GoogleService-Info-Debug.plist
else [ $CONFIGURATION = "Staging" ];
    GOOGLE_SERVICE_PLIST_FILE=GoogleService-Info-Staging.plist
fi
# If file exist then source it or show error
FILE_PATH="${PROJECT_DIR}/Application/Resources/Firebase/${GOOGLE_SERVICE_PLIST_FILE}"
echo $FILE_PATH
if [ -f "$FILE_PATH" ]; then
    echo "Copying ${FILE_PATH} file for `${CONFIGURATION}` Configuration "
    cp -r ${FILE_PATH} "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
    exit 0
else 
    echo "warning: ${FILE_PATH} does not exist."
    echo "error: Provide ${FILE_PATH} file in project Resources/Firbase directory"
    exit -99
fi

