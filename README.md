Butlersh - Server Management Tool

WIP

## Development

Build the Ubuntu docker image for development & testing purpose 
```bash
docker build . -t butlersh:ubuntu-2404
```

Run a docker container from the image above

```bash
docker run -it --rm -w /usr/src/app -v .:/usr/src/app butlersh:ubuntu-2404 bash
```

Execute the ShellSpec command
```bash
shellspec
```
