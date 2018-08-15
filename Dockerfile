FROM mgibio/bam-readcount:0.7.4
MAINTAINER John Garza <johnegarza@wustl.edu>

LABEL \
    description="Image containing the fpfilter tool"

#get the fpfilter script
WORKDIR /opt
RUN wget --no-check-certificate https://raw.githubusercontent.com/genome/fpfilter-tool/v0.1.0/fpfilter.pl && \
    cp fpfilter.pl /usr/bin/fpfilter.pl && \
    rm fpfilter.pl

#fix ubuntu locale bug- other suggestions at
#https://stackoverflow.com/questions/8671308/non-interactive-method-for-dpkg-reconfigure-tzdata

RUN apt-get update -y && apt-get install -y libnss-sss tzdata
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

RUN echo "America/Chicago" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

#clear inherited entrypoint
ENTRYPOINT []
