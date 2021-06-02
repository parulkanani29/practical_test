class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum role: %i[doctor patient]

  scope :doctors, -> { where(role: 'doctor') }
  scope :patients, -> { where(role: 'patient') }

  # has_many :appointments
  has_many :patient_appointments, foreign_key: "patient_id", class_name: "Appointment"
  has_many :doctor_appointments, foreign_key: "doctor_id", class_name: "Appointment"
end
