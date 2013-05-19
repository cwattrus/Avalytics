var update_pie_chart = function(url, selector){
  $.getJSON(url, function(data){
    nv.addGraph(function() {
      var chart = nv.models.pieChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .showLabels(true)
          .height(600)
          .color(["#c06040", "#e0c080", "#a0a0a0", "#808040", "#e0f0f0", "#e0e0a0", "#806040", "#606040"])
          .tooltipContent(function(key, y, e, graph) {
            return '<div class="popover-title"><div class="lead">' + key + '</div>' +
                   '<div class="lead"><strong>' +  parseInt(y,10) + '</strong></div></div>'
          });

      d3.select(selector)
          .datum(data)
          .transition().duration(1000)
          .call(chart);

      nv.utils.windowResize(chart.update);
      return chart;
    });
  });
};