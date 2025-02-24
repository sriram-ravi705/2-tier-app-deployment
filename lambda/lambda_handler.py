import json
import boto3
from datetime import datetime,timezone,timedelta

ec2=boto3.resource('ec2')
ag=boto3.client('autoscaling')

def change_auto_scaling_desired_capacity(value,value1,value2):
    autoscale_name = "terraform_autoscaling"
    ag.update_auto_scaling_group(AutoScalingGroupName=autoscale_name,MaxSize=value,MinSize=value1,DesiredCapacity=value2)

def lambda_handler(event, context):
    # TODO implement
    instance_id=[]
    
    indian_timezone=timezone(timedelta(hours=5,minutes=30))
    current_time=datetime.now(indian_timezone)
    current_hour=current_time.hour
    
    filters=[
        {
            "Name": "tag:Terraform",
            "Values": ["Terraform_Instance"]
        }
        ]
    instances=ec2.instances.filter(Filters=filters)
    if current_hour==11:
        for instance in instances:
            if instance.state['Name']=="stopped":
                instance_id.append(instance.id)
                change_auto_scaling_desired_capacity(3,1,2)
                instance.start()
    elif current_hour==10:
        for instance in instances:
            if instance.state['Name']=="running":
                instance_id.append(instance.id)
                change_auto_scaling_desired_capacity(0,0,0)
                instance.stop()
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
