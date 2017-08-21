# docker-thelounge

Alpine Linux Docker image for 
[thelounge](https://github.com/thelounge/lounge)@[master](https://github.com/thelounge/lounge/commits/master)

## Building Image

Clone this Git repo and build the image with `docker build -t mylounge .`.

You can set `GIT_REV` to any branch, tag or commit hash when building image like this:

```
docker build --build-arg GIT_REV=v2.4.0 -t mylounge .
```

## Running Container

```
docker run -d --name lounge -v ~/.lounge:/root/.lounge -p 9000:9000 mylounge
```

Run `add daGrevis` to add a user:

```
docker run --rm -it -v ~/.lounge:/root/.lounge mylounge lounge add daGrevis
```

To run Lounge in private mode, set `public` to `false` in `~/.lounge/config.js`
and restart container.

## Deployment

Try [docker-compose](https://github.com/daGrevis/daGrev.is/blob/f9f3fab452759b517520f72932bfca47e3e3abc4/docker-compose.yml#L51-L57) for managing deployments.

Here's what I do:

1) Build it on local machine (`docker build -t mylounge .`),

2) Save image to local filesystem (`docker save -o mylounge.tar mylounge`),

3) Send it to your server (`scp mylounge.tar dagrev.is:~`),

4) Load image on your server (`docker load -i mylounge.tar`),

5) Restart containers (`docker-compose restart`).
