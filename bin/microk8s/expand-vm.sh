#!/bin/bash

# NOTE: these steps did not really work, it increased memory but not cpu, and i had to restart things a few times
# https://github.com/canonical/multipass/issues/1158

# stop multipassd
sudo launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist

# edit /var/root/Library/Application Support/multipassd/multipassd-vm-instances.json
# you'll need sudo for that
# See sample in this directory

# start multipassd again
sudo launchctl load /Library/LaunchDaemons/com.canonical.multipassd.plist