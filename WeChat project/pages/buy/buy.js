let app = getApp();
var sliderWidth = 190 // 需要设置slider的宽度，用于计算中间位置
// 最大行数
var max_row_height = 5;
// 行高
var food_row_height = 50;
// 底部栏偏移量
var cart_offset = 90;
//桌号
let tableNum = null;
Page({
  data: {
    username:'',
    password:'',
    tabs: ["今日菜单"],
    activeIndex: 0,
    sliderOffset: 0,
    sliderLeft: 0,
    sliderWidth: 0.5,
    // 左右两侧菜单的初始显示次序
    curNav: 0,
    // 右菜单
    categoryList: [],
    //所有菜品
    commodity_list: [],
    // 左菜单
    foodList: [], //展示菜品
    // 购物车
    cartList: [],
    hasList: false, // 列表是否有数据
    totalPrice: 0, // 总价，初始为0
    totalNum: 0, //总数，初始为0
    // 购物车动画
    animationData: {},
    animationMask: {},
    maskVisual: "hidden",
    maskFlag: true,

  },
  onLoad: function (options) {
    let _this = this;
    if (options.tableNum) {
      tableNum = options.tableNum;
      console.log("桌号:", tableNum)
    }
    // 获取左侧分类菜单数据
    var categoryList = [];
    //所有菜品
    var commodityList = [];
    // 获取右侧菜品列表数据
    var resFood = [];
    wx.request({
      url: 'http://localhost:8989/findAllonsellCommodity',
      success(res) {
        if (res.data.length > 0) {
          commodityList = res.data;
          for (var i in commodityList) {
            commodityList[i].quantity = 0;
          }
          wx.request({
            url: 'http://localhost:8989/findAllCategory',
            success(res) {
              categoryList = res.data;

              for (var i = 0; i < commodityList.length; i++) {
                if (commodityList[i].categoryid == categoryList[0].ctype)
                  resFood.push(commodityList[i])
              }
              _this.setData({
                categoryList: categoryList,
                curNav: categoryList[0].ctype,
                foodList: resFood,
                commodity_list: commodityList,
                username:app.data.username,
                password:app.data.password
              })
            }
          })
        } else {
          wx.showLoading({
            title: '数据为空',
          })
        }
      }
    });
    wx.getSystemInfo({
      success: function (res) {
        _this.setData({
          sliderLeft: (res.windowWidth / _this.data.tabs.length - res.windowWidth / 2) / 2,
          sliderOffset: res.windowWidth / _this.data.tabs.length * _this.data.activeIndex,
        });
      }
    });
  },


  // 点击切换顶部tab
  tabClick: function (e) {
    this.setData({
      sliderOffset: e.currentTarget.offsetLeft,
      activeIndex: e.currentTarget.id
    });
  },

  // 点击切换右侧数据
  changeRightMenu: function (e) {
    var classify = e.currentTarget.id; // 获取点击项的id
    console.log(classify);
    var commodity_list = this.data.commodity_list;
    var resFood = [];
    for (var i = 0; i < commodity_list.length; i++) {
      if (commodity_list[i].categoryid == classify) {
        resFood.push(commodity_list[i]);
        console.log(resFood)
      }
    }
    console.log(resFood)
    this.setData({
      // 右侧菜单当前显示第curNav项
      curNav: classify,
      foodList: resFood
    })
  },

  // 购物车增加数量
  addCount: function (e) {
    //点加号之前必须先扫码桌号
    if (!tableNum) {
      wx.showModal({
        title: '提示',
        content: '请到首页扫码点餐',
        showCancel: false, //去掉取消按钮
        success: function (res) {
          if (res.confirm) {
            wx.switchTab({
              url: '../index/index',
            })
          }
        }
      })
      return;
    }
    var id = e.currentTarget.dataset.id;
    var foodList = this.data.foodList;
    var commodity_list = this.data.commodity_list;
    var carlist = [];
    // for (var i in foodList) { // 遍历菜单找到被点击的菜品，数量加1
    //   if (foodList[i].commodityid == id) {
    //     foodList[i].quantity += 1;
    //     break;
    //   }
    // }
    for (var i in commodity_list) {
      if (commodity_list[i].commodityid == id) {
        commodity_list[i].quantity += 1;
        break;
      }
    }

    for (var i in commodity_list) {
      if (commodity_list[i].quantity > 0) {
        carlist.push(commodity_list[i])
      }
    }
    console.log(carlist);
    this.setData({
      foodList: foodList,
      commodity_list: commodity_list,
      cartList: carlist
    })
    this.getTotalPrice();
  },
  // 定义根据id删除数组的方法
  removeByValue: function (array, val) {
    for (var i = 0; i < array.length; i++) {
      if (array[i].id == val) {
        array.splice(i, 1);
        break;
      }
    }
  },
  // 购物车减少数量
  minusCount: function (e) {
    var id = e.currentTarget.dataset.id;
    var foodList = this.data.foodList;
    var commodity_list = this.data.commodity_list;
    var carlist = [];
    // for (var i in foodList) { // 遍历菜单找到被点击的菜品，数量加1
    //   if (foodList[i].commodityid == id) {
    //     foodList[i].quantity -= 1;
    //     break;
    //   }
    // }
    for (var i in commodity_list) {
      if (commodity_list[i].commodityid == id) {
        commodity_list[i].quantity -= 1;
        break;
      }
    }
    for (var i in commodity_list) {
      if (commodity_list[i].quantity > 0) {
        carlist.push(commodity_list[i])
      }
    }
    console.log(carlist);
    this.setData({
      foodList: foodList,
      commodity_list: commodity_list,
      cartList: carlist
    })
    this.getTotalPrice();
  },
  // 获取购物车总价、总数
  getTotalPrice: function () {
    var cartList = this.data.cartList; // 获取购物车列表
    var totalP = 0;
    var totalN = 0
    //循环列表得到每个数据
    for (var i in cartList) {
      totalP += cartList[i].quantity * cartList[i].price; // 所有价格加起来     
      totalN += cartList[i].quantity
    }
    this.setData({ // 最后赋值到data中渲染到页面
      totalNum: totalN,
      totalPrice: totalP.toFixed(2)
    });
  },
  // 清空购物车
  cleanList: function (e) {
    var id = e.currentTarget.dataset.id;
    var foodList = this.data.foodList;
    var commodity_list = this.data.commodity_list;
    var carlist = this.data.cartList;
    for (var j in carlist)
      for (var i in commodity_list) {
        if (commodity_list[i].commodityid == carlist[j].commodityid) {
          commodity_list[i].quantity = 0;
          break;
        }
      }
    console.log(carlist);
    this.setData({
      foodList: foodList,
      commodity_list: commodity_list,
      cartList: carlist
    })
    this.getTotalPrice();
    this.cascadeDismiss()
  },

  //删除购物车单项
  deleteOne: function (e) {
    var id = e.currentTarget.dataset.id;
    var foodList = this.data.foodList;
    var commodity_list = this.data.commodity_list;
    var carlist = [];
    for (var i in commodity_list) {
      if (commodity_list[i].commodityid == id) {
        commodity_list[i].quantity = 0;
        break;
      }
    }
    for (var i in commodity_list) {
      if (commodity_list[i].quantity > 0) {
        carlist.push(commodity_list[i])
      }
    }
    console.log(carlist);
    this.setData({
      foodList: foodList,
      commodity_list: commodity_list,
      cartList: carlist
    })
    this.getTotalPrice();
  },
  //切换购物车开与关
  cascadeToggle: function () {
    var that = this;
    var arr = this.data.cartList
    if (arr.length > 0) {
      if (that.data.maskVisual == "hidden") {
        that.cascadePopup()
      } else {
        that.cascadeDismiss()
      }
    } else {
      that.cascadeDismiss()
    }

  },
  // 打开购物车方法
  cascadePopup: function () {
    var that = this;
    // 购物车打开动画
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
    // 遮罩渐变动画
    var animationMask = wx.createAnimation({
      duration: 200,
      timingFunction: 'linear',
    });
    that.animationMask = animationMask;
    animationMask.opacity(0.8).step();
    that.setData({
      animationMask: that.animationMask.export(),
      maskVisual: "show",
      maskFlag: false,
    });
  },
  // 关闭购物车方法
  cascadeDismiss: function () {
    var that = this
    // 购物车关闭动画
    that.animation.translate(0, 285).step();
    that.setData({
      animationData: that.animation.export()
    });
    // 遮罩渐变动画
    that.animationMask.opacity(0).step();
    that.setData({
      animationMask: that.animationMask.export(),
    });
    // 隐藏遮罩层
    that.setData({
      maskVisual: "hidden",
      maskFlag: true
    });
  },
  // 跳转确认订单页面
  gotoOrder: function () {
    if (!tableNum) {
      wx.showModal({
        title: '提示',
        content: '请到首页扫码点餐',
        showCancel: false, //去掉取消按钮
        success: function (res) {
          if (res.confirm) {
            wx.switchTab({
              url: '../index/index',
            })
          }
        }
      })
      return;
    }

    if (this.data.username=='') {
      wx.showModal({
        title: '请登录',
        content: '请到个人中心登录',
        showCancel: false, //去掉取消按钮
        success: function (res) {
          if (res.confirm) {
            wx.switchTab({
              url: '../my/my',
            })
          }
        }
      })
      return;
    }
    app.data.cartList=this.data.cartList;
    app.data.tableNum=tableNum;
    app.data.totalPrice=this.data.totalPrice;
    app.data.totalNum=this.data.totalNum;
    console.log( app.data.totalPrice)
    wx.navigateTo({
      url: '../confirmOrder/confirmOrder' 
    })
  },
  GetQueryString: function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
  }


})