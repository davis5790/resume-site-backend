import boto3

client = boto3.client('dynamodb')
TableName = 'Resume-Website-Stats'

# Test to check that get_item returns a number

# Test to check that list_tables returns a non empty list

def get_views():
    response = client.get_item(
        TableName = TableName,
        Key = {
            'stat': {'S': "view-count"}
        },
        ProjectionExpression = 'quantity'
    )
    return int(response['Item']['quantity']['N'])

def test_answer():
    assert get_views() >= 0