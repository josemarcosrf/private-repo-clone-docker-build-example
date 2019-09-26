# Install private git repo inside Docker with SSH

## Rationale

We want to create a docker image installing some dependecy from
a private github repository using SSH read keys.

To do so we use a `multi-stage` build in Docker so we always keep
our SSH keys protected as the first stage, where the SSH key is, 
won't be present in the final image.

More info abou the process can be found in [this blog post](https://vsupalov.com/build-docker-image-clone-private-repo-ssh-key/)


## How To
1. Generate a SSH key
```bash
    ssh-keygen -t rsa -b 4096 -C "your@email..com"
```

2. Add the public key as _read-only_ [deploy key](https://github.blog/2015-06-16-read-only-deploy-keys/) to your repo.
More [info here](https://superuser.com/questions/1314064/read-only-access-to-github-repo-via-ssh-key)

3. Run the `build-docker.sh` script:
```bash
    # export path to the public key
    export KEY_PATH=<your-public-key-path>
    ./build-docker.sh
```
