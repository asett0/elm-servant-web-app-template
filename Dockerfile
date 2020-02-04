# syntax=docker/dockerfile:experimental

FROM haskell:8.6 AS dependencies
COPY backend/package.yaml backend/stack.yaml backend/
WORKDIR /backend
RUN --mount=type=cache,target=/root/.stack/ stack build --only-dependencies

FROM dependencies AS dev
COPY . .
RUN stack build
CMD ["stack","exec","backend-exe"]

# FROM ubuntu:18.04