class Entity < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def self.getEntity(entity_id, entity_type)
    Entity.where(
      "entity_id = ? AND entity_type = ?",
      entity_id,
      entity_type
    ).take
  end
end
