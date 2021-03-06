class User < ActiveRecord::Base
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :roles
  
  has_many :comments
  
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :lockable
  
  validates :username, presence: true, uniqueness: true
  
  def has_role?(name)
     self.roles.where(name: name).length > 0
  end
  
  # allow users to update their accounts without passwords
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
