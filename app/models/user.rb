class User < ApplicationRecord
    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness:true}
    validates :password, {length:{within: 8...32}}
    
    has_secure_password
end
