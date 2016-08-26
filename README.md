# docker-thelounge

Alpine Linux Docker image for 
[thelounge](https://github.com/thelounge/lounge)@[master](https://github.com/thelounge/lounge/commits/master)

## How

### Build

Clone this Git repo and build the image with `docker build -t mylounge .`.

You can change `GIT_REV` in `Dockerfile` to any branch, tag or commit hash.

### Run

Run Lounge in public mode:

```
docker run -d --name lounge -p 9000:9000 mylounge
```

Run `lounge add daGrevis`:

```
docker run --rm -it -v ~/.lounge:/home/lounge/.lounge mylounge lounge add daGrevis
```

Run Lounge in private mode:

```
docker run -d --name lounge -p 9000:9000 -v ~/.lounge:/home/lounge/.lounge mylounge lounge --private start
```
