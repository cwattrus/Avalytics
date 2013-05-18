var update_pie_chart = function(url, selector){
    $.getJSON(url, function(data){
      nv.addGraph(function() {
        var h = 400,
            w = 400;

        var chart = nv.models.pieChart()
            .x(function(d) { return d.label })
            .y(function(d) { return d.value })
            .showLabels(true)
            .width(w)
            .height(h)
            .color(["#c06040", "#e0c080", "#a0a0a0", "#808040", "#e0f0f0", "#e0e0a0", "#806040", "#606040"])
            .tooltipContent(function(key, y, e, graph) {
              return '<div class="popover-title"><div class="lead">' + key + '</div>' +
                     '<div class="lead"><strong>' +  parseInt(y,10) + '</strong></div></div>'
            });

          d3.select(selector)
              .datum(data)
              .transition().duration(1200)
              .call(chart);

        return chart;
      });
    });
  };