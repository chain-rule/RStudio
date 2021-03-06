# RStudio

The repository provides a scaffold for building a Docker image for running
[RStudio].

## Local

### Installation

```sh
# Build a Docker image:
make build

# Create an alias for convenience:
make alias >> ~/.zshrc
```

### Usage

```sh
# Go to an arbitrary directory:
cd /path/to/some/project

# Start a container:
rstudio
```

## Cloud

### Installation

```sh
# Build a Docker image and push to Container Registry:
make -f Makefile.cloud build

# Create an alias for convenience:
make -f Makefile.cloud alias >> ~/.zshrc
```

### Usage

```sh
# Create a virtual machine in Compute Engine:
rstudio create

# Start the machine:
rstudio start

# Open a shell:
rstudio shell

# Open the web interface:
open http://localhost:8787

# Suspend the machine:
rstudio suspend

# Resume the machine:
rstudio resume

# Stop the machine:
rstudio stop

# Delete the machine:
rstudio delete
```

[RStudio]: https://www.rstudio.com/
