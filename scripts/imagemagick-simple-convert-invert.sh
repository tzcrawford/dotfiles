#!/bin/sh
magick convert -density 300 -quality 95 -negate "$@"
