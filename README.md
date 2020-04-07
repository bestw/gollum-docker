## gollum-docker

This is a Docker image for [gollum](https://github.com/gollum/gollum), git and ssh-server, a simple wiki that stores documents in a git repository.

### Usage

```bash
mkdir -p ~/wiki && git init ~/wiki
docker run -d --name=gollum --restart always -p 8080:4567 -v ~/wiki:/wiki bestw/gollum
```

This will pull and run the `bestw/gollum` image, exposing the website on port 8080.
