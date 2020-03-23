#!/bin/sh

mkdir -p dist
cp DiagramRFC.svg dist/DiagramRFC.svg
docker run -v "`pwd`:/data" danielfett/markdown2rfc dtp-authorization-code-flow.md dist
