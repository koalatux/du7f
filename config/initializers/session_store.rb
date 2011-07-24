# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
#TODO
ActionController::Base.session = {
  :key         => '_du7f_session',
  :secret      => 'a6a1fbd066d5f8aa596723a68acedf31a9eb460d9f4ecacc675a9cc53017b34ea497c336875ff766c7b66b7218d81f4db7e6cd9a8751942d62fae8dbb10538d7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
