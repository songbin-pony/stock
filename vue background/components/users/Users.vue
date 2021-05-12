<template>
  <div>
    <el-table
      :data="showdata.filter(data => !search || data.username.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
      style="width: 100%">
      <el-table-column
        label="用户名"
        prop="username">
      </el-table-column>
      <el-table-column
        label="密码"
        prop="password">
      </el-table-column>
      <el-table-column
        align="right">
        <template slot="header" slot-scope="scope">
          <el-input
            v-model="search"
            size="mini"
            placeholder="输入用户名搜索"/>
        </template>
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleReset(scope.$index, scope.row.username)">重置密码
          </el-button>
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row.username)">注销
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
                   :page-sizes="[5, 10, 20, 40]"
                   :page-size="pagesize" layout="total, sizes, prev, pager, next, jumper" :total="showdata.length">
    </el-pagination>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        search: ''
      };
    },
    methods: {
      handleDelete(index, username) {
        console.log(index, username);
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/user/deleteuser/",
          data: _this.$qs.stringify({params_1: username}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res);
          if (res.data.ret==='success') {
            //refresh
            _this.findAll();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      },
      handleReset(index, username) {
        console.log(index, username);
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/user/resetuser/",
          data: _this.$qs.stringify({params_1: username}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res);
          if (res.data.ret==='success') {
            //refresh
            _this.findAll();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      },
      findAll() {
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/user/findcommonuser/",
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res);
          _this.showdata = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      },
      handleSizeChange(size) {
        this.pagesize = size;
        console.log(this.pagesize)  //每页下拉显示数据
      },
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage;
        console.log(this.currentPage)  //点击第几页
      },
    },
    created() {
      this.findAll()

    }
  }
</script>
<style scoped>
  .transition-box {
    margin-bottom: 10px;
    width: 100%;
    height: 400px;
    border-radius: 4px;
    background-color: #ccc;
    text-align: left;
    color: #fff;
    padding: 40px 20px;
    box-sizing: border-box;
    margin-right: 20px;
  }

  .submit_button {
    text-align: center;
    padding-bottom: 20px;
  }

</style>
