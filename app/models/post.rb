class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  # To properly associate posts with their users, you should uncomment the line above,
  # add a User in your seed data, and update all of the posts in the seed data with
  # that user as their user:. Also do the same for comments.
end
