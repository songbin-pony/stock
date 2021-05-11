<template>
  <div>
    <div class="block">
      <div class="padding10"><h4>请选择时间</h4></div>
      <el-date-picker
        class="padding10"
        v-model="selecttime"
        type="daterange"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        format="yyyy 年 MM 月 dd 日"
        value-format="yyyyMMdd">
      </el-date-picker>
      <div class="padding10">
        <el-button size="medium" @click="btnconfirm">查询</el-button>
      </div>
    </div>
    <div>
      <el-table
        :data="showdata.slice((currentPage2-1)*pagesize2,currentPage2*pagesize2)"
        style="width: 100%">
        <el-table-column
          label="公告日期"
          prop="ann_date">
        </el-table-column>
        <el-table-column
          label="报告期"
          prop="end_date">
        </el-table-column>
        <el-table-column
          label="基本每股收益"
          prop="eps">
        </el-table-column>
        <el-table-column
          label="稀释每股收益"
          prop="dt_eps">
        </el-table-column>
        <el-table-column
          label="每股营业总收入"
          prop="total_revenue_ps">
        </el-table-column>
        <el-table-column
          label="每股营业收入"
          prop="revenue_ps">
        </el-table-column>
        <el-table-column
          label="每股资本公积"
          prop="capital_rese_ps">
        </el-table-column>
        <el-table-column
          label="每股未分配利润"
          prop="undist_profit_ps">
        </el-table-column>
        <el-table-column
          label="非经营性损失"
          prop="extra_item">
        </el-table-column>
        <el-table-column
          label="毛利"
          prop="gross_margin">
        </el-table-column>
        <el-table-column
          label="流动比率"
          prop="current_ratio">
        </el-table-column>
      </el-table>
      <el-pagination @size-change="handleSizeChange2" @current-change="handleCurrentChange2"
                     :current-page="currentPage2" :page-sizes="[5, 10, 20, 40]"
                     :page-size="pagesize2" layout="total, sizes, prev, pager, next, jumper" :total="showdata.length">
      </el-pagination>
    </div>
  </div>
</template>

<script>
  export default {
    name: "subfinance4",
    props: ["selectvalue"],
    data() {
      return {
        tscode: this.selectvalue,
        currentPage2:1,
        pagesize2:10,
        selecttime: [],
        showdata: []
      }
    },
    methods: {
      btnconfirm() {
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/finance/financeinfo_4/",
          data: _this.$qs.stringify({
            params_1: _this.tscode,
            params_2: _this.selecttime[0],
            params_3: _this.selecttime[1]
          }),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          _this.showdata = res.data;
          console.log(_this.showdata);
        }).catch(function (err) {
          console.log(err);
        })
      },
      dayinfo() {
        let _this = this;
        let nowtime=this.$moment().format('YYYYMMDD');
        let beforetime=this.$moment().subtract(180,'days').format('YYYYMMDD');
        console.log(nowtime);
        console.log(beforetime);
        this.$http({
          method: 'post',
          url: "http://localhost:8000/finance/financeinfo_4/",
          data: _this.$qs.stringify({
            params_1: _this.tscode,
            params_2: beforetime,
            params_3: nowtime
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
      },
      handleSizeChange2(size) {
        this.pagesize2 = size;
        console.log(this.pagesize2)  //每页下拉显示数据
      },
      handleCurrentChange2(currentPage2) {
        this.currentPage2 = currentPage2;
        console.log(this.currentPage2)  //点击第几页
      }
    },
    created() {
      console.log(this.tscode);
      if (this.selectvalue == '') {
        this.$router.push('/finance');
      } else {
        this.dayinfo()
      }
    }
  }
</script>

<style scoped>

  .block{
    display: flex;
    align-items: center;
  }
  .padding10{
    padding: 10px;
  }
</style>
