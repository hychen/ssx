#!/usr/bin/env lsc -cj
author:
  name: ['Chen Hsin-Yi']
  email: 'hychen@ssxelator.com'
name: 'ssx-web'
description: 'SSX Web'
version: '0.1.1'
main: \lib/index.js
repository:
  type: 'git'
  url: 'git://github.com/tw-ssxeleator/ssx-web.git'
scripts:
  test: """
    mocha
  """
  prepublish: """
    node_modules/LiveScript/bin/lsc -cj package.ls && node_modules/LiveScript/bin/lsc -c app.ls
  """
engines: {node: '0.11.x'}
dependencies:
  "express": "~4.2.0",
  "static-favicon": "~1.0.0",
  "morgan": "~1.0.0",
  "cookie-parser": "~1.0.1",
  "body-parser": "~1.0.0",
  "debug": "~0.7.4",
  "jade": "~1.3.0"
  LiveScript: \1.2.x
devDependencies:
  express: \3.4.x
  mocha: \1.14.x
  supertest: \0.7.x
  chai: \1.8.x
  LiveScript: \1.2.x
