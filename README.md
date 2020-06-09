[![Build Status](https://travis-ci.com/dantin/cubic-platform.svg?&branch=master)](https://travis-ci.com/dantin/cubic-platform)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

# Cubic Platform

Cubic Platform is a backend project using Microservice Architecture.

This repository contains:

1. Source code.
2. `Dockerfiles` & `docker-compose` scripts.
3. Documents.
4. CI/CD integration settings.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

This project is the backend service of the application that helps doctors diagnosing and communication remotely.

The solution includes:

- Client-side application
- Hardware devices(e.g. camera, video encoding/decoding box, etc.)
- Server-side service

## Install

You can clone the repository wherever you want.

    $ git clone https://github.com/dantin/cubic-platform.git && cd cubic-platform
    $ make image
    $ make images

## Usage

This is only a documentation page. You can find out more on [here](docs/README.md).

## Related Efforts

- [Consul](https://github.com/hashicorp/consul) - Registry.
- [RabbitMQ](https://github.com/rabbitmq/rabbitmq-server) - AMQP messaging broker.
- [Keycloak](https://github.com/keycloak/keycloak) - Identity and Access Management support.

## Maintainers

[@dantin](https://github.com/dantin)

## Contributing

Suggestions and improvements welcome!

Feel free to [Open an issue](https://github.com/dantin/cubic-platform/issues/new) or submit PRs.

## License

[BSD 3 Clause](LICENSE) © David Ding
