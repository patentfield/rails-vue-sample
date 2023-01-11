<template lang="pug">
#page4
  h2 page 4
  p This is page 4
    .graph-wrapper
      graph(:charttype="'linechart'")
  
  </template>
  
  <script>
  import Graph from "../components/atoms/Graph.vue";
  export default {
    data: function () {
      return {
        message1: "Hello Vue!",
      };
    },
    components: {
      'graph': Graph
    },
  };
  </script>
  
<style lang="scss" scoped>
p {
  font-size: 3em;
  text-align: center;
}
</style>