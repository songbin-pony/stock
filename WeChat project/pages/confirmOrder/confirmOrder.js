var util = require('../../utils/util.js');
let app = getApp();
let payWay = [{
  "id": 1,
  "package": "会员卡支付"
}, {
  "id": 2,
  "package": "微信支付"
}, {
  "id": 3,
  "package": "银行卡支付"
}]
Page({
  //页面的初始数据
  data: {
    username: "",
    tableNum: "",
    confirmOrder: [],
    // 输入框中的用餐人数
    diner_num: 0,
    // 用餐人数输入框获取焦点
    diner_numF: false,
    // 备注信息
    remarks: "",
    //支付方式列表
    payWayList: [],
    // 购物车数据
    cartList: [],
    totalPrice: 0,
    totalNum: 0,
    // 遮罩
    maskFlag: true,
  },
  // 生命周期函数--监听页面加载
  onLoad: function () {
    var tableNum = app.data.tableNum;
    var cartList = app.data.cartList;
    var totalPrice = app.data.totalPrice;
    var totalNum = app.data.totalNum;
    var username = app.data.username;
    this.setData({
      cartList: cartList,
      tableNum: tableNum,
      totalPrice: totalPrice,
      totalNum: totalNum,
      username: username
    })
  },
  // 点击数字，输入框出现对应数字
  getDinnerNUM: function (e) {
    var dinnerNum = e.currentTarget.dataset.num;
    var diner_num = this.data.diner_num;
    // 点击“输”，获取焦点，
    if (dinnerNum == 0) {
      this.setData({
        diner_numF: true,
      })
      this.getDinerNum();
    } else {
      this.setData({
        diner_num: dinnerNum
      });
    }
  },
  //打开支付方式弹窗
  choosePayWay: function () {
    var that = this;
    that.setData({
      payWayList: payWay
    });

    // 支付方式打开动画
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: 'ease-in-out',
      delay: 0
    });
    that.animation = animation;
    animation.translate(0, -285).step();
    that.setData({
      animationData: that.animation.export(),
    });
    that.setData({
      maskFlag: false,
    });
  },
  // 支付方式关闭方法
  closePayWay: function () {
    var that = this
    // 支付方式关闭动画
    that.animation.translate(0, 285).step();
    that.setData({
      animationData: that.animation.export()
    });
    that.setData({
      maskFlag: true
    });
  },
  // 获取输入的用餐人数
  getDinerNum: function (e) {
    var diner_num = this.data.diner_num;
    this.setData({
      diner_num: diner_num
    })
  },
  // 获取备注信息
  getRemark: function (e) {
    var remarks = this.data.remarks;
    this.setData({
      remarks: e.detail.value
    })
  },
  //提交订单
  submitOrder: function (e) {
    var _this = this;
    var orderid = _this.generateUuid();
    if (getApp().data.balance < this.data.totalPrice) {
      wx.showToast({
        title: '余额不足，请先充值',
        icon: 'none',
        duration: 2000
      })
    } else {
      wx.request({
        url: 'http://localhost:8989/saveOrder',
        method: "POST",
        data: {
          orderid: orderid,
          tablenum: _this.data.tableNum,
          ordertime: util.formatTime_2(new Date()),
          username: _this.data.username,
          dinnernum: _this.data.totalNum,
          remarks: _this.data.remarks,
          totalprice: _this.data.totalPrice,
          statusone:"0",
          statustwo:"0"
        },
        success(res_1) {
          console.log(res_1.data);

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

          if (res_1.data) {
            // 支付方式关闭动画
            _this.animation.translate(0, 285).step();
            _this.setData({
              animationData: _this.animation.export()
            });
            _this.setData({
              maskFlag: true
            });
            wx.switchTab({
              url: '../index/index',
            })
            wx.showToast({
              title: '下单成功！',
              icon: 'success',
              duration: 2000
            })
          } else {
            // 支付方式关闭动画
            _this.animation.translate(0, 285).step();
            _this.setData({
              animationData: _this.animation.export()
            });
            _this.setData({
              maskFlag: true
            });
          }
        }
      })

      for (var i in _this.data.cartList) {
        wx.request({
          url: 'http://localhost:8989/saveOrderDetail',
          method: "POST",
          data: {
            orderid: orderid,
            commodityid: _this.data.cartList[i].commodityid,
            commoditynum: _this.data.cartList[i].quantity,
            commodityname: _this.data.cartList[i].cname
          },
          success(res_2) {
            console.log(res_2.data)
          }
        })
      }
    }


  },
  generateUuid: function (length = 5) {
    return Number(Math.random().toString().substr(3, length) + Date.now()).toString(36);
  }


})