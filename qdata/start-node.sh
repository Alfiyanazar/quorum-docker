#!/bin/bash

#
# This is used at Container start up to run the constellation and geth nodes
#

set -u
set -e

GETH_ARGS="--datadir /qdata/dd --raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --nodiscover --unlock 0 --password /qdata/passwords.txt"

if [ ! -d /qdata/dd/geth/chaindata ]; then
  echo "[*] Mining Genesis block"
  /usr/local/bin/geth --datadir /qdata/dd init /qdata/genesis.json
fi


sleep 2

echo "[*] Starting node"
/usr/local/bin/geth $GETH_ARGS 2>>/qdata/logs/geth.log
