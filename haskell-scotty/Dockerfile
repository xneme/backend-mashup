FROM haskell:9.4.5 AS builder

WORKDIR /project
COPY stack.yaml /project/
RUN stack setup

COPY package.yaml /project/
RUN stack build --only-dependencies

COPY . /project/
RUN stack build --copy-bins --local-bin-path /usr/local/bin
ENTRYPOINT [ "haskell-scotty-exe" ]

#FROM scratch
#COPY --from=builder /project/build/haskell-scotty-exe /server-mashup-haskell-scotty
#CMD [ "tail", "-f", "/dev/null" ]
#ENTRYPOINT [ "/server-mashup-haskell-scotty" ]

