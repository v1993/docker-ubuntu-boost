# docker-ubuntu-boost
Simple dockerfile for providing ubuntu with last boost

Current boost version is 1.67.0.

This repository uses travis-ci for regular builds. It include three editions:
1. latest = ubuntu:latest
2. rolling = ubuntu:rolling
3. baseimage = baseimage:master

# Variables (useful for you):

* `BOOST_VERSION_DOT` — dot separated boost version (e.g. 1.67.0)
* `BOOST_VERSION_UNDERSCORE` — underscore separated boost version (e.g. 1_67_0)
* `BOOST_BUILD_DIR` — boost sources location
* `BOOST_REINSTALL_FILE` — path to file which will reinstall boost (if it is affected somehow by you).

Use `BOOST_REINSTALL_FILE` like

    RUN $BOOST_REINSTALL_FILE
