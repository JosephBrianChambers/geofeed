# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



my thoughts on https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one
- thanks https://github.com/andela and https://scotch.io/ !
- nice rails api boiler plate as any to get a project up and running
- solid boiler plate to scale/swap off of: versioned api, faker, rspec, pagination, serialization, jwt token based auth
- jwt token based auth security TODOS:
* eliminate XSS attacks on client local storage by storing jwt in cookie config'ed with 'http_only' & 'secure'
* jwt stored in cookie opens CSRF attack, so fix by sending js enabled cookie, dedicated to pass csrf token to client, client must also send it, which server will verify against csrf token encoded in jwt payload
* jwt uses a server side secret to sign essentially plain text (base64 encoded) payload. Don't include sensitive data in jwt payload. As a precausion, encrypt cookie content before storing on cookie. Rails V4 and up does this by default, but should addtionally do this with our jwt encode/decode implementation to keep auth/security more compartmentalized/standalone(if worth trade offs)
- learned about content negotiation, cool
- todo: swap in fast json serializer
- liked the exception handling to keep code simple
- nice use of helper modules
