[![Open Issues](https://img.shields.io/github/issues/VantStark/docker-atlassian-crucible.svg)](https://github.com/VantStark/docker-atlassian-crucible/issues) [![Stars on GitHub](https://img.shields.io/github/stars/VantStark/docker-atlassian-crucible.svg)](https://github.com/VantStark/docker-atlassian-crucible/stargazers) [![Forks on GitHub](https://img.shields.io/github/forks/VantStark/docker-atlassian-crucible.svg)](https://github.com/VantStark/docker-atlassian-crucible/network) [![Stars on Docker Hub](https://img.shields.io/docker/stars/techzero/atlassian-crucible.svg)](https://hub.docker.com/r/techzero/atlassian-crucible/) [![Pulls on Docker Hub](https://img.shields.io/docker/pulls/techzero/atlassian-crucible.svg)](https://hub.docker.com/r/techzero/atlassian-crucible/)

# Supported tags and respective `Dockerfile` links

- [`4.8.4`, `4.8`, `4`, `latest`](https://github.com/VantStark/docker-atlassian-crucible/blob/main/4.8.4/Dockerfile)

# Atlassian Crucible in a Docker container

This is a containerized installation of Atlassian Crucible with Docker, and it's a match made in heaven for us all to enjoy. The aim of this image is to keep the installation as straight forward as possible, but with a few Docker related twists.

## Get started

To quickly get started running a Crucible instance, use the following command:

```bash
docker run --name crucible \
    -d \
    -v /path/to/crucible:/var/atlassian/crucible \
    -e TZ=<timezone> \
    -e X_PROXY_NAME="example.com" \
    -e X_PROXY_PORT="8060" \
    -e X_PROXY_SCHEME="https" \
    -p 8060:8060 \
    techzero/atlassian-crucible:latest
```

Then simply navigate your preferred browser to `http://[dockerhost]:8060` and finish the configuration.

## Configuration

You can configure a small set of things by supplying the following environment variables

| Environment Variable | Description                                                                                      |
| -------------------- | ------------------------------------------------------------------------------------------------ |
| X_PROXY_NAME         | Sets the Tomcat Connectors `ProxyName` attribute                                                 |
| X_PROXY_PORT         | Sets the Tomcat Connectors `ProxyPort` attribute                                                 |
| X_PROXY_SCHEME       | If set to `https` the Tomcat Connectors `secure=true` and `redirectPort` equal to `X_PROXY_PORT` |
| X_PATH               | Sets the Tomcat connectors `path` attribute                                                      |
