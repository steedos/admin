#!/bin/bash
meteor build --server http://192.168.0.10:3000 --directory .build
cd .build/bundle/programs/server
npm install
#cd ../../../
#pm2 startOrRestart pm2.json
