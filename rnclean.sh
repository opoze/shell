#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>

#title           :rnclean.sh
#description     :script to clena React Native folder before run or build.
#author		       :Luis Pozenato luispoze at gmail.com
#date            :20200502
#version         :0.1
#usage		       :bash rnclean.sh

BOLD='\033[1m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
WHITE='\033[97m'

dots()
{
  while kill -0 $! >& /dev/null; do
    echo -n '.'
    sleep .2
  done
}

echo -e "\n${WHITE}${BOLD}React Native clean${NOCOLOR}\n"

if [ -d "./node_modules" ]; then
  echo -ne "${NOCOLOR}Removing node_modules folder"
  rm -rf ./node_modules >& /dev/null &
  dots
  echo -e "${GREEN} done.${NOCOLOR}"
else
  echo -e "${GREEN}node_modules folder not found, skipping remove.${NOCOLOR}"
fi

if [ -f "./package.json" ]; then
  echo -ne "${NOCOLOR}Yarn install"
  yarn -s install >& /dev/null &
  dots
  echo -e "${GREEN} done.${NOCOLOR}"
else
  echo -e "${GREEN}package_json file not found, skipping yarn install${NOCOLOR}"
fi

if [ -d "./ios" ]; then
  cd ios
  if [ -d "Pods" ]; then
    echo -ne "${NOCOLOR}Removing Pods folder"
    rm -rf ./Pods >& /dev/null &
    dots
    echo -e "${GREEN} done.${NOCOLOR}"
  else
      echo -e "${GREEN}Pods folder not found, skipping remove.${NOCOLOR}"
  fi
  if [ -f "Podfile.lock" ]; then
    echo -ne "${NOCOLOR}Removing Podfile.lock file"
    rm ./Podfile.lock >& /dev/null &
    dots
    echo -e "${GREEN} done.${NOCOLOR}"
  else
    echo -e "${GREEN}Podfile.lock file not found, skipping remove.${NOCOLOR}"
  fi
  if [ -f "./Podfile" ]; then
    echo -ne "${NOCOLOR}Installing Pods"
    pod install >& /dev/null &
    dots
    echo -e "${GREEN} done.${NOCOLOR}"
  else
    echo -e "${GREEN}Podfile folder not found, skipping pod install.${NOCOLOR}"
  fi
else
  echo -e "${GREEN}ios folder not found, skipping pods clean.${NOCOLOR}"
fi

echo -e "\n${WHITE}${BOLD}React Native clean complete. ${GREEN}Have a nice day!${NOCOLOR}\n"