#!/bin/bash
sed "s/tagVersion/$1/g" deployments.yaml > backend.yaml