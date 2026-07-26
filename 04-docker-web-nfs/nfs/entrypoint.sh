#!/bin/bash
mkdir -p /exports
chmod 777 /exports

rpcbind
rpc.statd
rpc.nfsd

exportfs -arv

exec rpc.mountd -F