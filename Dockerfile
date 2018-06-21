FROM alpine:3.7

COPY firewall.sh /opt/bin/firewall.sh
RUN apk -U add iptables bash

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/opt/bin/firewall.sh" ]
