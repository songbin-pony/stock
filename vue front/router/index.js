import Vue from 'vue'
import Router from 'vue-router'
import Index from '../components/Index'
import mystock from '../components/mystock/mystock'
import history from '../components/history/history'
import login from '../components/login/Login'
import register from '../components/register/register'
import finance from '../components/finance/finance'
import subfinance1 from '../components/finance/subfinance1'
import subfinance2 from '../components/finance/subfinance2'
import subfinance3 from '../components/finance/subfinance3'
import subfinance4 from '../components/finance/subfinance4'
import subfinance5 from '../components/finance/subfinance5'
import predict from '../components/predict/predict'
import kline from '../components/kline/kine'
import subkline1 from '../components/kline/subkline1'
import subkline2 from '../components/kline/subkline2'
import subkline3 from '../components/kline/subkline3'
import subkline4 from '../components/kline/subkline4'
import subkline5 from '../components/kline/subkline5'
import subkline6 from '../components/kline/subkline6'
import subhistory1 from '../components/history/subhistory1'
import subhistory2 from '../components/history/subhistory2'
import subhistory3 from '../components/history/subhistory3'
import subhistory4 from '../components/history/subhistory4'
import basic from '../components/basic/basic'
import subbasic1 from '../components/basic/subbasic1'
import subbasic2 from '../components/basic/subbasic2'
import subbasic3 from '../components/basic/subbasic3'
import example from '../components/example/example'
import newsdetail from '../components/newsdetail/newsdetail'
import newslist from '../components/newslist/newslist'
Vue.use(Router);

export default new Router({
  routes: [
    {path: '/index', component: Index},
    {path: '/', redirect: '/index'},
    {path: '/mystock', component: mystock,
    children:[{path: 'login', component: login},{path: 'index', component: Index}]
    },
    {path: '/history', component: history,children:[
        {path:'subhistory1',component:subhistory1},
        {path:'subhistory2',component:subhistory2},
        {path:'subhistory3',component:subhistory3},
        {path:'subhistory4',component:subhistory4},
      ]},
    {path: '/finance', component: finance,children:[
        {path:'subfinance1',component:subfinance1},
        {path:'subfinance2',component:subfinance2},
        {path:'subfinance3',component:subfinance3},
        {path:'subfinance4',component:subfinance4},
        {path:'subfinance5',component:subfinance5},
      ]},
    {path: '/register', component: register},
    {path: '/login', component: login},
    {path:'/predict',component:predict},
    {path:'/example',component:example},
    {path:'/newsdetail',component:newsdetail},
    {path:'/newslist',component:newslist},
    {path:'/kline',component:kline,children:[
        {path:'subkline1',component:subkline1},
        {path:'subkline2',component:subkline2},
        {path:'subkline3',component:subkline3},
        {path:'subkline4',component:subkline4},
        {path:'subkline5',component:subkline5},
        {path:'subkline6',component:subkline6},
      ]},
    {path:'/basic',component:basic,children:[
        {path:'subbasic1',component:subbasic1},
        {path:'subbasic2',component:subbasic2},
        {path:'subbasic3',component:subbasic3},
      ]}

  ]
})
