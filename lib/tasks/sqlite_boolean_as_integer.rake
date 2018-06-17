namespace :sqlite_boolean_as_integer do
  desc "Convert specific booleans to integers."
  task convert_to_int: :environment do
    Poll.where("comments_allowed = 't'").update_all(comments_allowed: 1)
    Poll.where("comments_allowed = 'f'").update_all(comments_allowed: 0)
  end
end
