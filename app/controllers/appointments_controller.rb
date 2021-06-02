class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  def index
  	@appointments = Appointment.doctor_appointments(params[:doctor_id])
  end

  def show
  	@appointment = Appointment.find(params[:id])
  end

  def new
  	@doctor_id = params[:doctor_id].present? ? params[:doctor_id] : ''
  	@appointment = Appointment.new
  end

  def create
  	@appointment = current_user.patient_appointments.new(appointment_params) 
  	params[:appointment][:booking_time] = params[:appointment][:booking_time].in_time_zone("Kolkata")
    if @appointment.save   
      flash[:notice] = 'Appointment added!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit appointment!'   
      render :new   
    end   
  end

  def edit
  	@appointment = Appointment.find(params[:id])
  end

  def update
  	@appointment = Appointment.find(params[:id])   
    if @appointment.update_attributes(appointment_params)   
      flash[:notice] = 'Appointment updated!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit appointment!'   
      render :edit   
    end   
  end

  def destroy
  	@appointment = Appointment.find(params[:id])
  	booking_time = @appointment.booking_time.in_time_zone("Kolkata") - 2.hours
  	cancel_time = Time.now.in_time_zone("Kolkata")
  	if booking_time > cancel_time
	  	if @appointment.delete   
	      flash[:notice] = 'Appointment deleted!'   
	    else   
	      flash[:error] = 'Failed to delete this appointment!'   
	    end  
	else
		flash[:error] = 'Appointment can not delete!'   
	end 
	redirect_to root_path   
  end

  private

  def appointment_params   
    params.require(:appointment).permit(:description, :booking_time, :appointment_number, :patient_id, :doctor_id)   
  end
end
