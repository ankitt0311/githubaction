provider "azurerm" {
  features {}
  subscription_id = "da9ef7cd-7330-44f4-924c-71cb2f569631"
}
 
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-high-alert"
  resource_group_name = "test-sms-alert-rg"
  scopes              = ["/subscriptions/da9ef7cd-7330-44f4-924c-71cb2f569631/resourceGroups/Dev-test/providers/Microsoft.Compute/virtualMachines/demotestfordevrev"]
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
    action_group_id = "/subscriptions/da9ef7cd-7330-44f4-924c-71cb2f569631/resourceGroups/cspm-test-rg/providers/microsoft.insights/actionGroups/ankitactiongroup"
  }
}