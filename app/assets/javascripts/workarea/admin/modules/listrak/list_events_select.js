/**
 * @namespace WORKAREA.listrakListEventsSelect
 */

WORKAREA.registerModule('listrakListEventsSelect', (function () {
    'use strict';

    var injectHiddenInput = function (index, select) {
            // allows select[multiple=true] elements to post empty values
            if ( ! $(select).is('[multiple]')) { return; }

            $(select).before(function () {
                return JST['workarea/core/templates/hidden_input']({
                    name: select.name,
                    value: ''
                });
            });
        },

        getConfig = function () {
            var settings = _.assign({}, WORKAREA.config.remoteSelects, {
                placeholder: I18n.t('workarea.admin.listrak_configuration.edit.events_select_placeholder'),
                allowClear: true,
                multiple: true,
                width: false,
                ajax: {
                    url: function () {
                        return WORKAREA.routes.admin.listrakListEventsPath({ list_id: listId(), format: "json" });
                    },
                    dataType: 'json',
                    delay: 250,
                    processResults: function (data) {
                        return {
                            results: _.map(data.results, function (item) {
                                return {
                                    id: item.value,
                                    text: item.label
                                };
                            })
                        };
                    },
                    cache: true,
                    escapeMarkup: function (markup) {
                        return markup;
                    }
                }
            });

            return settings;
        },

        listId = function () {
            return $('#default_list_id').val();
        },

        initSelect2 = function (index, select) {
            $(select)
            .each(injectHiddenInput)
            .select2(getConfig());
        },

        resetEventIds = function () {
            $('[data-listrak-events-select]')
            .val(null).trigger('change');
        },

        destroy = function (event) {
            $('[data-listrak-events-select]', event.currentTarget)
            .select2('destroy');
        },

        init = function ($scope) {
            $('#default_list_id').on("change", resetEventIds);
            $('[data-listrak-events-select]', $scope)
                .each(initSelect2);
        };

    $(document).on('turbolinks:before-cache', destroy);

    return {
        init: init
    };
}()));
