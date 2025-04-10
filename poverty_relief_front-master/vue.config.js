const {defineConfig} = require('@vue/cli-service')
module.exports = defineConfig({
    transpileDependencies: true,
    devServer: {
        port: 8089,

    },
    lintOnSave: false,
    chainWebpack: config => {
        config.plugin('html')
            .tap(args => {
                args[0].title = "精准扶贫系统";
                return args;
            })
        // config.plugin('provide').use(webpack.ProvidePlugin, [{
        //     $: 'jquery',
        //     jquery: 'jquery',
        //     jQuery: 'jquery',
        //     'window.jQuery': 'jquery'
        // }])

    }
})
