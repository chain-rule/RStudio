# RStudio

The repository provides a scaffold for building a Docker image for running
[RStudio].

## Installation

Build a Docker image:

```sh
make build
```

Create an alias `rstudio` for starting a container:

```sh
make alias
```

Restart the shell.

## Usage

Go to an arbitrary directory and use the `rstudio` alias:

```sh
cd /path/to/some/project
rstudio
```

[RStudio]: https://www.rstudio.com/
