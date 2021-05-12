<template>
  <div class="loginbox">
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
</template>
<script>
  export default {
    name: "Login",
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
              url: "http://localhost:8000/user/login/",
              data: _this.$qs.stringify({'params_1': _this.ruleForm.username}),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
              }

            }).then(function (res) {
              if (res.data.length === 0) {
                alert("用户不存在，请先注册");
              } else {
                if (res.data[0].password != _this.ruleForm.password) {
                  alert("密码错误");
                } else {
                  alert("登录成功");
                  _this.$emit('receiveLoginData', {
                    username: _this.ruleForm.username,
                    password: _this.ruleForm.password
                  });
                  _this.resetForm(formName);
                  console.log(_this.ruleForm.username);
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
      }
    }
  }
</script>
<style scoped>
  .loginbox {
    width: 400px;
    height: 200px;
    margin: 0 auto;
  }
</style>
