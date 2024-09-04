local Config = require('config')


return Config:init()
    :append(require('config.appearance'))
    :append(require('config.launch'))
    :append(require('config.bindings'))
    :append(require('config.palette'))
    :append(require('config.domains')).options
