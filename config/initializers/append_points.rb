# Analytics adapter for Listrak tag management
Workarea::Plugin.append_javascripts(
  "storefront.modules",
  "workarea/storefront/listrak/adapters/listrak_adapter",
  "workarea/storefront/listrak/modules/listrak"
)

# Pass configuration for the Listrak adapter to the client-side
Workarea::Plugin.append_javascripts(
  "storefront.config",
  "workarea/storefront/listrak/listrak_config"
)

Workarea::Plugin.append_javascripts(
  "admin.modules",
  "workarea/admin/modules/listrak/list_events_select"
)

# Tracking pixel for checkout conversion tracking
Workarea::Plugin.append_javascripts(
  "storefront.checkout_confirmation",
  "workarea/storefront/checkouts/listrak"
)

Workarea.append_partials(
  "admin.settings_menu",
  "workarea/admin/shared/listrak_configuration_link"
)
