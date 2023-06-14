sudo docker build -t ns3-dce-base:22.04 -f Dockerfile-base-22.04 .
sudo docker build -t ns3-dce-fec:22.04 -f Dockerfile-fec-22.04 .
sudo docker build -t ns3-dce-mpquic:22.04 -f Dockerfile .
