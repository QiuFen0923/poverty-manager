import router from "./index";
import store from "../store/index"

router.beforeEach((to, from, next) => {
    // 检查是否需要登录
    const requiresAuth = to.matched.some(record => record.meta.requiresAuth);

    // 用户已登录或尝试访问的页面不需要认证
    if (store.state.UserToken || !requiresAuth) {
        // 如果用户已登录但尚未获取权限列表，则获取权限列表
        if (store.state.UserToken && !store.state.permission.permissionList) {
            // 调用 Vuex action 来获取权限列表
            // 注意：这里假设 FETCH_PERMISSION 是一个返回 Promise 的 action
            store.dispatch("permission/FETCH_PERMISSION").then(() => {
                // 权限列表加载完成后，继续路由
                next();
            }).catch(() => {
                // 权限列表加载失败，可能重定向到错误页面或保持当前页面
                // 这里简单处理为跳转到登录页面，但实际项目中可能需要更复杂的逻辑
                next({ path: '/login' });
            });
        } else {
            // 用户已登录且已有权限列表，或尝试访问的页面不需要认证，直接继续
            next();
        }
    } else {
        // 用户未登录且尝试访问需要认证的页面，重定向到登录页面
        next({
            path: '/login',
            // query: { redirect: to.fullPath } // 将当前路由的完整路径作为查询参数传递给登录页面
        });
    }
});
