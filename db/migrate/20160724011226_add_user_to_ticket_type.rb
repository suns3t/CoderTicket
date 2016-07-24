class AddUserToTicketType < ActiveRecord::Migration
  def change
    add_reference :ticket_types, :user, index: true, foreign_key: true
  end
end
