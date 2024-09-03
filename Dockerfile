FROM fauria/vsftpd

EXPOSE 20 21 21100-21110

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]