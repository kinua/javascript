window.app = {}
app.routers = {}
app.models = {}
app.collections = {}
app.views = {}

MainRouter = require('routers/main_router').MainRouter
HomeView = require('views/home_view').HomeView

{Projector} = require 'models/projector'

{MenuList} = require 'collections/menu_list'
{VideoList} = require 'collections/video_list'

{MenuListView} = require 'views/menu_list_view'
{ContentView} = require 'views/content_view'
{VideoListView} = require 'views/video_list_view'

# app bootstrapping on document ready
$(document).ready ->
  app.initialize = ->
    app.routers.main = new MainRouter()

    app.models.projector = new Projector()

    app.collections.menuList = new MenuList()
    app.collections.videoList = new VideoList()

    app.views.home = new HomeView()
    app.views.menuListView = new MenuListView
      collection: app.collections.menuList
    app.views.contentView = new ContentView
      projector: app.models.projector
      videoList: app.collections.videoList
    
    app.collections.menuList.fetch()
    app.collections.videoList.fetch()

    app.routers.main.navigate 'home', true if Backbone.history.getFragment() is ''
  app.initialize()
  Backbone.history.start()
