FROM ubuntu:24.04

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install pixi
RUN curl -fsSL https://pixi.sh/install.sh | PIXI_NO_PATH_UPDATE=1 bash
ENV PATH="/root/.pixi/bin:${PATH}"

WORKDIR /root/dotfiles
COPY . .

RUN pixi run setup
RUN pixi run test

CMD ["bash", "-c", "eval \"$(pixi shell-hook)\" && zsh -i"]
