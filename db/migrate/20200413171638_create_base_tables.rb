class CreateBaseTables < ActiveRecord::Migration[5.1]
  def change
    create_table :mortgage_reports do |t|
      t.integer :total_mortgage
      t.integer :pending_mortgage
      t.string :regular_in_payment
      t.belongs_to :address, index: true, null: false
      t.timestamps null: false
    end

    create_table :credit_reports do |t|
      t.integer :credit_score
      t.belongs_to :applicant, index: true, null: false
      t.timestamps null: false
    end

    create_table :addresses do |t|
      t.text :street, null: false
      t.text :unit_number
      t.text :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :county, null: false
      t.belongs_to :decision_request, index: true, null: false
      t.timestamps null: false
    end

    create_table :applicants do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :encrypted_ssn, null: false
      t.string :encrypted_ssn_iv
      t.float :income, null: false
      t.string :income_type
      t.float :requested_loan_amount, null: false
      t.belongs_to :decision_request, index: true, null: false
      t.timestamps null: false
    end

    create_table :decisions do |t|
      t.string :rule_name
      t.string :decision
      t.string :message
      t.belongs_to :decision_request, index: true, null: false
      t.timestamps null: false
    end

    create_table :decision_requests do |t|
      t.integer :application_id
      t.string :decision
      t.timestamps null: false
    end
  end
end
