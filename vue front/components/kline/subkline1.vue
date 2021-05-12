<template>
  <div>
    <h2>实时</h2>
    <el-image :src="imgurl"></el-image>
  </div>
</template>

<script>
  export default {
    name: "subkline1",
    props: ["selectvalue"],
    data() {
      return {
        imgurl: 'http://img1.money.126.net/chart/hs/time/540x360/0' + this.selectvalue + '.png'
      };
    },
    methods: {},
    created() {
      if (this.selectvalue == '') {
        this.$router.push('/kline');
      }
    }


  }
</script>

<style scoped>

</style>
