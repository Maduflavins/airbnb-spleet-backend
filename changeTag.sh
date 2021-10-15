#!/bin/bash
sed "s/tagVersion/$1/g" deployments.yml > backend.yaml