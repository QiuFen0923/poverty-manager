const dynamicRouter = [
    {
        path: '/',
        name: 'Manager',
        meta: { name: '后台' },
        component: () => import('../views/Manager.vue'),
        redirect: '/home',  // 重定向到主页
        children: [
            { path: 'home', name: 'Home', meta: { name: '系统首页', requiresAuth: true }, component: () => import('../views/manager/ViewMap') },
            { path: 'admin', name: 'Admin', meta: { name: '管理员信息', requiresAuth: true }, component: () => import('../views/manager/Admin') },
            { path: 'feedback', name: 'Feedback', meta: { name: '反馈信息', requiresAuth: true }, component: () => import('../views/manager/Feedback') },
            { path: 'worker', name: 'Worker', meta: { name: '工作人员信息', requiresAuth: true }, component: () => import('../views/manager/Worker') },
            { path: 'user', name: 'User', meta: { name: '用户信息', requiresAuth: true }, component: () => import('../views/manager/User') },
            { path: 'password', name: 'Password', meta: { name: '修改密码', requiresAuth: true }, component: () => import('../views/manager/Password') },
            { path: 'notice', name: 'Notice', meta: { name: '公告信息', requiresAuth: true }, component: () => import('../views/manager/Notice') },
            { path: 'poverty', name: 'Poverty', meta: { name: '贫困信息', requiresAuth: true }, component: () => import('../views/manager/Poverty') },
            { path: 'policy', name: 'Policy', meta: { name: '政策信息', requiresAuth: true }, component: () => import('../views/manager/Policy') },
            { path: 'information', name: 'Information', meta: { name: '资讯信息', requiresAuth: true }, component: () => import('../views/manager/Information') },
            { path: 'comment', name: 'Comment', meta: { name: '评论信息', requiresAuth: true }, component: () => import('../views/manager/Comment') },
            { path: 'need', name: 'Need', meta: { name: '阳光操作管理', requiresAuth: true }, component: () => import('../views/manager/Need') },
            { path: 'view_map', name: 'My_home', meta: { name: '数据统计', requiresAuth: true }, component: () => import('../views/manager/ViewMap') },
            {
                path: 'adminPerson',
                name: 'AdminPerson',
                meta: { name: '个人信息', requiresAuth: true },
                component: () => import('../views/manager/AdminPerson') // 确保路径正确
            },
            {
                path: '/financial',
                name: 'Financial',
                component: () => import('@/views/manager/Financial.vue'),
                meta: { requiresAuth: true }
            },
            {
                path: '/message',
                name: 'Message',
                component: () => import('@/views/manager/Message.vue'),
                meta: { requiresAuth: true }
            },
        ]
    },
    {
        path: '/',
        name: 'Foreground',
        meta: { name: '前台' },
        redirect: '/main_page',
        component: () => import('../views/Foreground.vue'),
        children: [
            { path: 'notice_detail/:id?', name: 'NoticeDetail', meta: { name: '资讯详情', requiresAuth: true }, component: () => import('../views/foreground/NoticeDetail') },
            { path: 'main_page', name: 'MainPage', meta: { name: '主页', requiresAuth: true }, component: () => import('../views/foreground/MainPage') },
            { path: 'need', name: 'need', meta: { name: '需求申请', requiresAuth: true }, component: () => import('../views/foreground/Need') },
            { path: 'user_person', name: 'UserPerson', meta: { name: '个人信息', requiresAuth: true }, component: () => import('../views/foreground/UserPerson') },
            { path: 'check_reply', name: 'CheckReply', meta: { name: '查看回复', requiresAuth: true }, component: () => import('../views/foreground/CheckReply') },
            { path: 'more_policy_or_notice', name: 'MorePolicyOrNotice', meta: { name: '更多', requiresAuth: true }, component: () => import('../views/foreground/MorePolicyOrNotice') },
        ]
    },

]
export default dynamicRouter
