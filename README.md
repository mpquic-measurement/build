# ns3-dce-mpquic

Modified from [`francoismichel/flec-simulation-experiments`](https://github.com/francoismichel/flec-simulation-experiments).

## build

See [build.sh](./build.sh) for manual build instructions or pull pre-built images by

```bash
docker pull cr.jinwei.me/mpquic/ns3-dce-mpquic:20.04
```

No optimizations have been made to reduce Docker image size yet, around ~16GB.

## run

See [run.sh](./run.sh) for more instructions.

## ns-3-dce

Put recompiled and linked binaries under `/home/ns3dce/dce-linux-dev/build/bin` to be loaded by `ns-3-dce`.

Modify `ns-3` scripts under `myscripts` and run `./waf --run [script name]` under `/home/ns3dce/dce-linux-dev/source/ns-3-dce`.

Build directories:

`xquic`: `/home/ns3dce/xquic/build`

`picoquic`: `/home/ns3dce/picoquic`