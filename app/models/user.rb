class User < ApplicationRecord
    mount_uploader :image_name, ImageUploader

    validates :name, uniqueness: true, presence: true
    validates :email, uniqueness: true, allow_nil: true
    validates :twitter_uid, uniqueness: true, allow_nil: true
    validates :new_password_hash, uniqueness: true, allow_nil: true

    has_secure_password
end

# :name :string
# :email :string
# :password_digest :string
# :image_name :string
# :introduction :string
# :web_site :string
# :twitter_uid :string
# :twitter_url :string
# :new_password_hash :string

# :is_published_profile :boolean
# :is_published_introduction :boolean
# :is_published_url :boolean
# :is_published_twitter_url :boolean
# :is_published_trecords :boolean