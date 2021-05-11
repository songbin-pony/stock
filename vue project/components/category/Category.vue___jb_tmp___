<template>
  <el-container>
    <el-header>
      <h2>菜品类目管理</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.cname.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="菜品id"
            prop="ctype">
          </el-table-column>
          <el-table-column
            label="名字"
            prop="cname">
          </el-table-column>
          <el-table-column
            align="right">
            <template slot="header" slot-scope="scope">
              <el-input
                v-model="search"
                size="mini"
                placeholder="输入描述搜索"/>
            </template>
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="handleReset(scope.$index, scope.row.ctype)">修改信息
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row.ctype)">删除
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
    <el-dialog title="菜品类目信息修改" :visible.sync="dialogFormVisible_1">
      <el-form :model="reSetForm" :rules="rules" ref="reSetForm">
        <el-form-item label="id" :label-width="formLabelWidth">
          <el-input v-model="reSetForm.ctype" autocomplete="off" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="名字" :label-width="formLabelWidth" prop="cname">
          <el-input v-model="reSetForm.cname" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_1 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_1">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="菜品类目添加" :visible.sync="dialogFormVisible_2">
      <el-form :model="newCategoryForm" :rules="rules" ref="newCategoryForm">
        <el-form-item label="名字" :label-width="formLabelWidth" prop="cname">
          <el-input v-model="newCategoryForm.cname" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_2 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_2">确 定</el-button>
      </div>
    </el-dialog>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="dialogFormVisible_2=true">
      添加类目
    </el-button>
  </el-container>
</template>
<script>
  export default {
    name: "Category",
    data() {
      let checkName = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('名字不能为空'));
        } else {
          callback();
        }
      };
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        search: '',
        dialogFormVisible_1: false,
        dialogFormVisible_2: false,
        formLabelWidth: '120px',
        reSetForm: {
          ctype: '',
          cname: ''

        },
        newCategoryForm: {
          ctype: '',
          cname: ''

        },
        rules: {
          cname: [
            {validator: checkName, trigger: 'blur'}
          ]
        }
      };

    },
    methods: {
      dialogConfirmed_2() {
        let _this = this;
        _this.$http.post("http://localhost:8989/saveCategory", _this.newCategoryForm).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.dialogFormVisible_2 = false;
            _this.newCategoryForm = {};
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });

      },
      dialogConfirmed_1() {
        let _this = this;
        console.log(_this.reSetForm);
        this.$http.post("http://localhost:8989/updateCategory", _this.reSetForm).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.dialogFormVisible_1 = false;
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      }
      ,
      handleDelete(index, ctype) {
        console.log(index, ctype);
        let _this = this;
        this.$http.post("http://localhost:8989/deleteCategory", {params_1: ctype}).then(function (res) {
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
      handleReset(index, ctype) {
        let _this = this;
        this.$http.post("http://localhost:8989/findCategoryByType", {params_1: ctype}).then(function (res) {
          _this.reSetForm = res.data[0];
          _this.dialogFormVisible_1 = true;
        }).catch(function (err) {
          console.log(err);
        })
      }
      ,
      findAll() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllCategory').then(function (res) {
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
