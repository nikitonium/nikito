#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.nikitocore/nikitod.pid file instead
nikito_pid=$(<~/.nikitocore/testnet3/nikitod.pid)
sudo gdb -batch -ex "source debug.gdb" nikitod ${nikito_pid}
