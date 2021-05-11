<template>
  <div>
    <h2>月K</h2>
    <el-image :src="imgurl"></el-image>
  </div>
</template>

<script>
  export default {
    name: "subkline6",
    props: ["selectvalue"],
    data() {
      return {
        imgurl: 'http://img1.money.126.net/chart/hs/kline/month/0' + this.selectvalue + '.png'
      };
    },
    methods: {},



  }
</script>

<style scoped>

</style>
