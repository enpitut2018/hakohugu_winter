const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const customConfig = require('./custom')

environment.loaders.append('vue', vue)
// Merge custom config
environment.config.merge(customConfig)
module.exports = environment
