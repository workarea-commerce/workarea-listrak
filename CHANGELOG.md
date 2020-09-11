Workarea Listrak 5.0.4 (2020-09-11)
--------------------------------------------------------------------------------

*   Bump version for release


    Ben Crouse

*   Ignore Tracking Params In Rack Cache

    Set the `Rack::Cache::Key` proc to ignore any param that starts with
    `trk_`, as these parameters are sent by Listrak and are unique per
    email, and used to track clicks from emails on the site. This avoids a
    potential over-caching situation in which a given request cannot be cached
    due to the constantly changing query parameters.

    LISTRAK-3

    Tom Scott



Workarea Listrak 5.0.3 (2020-02-05)
--------------------------------------------------------------------------------

*   Fix Proxy Usage in OAuth Client

    When obtaining an OAuth access token from Listrak, requests were not
    being sent through the HTTP proxy set in `$http_proxy` due to the way
    the `Net::HTTP` library was being used. To resolve this, refactor the
    `Listrak::OAuth.token` code to make a request using an instance of the
    `Net::HTTP` client, rather than by using the `.post_form` convenience
    method, as this is the only way to use the proxy in production.

    Fixes #2

    LISTRAK-1
    Tom Scott

*   Update README

    Matt Duffy



Workarea Listrak 5.0.2 (2019-08-22)
--------------------------------------------------------------------------------

*   Open Source! For real!
 
 
 
Workarea Listrak 5.0.1 (2019-08-21)
--------------------------------------------------------------------------------

*   Open Source! lol jk



Workarea Listrak 5.0.0 (2019-06-25)
--------------------------------------------------------------------------------

*   Listrak REST APIs

    Replace the SOAP implementation with Lisrak's REST APIs

    LISTRAK-52
    Eric Pigeon



Workarea Listrak 4.0.2 (2019-02-19)
--------------------------------------------------------------------------------

*   Perform the `_ltk` check when events are fired, instead of when the adapter is registered.

    LISTRAK-59
    Brian Berg

*   Add condition to check the listrak SDK is available before running adapter callbacks

    LISTRAK-57
    Jake Beresford



Workarea Listrak 4.0.1 (2018-01-11)
--------------------------------------------------------------------------------

*   Refactor Listrak SCA reporting

    Our original implementation was not passing along configured
    `email_capture_ids` to javascript, this updates that config markup to
    match patterns present in other workarea plugins.

    Listrak adapter was using route syntax from v2 when storefront was
    called `store_front`.  Updating to the new v3 route resolves issues with
    updating cart items analytics.

    There was room for improvement with how our listrak module handled
    adding SCA email address abandoner listener to every email field.
    Before this plugin relied on host app to pass each field name in the
    configuration, this update enchances that experience by also including a
    search for _all_ email fields within a given `$scope`.

    LISTRAK-47

    Refactor JS

    The mutation of the emailIds array made the updated JS hard to follow
    and understand at what point what typeof `configIds`.

    Names and var creation has been cleaned up to make the selector string
    building more readable.

    LISTRAK-47
    Jordan Stewart


Workarea Listrak 4.0.0 (2017-07-31)
--------------------------------------------------------------------------------


Workarea Listrak 4.0.0 (2017-07-31)
--------------------------------------------------------------------------------


Workarea Listrak 4.0.0 (2017-07-31)
--------------------------------------------------------------------------------

*   LISTRAK-45
    Eric Pigeon

*   Use different list ID in transactional email

    Transactional emails always use a different List ID on Listrak than the
    normal email subscribe list. This new configuration setting is available
    in the `:listrak` secrets as `:transactional_list_id`.

    LISTRAK-43
    Tom Scott


WebLinc Listrak 3.1.4.pre (2017-03-14)
--------------------------------------------------------------------------------

*   Fix regressions to older arity syntax

    After the LISTRAK-42 fix was deployed as workarea-listrak v3.1.3, another
    error popped up due to perform_api_call being called with the wrong
    number of arguments.

    Report: https://discourse.workarea.com/t/listrak-gem-contact-api-call-bug/680/3

    LISTRAK-42
    Tom Scott

*   Write tagged log messages when making requests

    When sending requests to Listrak's SOAP API, log all request/response
    params so that we can easily debug the data in case of failure. This is
    especially true for transactional messages. Also, make sure log messages
    are tagged with "[LISTRAK]" so they can be easily found when grepping
    through log history.

    LISTRAK-41
    Tom Scott

*   Display price in fixed-point notation LISTRAK-40 SHADES-684
    Tom Scott

*   Use correct attribute for item price.

    Price was not getting passed in AddItem() calls causing improper reports
    on the Listrak admin side.

    LISTRAK-40
    SHADES-684
    Tom Scott

*   Merge branch 'bugfix/LISTRAK-39-dont-run-workers-except-in-production'

    Added more docs.
    Tom Scott

*   Dont run workers except in production

    all the environments were exporting to the same ftp with the same file
    name, only enable the scheduled jobs when the environment is production.

    LISTRAK-39
    Eric Pigeon

*   Fix typo in setting of Order.ItemTotal

    The ItemTotal in this handler was being set to a blank value due to the
    typo on the `payload.subtotal_price` key.

    LISTRAK-37
    Tom Scott

*   Improve errors in Workarea::Listrak::Gateway

    LISTRAK-34
    Tom Scott

*   Fix multiple email captures in Listrak

    It seems that the CaptureEmail calls over each email_capture_id was
    causing multiple requests to be sent to Listrak for each completed
    field. This will prevent calls for nonexistent items by checking for
    whether the field exists on the page prior to calling
    `_ltk.SCA.CaptureEmail()` on it.

    This fixes one of the tasks in SHADES-668 as well.

    LISTRAK-36
    Tom Scott

*   Rename checkoutConfirmation to checkoutOrderPlaced

    The JS code wasn't firing on confirmation because the analytics event
    was misnamed, renamed it ot what's found in base so it will "Just Work".

    This will also resolve SHADES-688 when it's deployed in **v3.0.1**.

    LISTRAK-35
    Tom Scott

*   Add Jesse's changes for firing the ltk event.

    LISTRAK-30
    Tom Scott

*   LISTRAK-30 Refactor Listrak JS code as an analytics adapter
    Eric Pigeon

*   Append sdk partial to storefront.javascript

    This is apparently a more accurate place to be putting this code, in
    addition, it places the code on the bottom of the page. Not really sure
    how "breaking" of a change this is gonna be so hold off on merging
    before we're sure.

    LISTRAK-32
    Tom Scott

*   Hard-code WSDL URL

    This URL never changes, there's no reason to supply it from secrets.

    LISTRAK-31
    Tom Scott

*   Fix cart recreate tag

    This is based on the implementation in Tahari, the cart recreate code
    supplied by Listrak in their docs is apparently incorrect. Since the
    `_ltk` object is already defined, we don't need to wait for any kind of
    event. Instead, we should be calling Listrak SCA methods as soon as we
    can.

    LISTRAK-28
    Tom Scott

*   Use full url for product images

    LISTRAK-25
    Eric Pigeon

*   Shedule product export nightly

    LISTRAK-24
    Eric Pigeon

*   LISTRAK-123: Ensure product URL is fully-qualified

    Had an issue with testing this one...had to hard-set the
    `Workarea.config.domain`.
    Tom Scott

*   LISTRAK-20: Use absolute paths for CSVs

    Can cause issues building files on the server, solved by always
    prepending `Rails.root` in file_to_upload.
    Tom Scott

*   Fix ftp hash symbol access

    fix trying to access hash from secrets as symbol keys
    clean up decorator to follow convention
    test decorated categorization method
    fix dummy mongoid.yml to be mongoid 5 compliant
    clean up gemspec authors

    LISTRAK-19
    Eric Pigeon

*   Update item price method and ensure _ltk var exists

    Running tests on this one uncovered an issue that would have caused the
    cart summary view to error out. Updated the `item.unit_price` call to
    `item.total_price` everywhere, since that field is defined on
    Order::Item and OrderItemViewModel doesn't define a unit_price method.

    LISTRAK-17
    Tom Scott

*   LISTRAK-17: Trigger cart updates when the cart summary view is rendered
    bberg

*   LISTRAK-16: Configuration refactor. Tom deflips table.
    Mark Platt

*   LISTRAK-16: Add secrets to an config in initializer. Update js to use config
    Mark Platt

*   Fix render_listrak_tracking_code overriding

    This wasn't able to be overridden properly in the host app, and I had to
    resort to a `nil?` check in order to allow it to be overridden. Not sure
    of how the configuration hierarchy works in this case, but it's much
    easier and clearer in the engine.rb to write it this way IMHO.

    LISTRAK-13
    Tom Scott

*   v0.13.0: Render Listrak JS conditionally

    Some clients wish to use Google Tag Manager in order to render
    the Listrak JavaScript tracking code. While this was always
    configurable, the setting has been renamed to
    `listrak_render_tracking_code` in order to prevent naming conflicts and
    be more descriptive of the domain in which it is active.

    This is a major-version release in case anyone was already using the old,
    badly-named config setting. Renamed it to be "namespaced" within
    listrak, so it's easy to see where the setting is being used.

    LISTRAK-11
    Tom Scott

*   Use configured merchant_id in Listrak JS tracker

    Listrak needs to include a bit of JS on every page for tracking user
    movements through the app. The merchant ID included in this tracking
    code was hard-coded into the gem and the same for every user of the gem.
    Refactored to use a secret from `config/secrets.yml` instead of the
    hard-coded value. Users of the workarea-listrak gem will need to update
    `config/secrets.yml` and insert a `:merchant_id:` into the `listrak:`
    hash. This ID can be obtained from your client's Listrak account.

    Releasing this as a minor version upgrade (v0.12.0) because it depends on
    configuration in secrets.yml that wasn't there before, and will break
    apps in production without a corresponding change to the encrypted data
    bag for this app.

    LISTRAK-10
    Tom Scott

*   Disable Listrak JS in testing.

    When testing the application with Capybara, sometimes Listrak can fail
    the build for random reasons. This definitely shouldn't block feature
    testing an application, as this kind of integration can fail for a wide
    variety of reasons, and we want our tests to depend on the network as
    little as possible. This change surrounds the assignment of the JS
    partial to the application layout with a conditional, that omits adding
    the partial if we are currently in the test environment.

    Example: https://bamboo.tools.workarea.com/browse/ESTUYO-DEV-172/log

    LISTRAK-9
    Tom Scott
