#!/bin/sh

awslocal sqs create-queue --queue-name mcabank_payment_events_queue --region eu-west-1

