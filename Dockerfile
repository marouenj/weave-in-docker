FROM docker:1.11

MAINTAINER marouenj

RUN mkdir /app

COPY ./weave /app/weave
ENV PATH $PATH:/app

ENTRYPOINT ["weave"]
CMD ["launch"]
