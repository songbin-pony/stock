<template>
  <div>
    <h2>日K(1季)</h2>
    <el-image :src="imgurl"></el-image>
  </div>
</template>

<script>
  export default {
    name: "subkline3",
    props: ["selectvalue"],
    data() {
      return {
        imgurl: 'http://img1.money.126.net/chart/hs/kline/day/90/0' + this.selectvalue + '.png'
      };
    },
    methods: {},



  }
</script>

<style scoped>

</style>
