import base64

# read environment variables and initialize here
print("initializing kinesis lambda")

# entry point for lambda
def lambda_handler(event, context):
    lines_read = 0
    error = 0
    records = event['Records']
    print("records received: {0}".format(len(records)))
    for record in records:
        lines_read += 1
        try:
            line = base64.b64decode(record['kinesis']['data'])
            line = line.decode('utf-8')
            if lines_read == 1:
                print(line)
        except Exception as e:
            print("Error on line {0}".format(lines_read))
            print(e)
            error += 1
            continue

