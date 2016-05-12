Cyber.Views.Builds ||= {}

class Cyber.Views.Builds.IndexView extends Backbone.View
  template: JST["backbone/templates/builds/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (build) =>
    view = new Cyber.Views.Builds.BuildView({model : build})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(builds: @collection.toJSON() ))
    @addAll()

    return this
