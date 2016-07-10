class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
    has_many :wikis
    before_create :default_user_role_standard

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def publicize_wikis_if_standard
    if standard?
      wikis.each do |wiki|
        wiki.public = true
        wiki.save
      end
    end
  end
  
  private

  def default_user_role_standard
    self.role ||= 'standard'
  end
end
