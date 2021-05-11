<template>
  <el-container>
    <el-header>
      <h2>在售类目管理</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.cname.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="名字"
            prop="cname">
          </el-table-column>
          <el-table-column
            label="价格"
            prop="price">
          </el-table-column>
          <el-table-column
            label="描述"
            prop="description">
          </el-table-column>
          <el-table-column
            label="图片">
            <template slot-scope="scope">
              <el-image style="width: 50px; height: 50px" :src="scope.row.link" fit="fill"></el-image>
            </template>
          </el-table-column>
          <el-table-column
            label="类目名称"
            prop="categoryname">
          </el-table-column>
          <el-table-column
            label="图片链接"
            prop="link">
          </el-table-column>
          <el-table-column
            label="库存"
            prop="stock">
          </el-table-column>
          <el-table-column
            align="right">
            <template slot="header" slot-scope="scope">
              <el-input
                v-model="search"
                size="mini"
                placeholder="输入菜名搜索"/>
            </template>
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="handleReset(scope.$index, scope.row.commodityid)">上架
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row.commodityid)">删除
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
  </el-container>
</template>
<script>
  export default {
    name: "selloutCommodity",
    data() {
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        search: '',
        formLabelWidth: '120px',
      };

    },
    methods: {
      handleDelete(index, ctype) {
        console.log(index, ctype);
        let _this = this;
        this.$http.post("http://localhost:8989/deleteCommodity", {params_1: ctype}).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });

      }
      ,
      handleReset(index, commodityid) {
        console.log(index, commodityid);
        let _this = this;
        this.$http.post("http://localhost:8989/tosellCommodity", {params_1: commodityid}).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      }
      ,
      findAll() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllselloutCommodity').then(function (res) {
          console.log(res);
          _this.showdata = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      }
      ,
      handleSizeChange(size) {
        this.pagesize = size;
        console.log(this.pagesize)  //每页下拉显示数据
      }
      ,
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage;
        console.log(this.currentPage)  //点击第几页
      }
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
