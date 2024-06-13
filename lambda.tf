# resource "aws_dynamodb_table" "user" {
#   name           = "User"
#   # billing_mode   = "PROVISIONED"  # or "PAY_PER_REQUEST" for on-demand capacity mode
  
#   attribute {
#     name = "Id"
#     type = "N"
#   }
  
#   hash_key = "Id"
#   read_capacity = 5
#   write_capacity = 5
# }

# # Define IAM role for Lambda execution
# resource "aws_iam_role" "lambda_execution_role" {
#   name               = "lambda-execution-role"
#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Principal" : {
#           "Service" : "lambda.amazonaws.com"
#         },
#         "Action" : "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # Attach AWSLambdaBasicExecutionRole policy to IAM role
# resource "aws_iam_policy_attachment" "lambda_basic_execution" {
#   name       = "lambda-basic-execution"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#   roles      = [aws_iam_role.lambda_execution_role.name]
# }

# # Define the custom policy
# resource "aws_iam_policy" "custom_lambda_policy" {
#   depends_on = [aws_dynamodb_table.user]
#   name        = "custom-lambda-policy"
#   description = "Policy for Lambda function to access DynamoDB table User"
#   policy      = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Sid": "VisualEditor0",
#         "Effect": "Allow",
#         "Action": [
#           "dynamodb:PutItem",
#           "dynamodb:DescribeTable",
#           "dynamodb:DeleteItem",
#           "dynamodb:GetItem",
#           "dynamodb:UpdateItem"
#         ],
#         "Resource": "${aws_dynamodb_table.user.arn}"
#       }
#     ]
#   })
# }

# # Attach the custom policy to the Lambda execution role
# resource "aws_iam_role_policy_attachment" "lambda_custom_policy_attachment" {
#   policy_arn = aws_iam_policy.custom_lambda_policy.arn
#   role       = aws_iam_role.lambda_execution_role.name
# }

# # Define Lambda function
# resource "aws_lambda_function" "my_lambda_function" {
#   filename         = "publish.zip" # Path to your .NET API ZIP file
#   function_name    = "hello2"
#   role             = aws_iam_role.lambda_execution_role.arn
#   handler          = "user-lambda::user_lambda.Function::FunctionHandler" # Update with your handler
#   runtime          = "dotnet6" # or "dotnetcore2.1" depending on your .NET version
#   memory_size      = 3000 # Set memory size to 6GB (Lambda allows up to 10GB)
#   timeout          = 60 # Set execution timeout to 1 minute
#   source_code_hash = filebase64sha256("publish.zip") # Update path
# }
