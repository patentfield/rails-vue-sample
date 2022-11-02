<template lang="pug">
#page3
  h2 page 3
  p This is page 3
  .graph-wrapper
    graph(:charttype="'barchart2'")

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
