/**
 * @namespace WORKAREA.listrakAdapter
 */
WORKAREA.analytics.registerAdapter('listrakAdapter', function () {
    'use strict';

    if (!WORKAREA.config.listrak.merchantId) {
        return;
    }

    var productView = function(payload) {
            if (_.isUndefined(window._ltk)) { return; }

            /**
             * browsing activity
             */
            _ltk.Activity.AddProductBrowse(payload.sku);
            _ltk.Activity.Submit();
        },

        productQuickView = function(payload) {
            if (_.isUndefined(window._ltk)) { return; }

            /**
             * browsing activity
             */
            _ltk.Activity.AddProductBrowse(payload.sku);
            _ltk.Activity.Submit();
        },

        pageView = function() {
            if (_.isUndefined(window._ltk)) { return; }

            /**
             * conversion tracking
             */
            _ltk.Click.Submit();

            /**
             * browsing activity
             */
            _ltk.Activity.AddPageBrowse();
            _ltk.Activity.Submit();
        },

        cartView = function(payload) {
            if (_.isUndefined(window._ltk)) { return; }

            if (payload.items.length > 0) {
                if (!_.isEmpty(payload.token)) {
                    _ltk.SCA.CartLink = WORKAREA.routes.storefront.resumeCartPath(payload.token);
                }
                _.each(payload.items, function (item) {
                    _ltk.SCA.AddItemWithLinks(
                        item.sku,
                        item.quantity,
                        item.price,
                        item.product_name,
                        item.image_url,
                        WORKAREA.routes.storefront.productPath(item.slug)
                    );
                });
                _ltk.SCA.Submit();
            }
            else {
                _ltk.SCA.ClearCart();
            }
        },

        orderConfirmation = function(payload) {
            if (_.isUndefined(window._ltk)) { return; }
            
            _ltk.Order.SetCustomer(payload.email, payload.first_name, payload.last_name);
            _ltk.Order.OrderNumber = payload.number;
            _ltk.Order.ItemTotal = payload.subtotal_price;
            _ltk.Order.ShippingTotal = payload.shipping_total;
            _ltk.Order.TaxTotal = payload.tax_total;
            _ltk.Order.HandlingTotal = '0.00';
            _ltk.Order.OrderTotal = payload.total_price;
            _.each(payload.items, function (item) {
                _ltk.Order.AddItem(item.sku, item.quantity, item.price.toFixed(2));
            });
            _ltk.Order.Submit();

            /**
             * sca removal
             */
            _ltk.SCA.SetCustomer(payload.email, payload.first_name, payload.last_name);
            _ltk.SCA.OrderNumber = payload.number;
            _ltk.SCA.Submit();
        };

    return {
        'pageView': function() {
            WORKAREA.listrak.addListrakListener(pageView);
        },
        'productView': function(payload) {
            WORKAREA.listrak.addListrakListener(_.partial(productView, payload));
        },
        'productQuickView': function(payload) {
            WORKAREA.listrak.addListrakListener(_.partial(productQuickView, payload));
        },
        'cartView': function(payload) {
            WORKAREA.listrak.addListrakListener(_.partial(cartView, payload));
        },
        'checkoutOrderPlaced': function(payload) {
            WORKAREA.listrak.addListrakListener(_.partial(orderConfirmation, payload));
        }
    };
});
