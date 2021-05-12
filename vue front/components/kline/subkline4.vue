<template>
  <div>
    <h2>日K(半年)</h2>
    <el-image :src="imgurl"></el-image>
  </div>
</template>

<script>
  export default {
    name: "subkline4",
    props: ["selectvalue"],
    data() {
      return {
        imgurl: 'http://img1.money.126.net/chart/hs/kline/day/180/0' + this.selectvalue + '.png'
      };
    },
    methods: {},



  }
</script>

<style scoped>

</style>
