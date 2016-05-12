class Cyber.Routers.BuildsRouter extends Backbone.Router
  initialize: (options) ->
    @builds = new Cyber.Collections.BuildsCollection()
    @builds.reset options.builds
    @chart_pass_fail = options.chart_pass_fail
    @chart_durn_time = options.chart_durn_time

  routes:
    ".*"       : "index"

  index: ->
    @view = new Cyber.Views.Builds.IndexView(collection: @builds)
    $("#builds").html(@view.render().el)

    @chartPassFailModel = new ZingChart.ZingChartModel(@chart_pass_fail)
    @chartPassFailView = new ZingChart.ZingChartView({
      model: @chartPassFailModel,
      el: $("#chartPassFail")
    })
    @chartPassFailView.render()

    @chartDurnTimeModel = new ZingChart.ZingChartModel(@chart_durn_time)
    @chartDurnTimeView = new ZingChart.ZingChartView({
      model: @chartDurnTimeModel,
      el: $("#chartDurnTime")
    })
    @chartDurnTimeView.render()
