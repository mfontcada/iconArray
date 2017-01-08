HTMLWidgets.widget({

  name: 'iconArray',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

        // Remove previous
        el.innerHTML = "";

        var grid = HTMLWidgets.dataframeToD3(x.grid);

        var gap = x.gap;

        var w = (width - gap) / x.nrow - gap;
        var h = (height - gap) / x.ncol - gap;

        var svg = d3.select(el).append("svg")
          .attr("width", width)
          .attr("height", height);

        var square = svg.selectAll("g")
          .data(grid)
        .enter().append("g")
          .attr("class", "icon-array")
          .attr("id", function(d, i) {
            return x.ids[i];
          })
          .attr("transform", function(d, i) {
            var x = grid[i].row - 1;
            var y = grid[i].col - 1;
            var mx = x * w + (x + 1) * gap;
            var my = y * h + (y + 1) * gap;
            return "translate(" + mx + "," + my + ")";
          });

        square.append("rect")
          .attr("width", function (d, i) { return w * x.bar[i] })
          .attr("height", h)
          .style("fill", function (d, i) { return x.color[i] })
          .style("fill-opacity", function (d, i) { return x.opacity[i] })
          .style("cursor", "pointer");

        square.append("rect")
          .attr("width", w)
          .attr("height", h)
          .style("fill-opacity", 0)
          .style("stroke", "#000")
          .style("stroke-width", function (d, i) { return x.border[i] })
          .style("cursor", "pointer");

        square.append("text")
          .text(function (d, i) { return x.labels[i] })
          .attr("x", w / 2)
          .attr("y", h / 2)
          .attr("dy", ".35em")
          .style("text-anchor", "middle")
          .style("font-family", "monospace")
          .style("font-size", Math.min(w, h) / 2 + "px")
          .style("font-weight", "bold")
          .style("cursor", "pointer");

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
