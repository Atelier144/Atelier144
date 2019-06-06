class User < ApplicationRecord
    mount_uploader :image_name, ImageUploader

    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness:true}

    has_secure_password
    def get_image_name
        if self.image_name.present?
            return self.image_name.url
        else
            return "UserImage.png"
        end
    end
end
