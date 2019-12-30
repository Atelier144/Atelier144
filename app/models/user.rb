class User < ApplicationRecord
    mount_uploader :image_name, ImageUploader

    validates :name, uniqueness: true, presence: true
    validates :email, uniqueness: true, allow_nil: true
    validates :twitter_uid, uniqueness: true, allow_nil: true
    validates :new_password_hash, uniqueness: true, allow_nil: true

    has_secure_password

    def find_from_twitter_auth(auth)
        provider = auth[:provider]
        uid = auth[:uid]
    end
end

# :name :string
# :email :string
# :password_digest :string
# :image_name :string
# :introduction :string
# :is_published_introduction :boolean
# :web_site :string
# :is_published_web_site :boolean
# :twitter_uid :string
# :twitter_url :string
# :is_published_twitter_url :boolean
# :new_password_hash :string