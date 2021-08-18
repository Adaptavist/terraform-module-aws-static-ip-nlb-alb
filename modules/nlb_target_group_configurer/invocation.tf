resource "aws_lambda_permission" "populate_target_group" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.nlb-target-group-configurer.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.populate_target_group.arn
}

resource "aws_cloudwatch_event_rule" "populate_target_group" {
  depends_on          = [module.nlb-target-group-configurer]
  name                = "nlb-target-group-configurer-cwevent"
  description         = "Runs the NLB target group configurer every minute"
  schedule_expression = "rate(1 minute)"
  is_enabled          = true
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "populate_target_group" {
  target_id = module.nlb-target-group-configurer.lambda_function_name
  rule      = aws_cloudwatch_event_rule.populate_target_group.name
  arn       = module.nlb-target-group-configurer.lambda_function_arn
}