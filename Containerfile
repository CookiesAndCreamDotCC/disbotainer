# DisBotainer (Containerfile) - DisBot container
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

# Base image source
FROM docker.io/library/ruby:alpine

# Metadata
LABEL org.opencontainers.image.title="DisBot"
LABEL org.opencontainers.image.description="Discord bot using discordrb and SQLite"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.authors="Lazy Villain"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.url="https://github.com/CookiesAndCreamDotCC/disbot"
LABEL org.opencontainers.image.source="https://github.com/CookiesAndCreamDotCC/disbotainer"

# Package requirements
RUN apk add --no-cache build-base git sqlite sqlite-dev su-exec

# Set working directory
WORKDIR /app

# Clone the DisBot source
RUN git clone --depth 1 --branch main https://github.com/CookiesAndCreamDotCC/disbot.git .

# Install the Ruby gems
RUN bundle install

# Preserve original config to use as a template
RUN mv disbot.yml disbot.yml.example

# Persistent files reside under /data
RUN mkdir /data && \
  ln -sf /data/disbot.yml /app/disbot.yml && \
  ln -sf /data/disbot.db /app/disbot.db

# Create a non-root user
RUN addgroup -S disbot && \
  adduser -S -G disbot disbot && \
  chown -R disbot:disbot /app

# Copy DisBot start script into place
COPY start_disbot.sh /usr/local/bin/start_disbot.sh
RUN chmod 755 /usr/local/bin/start_disbot.sh

# Container volume exposed to host system
VOLUME ["/data"]

# DisBot start script
ENTRYPOINT ["/usr/local/bin/start_disbot.sh"]
#CMD ["ruby", "disbot.rb"]
