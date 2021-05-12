<template>
  <el-container>

    <el-select v-model="selectvalue" filterable placeholder="请选择股票">
      <el-option
        v-for="item in mystockdata"
        :key="item.symbol"
        :label="item.name"
        :value="item.symbol">
      </el-option>
    </el-select>
    <el-container>
      <el-aside width="120px">
        <el-row class="tac">
          <el-col :span="20">
            <h5>导航栏</h5>
            <el-menu
              default-active="subactiveIndex"
              class="el-menu-vertical-demo" @select="handleSelect">
              <el-menu-item index="/kline/subkline1">
                <span slot="title">分时</span>
              </el-menu-item>
              <el-menu-item index="/kline/subkline2">
                <span slot="title">日K(1月)</span>
              </el-menu-item>
              <el-menu-item index="/kline/subkline3">
                <span slot="title">月K(1季)</span>
              </el-menu-item>
              <el-menu-item index="/kline/subkline4">
                <span slot="title">日K(半年)</span>
              </el-menu-item>
              <el-menu-item index="/kline/subkline5">
                <span slot="title">周K</span>
              </el-menu-item>
              <el-menu-item index="/kline/subkline6">
                <span slot="title">月K</span>
              </el-menu-item>
            </el-menu>
          </el-col>
        </el-row>
      </el-aside>
      <el-main>
        <router-view :selectvalue="selectvalue"></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
  export default {
    name: "kine",
    props: ["username"],
    data() {
      return {
        subactiveIndex: this.$route.path,
        selectvalue: "",
        selectValueAndName: [],
        mystockdata: []
      };
    },
    methods: {
      handleSelect(key, keyPath) {
        if (this.selectvalue !== '') {
          console.log(key);
          console.log(keyPath);
          console.log(this.username);
          this.$router.push(key);
        } else {
          alert("请先选择股票")
        }
      },
      findMyStock() {
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/stock/findMystock/",
          data: _this.$qs.stringify({params_1: _this.username}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res.data);
          _this.mystockdata = res.data;
          _this.selectvalue = _this.mystockdata[0].symbol;
        }).catch(function (err) {
          console.log(err);
        })
      },
    },
    created() {
      this.findMyStock()
    },


  }
</script>

<style scoped>

</style>
