//index.js
const app = getApp()

Page({
  data: {
    banner: [],
  },

  //扫码点餐
  btnclick1: function() {
    let that = this;

    //注意：true 扫码点餐； false 本地点餐
    let saoMa = true;

    /**
     * 本地点餐
     */
    if (!saoMa) {
      that.goToBuy("1号桌")
      return
    }

    /**
     * 扫码点餐
     */
    wx.scanCode({
      success: (res) => {
        console.log(res.result)
        if (res.result) {
          let str = res.result;
          if (str.search("111") != -1) {
            console.log("1号桌")
            that.goToBuy("1号桌")
          } else if (str.search("222") != -1) {
            console.log("2号桌")
            that.goToBuy("2号桌")
          } else if (str.search("333") != -1) {
            console.log("3号桌")
            that.goToBuy("3号桌")
          } else if (str.search("444") != -1) {
            console.log("4号桌")
            that.goToBuy("4号桌")
          }
        }
      }
    })
  },

  //去点餐页
  goToBuy(tableNum) {
    wx.navigateTo({
      url: '../buy/buy?tableNum=' + tableNum
    })
  },

  //菜品浏览
  btnclick2: function() {
    wx.navigateTo({
      url: '../buy/buy'
    })
  },

  onLoad() {
    this.getTopBanner();
  },

  //获取首页顶部轮播图
  getTopBanner() {
    let that = this;
    wx.request({
      url: 'http://localhost:8989/findAllSlideImg',
      method: "GET",
      dataType: 'json',
      success: (res) => {
        console.log(res)
        this.setData({
          banner: res.data,
        })
      }
    })
  }


})