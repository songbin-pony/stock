import Vue from 'vue'
import Router from 'vue-router'
import Statistic from '../components/statistic/Statistic'
import Admininfo from '../components/admininfo/Admininfo'
import Slides from '../components/slides/Slides'
import Category from '../components/category/Category'
import onsellCommodity from '../components/onsellcommodity/onsellCommodity'
import ConfirmedOrder from '../components/confirmedorder/ConfirmedOrder'
import unConfirmedOrder from '../components/unconfirmedorder/unConfirmedOrder'
import selloutCommodity from '../components/selloutcommodity/selloutCommodity'
import unPayOrder from '../components/unpayorder/unPayOrder'
import user from '../components/user/User'

Vue.use(Router)

export default new Router({
  routes: [
    {path: '/statistic', component: Statistic},
    {path: '/', redirect: '/statistic'},
    {path: '/admininfo', component: Admininfo},
    {path: '/slides', component: Slides},
    {path: '/category', component: Category},
    {path: '/onsellcommodity', component:onsellCommodity},
    {path: '/confirmedorder', component: ConfirmedOrder},
    {path: '/unconfirmedorder', component: unConfirmedOrder},
    {path: '/selloutcommodity', component: selloutCommodity},
    {path: '/user', component: user},
    ]
})
