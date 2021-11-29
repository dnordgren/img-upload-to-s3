import logging

logger = logging.getLogger("img_upload_to_s3")
log_format = '%(asctime)s %(name)s %(message)s'
LOG_LEVEL = logging.INFO

# https://stackoverflow.com/questions/37703609/using-python-logging-with-aws-lambda
if len(logging.getLogger().handlers) > 0:
    # The Lambda environment pre-configures a handler logging to stderr. If a handler is already configured,
    # `.basicConfig` does not execute. Thus we set the level directly.
    logging.getLogger().setLevel(LOG_LEVEL)
else:
    logging.basicConfig(stream=sys.stdout, level=LOG_LEVEL, format=log_format)

def handler(event, context):
	"""Function ran by AWS Lambda when the Lambda is invoked.
    Args:
        event list((dict)): Data sent to Lambda
        Of form:
            [{
                key: value
            }]
        context (object): Lambda provided configuration object -
        https://docs.aws.amazon.com/lambda/latest/dg/python-context.html
    """
	logger.info("I uploaded it to S3, I promise")

if __name__ == "__main__":
    handler(None, None)
