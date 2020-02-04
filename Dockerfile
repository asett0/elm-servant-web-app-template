# syntax=docker/dockerfile:experimental
FROM haskell:8.6 AS dependencies
COPY backend/package.yaml backend/stack.yaml /backend/
WORKDIR /backend
RUN --mount=type=cache,target=/root/.stack/ stack build -v --only-dependencies

FROM dependencies AS dev
COPY backend/ . 
RUN stack build -v
# COPY frontend/ /frontend/
CMD ["stack","exec","backend-exe"]