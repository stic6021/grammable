FactoryBot.define do
  factory :gram do
    sequence :message do |n|
      "From FactoryBot; message #{n}."
    end
  end

  factory :user do
    sequence :email do |n|
      "no_reply-#{n}@domain.com"
    end
    password { "anything-#{rand}" }
    encrypted_password { 'k@b;f(r!x+t#' }
  end
end