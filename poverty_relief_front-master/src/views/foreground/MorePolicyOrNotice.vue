<template>
  <div class="main_box">
    <div class="image_box">
      <el-image :src="leftPic"/>
    </div>
    <div class="content_box">
      <el-card class="finger-hover" v-for="item in noticesOrPolicy" :key="item.id" @click.native="viewDetail(item.id)">
        <el-row>
          <el-col :span="18">
            <div class="item text finger-hover">
              {{ item.title}}
            </div>
          </el-col>
          <el-col :span="6" style="color: #6f7378;font-size: 1.2em;text-align: right">
            {{item.time}}
          </el-col>
        </el-row>
      </el-card>
      <div class="pagination">
        <el-pagination class="pagination-wrapper"
                       background
                       @current-change="handleCurrentChange"
                       :current-page="pageNum"
                       :page-size="pageSize"
                       layout=" prev, pager, next"
                       :total="total">
        </el-pagination>
      </div>
    </div>
    <div class="image_box">
      <el-image :src="rightPic"/>
    </div>
  </div>
</template>

<script>
import {getPovertyReliefNotices,getPovertyReliefPolicy,getPovertyReliefNoticeByPage,getPovertyReliefPolicyByPage} from "@/api/user";
export default {
  name: "MorePolicyOrNotice",
  data() {
    return {
      leftPic: require('../../assets/imgs/front_image/left.png'),
      rightPic: require('../../assets/imgs/front_image/right.png'),
      pageNum: 1,
      pageSize: 5,
      total: 0,
      noticesOrPolicy:[],
    }
  },
  mounted() {
    this.loadData()
    this.getTotal()
  },
  methods: {
    getNotices(){
      getPovertyReliefNotices().then(res=>{
        if (res.code === '200') {
          this.total=res.data.length
        }
      }).catch(err=>{
        this.$message(err.msg)
      })
    },
    getPolicy(){
      getPovertyReliefPolicy().then(res=>{
        if (res.code === '200') {
          this.total=res.data.length
        }
      }).catch(err=>{
        this.$message(err.msg)
      })
    },
    getTotal(){
      if (this.$route.query.kind === '1') {
        this.getNotices()
      }else {
        this.getPolicy()
      }
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.loadData(pageNum)
    },
    viewDetail(id) {
      console.log(id)
      this.$router.push({name: 'NoticeDetail', params: {id: id}});
    },
    loadData() {
      let data = {
        pageNum:this.pageNum,
        pageSize:this.pageSize
      }
      if (this.$route.query.kind === '1') // 分页查询资讯
      {
        getPovertyReliefNoticeByPage(data).then(res => {
          this.noticesOrPolicy = res.data?.list
        })
      } else// 分页查询政策
      {
        getPovertyReliefPolicyByPage(data).then(res => {
          this.noticesOrPolicy = res.data?.list
        })
      }
    },
  }
}
</script>

<style scoped>
@import "../../assets/css/mouse.css";
.main_box {
  display: grid;
  grid-template-columns: 280px 1fr 280px;
  grid-template-rows: 70vh;
  min-height: 500px;
  margin-top: 3%;
  position: relative;
}

.image_box {
  margin-top: 50px;
  width: 270px;
  /*overflow: hidden;*/
  /*transform: rotate(-45deg) translateX(130px) translateY(100px);*/
}

.content_box {
  width: 100%;
  /*background-color: #409EFF;*/
  /*margin: auto;*/
}

.pagination {
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%); /* 水平居中 */
}
</style>
