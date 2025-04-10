<template>
  <div class="box_whole">
    <div class="search">
      <el-input placeholder="请输入名称" style="width: 200px" v-model="content"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>

    <div class="operation">
      <el-button type="primary" plain @click="updateEdit">新增</el-button>
    </div>
    <el-table :data="needs" style="line-height: 30px;font-size: 15px;">
      <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
      <el-table-column prop="username" label="用户名" show-overflow-tooltip ></el-table-column>
      <el-table-column prop="content" label="申请内容" show-overflow-tooltip ></el-table-column>
      <el-table-column prop="opinion" label="领导回复" show-overflow-tooltip ></el-table-column>
      <el-table-column prop="deal" label="基层人员处理" show-overflow-tooltip ></el-table-column>
      <el-table-column prop="status" label="处理状态" show-overflow-tooltip ></el-table-column>
      <el-table-column prop="evaluate" label="我的评价" show-overflow-tooltip ></el-table-column>
      <el-table-column prop="time" label="申请时间"></el-table-column>
      <el-table-column label="操作" width="180" align="center">
        <template v-slot="scope">
          <el-button plain type="danger" size="mini" @click=del(scope.row.id) v-if="scope.row.status==='未处理'">撤销申请</el-button>
          <el-button plain type="primary" size="mini" @click=updateEvaluate(scope.row.id) v-if="scope.row.status==='已处理'">评价</el-button>
        </template>
      </el-table-column>
    </el-table>
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
    <el-dialog title="新增扶贫需求" :visible.sync="editorVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <div prop="elseDescription">
        <div>
          请输入你的需求内容
        </div>
        <el-input
            type="textarea"
            placeholder="请输入内容"
            v-model="needContent"
            show-word-limit
            :rows="6"
        >
        </el-input>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="editorVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="处理结果，评价一下吧" :visible.sync="viewEvaluate" width="40%">
      <div class="block">
        <el-rate
            v-model="userEvaluate"
            :colors="colors">
        </el-rate>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="viewEvaluate = false ; this.needContent = null">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Need",
  data(){
    return {
      form:{},
      pageNum : 1,
      userEvaluateId : null,
      pageSize : 10,
      total : 0,
      userEvaluate : null,
      content : null,
      needContent : null,
      colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
      needs:[],
      policy:[],
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      viewContent : null,
      editorVisible :false ,
      viewEvaluate : false,
    }
  },
  mounted() {
    this.load(this.pageNum)
  },
  methods:{
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    updateEdit(){
      this.editorVisible = true;
    },
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/need/delete/' + id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    save(){
      if(this.userEvaluateId === null){
        this.form.evaluate = "未评价"
        this.form.content =this.needContent;
        this.form.userId = this.user.id;
        this.$request({
          url: '/need/add',
          method: 'POST',
          data: this.form
        }).then(res => {
          if (res.code === '200') {  // 表示成功保存
            this.$message.success('新增成功')
            this.load(1)
            this.editorVisible = false
            this.needContent = null
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }else{
        this.form.id = this.userEvaluateId;
        this.form.evaluate =this.userEvaluate;
        this.$request({
          url:'/need/update',
          method: 'PUT',
          data: this.form
        }).then(res => {
          if (res.code === '200') {  // 表示成功保存
            this.$message.success('评价成功')
            this.load(1)
            this.viewEvaluate = false
            this.userEvaluateId = null
          } else {
            this.$message.error(res.msg)// 弹出错误的信息
          }
        })
      }
    },
    updateEvaluate(id){
      this.viewEvaluate =true;
      this.userEvaluateId = id;
    },
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
        this.$request.get('/need/selectPage', {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            content : this.content,
          }
        }).then(res => {
          this.needs = res.data?.list
          this.total = res.data?.total
        })
    },
    reset() {
      this.content = null
      this.load(1)
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
.operation {
  margin-top: 1%;
  margin-bottom: 1%;
}
</style>
