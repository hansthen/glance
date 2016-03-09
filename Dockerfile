FROM centos:centos7
MAINTAINER abhishek.mukherjee@clustervision.com

RUN yum -y swap -- remove systemd-container* -- install systemd systemd-libs
RUN yum -y -q install --setopt=tsflags=nodocs epel-release && \ 
    yum -y -q install --setopt=tsflags=nodocs http://rdo.fedorapeople.org/openstack-liberty/rdo-release-liberty.rpm && \
    yum -y -q install --setopt=tsflags=nodocs openstack-selinux openstack-utils openstack-glance python-glanceclient && \ 
    yum -y -q install --setopt=tsflags-nodocs python-pip && \
    yum -y update && yum clean all

RUN pip install supervisor
VOLUME /var/lib/glance


# RUN chown glance:glance /etc/glance/glance-api.conf
# RUN chown glance:glance /etc/glance/glance-registry.conf

EXPOSE 9191 9292
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
COPY rootimg /
#COPY docker-entrypoint.sh /
#COPY supervisord.conf /etc/supervisord.conf
#COPY glance-api.conf /etc/glance/glance-api.conf
#COPY glance-registry.conf /etc/glance/glance-registry.conf
