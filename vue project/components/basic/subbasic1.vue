<template>
  <div class="infobox">
    <div>
      <div>股票代码</div>
      <div>交易所代码</div>
      <div>法人代表</div>
      <div>总经理</div>
      <div>董秘</div>
      <div>注册资本</div>


    </div>
    <div>
      <div>{{showdata[0].ts_code}}</div>
      <div v-if="showdata[0].exchange==='SSE'">深交所</div>
      <div v-else>上交所</div>
      <div>{{showdata[0].chairman}}</div>
      <div>{{showdata[0].manager}}</div>
      <div>{{showdata[0].secretary}}</div>
      <div>{{showdata[0].reg_capital}}万</div>

    </div>
    <div>
      <div>注册日期</div>
      <div>所在省份</div>
      <div>所在城市</div>
      <div>公司主页</div>
      <div>电子邮件</div>
      <div>员工人数</div>
    </div>
    <div>
      <div>{{showdata[0].setup_date}}</div>
      <div>{{showdata[0].province}}</div>
      <div>{{showdata[0].city}}</div>
      <div>{{showdata[0].website}}</div>
      <div>{{showdata[0].email}}</div>
      <div>{{showdata[0].employees}}</div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "subbasic1",
    props: ["selectvalue"],
    data() {
      return {
        tscode: this.selectvalue,
        showdata: []
      }
    },
    methods: {
      showdatafunc() {
        let _this = this;
        _this.$http({
          method: 'post',
          url: "http://localhost:8000/basic/basicinfo/",
          data: _this.$qs.stringify({
            params_1: _this.tscode
          }),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res.data);
          _this.showdata = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      }

    },
    created() {
      if (this.selectvalue == '') {
        this.$router.push('/basic');
      } else {
        this.showdatafunc();
      }
    }
  }
</script>

<style scoped>
  .infobox {
    display: flex;
    margin: 20px;
    justify-content: space-around;
  }

  .infobox div div {
    margin-top: 5px;
  }
</style>
