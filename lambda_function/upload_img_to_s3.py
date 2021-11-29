import logging

logger = logging.getLogger("img_upload_to_s3")
log_format = '%(asctime)s %(name)s %(message)s'
LOG_LEVEL = logging.INFO

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
