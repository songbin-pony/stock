<template>
  <div>
    <div>
      <el-table
        :data="showdata.slice((currentPage2-1)*pagesize2,currentPage2*pagesize2)"
        style="width: 100%">
        <el-table-column
          label="姓名"
          prop="name">
        </el-table-column>
        <el-table-column
          label="公告日期"
          prop='ann_date' >
        </el-table-column>
        <el-table-column
          label="截止日期"
          prop="end_date">
        </el-table-column>
        <el-table-column
          label="岗位"
          prop="title">
        </el-table-column>
        <el-table-column
          label="报酬"
          prop="reward">
        </el-table-column>
        <el-table-column
          label="持股数"
          prop="hold_vol">
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
    name: "subbasic3",
    props: ["selectvalue"],
    data() {
      return {
        tscode: this.selectvalue,
        currentPage2:1,
        pagesize2:10,
        showdata: []
      }
    },
    methods: {
      manageinfo() {
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/basic/manageholdinfo/",
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
        this.$router.push('/basic');
      } else {
        this.manageinfo()
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
