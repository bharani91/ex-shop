# Authentic Pixels

**Digital goods shop & blog created using Phoenix Framework (Elixir)**

This is the source code for my new website - [Authentic Pixels](https://www.authenticpixels.com).
Through Authentic Pixels, I plan to deliver high quality free & premium web resources including Bootstrap HTML templates, startup landing pages, UI kits, mockups & themes for Ghost & Wordpress.

-----

## Demo & Screenshots

**View the live website here - [Authentic Pixels](https://www.authenticpixels.com)**

Here are some screenshots of the admin area.

![Authentic Pixels - Product Editor](/web/static/assets/images/promo/admin-1.jpg)

![Authentic Pixels - Dashboard](/web/static/assets/images/promo/admin-2.jpg)
-----

This project has been a great learning experience for me. Coming from Ruby on Rails, there are a lot of things that are done differently in Elixir/Phoenix and building this app has helped me understand the "Elixir way" of doing things.

Some of the things that this project helped me wrap my head around are -

1. Nested records & associations (e.g: Product has many variants)
2. Handling many-to-many associations and validating them
3. Uploading images
4. Testing
5. Switching to Webpack from Brunch
6. Creating Sitemaps and running a cron task to regularly run the sitemap generation task
7. Deploying (to a Digital Ocean box using Dokku)
8. Sending HTML emails.
9. Separating admin area from frontend using differnt layouts and scopes in `router.ex`

I will be writing about this is a lot more detail on [my blog](https://www.authenticpixels.com) soon.



-----------

## Installation

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

## Running tests

1. Set up your test database
```
MIX_ENV=test mix ecto.reset
```

2. Run all the tests on file change
```
mix test.watch
```

-----------

## Todo

- [x] Create sitemaps
- [x] Cron task to update sitemaps frequently
- [ ] Add archives page to blog
- [ ] Create RSS feeds
- [ ] Explore Google AMP versions for product/post pages
- [ ] Write integration tests for admin area


--------


## Credits

The Elixir/Phoenix community is really welcoming & responsive. There are tons of nice examples and packages that helped me with my learning. Here are some of the elixir packages that I am using in this project -

- **Comeonin** for password hashing
- **test.watch** for running tests
- **Bamboo** for sending emails
- **Cloudini** for uploading images to Cloudinary
- **Quantum** for running cron tasks
- **Curtail** for truncating HTML snippets
- **XML builder** for generating Sitemaps
- **Kerosene** for pagination


--------


For any questions/comments/suggestions, drop me a line at - [bharani@authenticpixels.com](mailto:bharani@authenticpixels.com) or send me a [tweet](https://twitter.com/bharani91).

Thanks,

Bharani,
**[Authentic Pixels - Free & Premium Web Resources](https://www.authenticpixels.com)**
