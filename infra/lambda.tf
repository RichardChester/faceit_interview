data "archive_file" "lambda" {
  type        = "zip"
  source_file = "build/bin/app"
  output_path = "build/bin/app.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-vpc-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
    role       = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = local.app_id
  handler          = "app"
  source_code_hash = base64sha256(data.archive_file.lambda_zip.output_path)
  runtime          = "go1.x"
  role             = "arn:aws:iam::${var.account_id}:role/lambda-vpc-execution-role"
  vpc_config {
      subnet_ids = toset([
    aws_subnet.pub_sub1.id,
    aws_subnet.pub_sub2.id,
  ])
      security_group_ids = [aws_security_group.interviewsg.id]
  }
  environment {
    variables = {
      POSTGRESQL_HOST = aws_db_instance.PsqlForLambda.endpoint
      POSTGRESQL_USER = var.db_username
      POSTGRESQL_PASSWORD = var.db_password
      POSTGRESQL_PORT = "5432"
      POSTGRESQL_DBNAME = postgres
    }
  }
}