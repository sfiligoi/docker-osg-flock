FROM opensciencegrid/software-base:fresh

# Fix condor UID to allow for persistency
RUN groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

RUN yum -y install \
                   osg-ca-certs \
                   cilogon-openid-ca-cert && \
    yum -y install osg-flock

RUN yum -y update

RUN yum clean all

ADD cron.d/fetch-crl.cron /etc/cron.d/fetch-crl.cron

ADD supervisord.d/condor.conf /etc/supervisord.d/condor.conf

# enables gratia
RUN touch /var/lock/subsys/gratia-probes-cron

