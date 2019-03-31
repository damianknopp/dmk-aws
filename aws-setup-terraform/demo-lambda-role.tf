resource "aws_iam_role" "demo-lambda-role" {
    name = "demo-lambda-role"
    assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}
resource "aws_iam_role_policy_attachment" "demo-role-policy-s3" {
    role       = "${aws_iam_role.demo-lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "demo-role-policy-cloudwatch" {
    role       = "${aws_iam_role.demo-lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "demo-role-policy-lambda" {
    role       = "${aws_iam_role.demo-lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "demo-role-policy-vpc" {
    role       = "${aws_iam_role.demo-lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "demo-role-policy-sqs" {
    role       = "${aws_iam_role.demo-lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}