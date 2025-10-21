FROM alpine:3.21

WORKDIR /

RUN apk update && apk add --no-cache wget

COPY cadviser.sh ./cadviser.sh

RUN chmod +x ./cadviser.sh

CMD ["./cadviser.sh"]
