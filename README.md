DisBotainer 🦭
===========

[![Discord](https://img.shields.io/discord/1347049108665532519?style=plastic&label=Discord)](https://discord.cookiesandcream.cc/)

### About
[Docker](https://www.docker.io/) / [Podman](https://podman.io/) container for [DisBot](https://github.com/CookiesAndCreamDotCC/disbot)

### Requirements
* a Discord account, bot application, and bot token (described in the installation steps [here](https://github.com/CookiesAndCreamDotCC/disbot/blob/main/README.md))
* [Docker](https://www.docker.io/) >=23.0 or [Podman](https://podman.io/) >=5.0 ([Buildah](https://buildah.io/) >=1.33.0) for Dockerfile/Containerfile heredoc support

### Installation
1. Install Docker or Podman:
    1. For Docker, see https://docs.docker.com/engine/install/ for Debian, Fedora, RHEL, and Ubuntu installation instructions.
    2. For Podman:
        * Debian/Mint/Ubuntu: `apt install podman`
        * Alma/Fedora/RHEL/Rocky: `dnf install podman`
        * Arch/Manjaro: `pacman -S podman`

2. Clone this repository:
* `git clone --depth 1 --branch main https://github.com/CookiesAndCreamDotCC/disbotainer.git`

3. Build the image:
    * Docker: `docker build -f Containerfile -t disbot .`
    * Podman: `podman build -t disbot .`

### Running the Container
1. Create the data directory which will contain the DisBot database (`disbot.db`) and configuration file (`disbot.yml`):
    * `mkdir disbotdata`

2. Initialize the container:
    * Docker: `docker run --rm -v ./disbotdata:/data disbot`
    * Podman: `podman run --rm -v ./disbotdata:/data disbot`

3. Configure `disbotdata/disbot.yml` to your liking. Be sure to add the bot token that was generated from the Discord developer portal, the server ID, and the ID of the user who is the bot administrator.

4. Run the container:
    * Docker: `docker run -d --name disbot --restart unless-stopped -v ./disbotdata:/data disbot`
    * Podman: `podman run -d --name disbot --restart unless-stopped -v ./disbotdata:/data disbot`

5. Check if the container is running:
    * Docker: `docker ps -a`
    * Podman: `podman ps -a`

### Support
To report bugs or request features, you can [submit an issue](https://github.com/CookiesAndCreamDotCC/disbotainer/issues).

You can also [join the Cookies & Cream Discord server](https://discord.cookiesandcream.cc/) if you need assistance. Please use the #development channel.
