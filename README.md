Butlersh - Server Management Tool

WIP

## Development

Build a docker image for testing purpose 
```bash
docker build . -t butlersh:latest
```

Run a docker container from the image above

```bash
docker run -it --rm -w /usr/src/app -v .:/usr/src/app butlersh:latest bash
```

Execute ShellSpec command
```bash
shellspec
```
