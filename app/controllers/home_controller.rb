class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:get_user_list]
  def index
	# @doctors = User.doctors.includes(:doctor_appointments)
	 @doctors = User.doctors.includes(:doctor_appointments)
	 @doctors = @doctors.select("users.*, (SELECT COUNT(appointments.id) FROM appointments where appointments.doctor_id = users.id) AS total_appointments")
  end

  def get_user_list
  	if params[:flag] == 'doctor'
  		render json: User.doctors 
  	elsif params[:flag] == 'patient'
  		render json: User.patients
  	else
  		render json: User.all
  	end
  end
end
