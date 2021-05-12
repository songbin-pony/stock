<template>
  <div>
  <el-carousel :interval="5000" arrow="always" style="height:520px">
    <el-carousel-item v-for="item in imgs" :key="item" style="height:480px">
      <el-image :src="item.link" fit="contain"></el-image>
    </el-carousel-item>
  </el-carousel>
  </div>
</template>

<script>
  import img1 from '../assets/a.jpg'
  //注意这种导入图片的方法
  export default {
    name: "Index",
    data() {
      return {
        imgs: [],
      }
    },
    methods: {
      findAll() {
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/banner/findall/",
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          _this.imgs = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      }
    },
    created() {
      this.findAll();
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
