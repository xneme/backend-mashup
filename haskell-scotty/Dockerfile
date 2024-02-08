FROM haskell:9.4.5 AS builder

WORKDIR /project
COPY stack.yaml /project/
RUN stack setup

COPY package.yaml /project/
RUN stack build --only-dependencies

COPY . /project/
#RUN stack build --copy-bins --local-bin-path /usr/local/bin
#ENTRYPOINT [ "haskell-scotty-exe" ]

RUN stack install --ghc-options="-fPIC" --flag haskell-scotty:static

RUN curl -sSL https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz \
  | tar -x --xz --strip-components 1 upx-3.94-amd64_linux/upx \
  && ./upx --best --ultra-brute /root/.local/bin/haskell-scotty

FROM scratch
COPY --from=builder /root/.local/bin/haskell-scotty /bin/
CMD ["/bin/haskell-scotty", "-"]


#FROM scratch
#COPY --from=builder /project/build/haskell-scotty-exe /server-mashup-haskell-scotty
#CMD [ "tail", "-f", "/dev/null" ]
#ENTRYPOINT [ "/server-mashup-haskell-scotty" ]

