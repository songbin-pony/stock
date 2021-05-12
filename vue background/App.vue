<template>
  <div id="app">
    <div v-if="admin===''">
      <div class="loginbox">
        <div><h1>后台管理系统</h1></div>
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
    </div>
    <div v-else>
      <el-container>
        <el-header>
          <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
            <el-menu-item index="/users">用户管理</el-menu-item>
            <el-menu-item index="/banner">Banner管理</el-menu-item>
            <el-menu-item index="/newslist">新闻管理</el-menu-item>
            <el-menu-item index="/news">新闻添加</el-menu-item>
          </el-menu>

        </el-header>
        <el-main>
          <router-view @changeparentactiveindex="childfunc_1"></router-view>
        </el-main>
        <el-footer>Made By HeChen</el-footer>
      </el-container>
    </div>
  </div>
</template>
<script>
  export default {
    name: "App",
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
        ruleForm: {
          username: '',
          password: '',
        },
        admin: '',
        adminpassword: '',
        activeIndex: this.$route.path,
        rules: {
          password: [
            {validator: validatePassword, trigger: 'blur'}
          ],
          username: [
            {validator: checkName, trigger: 'blur'}
          ]
        }
      };
    },
    methods: {
      submitForm(formName) {
        console.log(this);
        this.$refs[formName].validate((valid) => {
          if (valid) {
            let _this = this;
            console.log(_this.ruleForm.username, _this.ruleForm.password);
            this.$http({
              method: 'post',
              url: "http://localhost:8000/administrator/adminlogin/",
              data: _this.$qs.stringify({params_1: _this.ruleForm.username}),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
              }
            }).then(function (res) {
              if (res.data.length === 0) {
                alert("用户不存在，请重试");
              } else {
                if (res.data[0].password !== _this.ruleForm.password) {
                  alert("密码错误");
                } else {
                  alert("登录成功");
                  _this.admin = _this.ruleForm.username;
                  _this.adminpassword = _this.ruleForm.password;

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
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      handleSelect(key, keyPath) {
        console.log(key, keyPath);
        this.$router.push(key);
      },
      childfunc_1(){
        console.log(this.activeIndex);
        //这里顺序不能错
        this.activeIndex='/newslist';
        this.$router.push('/newslist');
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

  .el-header, .el-footer {
    background-color: #B3C0D1;
    color: #333;
    text-align: center;
    line-height: 60px;
  }

  .el-main {
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
  }

  .loginbox {
    width: 400px;
    height: 400px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -200px;
    margin-left: -200px;
  }

</style>
