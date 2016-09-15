#!/bin/bash

neato -Tsvg $1 > $1.svg
open $1.svg
