<template lang="pug">
#page1
  h2 page 1
  p This is page 1

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
