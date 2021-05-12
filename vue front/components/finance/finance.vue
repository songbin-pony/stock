<template>
  <el-container>

    <el-select v-model="selectvalue" filterable placeholder="请选择股票">
      <el-option
        v-for="item in mystockdata"
        :key="item.tscode"
        :label="item.name"
        :value="item.tscode">
      </el-option>
    </el-select>
    <el-container>
      <el-aside width="140px">
        <el-row class="tac">
          <el-col :span="20">
            <h5>导航栏</h5>
            <el-menu
              default-active="subactiveIndex"
              class="el-menu-vertical-demo" @select="handleSelect">
              <el-menu-item index="/finance/subfinance1">
                <span slot="title">利润表</span>
              </el-menu-item>
              <el-menu-item index="/finance/subfinance2">
                <span slot="title">资产负债表</span>
              </el-menu-item>
              <el-menu-item index="/finance/subfinance3">
                <span slot="title">现金流量表</span>
              </el-menu-item>
              <el-menu-item index="/finance/subfinance4">
                <span slot="title">财务指标数据</span>
              </el-menu-item>
              <el-menu-item index="/finance/subfinance5">
                <span slot="title">财务审计意见</span>
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
    name: "finance",
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
          _this.selectvalue = _this.mystockdata[0].tscode;
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
