class User < ApplicationRecord
    has_many :owners
    has_many :posts
    has_many :messages

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email_address, presence: true

    def blogs
        Blog.joins(:owners).where("owners.user_id= ?", id)
    end
end
