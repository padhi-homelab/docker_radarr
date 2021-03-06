# docker_radarr <a href='https://github.com/padhi-homelab/docker_radarr/actions?query=workflow%3A%22Docker+CI+Release%22'><img align='right' src='https://img.shields.io/github/workflow/status/padhi-homelab/docker_radarr/Docker%20CI%20Release?logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://microbadger.com/images/padhihomelab/radarr'><img src='https://img.shields.io/microbadger/layers/padhihomelab/radarr/latest?logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/radarr'><img src='https://img.shields.io/docker/image-size/padhihomelab/radarr/latest?label=size%20%5Blatest%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>

A multiarch [Radarr] Docker image, based on [Alpine Linux].

|           386            |       amd64        |          arm/v6          |          arm/v7          |       arm64        |         ppc64le          |          s390x           |
| :----------------------: | :----------------: | :----------------------: | :----------------------: | :----------------: | :----------------------: | :----------------------: |
| :heavy_multiplication_x: | :heavy_check_mark: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_check_mark: | :heavy_multiplication_x: | :heavy_multiplication_x: |

## Usage

```
docker run --detach \
           -p 7878:7878 \
           -e DOCKER_UID=`id -u` \
           -v /path/to/store/configs:/configs \
           -v /path/to/client/downloads:/downloads \
           -v /path/to/library/for/movies:/movies \
           -it padhihomelab/radarr
```

Runs `Radarr` with WebUI served on port 7878.

_<More details to be added soon>_


[Alpine Linux]: https://alpinelinux.org/
[Radarr]:       https://radarr.video/
