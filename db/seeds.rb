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
    {title: "Too Much Tuna", content: "This is too much tuna!"},
    {title: "Look At This Photograph", content: "How aboot this photograph of Tim Horton's, eh?"},
    {title: "Canadians Like Tuna", content: "We gave Nickelback too much tuna!"}
])

comments = Comment.create([
  {content: "Look at all that tuna!", post: posts[0]},
  {content: "Your music is an embarrassment to Canadia!", post: posts[1]},
  {content: "We're making a song aboot this tuna!", post: posts[2]}
])
