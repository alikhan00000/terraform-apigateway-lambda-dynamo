# resource "aws_api_gateway_rest_api" "my_api" {
#   name = "my-api"
#   description = "My API Gateway"

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_resource" "root" {
#   rest_api_id = aws_api_gateway_rest_api.my_api.id
#   parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
#   path_part = "user"
# }
# resource "aws_api_gateway_method" "proxy" {
#   rest_api_id = aws_api_gateway_rest_api.my_api.id
#   resource_id = aws_api_gateway_resource.root.id
#   http_method = "POST"
#   authorization = "NONE"
# }



# resource "aws_api_gateway_integration" "lambda_integration" {
#   depends_on  = [aws_lambda_function.my_lambda_function]
#   rest_api_id = aws_api_gateway_rest_api.my_api.id
#   resource_id = aws_api_gateway_resource.root.id
#   http_method = aws_api_gateway_method.proxy.http_method
#   integration_http_method = "POST"
#   type = "AWS_PROXY"
#   uri= aws_lambda_function.my_lambda_function.invoke_arn
# }
# resource "aws_lambda_permission" "apigw_lambda" {
#   statement_id = "AllowExecutionFromAPIGateway"
#   action = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.my_lambda_function.arn
#   principal = "apigateway.amazonaws.com"

#   source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*/*"
# }

# # URI: https://lambda.us-east-1.amazonaws.com/2015-03-31/functions/arn:aws:lambda:us-east-1:590183929077:function:rest-dynamo2/invocations
# # URI: https://lambda.us-east-1.amazonaws.com/2015-03-31/functions/arn:aws:lambda:us-east-1:590183929077:function:hello2/invocations/invocations
# resource "aws_api_gateway_method_response" "proxy" {
#   rest_api_id = aws_api_gateway_rest_api.my_api.id
#   resource_id = aws_api_gateway_resource.root.id
#   http_method = aws_api_gateway_method.proxy.http_method
#   status_code = "200"
# }
# resource "aws_api_gateway_integration_response" "proxy" {
#   rest_api_id = aws_api_gateway_rest_api.my_api.id
#   resource_id = aws_api_gateway_resource.root.id
#   http_method = aws_api_gateway_method.proxy.http_method
#   status_code = aws_api_gateway_method_response.proxy.status_code

#   depends_on = [
#     aws_api_gateway_method.proxy,
#     aws_api_gateway_integration.lambda_integration
#   ]
# }
# resource "aws_api_gateway_deployment" "my_deployment" {
#   depends_on   = [aws_api_gateway_integration.lambda_integration]
#   rest_api_id  = aws_api_gateway_rest_api.my_api.id
#   stage_name   = ""
# }
# resource "aws_api_gateway_stage" "example" {
#   stage_name    = "dev"  # Name of the stage, e.g., "dev", "prod", etc.
#   rest_api_id   = aws_api_gateway_rest_api.my_api.id
#   deployment_id = aws_api_gateway_deployment.my_deployment.id  # Assuming you have a deployment resource defined

#   # You can configure additional settings for the stage here

#   # Specify the dependency on API Gateway and Lambda resources
#   depends_on = [
#     aws_api_gateway_rest_api.my_api,
#     aws_api_gateway_deployment.my_deployment,
#     aws_lambda_function.my_lambda_function
#   ]
# }
# # Output the URL of the API Gateway stage
# output "api_gateway_url" {
#   value = aws_api_gateway_stage.example.invoke_url
# }