import request from "@/utils/request";

//获取扶贫资讯
export const getPovertyReliefNotices = () => request({url:'/notice/selectAll1',method:'get'})

//获取政策解读
export const getPovertyReliefPolicy = () => request({url:'/notice/selectAll2'})


//上传贫困申请表
export const uploadPovertyArchives = (data) => request({url:'/archives/add',method:'post',data:data})


//获取脱贫人员

export const getPovertyReliefPerson = () => request({url:'/user/selectAll3',method:'get'})


//根据id获取资讯或者政策
export const getPovertyReliefNoticesOrPolicyById = (id)=>request({url:`/notice/selectById/${id}`,method:'get'})

//分页获取资讯
export const getPovertyReliefNoticeByPage = ({pageNum,pageSize}) => request({url:'/notice/selectPage',method:'get',params:{pageNum,pageSize}})

//分页获取政策
export const getPovertyReliefPolicyByPage = ({pageNum,pageSize}) => request({url:'/notice/selectPage2',method:'get',params:{pageNum,pageSize}})

//根据id获取评论
export const getCommentById = (id) =>request({url:`/comment/selectById/${id}`,method:'get'})

//发表评论
export const sendRelativeComment=(data)=>request({url:"/comment/add",method:'post',data:data})

// 获取财政信息列表
export function getPovertyReliefFinancial() {
  return request({
    url: "/financial/list",
  });
}
  
  // 获取单条财政信息详情
  export function getFinancialDetail(id) {
    return request({
      url: `/financial/get/${id}`,
    });
  }

