# Project 2 Evaluation

## Technical Requirements
**2: Performing**
>The app contains 2 models, with at least 1 association. At least 1 model is full CRUD.

## Creativity and Interface
**1: Progressing**
>The app is styled and has an interface of value to the end user: it is not just a nav bar and an index page

>Consider making the layout more robust and bringing in flexbox

## Code Quality
**1: Progressing**
>Code lacks proper formatting, includes commented out, non-functional code, or otherwise contains major issues of quality (DRY, naming, etc)

>Overall good work, just need to do an edit to address a few bugs and get rid of unused code.

## Deployment and Functionality
**0: Incomplete**
>Application is not deployed

>Once you make the corrections suggested in the code comments, try walking through the Heroku CLI deployment guide again.


## Planning / Process / Submission
**1: Progressing**
>App is submitted, with basic evidence of planning. Documentation exists, but lacks common areas such as setup instructions, description of application functionality and link to deployed application

>Be sure to write up your readme.md with the content required in the project prompt

## Summary of Inline Code Comments

```diff
diff --git a/app/assets/stylesheets/application.css b/app/assets/stylesheets/application.css
index f001a94..e38e4ea 100644
--- a/app/assets/stylesheets/application.css
+++ b/app/assets/stylesheets/application.css
@@ -46,6 +46,10 @@
    position: absolute;
    top: 50;
    left: 50;
+   width: 100vw;
+   /*This is to ensure that the video extends across the page on different-sized
+   screens. See this article on how to ensure perfect fit across all screen sizes:
+   https://slicejack.com/fullscreen-html5-video-background-css/*/
  }

  main {
diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
index 4e5617f..b011ce8 100644
--- a/app/controllers/application_controller.rb
+++ b/app/controllers/application_controller.rb
@@ -1,4 +1,5 @@
 class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   before_action :authenticate_user!
+  # Nice use of before_action to authenticate login
:...skipping...
diff --git a/app/assets/stylesheets/application.css b/app/assets/stylesheets/application.css
index f001a94..e38e4ea 100644
--- a/app/assets/stylesheets/application.css
+++ b/app/assets/stylesheets/application.css
@@ -46,6 +46,10 @@
    position: absolute;
    top: 50;
    left: 50;
+   width: 100vw;
+   /*This is to ensure that the video extends across the page on different-sized
+   screens. See this article on how to ensure perfect fit across all screen sizes:
+   https://slicejack.com/fullscreen-html5-video-background-css/*/
  }

  main {
diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
index 4e5617f..b011ce8 100644
--- a/app/controllers/application_controller.rb
+++ b/app/controllers/application_controller.rb
@@ -1,4 +1,5 @@
 class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   before_action :authenticate_user!
+  # Nice use of before_action to authenticate login
 end
diff --git a/app/controllers/comments_controller.rb b/app/controllers/comments_controller.rb
index fe97adc..fd064aa 100644
--- a/app/controllers/comments_controller.rb
+++ b/app/controllers/comments_controller.rb
@@ -7,18 +7,24 @@ class CommentsController < ApplicationController

   def create
     @post = Post.find(params[:post_id])
-    @comment = @post.comments.create(comment_params)
+    @comment = @post.comments.create(comment_params.merge(user: current_user))
     redirect_to post_path(@post)
   end

   def edit
     @post = Post.find(params[:post_id])
     @comment = Comment.find(params[:id])
+    unless @comment.user == current_user
+      redirect_to :back
+    end
   end

   def update
     @post = Post.find(params[:post_id])
     @comment = Comment.find(params[:id])
+    unless @comment.user == current_user
+      redirect_to :back
+    end
     @comment.update(comment_params)
     redirect_to post_path(@post)
   end
@@ -26,6 +32,9 @@ class CommentsController < ApplicationController
   def destroy
     @post = Post.find(params[:post_id])
     @comment = Comment.find(params[:id])
+    unless @comment.user == current_user
+      redirect_to :back
+    end
     @comment.destroy
     redirect_to post_path(@post)
   end
diff --git a/app/controllers/posts_controller.rb b/app/controllers/posts_controller.rb
index 188742a..d24b4ff 100644
--- a/app/controllers/posts_controller.rb
+++ b/app/controllers/posts_controller.rb
@@ -13,22 +13,33 @@ class PostsController < ApplicationController
   end

   def create
-    @post = Post.create!(post_params)
+    @post = Post.create!(post_params.merge(user: current_user))
     redirect_to post_path(@post)
   end

   def edit
     @post = Post.find(params[:id])
+    unless @post.user == current_user
+      redirect_to :back
+    end
+    # We also should test that the user is allowed to modify posts in our controller
+    # actions, like above
   end

   def update
     @post = Post.find(params[:id])
+    unless @post.user == current_user
+      redirect_to :back
+    end
     @post.update(post_params)
     redirect_to post_path(@post)
   end

   def destroy
     @post = Post.find(params[:id])
+    unless @post.user == current_user
+      redirect_to :back
+    end
     @post.destroy
     redirect_to posts_path
   end
diff --git a/app/models/comment.rb b/app/models/comment.rb
index 4e76c5b..a11d158 100644
--- a/app/models/comment.rb
+++ b/app/models/comment.rb
@@ -1,3 +1,4 @@
 class Comment < ActiveRecord::Base
   belongs_to :post
+  belongs_to :user
 end
diff --git a/app/models/post.rb b/app/models/post.rb
index 1056b4d..cb5a7ce 100644
--- a/app/models/post.rb
+++ b/app/models/post.rb
@@ -1,4 +1,7 @@
 class Post < ActiveRecord::Base
+  belongs_to :user
   has_many :comments, dependent: :destroy
-  #  belongs_to :user, optional: :true
+  # To properly associate posts with their users, you should uncomment the line above,
+  # add a User in your seed data, and update all of the posts in the seed data with
+  # that user as their user:. Also do the same for comments.
 end
diff --git a/app/models/user.rb b/app/models/user.rb
index 7982420..1f99cc2 100644
--- a/app/models/user.rb
+++ b/app/models/user.rb
@@ -5,4 +5,5 @@ class User < ApplicationRecord
          :recoverable, :rememberable, :trackable, :validatable

          has_many :posts
+         has_many :comments
 end
diff --git a/app/views/comments/index.html.erb b/app/views/comments/index.html.erb
index e69de29..9618ba5 100644
--- a/app/views/comments/index.html.erb
+++ b/app/views/comments/index.html.erb
@@ -0,0 +1 @@
+<%# You can delete any unused view templates, like this one %>
diff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb
index 9fad3bc..9bd8435 100644
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
@@ -11,11 +11,14 @@
 <body>
   <%= video_tag "awesome Sony ultra hd food 4K Demo video 2016", autoplay: :autoplay, loop: :loop, mute: :mute, class: "video" %>
   <main>
+    <%# Maybe think about formatting these alerts and links into a navbar affixed
+    to the top of the page %>
     <p class="notice"><%= notice %></p>
     <p class="alert"><%= alert %></p>
     <!-- <%= image_tag('scribble.png') %>
     <%= link_to "Sign Up", new_user_registration_path %> -->
-
+    <%# Be careful commenting out code in ERB like above, it can cause errors. The proper
+    format is like this. %>
     <% if !current_user %>
         <%= link_to "Sign Up", new_user_registration_path %>
         <%= link_to "Sign In", new_user_session_path %>
diff --git a/app/views/posts/index.html.erb b/app/views/posts/index.html.erb
index 91c50a8..9d5ae29 100644
--- a/app/views/posts/index.html.erb
+++ b/app/views/posts/index.html.erb
@@ -3,6 +3,8 @@
   <% @posts.each do |post| %>
     <div>
       <h2><%= link_to post.title, post_path(post) %></h2>
+      <p>by <%= post.user.email %></p>
+      <%# Now that posts are associated with users, you can list the author for every post / comment %>
       <p>Last Update: <%= post.updated_at %></p>
       <p><%= post.content %></p>
     </div>
diff --git a/app/views/posts/show.html.erb b/app/views/posts/show.html.erb
index f1091bd..209d968 100644
--- a/app/views/posts/show.html.erb
+++ b/app/views/posts/show.html.erb
@@ -1,18 +1,25 @@
 <%= link_to "Back", posts_path %>
 <article>
   <h2><%= @post.title %></h2>
+  <p>by <%= @post.user.email %></p>
   <p>Last Update: <%= @post.updated_at %></p>
   <p><%= @post.content %></p>
-  <%= link_to "Edit Post", edit_post_path(@post) %>
-  <%= link_to "Delete Post", post_path(@post), method: :delete %>
+  <% if @post.user == current_user %>
+    <%= link_to "Edit Post", edit_post_path(@post) %>
+    <%= link_to "Delete Post", post_path(@post), method: :delete %>
+  <% end %>
+  <%# And now with user associations, you can set up user permissions. Like only
+  allowing the owner of the post to edit / delete it (if statement above) %>
   <h4>Comments</h4>
   <%= link_to "Add New Comment", new_post_comment_path(@post) %>
   <% @post.comments.each do |comment| %>
     <div>
-      <p>Last Update: <%= comment.updated_at %></p>
+      <p><%= comment.user.email %> - <%= comment.updated_at %></p>
       <p><%= comment.content %></p>
-      <%= link_to "Edit Comment", edit_post_comment_path(@post, comment) %>
-      <%= link_to "Delete Comment", post_path(@post), method: :delete %>
+      <% if comment.user == current_user %>
+        <%= link_to "Edit Comment", edit_post_comment_path(@post, comment) %>
+        <%= link_to "Delete Comment", post_path(@post), method: :delete %>
+      <% end %>
     </div>
   <% end %>
 </article>
diff --git a/config/routes.rb b/config/routes.rb
index d25810d..a8fbee9 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,6 +1,7 @@
 Rails.application.routes.draw do
   devise_for :users
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
+  # Good job setting up a root route and using nested resources appropriately
   root to: "posts#index"
   resources :posts do
     resources :comments
diff --git a/db/controller.rb b/db/controller.rb
deleted file mode 100644
index 8e70b52..0000000
--- a/db/controller.rb
+++ /dev/null
@@ -1,5 +0,0 @@
-ActiveRecord::Base.establish_connection(
-  :adapter => "postgresql",
-  :database => "food-journal_development"
-  :database => "food-journal_test"
-)
diff --git a/db/migrate/20170227192025_devise_create_users.rb b/db/migrate/20170227192025_devise_create_users.rb
index f577233..e9e817f 100644
--- a/db/migrate/20170227192025_devise_create_users.rb
+++ b/db/migrate/20170227192025_devise_create_users.rb
@@ -1,4 +1,5 @@
 class DeviseCreateUsers < ActiveRecord::Migration[5.0]
+  # Nice use of devise for setting up your User model and data
   def change
     create_table :users do |t|
       ## Database authenticatable
diff --git a/db/migrate/20170227194734_create_posts.rb b/db/migrate/20170227194734_create_posts.rb
index 3e95b6b..cc535f0 100644
--- a/db/migrate/20170227194734_create_posts.rb
+++ b/db/migrate/20170227194734_create_posts.rb
@@ -3,6 +3,7 @@ class CreatePosts < ActiveRecord::Migration[5.0]
     create_table :posts do |t|
       t.string :title
       t.string :content
+      t.references :user, foreign_key: true
       t.timestamps
     end
   end
diff --git a/db/migrate/20170228151209_create_comments.rb b/db/migrate/20170228151209_create_comments.rb
index b323851..58f93d3 100644
--- a/db/migrate/20170228151209_create_comments.rb
+++ b/db/migrate/20170228151209_create_comments.rb
@@ -3,6 +3,8 @@ class CreateComments < ActiveRecord::Migration[5.0]
     create_table :comments do |t|
       t.text :content
       t.references :post, foreign_key: true
+      t.references :user, foreign_key: true
+      # Good job specifying that the reference is a foreign key ++
       t.timestamps
     end
   end
diff --git a/db/schema.rb b/db/schema.rb
index 434b274..40aea9a 100644
--- a/db/schema.rb
+++ b/db/schema.rb
@@ -18,16 +18,20 @@ ActiveRecord::Schema.define(version: 20170228151209) do
   create_table "comments", force: :cascade do |t|
     t.text     "content"
     t.integer  "post_id"
+    t.integer  "user_id"
     t.datetime "created_at", null: false
     t.datetime "updated_at", null: false
     t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
+    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
   end

   create_table "posts", force: :cascade do |t|
     t.string   "title"
     t.string   "content"
+    t.integer  "user_id"
     t.datetime "created_at", null: false
     t.datetime "updated_at", null: false
+    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
   end

   create_table "users", force: :cascade do |t|
@@ -48,4 +52,6 @@ ActiveRecord::Schema.define(version: 20170228151209) do
   end

   add_foreign_key "comments", "posts"
+  add_foreign_key "comments", "users"
+  add_foreign_key "posts", "users"
 end
diff --git a/db/seeds.rb b/db/seeds.rb
index 8409388..badbb0b 100644
--- a/db/seeds.rb
+++ b/db/seeds.rb
@@ -5,20 +5,21 @@
 #
 #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
 #   Character.create(name: 'Luke', movie: movies.first)
+User.destroy_all
 Post.destroy_all
 Comment.destroy_all

-posts = Post.create([
-    {title: "Monday PB&J!", content: "tems Needed: Sliced Bread, Peanut Butter, Jelly, Knife, Plate, Spoon Step 1: Obtain two slices of bread from the loaf of bread and set them down separately on your plate for later use. Pick up the jar of peanut butter in one hand and with the opposite, unscrew the top counter clock wise. After removing the top, set the jar and cap down on the top of the table. Now pick up the jelly jar and open the jar in the same manner as the peanut butter jar and after set the jelly jar and cap down on the table. Step 2: Grab hold of the open jar of peanut butter and pick up the knife with the free hand. Grab a portion of peanut butter with your knife. Put down the peanut butter. With the hand that is now available, pick up one slice of bread from the plate and spread the peanut butter evenly onto the slice of bread using a knife. After completion set down the slice of bread on the plate (peanut butter side face up) and the knife.
+malcom = User.create!(email: "malcom@gmail.com", password: "password")

-Step 3: Pick up the jelly jar and the spoon with your free hand. Insert the spoon into the jelly jar and scoop out a decent portion of jelly. Set down the jelly jar and pick up the slice of bread with no peanut butter on it. Apply the jelly to the slice of bread and spread the jelly so that it is evenly distributed. After completion set the spoon down onto the plate. Step 4: While holding on to the slice of bread with jelly, pick up the slice of bread with peanut butter. Be sure to pick it up from the sides so that you do not stick your fingers. Adjust the slice of bread so that it is held on and open palm. Make sure that both slices of bread are facing the same direction. Bring both pieces of bread together as in a clapping motion."},
-    {title:"2much2na",content: "Look at all that tuna!"},
-    {title: "Special meal in D.C", content: "I love going to District Taco"},
-    {title: "Canadians Like Tuna", content: "We gave Nickelback too much tuna!"}
+posts = Post.create!([
+    {title: "Monday PB&J!",user: malcom, content: "tems Needed: Sliced Bread, Peanut Butter, Jelly, Knife, Plate, Spoon Step 1: Obtain two slices of bread from the loaf of bread and set them down separately on your plate for later use. Pick up the jar of peanut butter in one hand and with the opposite, unscrew the top counter clock wise. After removing the top, set the jar and cap down on the top of the table. Now pick up the jelly jar and open the jar in the same manner as the peanut butter jar and after set the jelly jar and cap down on the table. Step 2: Grab hold of the open jar of peanut butter and pick up the knife with the free hand. Grab a portion of peanut butter with your knife. Put down the peanut butter. With the hand that is now available, pick up one slice of bread from the plate and spread the peanut butter evenly onto the slice of bread using a knife. After completion set down the slice of bread on the plate (peanut butter side face up) and the knife. Step 3: Pick up the jelly jar and the spoon with your free hand. Insert the spoon into the jelly jar and scoop out a decent portion of jelly. Set down the jelly jar and pick up the slice of bread with no peanut butter on it. Apply the jelly to the slice of bread and spread the jelly so that it is evenly distributed. After completion set the spoon down onto the plate. Step 4: While holding on to the slice of bread with jelly, pick up the slice of bread with peanut butter. Be sure to pick it up from the sides so that you do not stick your fingers. Adjust the slice of bread so that it is held on and open palm. Make sure that both slices of bread are facing the same direction. Bring both pieces of bread together as in a clapping motion."},
+    {title:"2much2na",user: malcom, content: "Look at all that tuna!"},
+    {title: "Special meal in D.C",user: malcom, content: "I love going to District Taco"},
+    {title: "Canadians Like Tuna",user: malcom, content: "We gave Nickelback too much tuna!"}
 ])

-comments = Comment.create([
-  {content: "I LOOOOOOOOOOVE PB&J", post: posts[0]},
-  {content: "Chicken is better", post: posts[0]},
-  {content: "We're making a song aboot this jelly!", post: posts[0]}
+comments = Comment.create!([
+  {user: malcom, content: "I LOOOOOOOOOOVE PB&J", post: posts[0]},
+  {user: malcom, content: "Chicken is better", post: posts[0]},
+  {user: malcom, content: "We're making a song aboot this jelly!", post: posts[0]}
 ])
```
