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
          label="期末总股本"
          prop="total_share">
        </el-table-column>
        <el-table-column
          label="资本公积金"
          prop="cap_rese">
        </el-table-column>
        <el-table-column
          label="未分配利润"
          prop="undistr_profit">
        </el-table-column>
        <el-table-column
          label="盈余公积金"
          prop="surplus_rese">
        </el-table-column>
        <el-table-column
          label="专项储备"
          prop="special_rese">
        </el-table-column>
        <el-table-column
          label="货币资金"
          prop="money_cap">
        </el-table-column>
        <el-table-column
          label="交易性金融资产"
          prop="trad_asset">
        </el-table-column>
        <el-table-column
          label="应收票据"
          prop="notes_receiv">
        </el-table-column>
        <el-table-column
          label="应收账款"
          prop="accounts_receiv">
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
    name: "subfinance2",
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
          url: "http://localhost:8000/finance/financeinfo_2/",
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
          url: "http://localhost:8000/finance/financeinfo_2/",
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
