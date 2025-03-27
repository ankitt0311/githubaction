provider "azurerm" {
  features {}
  subscription_id = "08c98cf6-15de-4d54-9fe0-d49c61c07abe"
}
 
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-high-alert"
  resource_group_name = "test-sms-alert-rg"
  scopes              = ["/subscriptions/08c98cf6-15de-4d54-9fe0-d49c61c07abe/resourceGroups/Dev-test/providers/Microsoft.Compute/virtualMachines/demotestfordevrev"]
  description         = "{\"Severity\": \"3\", \"TargetResourceType\": \"Microsoft.Compute/virtualMachines\", \"MetricName\": \"Percentage CPU\", \"Customer\": \"Cust1\"}"
  severity            = 2
  frequency           = "PT1M" # Check every 1 minute
  window_size         = "PT5M" # Look at the past 5 minutes
 
  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = 100
  }
 
  action {
    action_group_id = "/subscriptions/08C98CF6-15DE-4D54-9FE0-D49C61C07ABE/resourceGroups/cspm-test-rg/providers/microsoft.insights/actionGroups/ankitactiongroup"
  }
}