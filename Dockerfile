FROM alpine:3.6

MAINTAINER isca

## Install all the Packages
RUN apk add --no-cache \
    shadow \
    openssh \
    weechat \
    weechat-aspell \
    weechat-lua \
    weechat-perl \
    weechat-ruby \
    tor \
    tmux && rm -rf /tmp/* /var/cache/apk/*

## Configure the container
# Fix sshd for priviliege separation
RUN mkdir /var/run/sshd
RUN chmod 700 /var/run

## Configure ssh
ADD sshd_config /etc/ssh/
#
## Create /data
RUN mkdir /data
#
## Configure Weechat
RUN groupadd weechat
RUN useradd -m -d /home/weechat -g weechat -s /home/weechat/login.sh weechat
RUN usermod -p '*' weechat

## Add files not to be changed by the end user
ADD login.sh /home/weechat/
ADD config.txt /home/weechat/

## Add startup script
ADD startup.sh /usr/sbin/

## Add authorized_keys placeholder
RUN (mkdir /home/weechat/.ssh; chown -R weechat.weechat /home/weechat/.ssh; chmod 700 /home/weechat/.ssh)
RUN touch /data/authorized_keys
RUN ln -s /data/authorized_keys /home/weechat/.ssh/
##RUN ln -sf /dev/stdout /var/log/ssh

## Configure Tmux
ADD tmux.conf /data/
RUN ln -s /data/tmux.conf /home/weechat/.tmux.conf

## Make Weechat configuration persistent
RUN mkdir /data/weechat
RUN chown -R weechat:weechat /data/weechat
RUN ln -s /data/weechat /home/weechat/.weechat

## Final steps

# Add Volume under /data
#VOLUME ["/data"]

# Expose port 22
EXPOSE 22

# Startup preocedure
CMD ["/bin/sh", "/usr/sbin/startup.sh"]
