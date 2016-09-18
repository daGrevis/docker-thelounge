# docker-thelounge

Alpine Linux Docker image for 
[thelounge](https://github.com/thelounge/lounge)@[master](https://github.com/thelounge/lounge/commits/master)

## Building Image

Clone this Git repo and build the image with `docker build -t mylounge .`.

You can set `GIT_REV` to any branch, tag or commit hash when building image like this:

```
docker build --build-arg GIT_REV=v2.0.0-pre.7 -t mylounge .
```

## Running Container

Run Lounge in public mode:

```
docker run -d --name lounge -p 9000:9000 mylounge
```

Run `lounge add daGrevis` to add a user:

```
docker run --rm -it -v ~/.lounge:/root/.lounge mylounge lounge add daGrevis
```

Run Lounge with config from `~/.lounge` in private mode:

```
docker run -d --name lounge -p 9000:9000 -v ~/.lounge:/root/.lounge mylounge lounge --private start
```

## Deployment

Try [docker-compose](https://github.com/daGrevis/daGrev.is/blob/09375a84860e44eca74fc495e5f95f63a7e662a2/docker-compose.yml#L30-L36) for managing deployments.

Here's what I do:

1) Build it on local machine (`docker build -t mylounge .`),

2) Save image to local filesystem (`docker save -o mylounge.tar mylounge`),

3) Send it to your server (`scp mylounge.tar dagrev.is:~`),

4) Load image on your server (`docker load -i mylounge.tar`),

5) Restart containers (`docker-compose restart`).
