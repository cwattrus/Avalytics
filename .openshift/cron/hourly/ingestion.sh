#!/bin/bash

pushd ${OPENSHIFT_REPO_DIR} > /dev/null
RAILS_ENV=production rake ingest:people >> ~/app-root/data/log/cron.log
popd > /dev/null
