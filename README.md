# web-app-template
### Playing around with web app tech stack using Haskell and Elm.

To build your image, in the root directory of this project run

`DOCKER_BUILDKIT=1 docker image build -t your-web-app:1.0.0 .`

To run your container in the root directory of this project run

`docker run your-web-app:1.0.0`

This repository uses build kit experimental `RUN --mount=type=cache`  feature to cache the `/root/.stack/` directory such that Docker can take advantage of stack's caching capability when adding new dependencies to the `package.yaml` file. 