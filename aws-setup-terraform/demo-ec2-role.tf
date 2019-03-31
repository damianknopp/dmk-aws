resource "aws_iam_role" "demo-ec2-role" {
  name = "demo-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "demo-ec2-policy" {
    name = "demo-ec2-policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:*",
                "ec2:*",
                "elasticmapreduce:*",
                "iam:AddRoleToInstanceProfile",
                "iam:AttachRolePolicy",
                "iam:CreateInstanceProfile",
                "iam:CreateRole",
                "iam:CreateServiceLinkedRole",
                "iam:DeleteInstanceProfile",
                "iam:DeleteRole",
                "iam:DetachRolePolicy",
                "iam:GetInstanceProfile",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole",
                "iam:ListInstanceProfiles",
                "iam:ListRoles",
                "iam:PassRole",
                "iam:PutRolePolicy",
                "iam:RemoveRoleFromInstanceProfile",
                "kinesis:*",
                "kms:List*",
                "lambda:*",
                "logs:*",
                "s3:*",
                "sqs:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::dmk-test/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "demo-ec2-role" {
    role = "${aws_iam_role.demo-ec2-role.name}"
    policy_arn = "${aws_iam_policy.demo-ec2-policy.arn}"
}

resource "aws_iam_instance_profile" "demo-ec2-role" {
  name = "demo-ec2-role",
  role = "${aws_iam_role.demo-ec2-role.name}"
}