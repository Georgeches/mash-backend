class Order < ApplicationRecord
   belongs_to :merchandiser

  validates :customer_name, presence: true
  validates :products_ordered, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :merchandiser_id, presence: true
end
