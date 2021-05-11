// pages/login/login.js
Page({
  data: {
    userName: '',
    userPwd: "",
    login_message:""
  },
  //获取用户输入的用户名
  userNameInput: function(e) {
    this.setData({
      userName: e.detail.value
    })
  },
  passWdInput: function(e) {
    this.setData({
      userPwd: e.detail.value
    })
  },
 
  loginBtnClick: function(e) {
    console.log("用户名：" + this.data.userName + " 密码：" + this.data.userPwd)
    wx.request({
      url: 'http://localhost:8989/findByName',
      method: "Post",
      data: {
        username: this.data.userName
      },
      dataType: 'json',
      success: (res) => {
        console.log(res)
        if(res.data[0].password!== this.data.userPwd) {
          this.setData({
            login_message: "用户名或密码不正确"
          })
        } else {
          getApp().data.balance=res.data[0].balance;
          getApp().data.username = this.data.userName;
          getApp().data.password = this.data.userPwd;
          wx.showToast({
            title: '登陆成功',
            icon: 'success',
            duration: 2000
          })
          setTimeout(function () {
            wx.navigateBack({
              delta: 1
            })
          }, 2000)

        }


      }
    })
},
register: function() {
  wx.navigateTo({
    url: '/pages/register/register',
  })
}
})