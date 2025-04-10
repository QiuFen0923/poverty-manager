import request from "../utils/request";

export const fetchPermission = (role)=> request({url:"/getPermissions",method:"get",params:{role:role}})

