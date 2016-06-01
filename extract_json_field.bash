#! /bin/bash

grep -Po '"Dice score":.*?[^\\]",' manifest.json | perl -pe 's/"Dice score"://; s/^"//; s/",$//'
