FROM ubuntu:latest

RUN apt-get -y update && apt-get install -y
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:pistache+team/unstable
RUN apt-get -y update
RUN apt-get -y install g++ cmake pkg-config libpistache-dev

COPY . .

WORKDIR .


RUN mkdir build
RUN cmake -B/build -S/
RUN cmake --build /build

CMD ./build/server_run

