FROM python:3.8-alpine

RUN pip install cfn-lint
RUN pip install pydot

WORKDIR /lint