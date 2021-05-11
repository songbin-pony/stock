<template>
  <div id="app">
      <el-container>
        <el-header>
          <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
            <el-menu-item index="/index">主页</el-menu-item>
            <el-menu-item index="/mystock">我的股票</el-menu-item>
            <el-menu-item index="/basic">基础数据</el-menu-item>
            <el-menu-item index="/kline">K线</el-menu-item>
            <el-menu-item index="/history">历史交易</el-menu-item>
            <el-menu-item index="/finance">财务数据</el-menu-item>
            <el-menu-item index="/predict">股票预测</el-menu-item>
            <el-menu-item index="/login">登录</el-menu-item>
            <el-menu-item index="/register">注册</el-menu-item>
            <div v-if="username===''">
              <span>未登录,请先登录</span>
            </div>
            <div v-else>
              <span>已登录：{{username}}</span>
            </div>
          </el-menu>

        </el-header>
        <el-main>
          <router-view @receiveLoginData="receiveLoginData" :username="username"></router-view>
        </el-main>
        <el-footer>Made By CheCao</el-footer>
      </el-container>
  </div>
</template>

<script>
  export default {
    name: 'App',
    data() {
      return {
        activeIndex: this.$route.path,
        username: 'hc',
        password: '1'
      };
    },
    methods: {
      handleSelect(key, keyPath) {
        console.log(key);
        console.log(keyPath);
        console.log(this.username);
        console.log(this.password);
        this.$router.push(key);
      },
      receiveLoginData(data){
        this.username=data.username;
        this.password=data.password;
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

</style>
