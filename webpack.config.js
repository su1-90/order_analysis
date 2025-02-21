const path = require('path');
const webpack = require('webpack');

module.exports = {
  mode: 'production',
  entry: './app/javascript/packs/application.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'public/packs')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      }
    ]
  },
  resolve: {
    alias: {
      'babel-loader': path.resolve(__dirname, 'node_modules/babel-loader')
    },
    extensions: ['.js'],
    fallback: {
      crypto: false
    }
  },
  plugins: [
    new webpack.LoaderOptionsPlugin({
      options: {
        experiments: {
          topLevelAwait: true,
          importAsync: true,
          importAwait: true
        }
      }
    })
  ]
};
