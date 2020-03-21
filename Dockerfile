# syntax=docker/dockerfile:experimental

FROM fpco/stack-build:lts-14.22 AS dependencies
COPY backend/package.yaml backend/stack.yaml /backend/
WORKDIR /backend/
RUN --mount=type=cache,target=/root/.stack/ stack build --only-dependencies

FROM dependencies AS dev
COPY backend/ ./
RUN --mount=type=cache,target=/root/.stack/ stack install --local-bin-path /backend/.stack-work/install/x86_64-linux/lts-14.22/8.6.5/bin/

FROM ubuntu:18.04 AS prod
COPY --from=dev /backend/.stack-work/install/x86_64-linux/lts-14.22/8.6.5/bin/backend-exe /backend/
CMD ["/backend/backend-exe"]