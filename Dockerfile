FROM armswdev/arm-tools:bare-metal-compilers

RUN sudo rm /var/lib/apt/lists/lock && \
  sudo apt-get update -y && \
  sudo apt-get upgrade -y && \
  sudo apt-get -y --no-install-recommends install \
  cmake \
  zip \
  unzip
   
RUN sudo mkdir -p /src/workspace

VOLUME /src/workspace

CMD cd /src/workspace && \
  git clone --recursive https://github.com/ETLCPP/etl.git && \ 
  cd etl && \
  git checkout 20.36.1 && \
  export CC=gcc && \
  export CXX=g++ && \
  gcc --version && \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TESTS=OFF \
  -DNO_STL=ON \
  -DETL_USE_TYPE_TRAITS_BUILTINS=OFF \
  -DETL_USER_DEFINED_TYPE_TRAITS=OFF \
  -DETL_FORCE_TEST_CPP03=OFF \
  -DCMAKE_INSTALL_PREFIX="cmake-build/cmake-installation" -B./cmake-build && \
  cd cmake-build && \
  cmake --build . && \
  cmake --install . && \
  cd cmake-installation && \
  zip --symlinks -r etl-v20.36.1.zip . && \
  exit
