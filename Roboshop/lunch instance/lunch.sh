#!/bin/bash

COMPONENT=$1

# -z validate the variable empty, true if is empty
if [ -z "${COMPONENT}" ]; then
  echo"Component name is needed"
fi

LID=lt-078d60fb07d6684f7
LVER=1

INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].state.Name | xargs -n1 )
if [ "${INSTANCE_STATE}" = "running" ]; then
  echo"Instance is already Existed"
  exit 0
fi

if [ "${INSTANCE_STATE}" = "stop" ]; then
  echo"Instance is already Existed"
  exit 0
fi

aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER}  --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
