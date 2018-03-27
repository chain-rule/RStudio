# RStudio

A Docker image for running [RStudio] without installing anything locally.


## Installation

```bash
make image
```

```bash
echo "alias rstudio='make -f \"${PWD}/Makefile\" root=\"\${PWD}\"'" >> ~/.bash_profile
```

## Usage

```bash
cd /my/project
rstudio
```

[RStudio]: https://www.rstudio.com/
