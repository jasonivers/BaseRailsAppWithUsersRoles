class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable #, :registerable

  # Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids
	has_and_belongs_to_many :roles
	define_index do
                indexes :email, :sortable => true
	end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
end
