# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Post.destroy_all
Comment.destroy_all

malcom = User.create!(email: "malcom@gmail.com", password: "password")

posts = Post.create!([
    {title: "Monday PB&J!",user: malcom, content: "tems Needed: Sliced Bread, Peanut Butter, Jelly, Knife, Plate, Spoon Step 1: Obtain two slices of bread from the loaf of bread and set them down separately on your plate for later use. Pick up the jar of peanut butter in one hand and with the opposite, unscrew the top counter clock wise. After removing the top, set the jar and cap down on the top of the table. Now pick up the jelly jar and open the jar in the same manner as the peanut butter jar and after set the jelly jar and cap down on the table. Step 2: Grab hold of the open jar of peanut butter and pick up the knife with the free hand. Grab a portion of peanut butter with your knife. Put down the peanut butter. With the hand that is now available, pick up one slice of bread from the plate and spread the peanut butter evenly onto the slice of bread using a knife. After completion set down the slice of bread on the plate (peanut butter side face up) and the knife. Step 3: Pick up the jelly jar and the spoon with your free hand. Insert the spoon into the jelly jar and scoop out a decent portion of jelly. Set down the jelly jar and pick up the slice of bread with no peanut butter on it. Apply the jelly to the slice of bread and spread the jelly so that it is evenly distributed. After completion set the spoon down onto the plate. Step 4: While holding on to the slice of bread with jelly, pick up the slice of bread with peanut butter. Be sure to pick it up from the sides so that you do not stick your fingers. Adjust the slice of bread so that it is held on and open palm. Make sure that both slices of bread are facing the same direction. Bring both pieces of bread together as in a clapping motion."},
    {title:"2much2na",user: malcom, content: "Look at all that tuna!"},
    {title: "Special meal in D.C",user: malcom, content: "I love going to District Taco"},
    {title: "Canadians Like Tuna",user: malcom, content: "We gave Nickelback too much tuna!"}
])

comments = Comment.create!([
  {user: malcom, content: "I LOOOOOOOOOOVE PB&J", post: posts[0]},
  {user: malcom, content: "Chicken is better", post: posts[0]},
  {user: malcom, content: "We're making a song aboot this jelly!", post: posts[0]}
])
