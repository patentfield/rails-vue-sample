<template lang="pug">
#page2
  h2 page 2
  p This is page 2

</template>

<script>
export default {
  data: function () {
    return {
      message1: "Hello Vue!",
    };
  },
};
</script>

<style lang="scss" scoped>
p {
  font-size: 3em;
  text-align: center;
}
</style>
