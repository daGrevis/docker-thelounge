# docker-thelounge

Alpine Linux Docker image for 
[thelounge@lounge](https://github.com/thelounge/lounge)@master

## How

Clone this Git repo and build the image with `docker build -t lounge .`.

Here's how you can run `lounge -h` inside Docker:

~~~
docker run --rm -v ~/.lounge:/lounge lounge lounge --home /lounge -h
~~~
