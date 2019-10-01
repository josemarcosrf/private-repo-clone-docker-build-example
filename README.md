# Install private git repo inside Docker with SSH

## Rationale

We want to create a docker image installing some dependecy from
a private github repository using SSH read keys.

To do so we use a [multi-stage Docker build](https://docs.docker.com/develop/develop-images/multistage-build/) so we always keep
our SSH keys protected and private.
This is so because the first stage of the build, where the SSH key is, 
won't be present in the final image, hence not exposing any sensitive information.

More info abou the process can be found in [this blog post](https://vsupalov.com/build-docker-image-clone-private-repo-ssh-key/)


For this example we'll be using this [private repo](https://github.com/jmrf/nlu-engine)

## How To
1. Generate a SSH key
```bash
    ssh-keygen -t rsa -b 4096 -C "your@email..com"
```

2. Add the private key as _read-only_ [deploy key](https://github.blog/2015-06-16-read-only-deploy-keys/) to your repo.
More [info here](https://superuser.com/questions/1314064/read-only-access-to-github-repo-via-ssh-key)

3. Run the `build-docker.sh` script:
```bash
    # export path to the private key
    export KEY_PATH=<your-private-key-path>
    ./build-docker.sh
```
