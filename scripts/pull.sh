#!/bin/bash
git -C $1 reset --hard origin/main
git -C $1 checkout .
git -C $1 pull