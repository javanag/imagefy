class SetDefaultForImageViews < ActiveRecord::Migration[6.1]
  def change
    change_column_default :images, :views, from: nil, to: 0
  end
end
