# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_application_session',
  :secret      => '67c2911fd98e5462e30f6083c388c385026a9c6a4c33bed7b0d20b1860b7e288b0c9ae9aa2efb109d788fcffbba5c545bea59773b04187223a6c506fdc4520a8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
