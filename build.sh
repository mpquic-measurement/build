podman build -t ns3-dce-base:20.04 -f Dockerfile-base-20.04 .
podman build -t ns3-dce-fec:20.04 -f Dockerfile-fec-20.04 .
podman build -t ns3-dce-mpquic:20.04 -f Dockerfile .
