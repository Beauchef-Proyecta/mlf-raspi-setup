#!/bin/bash
echo "Checkout..."
git -C $1 checkout .
echo "Fetch..."
git -C $1 fetch
echo "Reset..."
git -C $1 reset --hard origin/main