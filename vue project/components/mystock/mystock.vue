<template>
  <div v-if="username==''">
    <h2>请先登录</h2>
  </div>
  <div v-else>
    <h2>我的股票</h2>
    <div>
      <el-table
        :data="mystockdata.slice((currentPage1-1)*pagesize1,currentPage1*pagesize1)"
        style="width: 100%">
        <el-table-column
          label="股票代码"
          prop="symbol">
        </el-table-column>
        <el-table-column
          label="完整代码"
          prop="tscode">
        </el-table-column>
        <el-table-column
          label="名称"
          prop="name">
        </el-table-column>
        <el-table-column
          label="地区"
          prop="area">
        </el-table-column>
        <el-table-column
          label="行业"
          prop="industry">
        </el-table-column>
        <el-table-column
          align="right">
          <template slot="header" slot-scope="scope">
            <el-input v-model="search1" size="mini" placeholder="输入股票代码或者企业名称搜索" @input="searchfunc1"/>
          </template>
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleDelstock(scope.$index, scope.row.symbol)">移除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination @size-change="handleSizeChange1" @current-change="handleCurrentChange1"
                     :current-page="currentPage1" :page-sizes="[5, 10, 20, 40]"
                     :page-size="pagesize1" layout="total, sizes, prev, pager, next, jumper"
                     :total="mystockdata.length">
      </el-pagination>
    </div>
    <h2>股票列表</h2>
    <div>
      <el-table
        :data="showdata.slice((currentPage2-1)*pagesize2,currentPage2*pagesize2)"
        style="width: 100%">
        <el-table-column
          label="股票代码"
          prop="symbol">
        </el-table-column>
        <el-table-column
          label="完整代码"
          prop="tscode">
        </el-table-column>
        <el-table-column
          label="名称"
          prop="name">
        </el-table-column>
        <el-table-column
          label="地区"
          prop="area">
        </el-table-column>
        <el-table-column
          label="行业"
          prop="industry">
        </el-table-column>
        <el-table-column
          align="right">
          <template slot="header" slot-scope="scope">
            <el-input v-model="search2" size="mini" placeholder="输入股票代码或者企业名称搜索" @input="searchfunc2"/>
          </template>
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleAddstock(scope.$index, scope.row.symbol)">添加到我的股票
            </el-button>
          </template>
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
    name: "mystock",
    props: ["username"],
    data() {
      return {
        currentPage1: 1, //初始页
        currentPage2: 1, //初始页
        pagesize1: 10,    //    每页的数据
        pagesize2: 10,    //    每页的数据
        showdata: [],
        mystockdata: [],
        search1: '',
        search2: ''

      };
    },
    methods: {
      searchfunc1() {
        console.log(this.search1);
        if (this.search1 !== '') {
          let _this = this;
          this.$http({
            method: 'post',
            url: "http://localhost:8000/stock/searchByNameOrSymbol_1/",
            data: _this.$qs.stringify({params_1: _this.username, params_2: _this.search1}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }).then(function (res) {
            _this.mystockdata = res.data;
          }).catch(function (err) {
            console.log(err);
          });
        } else {
          this.findMyStock();
        }
      },
      searchfunc2() {
        console.log(this.search2);
        if (this.search2 !== '') {
          let _this = this;
          this.$http({
            method: 'post',
            url: "http://localhost:8000/stock/searchByNameOrSymbol_2/",
            data: _this.$qs.stringify({params_1: _this.search2}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }).then(function (res) {
            _this.showdata = res.data;
          }).catch(function (err) {
            console.log(err);
          });
        } else {
          this.findAllStock();
        }
      },
      handleAddstock(index, symbol) {
        console.log(index, symbol);
        let _this = this;
        _this.$http({
          method: 'post',
          url: "http://localhost:8000/stock/findBySymbolAndName/",
          data: _this.$qs.stringify({params_1: _this.username, params_2: symbol}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res);
          if (res.data.length == 0) {
            _this.$http({
              method: 'post',
              url: "http://localhost:8000/stock/Addstock/",
              data: _this.$qs.stringify({params_1: _this.username, params_2: symbol}),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
              }
            }).then(function (res) {
              console.log(res);
              if (res.data.ret == 'success') {
                alert('添加成功');
                _this.findMyStock()
              } else {
                alert('添加出错');
                console.log(res.data.success);
              }
            }).catch(function (err) {
              console.log(err);
            });
          } else {
            alert('您已添加此股票');
          }
        }).catch(function (err) {
          console.log(err);
        });
      },
      handleDelstock(index, symbol) {
        console.log(index, symbol);
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/stock/Delstock/",
          data: _this.$qs.stringify({params_1: _this.username, params_2: symbol}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res);
          if (res.data.ret == 'success') {
            _this.findMyStock()
          } else {
            alert('删除失败');
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      },
      findAllStock() {
        let _this = this;
        this.$http.get('http://localhost:8000/stock/findAllStock/').then(function (res) {
          console.log(res.data);
          _this.showdata = res.data;
        }).catch(function (err) {
          console.log(err);
        })
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
        }).catch(function (err) {
          console.log(err);
        })
      },
      handleSizeChange1(size) {
        this.pagesize1 = size;
        console.log(this.pagesize1)  //每页下拉显示数据
      },
      handleSizeChange2(size) {
        this.pagesize2 = size;
        console.log(this.pagesize2)  //每页下拉显示数据
      },
      handleCurrentChange1(currentPage1) {
        this.currentPage1 = currentPage1;
        console.log(this.currentPage1)  //点击第几页
      },
      handleCurrentChange2(currentPage2) {
        this.currentPage2 = currentPage2;
        console.log(this.currentPage2)  //点击第几页
      },

    },
    created() {
      this.findAllStock()
      this.findMyStock()
    }
  }
</script>
<style scoped>

</style>
