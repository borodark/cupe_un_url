# CupeUnUrl

## Prepare dev environment
 
### Build two docker images

* `docker build . -t cupe`
* `docker build . -f riak-leveldb.docker -t riak-leveldb`

### start docker compose in separete terminal

`docker-compose up --remove-orphans`

This will bring up one node `riak` and `test` container

### Drop into test container

`docker exec -it test bash`

We are in the `/opt/app` directory of the container that is also a root of the app.

```
bash-5.1$ pwd
/opt/app
bash-5.1$ ls -l
total 64
-rw-rw-r--    1 io       io             439 Mar 27 20:20 Dockerfile
-rw-r--r--    1 io       io             828 Mar 30 02:50 README.md
drwxr-xr-x    4 io       io            4096 Mar 30 01:50 _build
drwxr-xr-x    5 io       io            4096 Mar 27 20:12 assets
drwxr-xr-x    2 io       io            4096 Mar 28 04:39 config
drwxr-xr-x   33 io       io            4096 Mar 28 04:32 deps
-rw-rw-r--    1 io       io             984 Mar 27 20:42 docker-compose.yaml
drwxr-xr-x    4 io       io            4096 Mar 27 20:54 lib
-rw-r--r--    1 io       io            1805 Mar 28 04:31 mix.exs
-rw-r--r--    1 io       io           10024 Mar 28 04:32 mix.lock
drwxr-xr-x    4 io       io            4096 Mar 27 20:12 priv
-rw-rw-r--    1 io       io             327 Mar 27 20:22 riak-leveldb.docker
-rwxrwxr-x    1 io       io              92 Mar 28 02:07 start-server
drwxr-xr-x    4 io       io            4096 Mar 30 02:10 test
bash-5.1$ 

````
### Run tests 

`mix test`

### Start the server and test UI

`./start-server`

```
bash-5.1$ ./start-server 
Erlang/OTP 24 [erts-12.0.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit:no-native-stack]

[info] Running CupeUnUrlWeb.Endpoint with cowboy 2.9.0 at 0.0.0.0:4000 (http)
[info] Access CupeUnUrlWeb.Endpoint at http://localhost:4000
Interactive Elixir (1.12.2) - press Ctrl+C to exit (type h() ENTER for help)
[watch] build finished, watching for changes...
iex(mix_io@test)1> 
nil
iex(mix_io@test)2> 

```

Visit [`localhost:4000`](http://localhost:4000) to test UX
