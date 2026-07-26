FROM rockylinux:9

RUN yum -y install nfs-utils rpcbind && yum clean all

COPY exports /etc/exports
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2049 111 20048

ENTRYPOINT ["/entrypoint.sh"]