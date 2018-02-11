class CreateReviews < ActiveRecord::Migration
  def change
 create_table :reviews do |t|
      t.text :product_name
      t.string :product_type
      t.string :helpful
      t.string :rating
      t.text :review_text
      t.boolean :positive
      t.boolean :is_helpful
      t.boolean :use_for_train    
      t.timestamps null: false
      
      t.timestamps null: false
    end
  end
end
