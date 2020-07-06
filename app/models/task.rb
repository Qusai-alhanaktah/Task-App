class Task < ApplicationRecord
    validates :name, :presence => true
    validates :description, :presence => true
    has_one_attached :image
    has_rich_text :description
    # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    def self.search(search)
        where("name LIKE ?", "%#{search}%")
    end
end
