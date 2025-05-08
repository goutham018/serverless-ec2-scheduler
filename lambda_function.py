import os
import boto3

def lambda_handler(event, context):
    ec2_client = boto3.client('ec2', region_name='ap-south-1')
    
    instance_ids = os.environ['INSTANCE_IDS'].split(',')
    action = os.environ['ACTION'].lower()

    try:
        if action == 'start':
            ec2_client.start_instances(InstanceIds=instance_ids)
            print(f"Started instances: {instance_ids}")
            return {"statusCode": 200, "body": f"Started instances: {instance_ids}"}
        elif action == 'stop':
            ec2_client.stop_instances(InstanceIds=instance_ids)
            print(f"Stopped instances: {instance_ids}")
            return {"statusCode": 200, "body": f"Stopped instances: {instance_ids}"}
        else:
            raise ValueError("Invalid ACTION value. Must be 'start' or 'stop'.")
    except Exception as e:
        print(f"Error: {str(e)}")
        return {"statusCode": 500, "body": f"Error: {str(e)}"}
