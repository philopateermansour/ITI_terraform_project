import boto3

ses = boto3.client('ses')

def lambda_handler(event, context):
    try:
        records = event['Records']
        bucket_name = records[0]['s3']['bucket']['name']
        object_key = records[0]['s3']['object']['key']
    except (KeyError, IndexError) as e:
        return {
            "status": "Failed",
            "reason": f"Invalid event format: {str(e)}",
            "event_received": event
        }
    
    sender = "philopater.mansour.gerais@gmail.com"

    subject = f"S3 State File Changed: {object_key}"
    body = f"The file {object_key} in bucket {bucket_name} has changed."

    response = ses.send_email(
        Source=sender,
        Destination={
            'ToAddresses': [sender]
        },
        Message={
            'Subject': {'Data': subject},
            'Body': {'Text': {'Data': body}}
        }
    )

    return {"status": "Email sent", "ses_response": response}
