# Authentic Pixels

**Digital products shop & blog created using Phoenix Framework (Elixir)**

-----

##### Demo: [Authentic Pixels](https://www.authenticpixels.com)

-----

This project has been a great learning experience for me. Coming from Ruby on Rails, there are a lot of things that are done differently in Elixir/Phoenix.  Some of the things that this project helped me wrap my head around are -

- **Nested records & associations:** Adding & deleting records dynamically was a challenging exercise. I needed to create a nested association where a *product can have many variants*. I also needed to be able to add & remove variants dynamically from using a form. Check `variant.ex`, `templates/admin/products/form.ex` and `views/admin/product_view.ex` to see how I implemented this.

- **Handling many-to-many associations and validating them:** This actually turned out to be quite tricky. I wanted *product to have many categories* and *category to have many products*. I also wanted to ensure that when I am creating a product, I have chosen a category for it. Please check `/lib/utils/many_to_many.ex` to see how I solved it. If you have a better approach, do let me know.

- **Uploading images:** Since I plan to host this website on Heroku, I had to choose from S3 or Cloudinary for saving all my uploaded images (product images, blog post images etc.). I decided to go with Cloudinary because it seems like a painless way to handle uploads & image transformations. Cloudinary also provides a way to backup all you images to S3 which is quite nice. I have used an elixir package called [Cloudini](...) to uplaod my images to my Cloudinary account. Setting it up was quite trivial, you can either refer to the docs or check my `web/controllers/admin/product_image_controller.ex`.

- **Testing:** I haven't written exhausting tests for this project yet. I only have model and controller tests. I have been tinkering with the Hound library and I plan to write some integration tests pretty soon. When I was starting out, one thing that I missed was a way to automatically run the tests when I update the relevant files (something like Guard for Ruby/Ruby on rails projects). I found a package called 'test.watch'. It works well but my only issue with it is that it runs all the tests not just the tests relevant to the file that I am currently changing. Another issue that I found is that there is no way to 'focus' on one particular test. If anyone knows how to implement this, do let me knows

- **Switching to Webpack from Brunch:** Phoenix uses Brunch as the default asset bundler. I tinkered around with Brunch a little but and I think it is a pretty great tool. The only reason I switched to Webpack is that I have used it before in other projects and I can find my way around it easily.
Replacing Brunch with Webpack was very trivial, just add webpack and friends in your `package.json` file and change `dev.exs` to this -
```
config :ap, Ap.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: ["node_modules/.bin/webpack", "--watch", "--colors"]
  ]
```

-----------

### Installation

1. Clone the repository and install the dependencies
```
git clone git@github.com:authentic-pixels/exshop.git
cd exshop
mix deps.get
npm install
```

2. Create the database and run the migrations
```
mix ecto.create
mix ecto.migrate
```

4. Create an admin user. You can change the email and password in `priv/repo/seeds.exs` file.
```
mix run priv/repo/seeds.exs
```

5. Add your Cloudinary keys. Create a file called `dev.secret.exs` inside `config` folder with the following contents. Be sure to change the 'name', 'api_key' and 'api_secret' fields.
```
use Mix.Config
config :cloudini,
  api_key: "CHANGE_ME",
  api_secret: "CHANGE_ME",
  name: "CHANGE_ME",
  stub_requests: false,
  http_options: [timeout: 15000]
```

5. Start the server
```
iex -S mix phoenix.server
```
Now visit http://localhost:4000/ to see the frontend version. To access the admin area, visit http://localhost:4000/admin. You can login with the email and password set in `priv/repo/seeds.exs`.


------

### Running tests

1. Set up your test database
```
MIX_ENV=test mix ecto.reset
```

2. Run all the tests on file change
```
mix test.watch
```

-----------

### Todo

- Create RSS feeds
- Create sitemaps
- Add archives page to blog
- Write integration tests for admin area
- Create Google AMP versions for product & blog pages.


--------

For any questions/comments/suggestions, drop me a line at - [bharani@authenticpixels.com](mailto:bharani@authenticpixels.com) or send me a [tweet](https://twitter.com/bharani91).

Thanks,

Bharani -
**[Authentic Pixels - Free & Premium Web Resources](https://www.authenticpixels.com)**
