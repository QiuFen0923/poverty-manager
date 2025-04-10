<template>
  <div>
    <div class="search">
      <el-input
        placeholder="请输入标题查询"
        style="width: 200px"
        v-model="title"
      ></el-input>
      <el-select
        v-model="status"
        placeholder="请选择使用状态"
        style="width: 200px; margin-left: 10px"
      >
        <el-option
          label="未使用"
          value="未使用"
        ></el-option>
        <el-option
          label="已使用"
          value="已使用"
        ></el-option>
        <el-option
          label="已用完"
          value="已用完"
        ></el-option>
      </el-select>
      <el-button
        type="info"
        plain
        style="margin-left: 10px"
        @click="load(1)"
      >查询</el-button>
      <el-button
        type="warning"
        plain
        style="margin-left: 10px"
        @click="reset"
      >重置</el-button>
    </div>

    <div class="operation">
      <el-button
        type="primary"
        plain
        @click="handleAdd"
      >新增</el-button>
      <el-button
        type="danger"
        plain
        @click="delBatch"
      >批量删除</el-button>
    </div>

    <div class="table">
      <el-table
        :data="tableData"
        stripe
        @selection-change="handleSelectionChange"
      >
        <el-table-column
          type="selection"
          width="55"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="id"
          label="序号"
          width="80"
          align="center"
          sortable
        ></el-table-column>
        <el-table-column
          prop="title"
          label="标题"
          show-overflow-tooltip
        ></el-table-column>
        <el-table-column
          prop="status"
          label="使用状态"
          width="120"
        ></el-table-column>
        <el-table-column
          prop="budget"
          label="资金总额"
          width="120"
        ></el-table-column>
        <el-table-column
          prop="project"
          label="项目情况"
          width="120"
        ></el-table-column>
        <el-table-column
          prop="target"
          label="扶贫目标"
          width="120"
        ></el-table-column>
        <el-table-column
          prop="time"
          label="创建时间"
        ></el-table-column>
        <el-table-column
          prop="user"
          label="创建人"
        ></el-table-column>

        <el-table-column
          label="操作"
          width="180"
          align="center"
        >
          <template v-slot="scope">
            <el-button
              plain
              type="primary"
              @click="handleEdit(scope.row)"
              size="mini"
            >编辑</el-button>
            <el-button
              plain
              type="danger"
              size="mini"
              @click="del(scope.row.id)"
            >删除</el-button>
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
          :total="total"
        >
        </el-pagination>
      </div>
    </div>

    <el-dialog
      title="财政信息"
      :visible.sync="fromVisible"
      width="60%"
      :close-on-click-modal="false"
      destroy-on-close
      @close="cancel"
    >
      <el-form
        label-width="100px"
        style="padding-right: 50px"
        :model="form"
        :rules="rules"
        ref="formRef"
      >
        <el-form-item
          label="标题"
          prop="title"
        >
          <el-input
            v-model="form.title"
            placeholder="标题内容"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="使用状态"
          prop="status"
        >
          <el-select
            v-model="form.status"
            placeholder="请选择使用状态"
          >
            <el-option
              label="未使用"
              value="未使用"
            ></el-option>
            <el-option
              label="已使用"
              value="已使用"
            ></el-option>
            <el-option
              label="已用完"
              value="已用完"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="资金总额"
          prop="budget"
        >
          <el-input-number
            v-model="form.budget"
            :precision="2"
            :step="0.1"
          ></el-input-number>
        </el-form-item>
        <el-form-item
          label="项目情况"
          prop="project"
        >
          <el-input
            v-model="form.project"
            placeholder="请输入项目具体情况"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="扶贫目标"
          prop="target"
        >
          <el-input
            v-model="form.target"
            placeholder="请输入扶贫目标"
          ></el-input>
        </el-form-item>
      </el-form>
      <div
        slot="footer"
        class="dialog-footer"
      >
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button
          type="primary"
          @click="save"
        >确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "FinanceInfo",
  data() {
    return {
      tableData: [], // 所有的数据
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      title: null,
      status: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      rules: {
        title: [{ required: true, message: "请输入标题", trigger: "blur" }],
        status: [
          { required: true, message: "请选择使用状态", trigger: "change" },
        ],
        budget: [
          { required: true, message: "请输入资金总额", trigger: "blur" },
        ],
        project: [
          { required: true, message: "请输入项目情况", trigger: "blur" },
        ],
        target: [
          { required: true, message: "请输入扶贫目标", trigger: "blur" },
        ],
      },
      ids: [],
    };
  },
  created() {
    this.load(1);
  },
  methods: {
    cancel() {
      this.fromVisible = false;
      location.href = "/financial";
    },
    handleAdd() {
      // 新增数据
      this.form = {}; // 新增数据的时候清空数据
      this.fromVisible = true; // 打开弹窗
    },
    handleEdit(row) {
      // 编辑数据
      this.form = JSON.parse(JSON.stringify(row)); // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true; // 打开弹窗
    },
    save() {
      // 保存按钮触发的逻辑  它会触发新增或者更新
      this.form.user = this.user.name;
      this.form.time = new Date().toLocaleString(); // 添加当前时间
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? "/financial/update" : "/financial/insert",
            method: this.form.id ? "PUT" : "POST",
            data: this.form,
          }).then((res) => {
            if (res.code === 200) {
              // 表示成功保存
              this.$message.success("保存成功");
              this.load(1);
              this.fromVisible = false;
            } else {
              this.$message.error(res.message); // 弹出错误的信息
            }
          });
        }
      });
    },
    del(id) {
      // 单个删除
      this.$confirm("您确定删除吗？", "确认删除", { type: "warning" })
        .then((response) => {
          this.$request.delete("/financial/delete/" + id).then((res) => {
            if (res.code === 200) {
              // 表示操作成功
              this.$message.success("操作成功");
              this.load(1);
            } else {
              this.$message.error(res.message); // 弹出错误的信息
            }
          });
        })
        .catch(() => {});
    },
    handleSelectionChange(rows) {
      // 当前选中的所有的行数据
      this.ids = rows.map((v) => v.id); //  [1,2]
    },
    delBatch() {
      // 批量删除
      if (!this.ids.length) {
        this.$message.warning("请选择数据");
        return;
      }
      this.$confirm("您确定批量删除这些数据吗？", "确认删除", {
        type: "warning",
      })
        .then((response) => {
          this.$request
            .delete("/financial/delete/batch", { data: this.ids })
            .then((res) => {
              if (res.code === 200) {
                // 表示操作成功
                this.$message.success("操作成功");
                this.load(1);
              } else {
                this.$message.error(res.message); // 弹出错误的信息
              }
            });
        })
        .catch(() => {});
    },
    load(pageNum) {
      // 分页查询
      if (pageNum) this.pageNum = pageNum;
      this.$request
        .post("/financial/page", {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
          status: this.status,
        })
        .then((res) => {
          if (res.code === 200) {
            this.tableData = res.data.list;
            this.total = res.data.total;
          } else {
            this.$message.error(res.message);
          }
        });
    },
    reset() {
      this.title = null;
      this.status = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
  },
};
</script>

<style scoped>
</style> 