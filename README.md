# ProvToolbox Playground

This repository is a playground for testing [ProvToolbox](https://github.com/lucmoreau/ProvToolbox/) functionalities and checking how to use the model in my own Java code.

## Installation

I tried to build all ProvToolbox modules myself but I failed with various errors.
In the end I just build `modules-core` and `modules-executable` (until that one fails). The resulting `jars` offer every functionality I need currently.

The module mentioned above are built in a Docker container.
The `build/build.sh` script should build the Docker image if it does not exist and then build both modules in `tmp`.
Depending on the Docker installation on your machine you have to use `sudo`. This command 

```
sudo bash build/build.sh
```

The resulting `jar` files can be copied to your classpath, e.g.

```
cd /tmp/provtoolbox-build
find . -iname "*.jar*" | xargs -i cp {} ~/github/ProvToolbox-playground/libs/
```

## Usage

The only thing this repo currently does is creating some provenance metadata for the fMRI workflow used as example in the Open Provenance Challenge and output it in various formats.