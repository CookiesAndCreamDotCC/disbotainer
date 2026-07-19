#!/bin/sh
# DisBotainer (start_disbot.sh) - DisBot container
# Copyright (C) 2026 Lazy Villain
# https://github.com/CookiesAndCreamDotCC/disbotainer
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

set -e

# Create the configuration file on first run
if [ ! -f /data/disbot.yml ]; then
  cp /app/disbot.yml.example /data/disbot.yml
  echo
  echo "                     !!!!!!!!!!!!!!!!!!!!!!!"
  echo "                     !!! ACTION REQUIRED !!!"
  echo "                     !!!!!!!!!!!!!!!!!!!!!!!"
  echo
  echo "The DisBot configuration file has been created at: /data/disbot.yml"
  echo
  echo "Please edit this file to include your Discord bot token, server ID,"
  echo "and administrative user ID. DisBot will not run without these items."
  echo "Restart the container after configuration has been completed."
  echo
  exit 0
fi

# Ensure the database exists
touch /data/disbot.db

# Make the persistent files writable by the disbot user
chown -R disbot:disbot /data

# Run DisBot as a non-root user
exec su-exec disbot ruby /app/disbot.rb
