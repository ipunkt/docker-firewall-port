#!/bin/bash

PROTOCOL=${PROTOCOL:-UDP}
PORT=${PORT:-111}
if [ -z "${ALLOWED_ADDRESSES}" ] ; then
	echo "Environment variable ALLOWED_ADDRESSES"
	exit 1
fi

PORT_PARAMETER="--dport ${PORT}"
PROTOCOL_PARAMETER="-p ${PROTOCOL}"
if [ "${PROTOCOL}" == "ANY" ] ; then
	PROTOCOL_PARAMETER=""
fi

while true ; do
	echo "Creating iptables rules"
	IFS=';, '
	for ALLOWED_ADDRESS in ${ALLOWED_ADDRESSES} ; do
		if ! iptables -C INPUT -s ${ALLOWED_ADDRESS} ${PROTOCOL_PARAMETER} ${PORT_PARAMETER} -j ACCEPT ; then
			iptables -I INPUT -s ${ALLOWED_ADDRESS} ${PROTOCOL_PARAMETER} ${PORT_PARAMETER} -j ACCEPT
		fi
	done

	if ! iptables -C INPUT ${PROTOCOL_PARAMETER} ${PORT_PARAMETER} -j DROP ; then
		iptables -A INPUT ${PROTOCOL_PARAMETER} ${PORT_PARAMETER} -j DROP
	fi

	echo "iptables rules created, sleeping 10 minutes"
	sleep 600s
done
