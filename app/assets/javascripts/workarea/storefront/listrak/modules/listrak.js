/**
 * @namespace WORKAREA.listrak
 */

WORKAREA.registerModule('listrak', (function () {
    'use strict';

    var getSdk = _.once(function() {
            var biJsHost = (("https:" === document.location.protocol) ? "https://" : "http://");
            (function (d, s, id, tid, vid) {
            var js, ljs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return; js = d.createElement(s); js.id = id;
            js.src = biJsHost + "cdn.listrakbi.com/scripts/script.js?m=" + tid + "&v=" + vid;
            ljs.parentNode.insertBefore(js, ljs);
            })(document, 'script', 'ltkSDK', WORKAREA.config.listrak.merchantId, '1');
        }),

        addListrakListener = function(listener) {
            if (!WORKAREA.config.listrak.merchantId) { return; }

            if (typeof _ltk === "undefined") {
                (function(d) { if (document.addEventListener) document.addEventListener('ltkAsyncListener', d);
                else { var e = document.documentElement; e.ltkAsyncProperty = 0; e.attachEvent('onpropertychange', function (e) {
                if (e.propertyName === 'ltkAsyncProperty'){d();}});}})( listener );
            }
            else {
                listener();
            }
        },

        getEmailSelectors = function () {
          var emailIds = WORKAREA.config.listrak.emailIds,
              selectors = _.map(emailIds, function (id) { return '#' + id; });

          selectors.push('input[type="email"]');

          return selectors.join(', ');
        },

        addEmailCaptures = function($scope) {
            addListrakListener(function () {
                var emailSelectors = getEmailSelectors();

                _.each($(emailSelectors, $scope), function(input) {
                    if (_.isUndefined($(input).attr('id'))) { return; }

                    _ltk.SCA.CaptureEmail($(input).attr('id'));
                });
            });
        },

        init = function ($scope) {
            addEmailCaptures($scope);

            if (_.isEmpty($('#ltkSDK')) && WORKAREA.config.listrak.merchantId) {
                getSdk();
            }
        };

    return {
        init: init,
        addListrakListener: addListrakListener
    };
}()));
