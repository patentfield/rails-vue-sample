<template lang="pug">
  #graph-area

</template>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

<script>
import { mapGetters } from "vuex";
import Plotly from 'plotly.js-dist';

export default {
  props: ['charttype'],
  data: function () {
    return {
      message: "graph component",
    };
  },
  computed: {
    ...mapGetters({
      trace: "trace",
    }),
  },
  mounted() {
    console.log("graph component mounted");
    console.log(this.charttype);
    switch(this.charttype) {
      case 'barchart':
        this.drawBarChart();
        break;
      case 'piechart':
        this.drawPieChart();
        break;
      case 'barchart2':
        this.drawBarChart2();
        break;
      case 'linechart':
        this.drawLineChart();
        break;
      default:
    }
  },
  methods: {
    drawGraph (id, traces, layout, options) {
      var WIDTH_IN_PERCENT_OF_PARENT, gd, left, top;
      WIDTH_IN_PERCENT_OF_PARENT = 100;
      gd = document.getElementById(id);
      gd.style.width = WIDTH_IN_PERCENT_OF_PARENT + '%';
      gd.style.height = 400 + 'px';
      gd.style.margin - (left = (100 - WIDTH_IN_PERCENT_OF_PARENT) / 2 + '%');
      gd.style.margin - (top = 0 + 'px');
      Plotly.newPlot(id, traces, layout, options);
    },
    drawBarChart () {
      var trace1 = {
        x: ['giraffes', 'orangutans', 'monkeys'],
        y: [20, 14, 23],
        name: 'SF Zoo',
        type: 'bar'
      };

      var trace2 = {
        x: ['giraffes', 'orangutans', 'monkeys'],
        y: [12, 18, 29],
        name: 'LA Zoo',
        type: 'bar'
      };
      var data = [trace1, trace2];
      var layout = {barmode: 'group'};

      this.drawGraph("graph-area", data, layout, {});
    },
    drawPieChart () {
      var data = [{
        values: [19, 26, 55],
        labels: ['Residential', 'Non-Residential', 'Utility'],
        type: 'pie'
      }];

      var layout = {
        height: 400,
        width: 500
      };

      this.drawGraph("graph-area", data, layout, {});
    },
    drawBarChart2 () {
      var trace = {
        x: this.trace['x'],
        y: this.trace['y'],
        name: 'Search Word',
        type: 'bar'
      };
      var data = [trace];
      var layout = {title: '検索ワード別ヒット件数'};

      this.drawGraph("graph-area", data, layout, {});
    },
    drawLineChart () {
      var trace = {
        x: this.trace['z'],
        y: this.trace['y'],
        type: 'scatter'
      };

      var data = [trace];
      
      this.drawGraph("graph-area", data, layout, {});
    },
  },
};
</script>
