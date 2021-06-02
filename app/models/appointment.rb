class Appointment < ApplicationRecord
	belongs_to :patient, class_name: "User"
    belongs_to :doctor, class_name: "User"

    validates :description, :booking_time, presence: true
    validate :validate_booking_time
    scope :doctor_appointments, ->(id) { where(doctor_id: id) }

    after_save    :add_appointment_number

    def add_appointment_number
    	appointment_number = Integer(self.appointment_number) rescue nil
    	update_column(:appointment_number, format('REG%.7d', id)) if self.appointment_number.blank?
    end

    def validate_booking_time
    	existing_time = booking_time.in_time_zone("Kolkata")
    	current_time = Time.now.in_time_zone("Kolkata") + 1.hours
    	if (existing_time < current_time)
    		errors.add(:booking_time, "Please book after #{current_time}")
    	end
    end
end
