# TODO: Define the output variable for the lambda function.

output "myfunction" {
  value = "${aws_lambda_function.test_lambda.function_name}"
}
