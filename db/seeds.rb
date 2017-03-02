# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
Comment.destroy_all

posts = Post.create([
    {title: "Too Much Steak", content: "This is too much steak i dont think i can eat it all!"},
    {title:"2much2na",content: "Look at all that tuna!"},
    {title: "Special meal in D.C", content: "I love going to District Taco"},
    {title: "Canadians Like Tuna", content: "We gave Nickelback too much tuna!"}
])

comments = Comment.create([
  {content: "Look at all that tuna!", post: posts[0]},
  {content: "Chicken is better", post: posts[0]},
  {content: "We're making a song aboot this tuna!", post: posts[0]}
])
