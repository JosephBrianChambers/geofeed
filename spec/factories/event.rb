FactoryBot.define do
  factory :event do
    start_time { 2.hours.ago }
    end_time { Time.now }
    loc_fence "POLYGON ((-13628970.563588852 4548232.494052839, -13626715.671254437 4548232.494052839, -13626715.671254437 4549589.251304904, -13628970.563588852 4549589.251304904, -13628970.563588852 4548232.494052839))"

    trait :with_moments do
      transient { moments_count 1 }

      # not using after(:build) here b/c join table records will be invalid without id's
      # for unpersisted model/associations, build in test code
      after(:create) do |event, evaluator|
        event.moments << create_list(:moment, evaluator.moments_count)
      end
    end
  end
end
