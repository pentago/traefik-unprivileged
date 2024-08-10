# Unprivileged Traefik Container Image

[![Main CI](https://github.com/pentago/traefik-rootless/actions/workflows/main.yaml/badge.svg)](https://github.com/pentago/traefik-rootless/actions/workflows/main.yaml)

To be able to run this critical component as unprivileged and secure as possible, it needs to be built as a custom image.

Approach here is to fetch the official image binary, and copy over the binary to a `scratch` based image with bare minimum of additions (*root certificates and zoneinfo* files from official image), running as unprivileged user (`1000:1000`) by default, all making it smaller and more secure.

Considering official image simplicity, this unprivileged image can be used across at least entire 3.x branch lifetime, hopefully even longer.

## Features

* Official, untouched binary
* Rootless
* Listens on high ports
* Bare-bones scratch image
* Multiple architectures
* Free
