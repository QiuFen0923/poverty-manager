<template>
  <div>
    <div class="search">
      <el-input placeholder="请输入姓名查询" style="width: 200px" v-model="userName"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>

    <div class="operation">
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe  @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
        <el-table-column prop="username" label="姓名" show-overflow-tooltip></el-table-column>
        <el-table-column prop="age" label="年龄" show-overflow-tooltip></el-table-column>
        <el-table-column prop="education" label="教育程度" show-overflow-tooltip></el-table-column>
        <el-table-column prop="price" label="收入" show-overflow-tooltip></el-table-column>
        <el-table-column prop="life" label="生活状态" show-overflow-tooltip></el-table-column>
        <el-table-column prop="status" label="审核状态"></el-table-column>
        <el-table-column label="操作" width="180" align="center">
          <template v-slot="scope">
            <el-button plain type="primary" size="mini" @click=handleEdit(scope.row)>查看详情</el-button>
            <el-button plain type="primary" size="mini" @click=handleEdit(scope.row) v-if="scope.row.status==='未审核'">去审核</el-button>
            <el-button plain type="danger" size="mini" @click=del(scope.row.id)>删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total">
        </el-pagination>
      </div>
    </div>
    <el-dialog title="困难详情" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" ref="formRef">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.username" placeholder="姓名" disabled></el-input>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
          <el-input v-model="form.age" placeholder="电话" disabled></el-input>
        </el-form-item>
        <el-form-item label="教育程度" prop="education">
          <el-input v-model="form.education" placeholder="年龄" disabled></el-input>
        </el-form-item>
        <el-form-item label="收入" prop="price">
          <el-input v-model="form.price" placeholder="邮箱" disabled></el-input>
        </el-form-item>
        <el-form-item label="负债" prop="debt">
          <el-input v-model="form.debt" placeholder="负债" disabled></el-input>
        </el-form-item>
        <el-form-item label="手艺技术" prop="skill">
          <el-input v-model="form.skill" placeholder="技术" disabled></el-input>
        </el-form-item>
        <el-form-item label="工作行业" prop="work">
          <el-input v-model="form.work" placeholder="工作" disabled></el-input>
        </el-form-item>
        <el-form-item label="住房情况" prop="house">
          <el-input v-model="form.house" placeholder="住房" disabled></el-input>
        </el-form-item>
        <el-form-item label="受灾情况" prop="harm">
          <el-input v-model="form.harm" placeholder="受灾" disabled></el-input>
        </el-form-item>
        <el-form-item label="土地面积" prop="area">
          <el-input v-model="form.area" placeholder="面积" disabled></el-input>
        </el-form-item>
        <el-form-item label="生活状态" prop="life">
          <el-input v-model="form.life" placeholder="电话" disabled></el-input>
        </el-form-item>
        <el-form-item label="残疾情况" prop="disable">
          <el-input v-model="form.disable" placeholder="残疾情况" disabled></el-input>
        </el-form-item>
        <el-form-item label="其他描述" prop="elseDescription">
          <el-input v-model="form.elseDescription" placeholder="描述" disabled></el-input>
        </el-form-item>
        <el-form-item label="审核" prop="status" >
          <el-select v-model="form.status" placeholder="请选择" style="width: 100%">
            <el-option label="未通过" value="未通过"></el-option>
            <el-option label="已通过" value="已通过"></el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import E from 'wangeditor'

let editor
function  initWangEditor(content){ setTimeout( () =>{
  if(!editor){
    editor = new E('#editor')
    editor.config.placeholder = '请输入内容'
    editor.config.uploadFileName = 'file'
    editor.config.uploadImgServer = 'http://localhost:9090/files/wang/upload'
    editor.create()
  }
  editor.txt.html(content)
},0)
}

export default {
  name: "Poverty",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      userName: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
        title: [
          {required: true, message: '请输入标题', trigger: 'blur'},
        ],
      },
      ids: [] ,
      viewContent :null,
      editorVisible :false

    }
  },
  created() {
    this.load(1)
  },
  methods: {
    viewAll(){

    },
    cancel(){
      this.fromVisible = false
      location.href = '/archives'
    },
    handleAdd() {   // 新增数据
      this.form = {}  // 新增数据的时候清空数据
      this.fromVisible = true   // 打开弹窗
    },
    handleEdit(row) {   // 编辑数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true   // 打开弹窗
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/archives/update' : '/archives/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // 表示成功保存
              this.$message.success('保存成功')
              this.load(1)
              this.fromVisible = false
            } else {
              this.$message.error(res.msg)  // 弹出错误的信息
            }
          })
        }
      })
    },
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/archives/delete/' + id).then(res => {
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
    handleSelectionChange(rows) {   // 当前选中的所有的行数据
      this.ids = rows.map(v => v.id)   //  [1,2]
    },
    delBatch() {   // 批量删除
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/archives/delete/batch', {data: this.ids}).then(res => {
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
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/archives/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          userName: this.userName,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    reset() {
      this.userName = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>

</style>
