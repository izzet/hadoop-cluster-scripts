#!/bin/bash

utils-check-sudo() {
    echo "⏳ Checking sudo privileges..."
    if [ "$EUID" -ne 0 ]; then 
        echo "❌ Please run as root" 
        exit
    fi
    echo "✅ sudo privileges provided"
}

"${@}"