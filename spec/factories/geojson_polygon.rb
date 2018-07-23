FactoryBot.define do
  factory :geojson_polygon, class: Hash do
    type "Polygon"
    properties { {} }

    trait :sf_vanness do
      coordinates {
        [
          [
            [-122.43112564086914, 37.77885586164994],
            [-122.41086959838866, 37.77885586164994],
            [-122.41086959838866, 37.78848836594184],
            [-122.43112564086914, 37.78848836594184],
            [-122.43112564086914, 37.77885586164994]
          ]
        ]
      }
    end

    trait :sf do
      coordinates {
        [
          [
            [-122.53738403320312,37.6892542140253],
            [-122.33757019042969,37.6892542140253],
            [-122.33757019042969,37.81792077237497],
            [-122.53738403320312,37.81792077237497],
            [-122.53738403320312, 37.6892542140253]
          ]
        ]
      }
    end

    initialize_with { attributes.stringify_keys }
  end

  factory :geojson_polygon_feature, class: Hash do
    type "Feature"
    properties { {} }

    trait :sf_vanness do
      geometry {
        {
          "type" => "Polygon",
          "coordinates" => [
            [
              [-122.43112564086914, 37.77885586164994],
              [-122.41086959838866, 37.77885586164994],
              [-122.41086959838866, 37.78848836594184],
              [-122.43112564086914, 37.78848836594184],
              [-122.43112564086914, 37.77885586164994]
            ]
          ]
        }
      }
    end

    initialize_with { attributes.stringify_keys }
  end
end



