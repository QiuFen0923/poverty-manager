<template>
  <div class="box_whole">

    <el-table
        :data="feedback"
        style="line-height: 30px;font-size: 15px;"
        :cell-style="{textAlign:'center'}"
        :header-cell-style="{ textAlign: 'center' }"
        :row-style="{height:'60px'}"

    >
<!--      <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>-->
      <el-table-column prop="time" sortable label="反馈时间"></el-table-column>
      <el-table-column prop="dealContent" label="回复内容" show-overflow-tooltip></el-table-column>
      <el-table-column prop="content" label="反馈内容" show-overflow-tooltip >
        <template v-slot = "scope">
          <el-button  type="primary" size="mini" @click ="viewReply(scope.row.content)">查看</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="pagination" style="text-align: center">
      <el-pagination class="pagination-wrapper"
          background
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-size="pageSize"
          layout=" prev, pager, next"
          :total="total">
      </el-pagination>
    </div>
    <el-dialog title="内容" :visible.sync="editorVisible" width="50%" :close-on-click-modal="false" destroy-on-close>
      <div v-html="this.viewContent" class="w-e-text"></div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "CheckReply",
  data(){
    return {
      pageNum : 1,
      pageSize : 10,
      total : 0,
      num : this.$route.query.kind,
      feedback:[],
      policy:[],
      viewContent : null,
      editorVisible :false
    }
  },
  mounted() {
    this.load(this.pageNum)
  },
  methods:{
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    ViewDetail(id){
      this.$router.push({ name: 'NoticeDetail', params: {id:id} });
    },
    viewReply(content){
      this.viewContent = content
      this.editorVisible = true
    },
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
        this.$request.get('/feedback/selectPage', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
          }
        }).then(res => {
          this.feedback = res.data?.list
          this.total = res.data?.total
        })
    },
  }
}
</script>

<style scoped>
.pagination {
  position: absolute;
  bottom: 10px;
  left: 50%;
  transform: translateX(-50%); /* 水平居中 */
}
.box_whole {
  margin: 2%;
  border: double #bdbbbb 5px;
  border-radius: 2%;
  padding: 2%;
  height: 80vh;
  min-height: 600px;
  position: relative;
}
</style>
