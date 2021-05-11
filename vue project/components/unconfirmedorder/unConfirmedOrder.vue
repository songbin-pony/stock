<template>
  <el-container>
    <el-header>
      <h2>在售类目管理</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.username.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="订单编号"
            prop="orderid">
          </el-table-column>
          <el-table-column
            label="用户名"
            prop="username">
          </el-table-column>
          <el-table-column
            label="餐桌号"
            prop="tablenum">
          </el-table-column>
          <el-table-column
            label="用餐人数"
            prop="dinnernum">
          </el-table-column>
          <el-table-column
            label="下单时间"
            prop="ordertime">
          </el-table-column>
          <el-table-column
            label="金额"
            prop="totalprice">
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
                @click="handleWatch(scope.$index, scope.row.orderid)">查看详情
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleConfirm(scope.$index, scope.row.orderid)">确认订单
              </el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
                       :page-sizes="[5, 10, 20, 40]"
                       :page-size="pagesize" layout="total, sizes, prev, pager, next, jumper" :total="showdata.length">
        </el-pagination>
      </div>
    </el-main>
    <el-dialog title="订单详情" :visible.sync="dialogFormVisible_1">
      <el-table
        :data="watchForm"
        style="width: 100%">
        <el-table-column
          prop="commodityname"
          label="菜名"
          width="180">
        </el-table-column>
        <el-table-column
          prop="commoditynum"
          label="数量"
          width="180">
        </el-table-column>
      </el-table>
    </el-dialog>
  </el-container>
</template>
<script>
  export default {
    name: "unConfirmedOrder",
    data() {
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        search: '',
        dialogFormVisible_1: false,
        formLabelWidth: '120Fpx',
        watchForm:[]
      }
    },
    methods: {
      findAllOrder() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllOrder').then(function (res) {
          console.log(res);
          _this.showdata = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      },
      handleSizeChange(size) {
        this.pagesize = size;
        console.log(this.pagesize)  //每页下拉显示数据
      }
      ,
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage;
        console.log(this.currentPage)  //点击第几页
      },
      handleConfirm(index, orderid) {
        console.log(index, orderid);
        let _this = this;
        this.$http.post("http://localhost:8989/ConfirmOrder", {orderid: orderid}).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAllOrder();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });

      },
      handleWatch(index, orderid) {
        let _this = this;
        this.$http.post("http://localhost:8989/findDetailOrderById", {orderid: orderid}).then(function (res) {
          console.log(res.data);
          _this.watchForm = res.data;
          _this.dialogFormVisible_1 = true;
        }).catch(function (err) {
          console.log(err);
        })
      }

    },
    created() {
      this.findAllOrder();
    }
  }
</script>

<style scoped>

</style>
