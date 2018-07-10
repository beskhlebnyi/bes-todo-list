class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many  :lists, dependent: :destroy
end
