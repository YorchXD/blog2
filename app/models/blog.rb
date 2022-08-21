class Blog < ApplicationRecord
    has_many :owners
    has_many :posts

    validates :name, presence: true 
    validates :description, presence: true 

    def propietarios
        User.joins(:owners).where("owners.blog_id = ?", id)
    end
end
