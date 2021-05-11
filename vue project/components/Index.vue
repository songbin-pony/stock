<template>
  <el-carousel :interval="5000" arrow="always" style="height:520px">
    <el-carousel-item v-for="item in imgs" :key="item" style="height:480px">
        <el-image :src="item" fit="contain"></el-image>
    </el-carousel-item>
  </el-carousel>
</template>

<script>
  import img1 from '../assets/a.jpg'
  //注意这种导入图片的方法
  export default {
    name: "Index",
    data() {
      return {
        imgs: ["https://img-pre.ivsky.com/img/tupian/pre/202003/26/zaocan-010.jpg", "http://5b0988e595225.cdn.sohucs.com/images/20180922/7e4367e13597439ab30c262c07ce4572.jpeg", "https://t7.baidu.com/it/u=12235476,3874255656&fm=193&f=GIF"]
      }
    }

  }
</script>

<style scoped>
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }

  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
</style>
