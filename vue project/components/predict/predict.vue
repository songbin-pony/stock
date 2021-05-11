<template>
  <div class="box">
    <div>
      <div class="topselect">
        <div style="margin-right: 30px"><h3>请选择股票</h3></div>
        <el-select v-model="selectvalue" placeholder="请选择" @change="selectTrigger()">
          <el-option
            v-for="item in stock_list"
            :key="item.tscode"
            :label="item.name"
            :value="item.tscode">
          </el-option>
        </el-select>
      </div>
      <div class="topselect">
        <div style="margin-right: 30px"><h3>今日预测股价</h3></div>
        <div v-if="predict_result"><h3>{{predict_result+'元/股'}}</h3></div>
        <div v-else><h3>正在预测中</h3></div>
      </div>
    </div>
    <div id="main" style="width: 800px;height: 600px;"></div>
  </div>
</template>
<script>

  export default {
    name: 'Analysis',
    props: ["username"],
    data() {
      return {
        selectvalue: '',
        data_list: {},
        predict_result: '',
        stock_list: [],
        predict_list: {},
        showdata: [],
        showxdata: [],
        showydata: [],
        firstTimeFlag: true,
      }
    },
    methods: {
      data_extract(tscode) {
        let tscode_data = this.data_list[tscode];
        console.log(this.predict_list);
        console.log(tscode_data);
        this.showxdata = [];
        this.showydata = [];
        for (let i = tscode_data.length - 1; i >= 0; i--) {
          this.showxdata.push(tscode_data[i][0]);
          this.showydata.push(tscode_data[i][1])
        }

      },
      myEcharts() {
        // 基于准备好的dom，初始化echarts实例
        let myChart = this.$echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        let option = {
          title: {
            text: '股价趋势图'
          },
          tooltip: {},
          legend: {
            data: []
          },
          xAxis: {
            data: this.showxdata,
            name: '时间',
            nameLocation: 'middle',
            nameTextStyle: {
              padding: [20, 0, 0, 0]
            },
          },
          yAxis: {
            name: '单位：元/股',
            nameTextStyle: {
              padding: [0, 0, 20, 0]
            },
            nameLocation: "middle"
          },
          series: [{
            name: '数据',
            type: 'line',
            data: this.showydata
          }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
      }
      ,
      selectTrigger() {
        this.data_extract(this.selectvalue);
        this.myEcharts();
        this.predict_result = this.predict_list[this.selectvalue];
      },
      async predictdata() {
        let _this = this;
        await this.$http({
          method: 'post',
          url: "http://localhost:8000/stock/predict_data/",
          data: _this.$qs.stringify({params_1: _this.username}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res.data);
          _this.data_list = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      },
      async predictstock() {
        let _this = this;
        await this.$http({
          method: 'post',
          url: "http://localhost:8000/stock/predict_result/",
          data: _this.$qs.stringify({params_1: _this.username}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          _this.predict_list = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      },
      async predictlist() {
        let _this = this;
        await this.$http({
          method: 'post',
          url: "http://localhost:8000/stock/predict_list/",
          data: _this.$qs.stringify({params_1: _this.username}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          _this.stock_list = res.data;
          _this.selectvalue = res.data[0].tscode;
          console.log(_this.stock_list[0].name);
        }).catch(function (err) {
          console.log(err);
        })
      },
      async initData() {
        await this.predictlist();
        await this.predictdata();
        this.data_extract(this.selectvalue);
        this.myEcharts();
      },
      async predictfinish() {
        await this.predictstock();
        alert('预测完成');
        this.predict_result = this.predict_list[this.selectvalue];
      }
    },

    created() {
      this.initData();
      if (this.firstTimeFlag) {
        this.firstTimeFlag = false;
        this.predictfinish();
      }
    }
  }
</script>
<style scoped>
  .topselect {
    display: flex;
    align-items: center;
    margin-left: 10px;
    margin-top: 20px;
  }

  .box {
    display: flex;
  }

</style>
