#!/bin/bash

# Clolorized Echo Output

RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e -n "Do you want to build new ${BLUE}DOCKER CONTAINER${NC} {Press Y or N} and then press [ENTER}: "
read BUILD_STATUS

if [[ "$BUILD_STATUS" == "Y" ]] || [[ "$BUILD_STATUS" == "y" ]] || [[ "$BUILD_STATUS" == "yes" ]] ; then 

   echo -e -n "Building and running ${CYAN}NEW${NC} docker image...\n"

   ################################
   #        Clone Repository      #
   ################################

   if [ -d "openvino" ]; then rm -Rf openvino; fi

   git clone --branch=3.334 --depth=1 https://yi-israel:Xuna7421@bitbucket.org/yi-israel/openvino/

   cd openvino

   ### Remove password from config file

   git remote set-url origin https://yi-israel@bitbucket.org/yi-israel/openvino/


   #################################################
   #        Build Docker Image & Run Container     #
   #################################################

   docker-compose -f docker-compose.yml up -d --build

fi

if [[ "$BUILD_STATUS" == "N" ]] || [[ "$BUILD_STATUS" == "n" ]] || [[ "$BUILD_STATUS" == "no" ]] ; then

   echo -e -n "Running ${GREEN}existing${NC} docker image...\n"

   docker-compose -f docker-compose.yml up -d

fi

if [[ "$BUILD_STATUS" == "" ]]; then

   echo -e -n "No ${YELLOW}input${NC}, script ${RED}exiting!!${NC}\n"

   exit

fi