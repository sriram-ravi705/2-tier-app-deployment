#!/bin/bash
cd /home/ubuntu/Taskify
pm2 start index.js --name nodejs
pm2 save
pm2 flush