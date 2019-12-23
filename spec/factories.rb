FactoryBot.define do
  factory :gram do
    sequence :message do |n|
      "From FactoryBot; message #{n}."
    end
  end
end