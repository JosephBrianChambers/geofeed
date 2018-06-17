FactoryBot.define do
  factory :event do
    start_time { 2.hours.ago }
    end_time { Time.now }
    loc_fence "POLYGON ((-10625674.367581893 5011056.081856389, -10703945.884545928 4531643.040451525, -8972188.571717028 4531643.040451525, -10625674.367581893 5011056.081856389))"

    trait :with_moments do
      transient { moments_count 1 }

      after(:build) do |event, evaluator|
        event.moments = build_list(:moment, evaluator.moments_count, event: event)
      end
    end
  end
end
