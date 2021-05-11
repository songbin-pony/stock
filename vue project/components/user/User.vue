<template>
  <el-container>
    <el-header>
      <h2>用户管理</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.username.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="用户编号"
            prop="userid">
          </el-table-column>
          <el-table-column
            label="用户名"
            prop="username">
          </el-table-column>
          <el-table-column
            label="密码"
            prop="password">
          </el-table-column>
          <el-table-column
            label="余额"
            prop="balance">
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
                @click="handlecharge(scope.$index, scope.row.username)">充值
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handledel(scope.$index, scope.row.userid)">注销用户
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
    <el-dialog title="充值" :visible.sync="dialogFormVisible_1">
      <el-form :model="numberValidateForm" ref="numberValidateForm" label-width="100px" class="demo-ruleForm">
        <el-form-item
          label="充值金额"
          prop="chargenum"
          :rules="[
      { required: true, message: '充值金额不能为空'},
      { type: 'number', message: '充值金额必须为数字值'}
    ]"
        >
          <el-input type="number" v-model.number="numberValidateForm.chargenum" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('numberValidateForm')">提交</el-button>
          <el-button @click="resetForm('numberValidateForm')">重置</el-button>
        </el-form-item>
      </el-form>

    </el-dialog>
  </el-container>
</template>
<script>
  export default {
    name: "user",
    data() {
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        search: '',
        dialogFormVisible_1: false,
        formLabelWidth: '120Fpx',
        chargenum: '',
        numberValidateForm: {
          chargenum: ''
        },
        chargeusername: ""
      }
    },
    methods: {
      findAllUser() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllUser').then(function (res) {
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
      handlecharge(index, username) {
        console.log(index, username);
        this.chargenum = 0;
        this.chargeusername = username;
        this.dialogFormVisible_1 = true;

      },
      handledel(index, userid) {
        let _this = this;
        this.$http.post("http://localhost:8989/delUserById", {
          userid: userid
        }).then(function (res) {
          console.log(res.data);
          if (res.data.success) {
            //refresh
            _this.findAllUser();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        })
      },
      submitForm(formName) {
        let _this = this;
        this.$refs[formName].validate((valid) => {
          if (valid) {
            _this.$http.post("http://localhost:8989/chargebalance", {
              username: _this.chargeusername,
              charge: _this.numberValidateForm.chargenum
            }).then(function (res) {
              console.log(res.data);
              if (res.data.success) {
                //refresh
                _this.findAllUser();
              } else {
                alert(res.data.message);
                console.log(res.data.success);
              }
            }).catch(function (err) {
              console.log(err);
            })
            this.dialogFormVisible_1 = false;
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }

    },
    created() {
      this.findAllUser();
    }
  }
</script>

<style scoped>

</style>
