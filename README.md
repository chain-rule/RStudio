# RStudio

The repository provides a scaffold for building a Docker image for running
[RStudio].

## Local

### Installation

```sh
# Build a Docker image:
make build

# Create an alias for convenience:
make alias
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
make -f Makefile.cloud alias
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
open http://localhost:8080

# Stop the machine:
rstudio stop

# Delete the machine:
rstudio delete
```

[RStudio]: https://www.rstudio.com/
