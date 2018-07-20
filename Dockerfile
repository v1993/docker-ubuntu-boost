# Version: 0.1.0
FROM ubuntu:latest
MAINTAINER Valeri Ochinski <v19930312@gmail.com>

ENV BOOST_VERSION_DOT        "1.67.0" \
    BOOST_VERSION_UNDERSCORE "1_67_0" \
    BOOST_BUILD_DIR          "/root/boost" \
    BOOST_TMP_DIR            "/tmp/boost" \
    BOOST_ARCHIVE            "${BOOST_TMP_DIR}/boost.zip"

RUN apt-get update -qq && \
    apt-get install -qq -y aria2 unzip apt-utils build-essential clang python-dev jam libicu-dev libbz2-dev liblzma-dev libboost-all-dev && \
    apt-get clean && \
    echo "Apt step OK" && \
    mkdir -p "${BOOST_BUILD_DIR}" "${BOOST_TMP_DIR}" && \
    aria2c -q -o "${BOOST_ARCHIVE}" "https://dl.bintray.com/boostorg/release/${BOOST_VERSION_DOT}/source/boost_${BOOST_VERSION_UNDERSCORE}.zip" && \
    echo "Download OK" && \
    unzip -q "${BOOST_ARCHIVE}" -d "${BOOST_TMP_DIR}" && \
    echo "Unzip OK" && \
    rm "${BOOST_ARCHIVE}" && \
    echo "Rm ${BOOST_ARCHIVE} OK" && \
    mv "${BOOST_TMP_DIR}/boost_${BOOST_VERSION_UNDERSCORE}"/* "$BOOST_BUILD_DIR" && \
    echo "Mv OK" && \
    rm -rf "${BOOST_TMP_DIR}" && \
    echo "Rm ${BOOST_TMP_DIR} OK" && \
    cd "$BOOST_BUILD_DIR" && \
    ./bootstrap.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu --with-toolset=clang && \
    ./b2 -j8 toolset=clang cxxflags="-stdlib=libstdc++ -fPIC" cflags="-fPIC" linkflags="-stdlib=libstdc++" && \
    ./b2 install 1>/dev/null && \
    echo "Build and install OK" && \
    rm -rf "${BOOST_BUILD_DIR}" && \
    echo "Rm ${BOOST_BUILD_DIR} OK"

CMD ["/bin/sh"]
