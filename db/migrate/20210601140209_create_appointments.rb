class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.datetime :booking_time
      t.string :description
      t.string :appointment_number
      t.references :patient, foreign_key: { to_table: 'users' }
      t.references :doctor, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
