#!/bin/bash

curl -sSL https://raw.githubusercontent.com/hypercurrentio/isotope-files/main/install_and_run.sh | bash -s -- 5000 YOUR_API_KEY
exec "$@"
