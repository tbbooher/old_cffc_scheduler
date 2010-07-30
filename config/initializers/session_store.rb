# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scheduler_session',
  :secret      => '647d093a9fffd921e395aae08500ecc359ee8c405df5b39e5aeb4af5743ceb020a231678f65f24e5c1835bd485fb6e629c4ade3c6ef0efb3bd9fffec222b9505'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
