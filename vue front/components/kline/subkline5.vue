<template>
  <div>
    <h2>周K</h2>
    <el-image :src="imgurl"></el-image>
  </div>
</template>

<script>
  export default {
    name: "subkline5",
    props: ["selectvalue"],
    data() {
      return {
        imgurl: 'http://img1.money.126.net/chart/hs/kline/week/0' + this.selectvalue + '.png'
      };
    },
    methods: {},



  }
</script>

<style scoped>

</style>
