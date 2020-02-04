# syntax=docker/dockerfile:experimental

FROM haskell:8.6 AS dependencies
COPY backend/package.yaml backend/stack.yaml /backend/
WORKDIR /backend/
RUN --mount=type=cache,target=/root/.stack/ stack build --only-dependencies

FROM dependencies AS dev
COPY backend/ ./
RUN --mount=type=cache,target=/backend/.stack-work/ stack build
# CMD ["stack","exec","backend-exe"]
CMD ["stack","exec","env"]

FROM ubuntu:18.04 AS prod
COPY --from=dev /backend/.stack-work/install/x86_64-linux/lts-14.22/8.6.5/bin/backend-exe /backend/
CMD ["/backend/backend-exe"]