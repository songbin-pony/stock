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
          label="日期"
          prop="trade_date">
        </el-table-column>
        <el-table-column
          label="开盘价"
          prop="open">
        </el-table-column>
        <el-table-column
          label="最高价"
          prop="high">
        </el-table-column>
        <el-table-column
          label="最低价"
          prop="low">
        </el-table-column>
        <el-table-column
          label="收盘价"
          prop="close">
        </el-table-column>
        <el-table-column
          label="成交量"
          prop="vol">
        </el-table-column>
        <el-table-column
          label="成交额"
          prop="amount">
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
    name: "subhistory2",
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
          url: "http://localhost:8000/history/weekinfo/",
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
        let beforetime=this.$moment().subtract(30,'days').format('YYYYMMDD');
        console.log(nowtime);
        console.log(beforetime);
        this.$http({
          method: 'post',
          url: "http://localhost:8000/history/weekinfo/",
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
        this.$router.push('/history');
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
