#!/bin/sh
# shellcheck disable=SC2039

if [ -z "${TYPE}" ]; then
    echo "🧨: TYPE env is (get|put)." && exit 1
fi

if [ -z "${S3_PATH}" ]; then
    echo "🧨‍: S3_PATH env is required." && exit 1
fi

if [ -z "${LOCAL_PATH}" ]; then
    echo "🧨‍: LOCAL_PATH env is required." && exit 1
fi

if [ -z "${ACCESS_KEY}" ]; then
    echo "🧨‍: ACCESS_KEY env is required." && exit 1
fi

if [ -z "${SECRET_KEY}" ]; then
    echo "🧨‍: SECRET_KEY env is required." && exit 1
fi

if [ -z "${HOST_BUCKET}" ]; then
    echo "🧨‍: HOST_BUCKET env is required." && exit 1
fi

if [ -z "${CHECK_SSL_HOSTNAME}" ]; then
    echo "🧨‍: CHECK_SSL_HOSTNAME env is required." && exit 1
fi

if [ -z "${CHECK_SSL_CERTIFICATE}" ]; then
    echo "🧨‍: CHECK_SSL_CERTIFICATE env is required." && exit 1
fi

echo "" >> /.s3cfg
echo "host_base=${HOST_BASE}" >> /.s3cfg
echo "access_key=${ACCESS_KEY}" >> /.s3cfg
echo "secret_key=${SECRET_KEY}" >> /.s3cfg
echo "host_bucket=${HOST_BUCKET}" >> /.s3cfg
echo "check_ssl_hostname=${CHECK_SSL_HOSTNAME}" >> /.s3cfg
echo "check_ssl_certificate=${CHECK_SSL_CERTIFICATE}" >> /.s3cfg


cp /.s3cfg /root/

if [ "$TYPE" == "put" ]; then
  s3cmd put "$LOCAL_PATH" "$S3_PATH" --recursive
  sleep 60 && echo "Done Uploading! 🥳🍕"
elif [ "$TYPE" == "get" ]; then
  s3cmd get "$S3_PATH" "$LOCAL_PATH" --recursive
  sleep 60 && echo "Done Downloading! 🥳🍺"
fi


