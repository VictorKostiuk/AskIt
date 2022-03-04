# frozen_string_literal: true

# 30.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4)
#   Question.create title: title, body: body
# end

User.find_each { |u| u.send(:set_gravatar_hash) ; u.save}