#!/bin/bash

sudo snap install microk8s --classic
sudo microk8s.status --wait-ready