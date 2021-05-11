// pages/my/my.js
var util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    username: "",
    password: "",
    balance:""

  },
  // 退出登陆
  User_Quit: function() {
    this.setData({
      username: "",
      password:""
    });
    getApp().data.username="";
    getApp().data.password="";
  },
  // 待完成订单
  paidorder() {
    if (!this.data.username) {
      wx.showToast({
        title: '请先登陆',
        icon: 'none',
        duration: 1000
      })
    } else {
      wx.navigateTo({
        url: '/pages/paidorder/paidorder',
      })
    }
  },
  // 已完成订单
  finishorder() {
    if (!this.data.username) {
      wx.showToast({
        title: '请先登陆',
        icon: 'none',
        duration: 1000
      })
    } else {
      wx.navigateTo({
        url: '/pages/finishorder/finishorder',
      })
    }
  },
  //充值入口
  charge_entry(){
    if (!this.data.username) {
      wx.showToast({
        title: '请先登陆',
        icon: 'none',
        duration: 1000
      })
    } else {
      wx.navigateTo({
        url: '/pages/chargeentry/chargeentry',
      })
    }
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {
    
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {
    this.setData({
      username: getApp().data.username,
      password: getApp().data.password,
      balance:getApp().data.balance
    })
   
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function() {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function() {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function() {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function() {

  },
  paid_order(){

  },
  finish_order(){

  },
  chargeentry(){

  }
})