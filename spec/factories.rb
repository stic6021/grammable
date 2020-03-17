FactoryBot.define do
  factory :gram do
    sequence :message do |n|
      "From FactoryBot; message #{n}."
    end
  end

  factory :user do
    email { 'no_reply@domain.com' }
    password { 'anything' }
    encrypted_password { 'k@b;f(r!x+t#'}
  end
end