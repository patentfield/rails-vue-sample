const path = require('path')
const glob = require('glob')
const webpack = require('webpack')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const WebpackManifestPlugin = require('webpack-manifest-plugin')

let entries = {}
glob.sync('./frontend/@(pages|components)/**/*.js').map(function(file) {
  let paths = file.split('/')
  let name;
  if (paths.length > 4) {
    name = paths[4].split('.')[0];
  } else {
    name = paths[3].split('.')[0];
  }
  entries[name] = file
})

module.exports = (env, argv) => {
  const IS_DEV = argv.mode === 'development'

  return {
    entry: {
      application: './frontend/init/application.js',
      styles: './frontend/init/styles.scss',
      ...entries
    },
    // devtool: IS_DEV ? 'source-map' : 'none',
    output: {
      filename: 'javascripts/[name]-[hash].js',
      path: path.resolve(__dirname, 'public/assets/')
    },
    plugins: [
      new VueLoaderPlugin(),
      new MiniCssExtractPlugin({
        filename: 'stylesheets/[name]-[hash].css'
      }),
      new WebpackManifestPlugin({
        writeToFileEmit: true
      }),
      new webpack.HotModuleReplacementPlugin()
    ],
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          loader: 'babel-loader'
        },
        {
          test: /\.vue$/,
          loader: 'vue-loader'
        },
        {
          test: /\.pug/,
          loader: 'pug-plain-loader'
        },
        {
          test: /\.(c|sc)ss$/,
          use: [
            {
              loader: MiniCssExtractPlugin.loader,
              options: {
                publicPath: path.resolve(
                  __dirname,
                  'public/assets/stylesheets/'
                )
              }
            },
            {
              loader: "css-loader",
              options: { url: true, sourceMap: true }
            },
            {
              loader: "sass-loader",
              options: { sourceMap: false }
            }
          ]
        },
        {
          test: /\.(jpg|png|gif)$/,
          loader: 'file-loader',
          options: {
            name: 'images/[name]-[hash].[ext]',
            publicPath: 'assets/'
          }
        },
        {
          test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
          use: [
            {
              loader: 'file-loader',
              options: {
                name: 'fonts/[name].[ext]',
                publicPath: '../'
              }
            }
          ]
        }
      ]
    },
    resolve: {
      alias: {
        vue: 'vue/dist/vue.js'
      },
      extensions: [
        '.js',
        '.scss',
        '.css',
        '.vue',
        '.jpg',
        '.png',
        '.gif',
        '.woff',
        '.woff2',
        '.svg',
        '.ttf',
        '.eot',
        ' '
      ]
    },
    performance: {
      maxAssetSize: 1024 * 1024 * 10,
      maxEntrypointSize: 1024 * 1024 * 10
    },
    optimization: {
      splitChunks: {
        cacheGroups: {
          vendor: {
            test: /.(c|sa)ss/,
            name: 'style',
            chunks: 'all',
            enforce: true
          }
        }
      },
      minimize: true
    },
    devServer: {
      host: 'localhost',
      port: 3035,
      publicPath: 'http://localhost:3035/public/assets/',
      contentBase: path.resolve(__dirname, 'public/assets/'),
      hot: true,
      hotOnly: true,
      disableHostCheck: true,
      historyApiFallback: true,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*'
      }
    }
  }
}
