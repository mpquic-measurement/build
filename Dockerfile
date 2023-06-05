FROM ns3-dce-fec:20.04

RUN sudo apt-get update && sudo apt-get install -y vim nano tree libcurl4-openssl-dev golang libevent-dev

RUN git clone https://github.com/mpquic-measurement/picoquic.git

COPY picoquic.patch ./picoquic

RUN cd picoquic && git apply --whitespace=warn < ./picoquic.patch && \
    cmake . && \
    make -j$(nproc)

WORKDIR /home/ns3dce

RUN git clone https://github.com/alibaba/xquic.git && \
    cd xquic && git clone https://github.com/google/boringssl.git ./third_party/boringssl && \
    cd ./third_party/boringssl && \
    mkdir -p build && cd build && \
    cmake -DBUILD_SHARED_LIBS=0 -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC" .. && \
    make ssl crypto -j$(nproc)

ENV SSL_TYPE_STR="boringssl"
ENV SSL_PATH_STR="/home/ns3dce/xquic/third_party/boringssl"
ENV SSL_INC_PATH_STR="/home/ns3dce/xquic/third_party/boringssl/include"
ENV SSL_LIB_PATH_STR="/home/ns3dce/xquic/third_party/boringssl/build/ssl/libssl.a;/home/ns3dce/xquic/third_party/boringssl/build/crypto/libcrypto.a"

WORKDIR /home/ns3dce/xquic

RUN git submodule update --init --recursive && \
    mkdir -p build && cd build && \
    cmake -DGCOV=on -DCMAKE_BUILD_TYPE=Debug -DXQC_ENABLE_TESTING=1 -DXQC_SUPPORT_SENDMMSG_BUILD=1 -DXQC_ENABLE_EVENT_LOG=1 -DXQC_ENABLE_BBR2=1 -DXQC_DISABLE_RENO=0 -DSSL_TYPE=${SSL_TYPE_STR} -DSSL_PATH=${SSL_PATH_STR} -DSSL_INC_PATH=${SSL_INC_PATH_STR} -DSSL_LIB_PATH=${SSL_LIB_PATH_STR} .. && \
    make -j$(nproc)

RUN cp /home/ns3dce/picoquic/picoquicdemo /home/ns3dce/dce-linux-dev/build/bin/
RUN cp /home/ns3dce/picoquic/picoquic_sample /home/ns3dce/dce-linux-dev/build/bin/

WORKDIR /home/ns3dce/dce-linux-dev/source/ns-3-dce

