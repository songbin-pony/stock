<template>
  <div class="registerbox">
    <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
      <el-form-item label="请输入用户名" prop="username">
        <el-input v-model.number="ruleForm.username" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="请输入密码" prop="password_1">
        <el-input type="password" v-model="ruleForm.password_1" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="请确认密码" prop="password_2">
        <el-input type="password" v-model="ruleForm.password_2" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')">注册</el-button>
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
  export default {
    name: "Register",
    data() {
      let checkName = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('用户名不能为空'));
        } else {
          callback();
        }
      };
      let validatePassword_1 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('密码不能为空'));
        } else {
          callback();
        }
      };
      let validatePassword_2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('密码不能为空'));
        } else if (value !== this.ruleForm.password_1) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        ruleForm: {
          username: '',
          password_1: '',
          password_2: ''
        },
        rules: {
          password_1: [
            {validator: validatePassword_1, trigger: 'blur'}
          ],
          password_2: [
            {validator: validatePassword_2, trigger: 'blur'}
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
            console.log(_this.ruleForm.username, _this.ruleForm.password_1);
            _this.$http({
              method: 'post',
              url: "http://localhost:8000/user/login/",
              data: _this.$qs.stringify({'params_1': _this.ruleForm.username}),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
              }
            }).then(function (res) {
              if (res.data.length === 0) {
                _this.$http({
                  method: 'post',
                  url: "http://localhost:8000/user/adduser/",
                  data: _this.$qs.stringify({'params_1': _this.ruleForm.username,'params_2': _this.ruleForm.password_2}),
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                  }
                }).then(function (res) {
                  console.log(res.data);
                  if (res.data.ret=='success') {
                    alert("注册成功，请登录");
                    _this.resetForm(formName);
                  } else {
                    alert(res.data.message);
                    console.log(res.data.success);
                  }
                }).catch(function (err) {
                  console.log(err);
                })
              } else {
                alert("用户名已存在，请重试")
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
      ,
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
  }
</script>
<style scoped>
  .registerbox {
    width: 400px;
    height: 300px;
    margin: 0 auto;
  }
</style>
