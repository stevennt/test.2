#!/bin/bash

# Set the repository name and folder name
REPO_NAME=<repository_name>
FOLDER_NAME=<folder_name>

# Set the remote repository URL
REMOTE_URL=$(git config --get remote.origin.url)
REMOTE_URL_WITH_CREDENTIALS="${REMOTE_URL/github.com/$GITHUB_USERNAME:$GITHUB_TOKEN@github.com}"

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

# Initialize an empty Git repository
git init

# Clone only the "master" branch of the remote repository into the temporary directory
git remote add origin $REMOTE_URL_WITH_CREDENTIALS
git fetch --depth=1 origin master
git checkout origin/master

# Create the folder to push
mkdir $FOLDER_NAME

# Copy the contents of the local folder into the new folder
cp -r /path/to/local/folder/* $FOLDER_NAME/

# Stage and commit the new folder
git add $FOLDER_NAME
git commit -m "Add $FOLDER_NAME"

# Push the new folder to the remote repository
git push origin master

# Clean up the temporary directory
cd ..
rm -rf $TEMP_DIR

