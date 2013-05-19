var update_horizontal_bar_chart = function(url, selector){
  $.getJSON(url, function(data){
    nv.addGraph(function() {
      var chart = nv.models.multiBarHorizontalChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .margin({top: 30, right: 20, bottom: 50, left: 175})
          .showValues(true)
          .tooltips(false)
          .showControls(false)
          .showLegend(false);

      chart.yAxis
          .tickFormat(d3.format(',.0'));

      d3.select(selector)
          .datum(data)
        .transition().duration(500)
          .call(chart);

      nv.utils.windowResize(chart.update);

      return chart;
    });
  });
};