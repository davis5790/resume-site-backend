import boto3

client = boto3.client('dynamodb')
TableName = 'Resume-Website-Stats'

def lambda_handler(event, context):

    response = client.update_item(
        TableName=TableName,
        Key = {'stat': {'S': 'view-count'}},
        UpdateExpression= 'ADD quantity :inc',
        ExpressionAttributeValues = {
            ':inc': {'N': '1'}
        },
        ReturnValues="UPDATED_NEW"
        )
        
    value = response['Attributes']['quantity']['N']
    
    return {
        'statusCode' : 200,
        'body' : value
    }
    
    # CI test push