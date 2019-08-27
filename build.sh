#!/bin/bash
set -e
set -u

usage() {
cat <<EOF

  Usage: $0 [options]

  This script builds a new docker image for the API / CMS app, and
  deploys it to the parkwoodent repository (when specified). It
  can also tag and version the image.

  Options:
    -h        Show this Message
    -a        Action: Build | Deploy | Build And Deploy
    -e        Environment: local | staging | production
    -p        Project Name
    -d        GitHub SHA

EOF
}

declare ACTION=${ACTION:-''}
declare ENV=${ENV:-''}
declare PROJECT=${PROJECT:-''}
declare DEPLOYMENT_TAG=${DEPLOYMENT_TAG:-''}

while getopts ":a:e:p:d:h:" opt; do
    case "$opt" in
    h)  usage; exit 0
        ;;
    a)  ACTION=$OPTARG
        echo "-a was triggered, Parameter: ${OPTARG}"
        ;;
    e)  ENV=$OPTARG
        echo "-e was triggered, Parameter: ${OPTARG}"
        ;;
    p)  PROJECT=$OPTARG
        echo "-p was triggered, Parameter: ${OPTARG}"
        ;;
    d)  DEPLOYMENT_TAG=$OPTARG
        echo "-d was triggered, Parameter: ${OPTARG}"
        ;;
    esac
done

if [ -z "$ACTION" ] || [ -z "$ENV" ] || \
   [ -z "$PROJECT" ] || [ -z "$DEPLOYMENT_TAG" ]; then
    usage
    exit 1
fi

if [ "$ACTION" == 'Build' ] || [ "$ACTION" == 'Build And Deploy' ]; then
    # TODO: Switch this over to semantic versioning for TAGS?
    docker build --pull -f Dockerfile -t parkwoodent/sample-microservice:${DEPLOYMENT_TAG} .
    docker push parkwoodent/sample-microservice:${DEPLOYMENT_TAG}
fi

exit 0
