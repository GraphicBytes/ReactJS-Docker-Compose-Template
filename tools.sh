#!/bin/bash

while true; do
  echo " "
  echo " "
  echo "############################"
  echo " "
  echo "      THE BODACH SHOW"
  echo "        SHELL TOOLS"
  echo " "
  echo "############################"
  echo " "
  branchName=$(git rev-parse --abbrev-ref HEAD)
  echo "Current Branch: $branchName"
  echo " "
  echo "Select an option:"
  echo " "
  echo "1. Cancel/Close"
  echo "2. Build Development web apps"
  echo "3. Build Staging web apps"
  echo "4. Build Production web apps"
  echo "5. Start/Reboot docker container in development mode"
  echo "6. Start/Reboot docker container in staging mode"
  echo "7. Start/Reboot docker container in production mode"
  echo "8. Git pull changes"
  echo "9. Git push changes to current branch"
  echo "10. Shut down container"
  echo " Shut down container"
  read -p "Enter option (1 to 10): " option

  case $option in
  1)
    echo " "
    echo "Operation cancelled. Bye Ó_ó"
    echo " "
    break
    ;;
  2)
    echo " "
    echo "Building development app"
    rm -r node_modules
    npm install
    npm run build-development  
    rm -r node_modules
    echo " "
    break
    ;;
  3)
    echo " "
    echo "Building staging app"
    rm -r node_modules
    npm install
    npm run build-staging  
    echo " "
    break
    ;;
  4)
    echo " "
    echo "Building production app"
    rm -r node_modules
    npm install
    npm run build-production 
    echo " "
    break
    ;;
  5)
    echo " "
    echo "Launch docker container into development environment?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.react.development down
      rm -r node_modules
      npm install
      npm run build-development  
      rm -r node_modules
      rm -r package-lock.json
      docker-compose --env-file .env.react.development up -d --build
      docker image prune -f
    fi
    ;;
  6)
    echo " "
    echo "Launch docker container into staging environment?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.react.staging down
      rm -r node_modules
      npm install
      npm run build-staging  
      rm -r node_modules
      rm -r package-lock.json
      docker-compose --env-file .env.react.staging up -d --build
      docker image prune -f
    fi
    ;;
  7)
    echo " "
    echo "Launch docker container into production environment?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      docker-compose --env-file .env.react.production down
      rm -r node_modules
      npm install
      npm run build-production  
      rm -r node_modules
      rm -r package-lock.json
      docker-compose --env-file .env.react.production up -d --build
      docker image prune -f
    fi
    ;;
  8)
    echo " "
    branchName=$(git rev-parse --abbrev-ref HEAD)
    echo "Current Branch: $branchName"
    echo " "
    echo "Pull all changes for this branch?"
    echo " "
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      git reset --hard
      git pull --all
    fi
    ;;
  9)
    echo " "
    echo "Push changes to git?"
    branchName=$(git rev-parse --abbrev-ref HEAD)
    echo "Current Branch: $branchName"
    read -p "Confirm [y/n]: " confirmation

    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      echo "Select an option for your commit message:"
      echo "1. Use default message ('Primary Dev Update')"
      echo "2. Enter a custom message"
      read -p "Enter option (1 or 2): " msgOption

      if [ "$msgOption" = "1" ]; then
        commitMessage="Primary Dev Update"
      elif [ "$msgOption" = "2" ]; then
        read -p "Enter your custom commit message: " customMessage
        commitMessage="$customMessage"
      else
        echo "Invalid option selected. Exiting."
        break
      fi

      git add --all
      git commit -m "$commitMessage"
      git push --all
    fi
    ;;
  10)
    echo " "
    echo "Shut down container?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" != "y" ]; then
      echo "Operation cancelled."
      continue
    else
      currentBranch=$(git rev-parse --abbrev-ref HEAD)
      if [ "$currentBranch" = "master" ]; then
        docker-compose --env-file .env.react.development down
      elif [ "$currentBranch" = "production" ]; then
        docker-compose --env-file .env.react.production down
      else
        echo " "
        echo "Must be in one of the 3 main git Branches."
        echo " "
        break
      fi
    fi
    ;;
  *)
    echo "Invalid option selected. Exiting."
    ;;
  esac
done
