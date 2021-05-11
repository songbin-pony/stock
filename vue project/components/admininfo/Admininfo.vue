<template>
  <el-container>
    <el-header>
      <h2>餐厅管理员</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.admin.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="用户名"
            prop="admin">
          </el-table-column>
          <el-table-column
            label="密码"
            prop="adminpassword">
          </el-table-column>
          <el-table-column
            label="电话"
            prop="phone">
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
                @click="handleReset(scope.$index, scope.row.admin)">修改信息
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row.admin)">删除
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
    <el-dialog title="管理员信息修改" :visible.sync="dialogFormVisible_1">
      <el-form :model="reSetForm" :rules="rules" ref="reSetForm">
        <el-form-item label="账户名" :label-width="formLabelWidth">
          <el-input v-model="reSetForm.admin" autocomplete="off" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth" prop="adminpassword">
          <el-input v-model="reSetForm.adminpassword" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth" prop="phone">
          <el-input v-model="reSetForm.phone" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_1 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_1">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="管理员添加" :visible.sync="dialogFormVisible_2">
      <el-form :model="newAdminUserForm" :rules="rules" ref="newAdminUserForm">
        <el-form-item label="账户名" :label-width="formLabelWidth" prop="admin">
          <el-input v-model="newAdminUserForm.admin" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth" prop="adminpassword">
          <el-input v-model="newAdminUserForm.adminpassword" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth" prop="phone">
          <el-input v-model="newAdminUserForm.phone" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_2 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_2">确 定</el-button>
      </div>
    </el-dialog>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="dialogFormVisible_2=true">
      添加管理员
    </el-button>
  </el-container>
</template>
<script>
  export default {
    name: "Admininfo",
    data() {
      let checkPhone = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('电话不能为空'));
        } else {
          callback();
        }
      };
      let checkAdmin = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('账户名不能为空'));
        } else {
          callback();
        }
      };
      let validateAdminPassword = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('密码不能为空'));
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
          admin: '',
          adminpassword: '',
          phone: ''

        },
        newAdminUserForm: {
          admin: '',
          adminpassword: '',
          phone: ''

        },
        rules: {
          adminpassword: [
            {validator: validateAdminPassword, trigger: 'blur'}
          ],
          phone: [
            {validator: checkPhone, trigger: 'blur'}
          ],
          admin: [
            {validator: checkAdmin, trigger: 'blur'}
          ]
        }
      };

    },
    methods: {
      dialogConfirmed_2() {
        let _this = this;
        this.$http.post("http://localhost:8989/findAdminByName", {params_1: _this.newAdminUserForm.admin}).then(function (res) {
          if (res.data.length === 0) {
            _this.$http.post("http://localhost:8989/saveAdminUser", _this.newAdminUserForm).then(function (res) {
              console.log(res);
              if (res.data.success) {
                //refresh
                _this.findAll();
                _this.dialogFormVisible_2 = false;
                _this.newAdminUserForm = {};
              } else {
                alert(res.data.message);
                console.log(res.data.success);
              }
            }).catch(function (err) {
              console.log(err);
            });
          } else {
            alert("账户名已存在")
          }

        }).catch(function (err) {
          console.log(err);
        });

      },
      dialogConfirmed_1() {
        let _this = this;
        console.log(_this.reSetForm);
        this.$http.post("http://localhost:8989/updateAdminUser", _this.reSetForm).then(function (res) {
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
      },
      handleDelete(index, admin) {
        console.log(index, admin);
        let _this = this;
        this.$http.post("http://localhost:8989/deleteAdminUser", {params_1: admin}).then(function (res) {
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

      },
      handleReset(index, admin) {
        let _this = this;
        this.$http.post("http://localhost:8989/findAdminByName", {params_1: admin}).then(function (res) {
          _this.reSetForm = res.data[0];
          _this.dialogFormVisible_1 = true;
        }).catch(function (err) {
          console.log(err);
        })
      },
      findAll() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllAdminUser').then(function (res) {
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
