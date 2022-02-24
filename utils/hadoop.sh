#!/bin/bash

hadoop-install-dependencies() {
    yum install -y java-1.8.0-openjdk
}

"${@}"