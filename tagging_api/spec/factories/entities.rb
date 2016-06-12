FactoryGirl.define do
  factory :entity do
    entity_id "entity1"
    entity_type "Product"
  end

  factory :entity_with_tag, parent: :entity do
    transient do
      tags { FactoryGirl.create(:tag) }
    end

    after_create do |entity, evaluator|
      entity.tags << evaluator.tag
    end
  end
end
