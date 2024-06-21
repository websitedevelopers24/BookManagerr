# app/models/book.rb
class Book < ApplicationRecord
    has_one_attached :cover_image
  
    validates :title, presence: true
    validates :author, presence: true
  
    validate :publication_date_cannot_be_in_the_future
  
    private
  
    def publication_date_cannot_be_in_the_future
      if publication_date.present? && publication_date > Date.today
        errors.add(:publication_date, "can't be in the future")
      end
    end
  end
  