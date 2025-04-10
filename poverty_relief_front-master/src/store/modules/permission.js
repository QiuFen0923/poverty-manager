import { fetchPermission, fetchPermission2 } from "../../api/index"
import router from "../../router/index";
import dynamicRouter from "../../router/dynamic-router"
import { recursionRouter, setDefaultRoute } from "../../utils/recursion-router";

export default {
    namespaced: true,
    state: {
        permissionList: null,
        sidebarMenu: [],//导航菜单
        currentMenu: '' //高亮
    },
    getters: {},
    mutations: {
        SET_PERMISSION(state, routes) {
            state.permissionList = routes;
        },
        CLEAR_PERMISSION(state) {
            state.permissionList = null
        },
        SET_MENU(state, menu) {
            state.sidebarMenu = menu
        },
        CLEAR_MENU(state) {
            state.sidebarMenu = []
        }
    },
    //异步访问
    actions: {
        async FETCH_PERMISSION({ commit, state }) {
            let user = JSON.parse(localStorage.getItem('xm-user') || '{}')
            let permissionList = (await fetchPermission(user.role)).data//
            console.log(permissionList)
            // console.log(permissionList[0].name,44444444)
            let routes = recursionRouter(permissionList, dynamicRouter)
            // let MainContainer = DynamicRoutes.find(v=>v.path === "/")
            // let children = MainContainer.children
            // children.push(...routes)
            //生成菜单
            // commit("SET_MENU",children)
            //设置默认路由
            // setDefaultRoute([MainContainer])
            //初始化路由
            let initialRoutes = router.options.routes
            router.addRoutes(routes)
            if (user.role === 'USER') {
                router.push({ name: "MainPage" });
            } else {
                router.push({ name: "Home" })
            }
            commit("SET_PERMISSION", [...initialRoutes, ...routes])
        },
    }
}
