provider "aws" {
   	region = var.region
 }


resource "aws_lambda_function" "test_lambda" {
	filename      = "Greetings.zip"
  	function_name = "greet_lambda"
  	role          = "${aws_iam_role.iam_for_lambda.arn}"
  	handler       = "greet_lambda.lambda_handler"
  	runtime	      = "python3.8"
	vpc_config {
    		subnet_ids         = ["subnet-038b6599cc5cb58e8","subnet-06755cc9187512efd"]
    		security_group_ids = ["sg-0fd5340acb76ccefd"]
  	}

	depends_on = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.example"]

}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/test_lambda"
  retention_in_days = 14
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}
