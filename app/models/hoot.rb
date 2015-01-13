class Hoot < ActiveRecord::Base
	validates :author, presence: true
	validates :content, presence: true, length: {maximum: 400}
end