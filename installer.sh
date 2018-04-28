#!/bin/bash
# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -o errexit

scripts_dir="$(dirname "${BASH_SOURCE[0]}")"

# make sure we're running as the owner of the checkout directory
RUN_AS="$(ls -ld "$scripts_dir" | awk 'NR==1 {print $3}')"
if [ "$USER" != "$RUN_AS" ]
then
    echo "This script must run as $RUN_AS, trying to change user..."
    exec sudo -u $RUN_AS $0
fi
clear
echo ""
read -r -p "Enter your SkyHD box IP address (format = 192.168.xxx.xxx): " skyboxip
echo ""

cd /home/pi/

echo ""
echo "Installing Raspbian updates....."
echo ""
sudo apt-get update -y

echo ""
echo "Installing nodejs npm.......(approx 5 mins)"
echo ""
sudo apt-get install nodejs npm node-semver -y

echo ""
echo "Installing sky-remote-cli....."
echo ""
sudo npm install -g sky-remote-cli -y

cd /home/pi/SkyHD
echo ""
echo "Installing Broadlink BlackBean requirements.....(approx 5 mins)"
echo ""
pip install -r blackbean_requirements.txt

cd /home/pi/SkyHD

echo ""
echo "This is the end of the installation script"
echo ""
