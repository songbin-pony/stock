import Vue from 'vue'
import Router from 'vue-router'
import Users from '../components/users/Users'
import banner from '../components/banner/banner'
import news from '../components/news/news'
import newslist from '../components/newslist/newslist'
import editnews from '../components/editnews/editnews'

Vue.use(Router);

export default new Router({
  routes: [
    {path: '/users', component: Users},
    {path: '/', redirect: "/users"},
    {path: '/banner', component: banner},
    {path: '/news', component: news},
    {path: '/newslist', component: newslist},
    {path: '/editnews', component:editnews},
  ]
})
