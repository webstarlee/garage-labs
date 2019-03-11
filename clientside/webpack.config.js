var webpack = require('webpack');

module.exports = {
    entry: './main.js',
    output: {
        path: '../public',
        filename: 'js/app.js'
    },
    plugins: [
        // new webpack.optimize.DedupePlugin()
    ],
    module: {
        loaders: [
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            },
            {
                test: /\.js$/,
                loader: 'babel',
                exclude: /node_modules/,
                query: {
                    presets: ['es2015']
                }
            }
        ]
    },
    vue: {
        loaders: {
            js: 'babel?presets[]=es2015'
        }
    },
    resolve: {
        alias: {
            'vue$': 'vue/dist/vue.js'
        }
    }
};