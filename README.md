# docker-ubuntu-boost
Simple dockerfile for providing ubuntu with last boost

Current boost version is 1.67.0.

This repository uses travis-ci for regular builds. It include three editions:
1. latest = ubuntu:latest [![Build Status](https://travis-ci.org/v1993/docker-ubuntu-boost.svg?branch=master)](https://travis-ci.org/v1993/docker-ubuntu-boost)
2. rolling = ubuntu:rolling [![Build Status](https://travis-ci.org/v1993/docker-ubuntu-boost.svg?branch=rolling)](https://travis-ci.org/v1993/docker-ubuntu-boost)
3. baseimage = baseimage:master [![Build Status](https://travis-ci.org/v1993/docker-ubuntu-boost.svg?branch=baseimage)](https://travis-ci.org/v1993/docker-ubuntu-boost)

# Variables (useful for you):

* `BOOST_VERSION_DOT` — dot separated boost version (e.g. 1.67.0)
* `BOOST_VERSION_UNDERSCORE` — underscore separated boost version (e.g. 1_67_0)
