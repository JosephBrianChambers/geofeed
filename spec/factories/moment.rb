FactoryBot.define do
  factory :moment do
    content_provider
    author { association :author, { content_provider: content_provider } }
    loc "POINT (-12972502.534477092 3734037.8655628334)"
    title "A Caption Title"
    caption "a longer description"
    sequence(:provider_id) { |n| "3523850s0x0x00994#{n}" }
  end
end
