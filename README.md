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
* eliminate XSS attacks on client local storage by storing jwt in cookie config'ed with 'http_only' & 'secure'. The signed jwt is essentially plain text (base64 encoded), so implement encrypt/decrypt during read/write/auth token. Keep rails csrf protection unaffected.
- learned about content negotiation, cool
- todo: swap in fast json serializer
- liked the exception handling to keep code simple
- nice use of helper modules
