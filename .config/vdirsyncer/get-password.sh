#!/usr/bin/env bash

set -eu -o pipefail

gopass show cal.blinry.org | head -1
