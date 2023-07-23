FROM messense/rust-musl-cross:x86_64-musl AS chef
ENV SQLX_OFFLINE=true
RUN cargo install cargo-chef
WORKDIR /backend-mashup-rust-poem

FROM chef AS planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder
COPY --from=planner /backend-mashup-rust-poem/recipe.json recipe.json
RUN cargo chef cook --release --target x86_64-unknown-linux-musl --recipe-path recipe.json
COPY . .
RUN cargo build --release --target x86_64-unknown-linux-musl

FROM scratch
COPY --from=builder /backend-mashup-rust-poem/target/x86_64-unknown-linux-musl/release/rust-poem /backend-mashup-rust-poem
ENTRYPOINT ["/backend-mashup-rust-poem"]

