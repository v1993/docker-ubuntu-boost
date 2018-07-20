# Version: 0.1.0
FROM ubuntu:latest
MAINTAINER Valeri Ochinski <v19930312@gmail.com>

ENV BOOST_VERSION_DOT        1.67.0
ENV BOOST_VERSION_UNDERSCORE 1_67_0
ENV BOOST_BUILD_DIR          /root/boost
ENV BOOST_TMP_DIR            /tmp/boost
ENV BOOST_ARCHIVE            ${BOOST_TMP_DIR}/boost.zip

RUN apt-get update -qq
RUN apt-get install -qq -y aria2 unzip apt-utils

RUN mkdir -p ${BOOST_BUILD_DIR} ${BOOST_TMP_DIR}
RUN aria2c -q -o ${BOOST_ARCHIVE} https://dl.bintray.com/boostorg/release/${BOOST_VERSION_DOT}/source/boost_${BOOST_VERSION_UNDERSCORE}.zip; \
    echo "Download OK"; \
    unzip -q ${BOOST_ARCHIVE} -d ${BOOST_TMP_DIR}; \
    echo "Unzip OK"; \
    rm ${BOOST_ARCHIVE}; \
    echo "Rm OK"; \
    mv ${BOOST_TMP_DIR}/boost_${BOOST_VERSION_UNDERSCORE}/* $BOOST_BUILD_DIR; \
    echo "Mv OK";

RUN apt-get install -qq -y build-essential clang python-dev jam libicu-dev libbz2-dev liblzma-dev libboost-all-dev

RUN cd $BOOST_BUILD_DIR && ./bootstrap.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu --with-toolset=clang
RUN cd $BOOST_BUILD_DIR && ./b2 -j8 toolset=clang cxxflags="-stdlib=libstdc++ -fPIC" cflags="-fPIC" linkflags="-stdlib=libstdc++"
RUN cd $BOOST_BUILD_DIR && ./b2 install 1>/dev/null

ENV BOOST_REINSTALL_FILE     ${BOOST_BUILD_DIR}/reinstall

RUN echo "cd $BOOST_BUILD_DIR && ./b2 install" > $BOOST_REINSTALL_FILE; chmod a+x $BOOST_REINSTALL_FILE

CMD ["/bin/sh"]
