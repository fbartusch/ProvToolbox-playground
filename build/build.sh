#! /bin/bash

build_docker_image() {
    if [ $(docker images -q fbartusch/provtoolbox-build-deps) == "" ]; then
        docker build . -t fbartusch/provtoolbox-build-deps
    fi
}

get_sources() {
    mkdir -p /tmp/provtoolbox-build && cd /tmp/provtoolbox-build
    if [ ! -d "ProvToolbox" ] ; then
        git clone --branch ProvToolbox-2.0.3 https://github.com/lucmoreau/ProvToolbox.git
    fi 
}

run_docker_build() {
    build_docker_image
    cd ProvToolbox/modules-core
    docker run --rm --volume="$(pwd)":/src --workdir=/src fbartusch/provtoolbox-build-deps mvn clean install
    cd ProvToolbox/modules-executable
    docker run --rm --volume="$(pwd)":/src --workdir=/src fbartusch/provtoolbox-build-deps mvn clean install
}

get_sources
run_docker_build
