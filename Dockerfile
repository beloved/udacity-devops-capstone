FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html/index.html
ADD https://get.aquasec.com/microscanner .
RUN chmod +x microscanner
RUN ./microscanner YjYxZTU5MmQ5MWJj

