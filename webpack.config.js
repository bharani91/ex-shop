var path                = require("path"),
    ExtractTextPlugin   = require("extract-text-webpack-plugin"),
    webpack             = require("webpack"),
    autoprefixer        = require("autoprefixer"),
    embedFileSize       = 100;


function join(dest) { return path.resolve(__dirname, dest); }
function web(dest) { return join("web/static/" + dest); }

var config = module.exports = {
  entry: {
    frontend: web("js/frontend.js"),
    admin: web("js/admin.js")
  },

  output: {
    path: join("priv/static"),
    filename: 'js/[name].js'
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader"
      },
      {
        test: /\.css$/,
        loader: "style-loader!css-loader"
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!postcss-loader!sass-loader")
      },
      {
        test: /\.(ico|txt)$/,
        loader: 'file?name=/[name].[ext]'
      },
      { test: /\.png$/,
        loader: 'url?limit=' + embedFileSize + '&mimetype=image/png' + '&name=/images/[name].[ext]'
      },
      { test: /\.jpg|.jpeg/,
        loader: 'url?limit=' + embedFileSize + '&mimetype=image/jpeg' + '&name=/images/[name].[ext]'
      },
      { test: /\.gif/,
        loader: 'url?limit=' + embedFileSize + '&mimetype=image/gif' + '&name=/images/[name].[ext]'
      },
      { test: /\.svg/,
        include: /assets\/images/,
        loader: 'url?limit=' + embedFileSize + '&mimetype=image/svg+xml' + '&name=/images/[name].[ext]'
      },
      {
        test: /\.(otf|eot|ttf|woff|woff2|svg)(\?.*)?$/,
        exclude: /assets\/images/,
        loader: 'file?name=/fonts/[name].[ext]'
      }
    ]
  },

  postcss: [
    autoprefixer({
      browsers: [
        "Android >= 4",
        "Chrome >= 20",
        "Firefox >= 24",
        "Explorer >= 8",
        "iOS >= 6",
        "Opera >= 12",
        "Safari >= 6"
      ]
    })
  ],

  plugins: [
    new ExtractTextPlugin('css/[name].css'),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      "window.jQuery": "jquery"
    })
  ],
  devtool: 'source-map'
};

// if running webpack in production mode, minify files with uglifyjs
if (process.env.NODE_ENV === "production") {
  config.plugins.push(
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin({ minimize: true })
  );
}
