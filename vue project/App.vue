<template>
  <div id="app">
    <div v-if="admin===''">
      <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="用户" prop="username">
          <el-input v-model.number="ruleForm.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="ruleForm.password" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div v-else>
      <el-container>
        <el-aside width="200px">
          <el-col :span="20">
            <h5>菜单栏</h5>
            <el-menu class="el-menu-vertical-demo" :default-active="activeIndex" @select="handleSelect">
              <el-menu-item index="/statistic">
                <span slot="title">统计信息</span>
              </el-menu-item>
              <el-menu-item index="/admininfo">
                <span slot="title">餐厅管理员</span>
              </el-menu-item>
              <el-menu-item index="/user">
                <span slot="title">用户管理</span>
              </el-menu-item>
              <el-menu-item index="/slides">
                <span slot="title">轮播图管理</span>
              </el-menu-item>
              <el-menu-item index="/category">
                <span slot="title">菜品类目管理</span>
              </el-menu-item>
              <el-menu-item index="/onsellcommodity">
                <span slot="title">在售菜品管理</span>
              </el-menu-item>
              <el-menu-item index="/selloutcommodity">
                <span slot="title">下架菜品管理</span>
              </el-menu-item>
              <el-menu-item index="/unconfirmedorder">
                <span slot="title">待确认的订单</span>
              </el-menu-item>
              <el-menu-item index="/confirmedorder">
                <span slot="title">确认的订单</span>
              </el-menu-item>
              <el-menu-item @click="exitLogin">
                <span slot="title">退出登录</span>
              </el-menu-item>
            </el-menu>
          </el-col>
        </el-aside>
        <el-container>
          <el-main>
            <router-view/>
          </el-main>
        </el-container>
      </el-container>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'App',
    data() {
      let checkName = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('用户名不能为空'));
        } else {
          callback();
        }
      };
      let validatePassword = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          callback();
        }
      };
      return {
        activeIndex: this.$route.path,
        admin: 'lw',
        adminpassword: '12',
        ruleForm: {
          username: '',
          password: '',
        },
        rules: {
          password: [
            {validator: validatePassword, trigger: 'blur'}
          ],
          username: [
            {validator: checkName, trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      exitLogin() {
        this.admin='';
      },
      handleSelect(key, keyPath) {
        console.log(key, keyPath);
        this.$router.push(key);
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      submitForm(formName) {
        console.log(this);
        this.$refs[formName].validate((valid) => {
          if (valid) {
            let _this = this;
            console.log(_this.ruleForm.username, _this.ruleForm.password);
            this.$http.post("http://localhost:8989/findAdminByName", {params_1: _this.ruleForm.username}).then(function (res) {
              if (res.data.length === 0) {
                alert("用户不存在，请重试");
              } else {
                if (res.data[0].adminpassword != _this.ruleForm.password) {
                  alert("密码错误");
                } else {
                  alert("登录成功");
                  _this.admin=_this.ruleForm.username;
                  _this.adminpassword=_this.ruleForm.password;

                }
              }
            }).catch(function (err) {
              console.log(err);
            })

          } else {
            console.log('error submit!!');
            return false;
          }
        });
      }
    }
  }
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }
</style>
