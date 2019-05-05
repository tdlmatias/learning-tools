FROM node:8.16.0-stretch-slim

LABEL maintainer "Scott Lowe <scott.lowe@scottlowe.org>"

RUN curl -L https://get.pulumi.com/releases/sdk/pulumi-v0.17.5-linux-x64.tar.gz -o /tmp/pulumi-v0.17.5-linux-x64.tar.gz && \
    tar -C /tmp -xvzf /tmp/pulumi-v0.17.5-linux-x64.tar.gz && \
    mv /tmp/pulumi/* /usr/local/bin/ && \
    chmod 0755 /usr/local/bin/* && \
    rm /tmp/pulumi-v0.17.5-linux-x64.tar.gz && \
    rm -rf /tmp/pulumi

COPY roles/js-simple-ec2/files/* /root/

RUN npm install /root && \
    npm cache clean --force

ENTRYPOINT [ "/usr/local/bin/pulumi" ]

CMD [ "--help" ]
