class AddSalaryToPlayers < ActiveRecord::Migration[5.0]
  def change
  	add_column :players, :salary, :integer
  end
end
