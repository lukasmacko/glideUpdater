[![Build Status](https://travis-ci.org/lukasmacko/glideUpdater.svg?branch=master)](https://travis-ci.org/lukasmacko/glideUpdater)

# GlideUpdater

The aim of the project is to fasten glide dependency update of a repository. Glide update runs in Travis-CI.
Sources from repo including updated deps are packe into docker image and pushed into dockerhub.

## Usage

- Edit `conf`
  ```
  <location in the go path where the project is cloned>
  <project name>
  <project repository>
  <commit to checkout>
  ```
- copy your desired `glide.yaml`
- comit & push
- check end of travis logs for instructions how to download updated sources
