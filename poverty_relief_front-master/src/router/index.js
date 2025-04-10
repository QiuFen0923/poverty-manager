import Vue from 'vue'
import VueRouter from 'vue-router'
import dynamicRouter from './dynamic-router' 

Vue.use(VueRouter)

// 解决导航栏或者底部导航tabBar中的vue-router在3.0版本以上频繁点击菜单报错的问题。
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}

const publicRoutes = [
    { path: '/login', name: 'Login', meta: { name: '登录', requiresAuth: false }, component: () => import('../views/Login') },
    { path: '/register', name: 'Register', meta: { name: '注册', requiresAuth: false }, component: () => import('../views/Register') },
    {
        path: '/forget_password',
        name: 'Forget',
        meta: { name: '忘记密码', requiresAuth: false }, // 不需要登录权限
        component: () => import('../views/Forget.vue') // 确保路径正确
    },
    { path: '403', name: 'NoAuth', meta: { name: '无权限', requiresAuth: false }, component: () => import('../views/manager/403') },
    ...dynamicRouter,
    { path: '*', name: 'NotFound', meta: { name: '无法访问', requiresAuth: false }, component: () => import('../views/404.vue') },
    { path: '/', redirect: '/login' },
    {
        path: "/financial-detail/:id",
        name: "FinancialDetail",
        component: () => import("@/views/foreground/FinancialDetail.vue"),
        meta: { requiresAuth: true },
      },
]



const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: publicRoutes
})


export default router


