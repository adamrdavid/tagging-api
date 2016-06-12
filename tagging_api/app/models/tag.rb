class Tag < ActiveRecord::Base
  has_and_belongs_to_many :entities

  def self.getOrCreateTags(tag_names)
    tags = []

    tag_names.each do |tag_name|
      if Tag.exists? :name => tag_name
        tag = Tag.find_by(name: tag_name)
      else
        tag = Tag.create! :name => tag_name
      end
      tags << tag
    end

    return tags
  end
end
