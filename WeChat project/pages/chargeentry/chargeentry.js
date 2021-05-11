// pages/chargeentry/chargeentry.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    username: "",
    password: "",
    balance:"",
    charge:0,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {


  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.setData({
      username: getApp().data.username,
      password: getApp().data.password,
      balance:getApp().data.balance
    })
  },

  chargeinput: function(e) {
    this.setData({
      charge: e.detail.value
    })
  },
  confirmcharge(){
    let _this=this;
    wx.request({
      url: 'http://localhost:8989/chargebalance',
      method: "Post",
      data: {
        username: _this.data.username,
        charge:_this.data.charge
      },
      dataType: 'json',
      success: (res) => {
        console.log(res)
        wx.request({
          url: 'http://localhost:8989/findByName',
          method: "Post",
          data: {
            username: _this.data.username
          },
          dataType: 'json',
          success: (res) => {
            getApp().data.balance = res.data[0].balance;
            console.log(res.data[0].balance)
          }
        })
        wx.showToast({
          title: '充值成功！',
          icon: 'success',
          duration: 2000
        })
        setTimeout(function () {
          wx.navigateBack({
            delta: 1
          })
        }, 2000)
      }
    })
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})