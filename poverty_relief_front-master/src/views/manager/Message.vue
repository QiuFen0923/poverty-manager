<template>
  <div>
    <div class="search">
      <el-input
        placeholder="请输入身份证号码查询"
        style="width: 200px;"
        v-model="sfz"
      ></el-input>
      <el-select
        v-model="poorstate"
        placeholder="请选择贫困状态"
        style="width: 200px; margin-left: 10px"
      >
        <el-option
          label="脱贫"
          value="脱贫"
        ></el-option>
        <el-option
          label="待扶贫"
          value="待扶贫"
        ></el-option>
        <el-option
          label="已扶贫"
          value="已扶贫"
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
        v-if="user.role === 'ADMIN'"
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
          v-if="user.role === 'ADMIN'"
        ></el-table-column>

        <el-table-column
          prop="sfz"
          width="140"
          label="身份证号码"
          align="center"
          show-overflow-tooltip
        >
          <template slot-scope="scope">
            {{ formatIdCard(scope.row.sfz) }}
          </template>
        </el-table-column>
        <el-table-column
          prop="applyname"
          label="申请人姓名"
          width="100"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="age"
          label="年龄"
          width="50"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="poorstate"
          label="贫困状态"
          width="120"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="province"
          label="所属省份"
          width="100"
          align="center"
        ></el-table-column>

        <el-table-column
          prop="homemember"
          label="家庭人数"
          width="80"
          align="center"
        ></el-table-column>
        <el-table-column
          prop="poorclass"
          label="贫困类别"
          width="120"
        ></el-table-column>
        <el-table-column
          prop="poorway"
          label="扶贫方式"
          width="120"
        ></el-table-column>
        <el-table-column
          prop="user"
          label="创建人"
          width="80"
          align="center"
        ></el-table-column>

        <el-table-column
          prop="currentstate"
          label="审核状态"
          width="140"
          align="center"
        >
          <template slot-scope="scope">
            <el-tag :type="getStateType(scope.row.currentstate)">
              {{ scope.row.currentstate }}
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column
          prop="time"
          label="创建时间"
          width="100"
          align="center"
        ></el-table-column>

        <el-table-column
          label="操作"
          width="180"
          align="center"
          v-if="user.role === 'ADMIN'"
        >
          <template v-slot="scope">
            <el-button
              v-if="scope.row.currentstate !== '拒绝申请' && scope.row.currentstate !== '已完成'"
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
              style="margin-left: 10px; margin-bottom: 5px"
            >删除</el-button>
            <el-button
              v-if="scope.row.poorstate === '待扶贫' && scope.row.currentstate === '待公示'"
              plain
              type="success"
              size="mini"
              @click="handleAudit(scope.row)"
            >公示审核</el-button>
            <el-button
              v-if="scope.row.currentstate === '已公示'"
              plain
              type="success"
              size="mini"
              @click="handleRevoke(scope.row)"
            >撤回</el-button>
            <el-button
              v-if="scope.row.currentstate === '异议待处理'"
              plain
              type="success"
              size="mini"
              @click="handleReview(scope.row)"
            >复核</el-button>
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
      title="信息记录"
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
          label="身份证"
          prop="sfz"
        >
          <el-input
            v-model="form.sfz"
            placeholder="请输入18位身份证号码"
            maxlength="18"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="申请人姓名"
          prop="applyname"
        >
          <el-input
            v-model="form.applyname"
            placeholder="申请人姓名"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="年龄"
          prop="age"
        >
          <el-input-number
            v-model="form.age"
            controls-position="right"
            style="width: 100px"
          ></el-input-number>
        </el-form-item>
        <el-form-item
          label="省份"
          prop="province"
        >
          <el-select
            v-model="form.province"
            placeholder="请选择省份"
            style="width: 100%"
            filterable
            clearable
          >
            <el-option
              v-for="item in provinceOptions"
              :key="item"
              :label="item"
              :value="item"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="贫困状态"
          prop="poorstate"
        >
          <el-select
            v-model="form.poorstate"
            placeholder="请选择贫困状态"
            style="width: 100%"
            @change="handlePoorStateChange"
          >
            <el-option
              label="已扶贫"
              value="已扶贫"
            ></el-option>
            <el-option
              label="待扶贫"
              value="待扶贫"
            ></el-option>
            <el-option
              label="脱贫"
              value="脱贫"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="家庭人数"
          prop="homemember"
        >
          <el-input-number
            v-model="form.homemember"
            controls-position="right"
            style="width: 180px"
          ></el-input-number>
        </el-form-item>
        <el-form-item
          label="贫困类别"
          prop="poorclass"
        >
          <el-input
            v-model="form.poorclass"
            placeholder="贫困类别"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="贫困原因"
          prop="poorreason"
        >
          <el-input
            v-model="form.poorreason"
            placeholder="请输入具体情况"
            type="textarea"
            :rows="3"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="民族"
          prop="ethnic"
        >
          <el-select
            v-model="form.ethnic"
            placeholder="请选择民族"
            style="width: 100%"
            filterable
          >
            <el-option
              v-for="item in ethnicOptions"
              :key="item"
              :label="item"
              :value="item"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="扶贫方式"
          prop="poorway"
        >
          <el-input
            v-model="form.poorway"
            placeholder="扶贫方式"
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

    <!-- 审核对话框 -->
    <el-dialog
      title="审核信息"
      :visible.sync="auditVisible"
      width="50%"
      :close-on-click-modal="false"
      center
      top="15vh"
    >
      <el-form
        label-width="120px"
        :model="auditForm"
        ref="auditFormRef"
        class="audit-form"
      >
        <el-form-item label="身份证号码">
          <el-input
            v-model="auditForm.sfz"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="申请人姓名">
          <el-input
            v-model="auditForm.applyname"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input
            v-model="auditForm.age"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="省份">
          <el-input
            v-model="auditForm.province"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="贫困状态">
          <el-input
            v-model="auditForm.poorstate"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="家庭人数">
          <el-input
            v-model="auditForm.homemember"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="贫困类别">
          <el-input
            v-model="auditForm.poorclass"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="贫困原因">
          <el-input
            type="textarea"
            v-model="auditForm.poorreason"
            disabled
            rows="3"
          ></el-input>
        </el-form-item>
        <el-form-item label="民族">
          <el-input
            v-model="auditForm.ethnic"
            disabled
          ></el-input>
        </el-form-item>
      </el-form>
      <div
        slot="footer"
        class="dialog-footer"
      >
        <el-button @click="auditVisible = false">取 消</el-button>
        <el-button
          type="primary"
          @click="confirmAudit"
        >确 定</el-button>
      </div>
    </el-dialog>

    <!-- 复核对话框 -->
    <el-dialog
      title="复核信息"
      :visible.sync="reviewVisible"
      width="50%"
      :close-on-click-modal="false"
      center
      top="15vh"
    >
      <el-form
        label-width="120px"
        :model="reviewForm"
        ref="reviewFormRef"
        class="audit-form"
      >
        <el-form-item label="身份证号码">
          <el-input
            v-model="reviewForm.sfz"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="申请人姓名">
          <el-input
            v-model="reviewForm.applyname"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input
            v-model="reviewForm.age"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="省份">
          <el-input
            v-model="reviewForm.province"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="贫困状态">
          <el-input
            v-model="reviewForm.poorstate"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="家庭人数">
          <el-input
            v-model="reviewForm.homemember"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="贫困类别">
          <el-input
            v-model="reviewForm.poorclass"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="贫困原因">
          <el-input
            type="textarea"
            v-model="reviewForm.poorreason"
            disabled
            rows="3"
          ></el-input>
        </el-form-item>
        <el-form-item label="民族">
          <el-input
            v-model="reviewForm.ethnic"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="异议意见">
          <el-input
            type="textarea"
            v-model="reviewForm.suggestion"
            disabled
            rows="2"
          ></el-input>
        </el-form-item>
      </el-form>
      <div
        slot="footer"
        class="dialog-footer"
      >
        <el-button @click="reviewVisible = false">取 消</el-button>
        <el-button
          type="danger"
          @click="rejectApplication"
        >拒绝申请</el-button>
        <el-button
          type="primary"
          @click="confirmReview"
        >复核通过</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
export default {
  name: "FinanceInfo",
  data() {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      sfz: null,
      applyname: null,
      poorstate: null,
      fromVisible: false,
      auditVisible: false,
      reviewVisible: false,
      reviewForm: {},
      form: {},
      auditForm: {},
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      rules: {
        sfz: [
          { required: true, message: "请输入身份证号码", trigger: "blur" },
          { len: 18, message: "身份证号必须为18位", trigger: "blur" },
        ],
        poorstate: [
          { required: true, message: "请选择贫困状态", trigger: "change" },
        ],
        homemember: [
          { required: true, message: "请输入家庭人数", trigger: "blur" },
        ],
        age: [{ required: true, message: "请输入年龄", trigger: "blur" }],
        poorreason: [
          { required: true, message: "请输入贫困原因", trigger: "blur" },
        ],
        ethnic: [{ required: true, message: "请输入民族", trigger: "blur" }],
        province: [
          { required: true, message: "请选择省份", trigger: "change" },
        ],
      },
      ids: [],
      ethnicOptions: [
        "汉族",
        "壮族",
        "满族",
        "回族",
        "苗族",
        "维吾尔族",
        "土家族",
        "彝族",
        "蒙古族",
        "藏族",
        "布依族",
        "侗族",
        "瑶族",
        "朝鲜族",
        "白族",
        "哈尼族",
        "哈萨克族",
        "黎族",
        "傣族",
        "畲族",
        "傈僳族",
        "仡佬族",
        "东乡族",
        "高山族",
        "拉祜族",
        "水族",
        "佤族",
        "纳西族",
        "羌族",
        "土族",
        "仫佬族",
        "锡伯族",
        "柯尔克孜族",
        "达斡尔族",
        "景颇族",
        "毛南族",
        "撒拉族",
        "布朗族",
        "塔吉克族",
        "阿昌族",
        "普米族",
        "鄂温克族",
        "怒族",
        "京族",
        "基诺族",
        "德昂族",
        "保安族",
        "俄罗斯族",
        "裕固族",
        "乌孜别克族",
        "门巴族",
        "鄂伦春族",
        "独龙族",
        "塔塔尔族",
        "赫哲族",
        "珞巴族",
      ],
      provinceOptions: [
        "北京市",
        "天津市",
        "河北省",
        "山西省",
        "内蒙古自治区",
        "辽宁省",
        "吉林省",
        "黑龙江省",
        "上海市",
        "江苏省",
        "浙江省",
        "安徽省",
        "福建省",
        "江西省",
        "山东省",
        "河南省",
        "湖北省",
        "湖南省",
        "广东省",
        "广西壮族自治区",
        "海南省",
        "重庆市",
        "四川省",
        "贵州省",
        "云南省",
        "西藏自治区",
        "陕西省",
        "甘肃省",
        "青海省",
        "宁夏回族自治区",
        "新疆维吾尔自治区",
        "台湾省",
        "香港特别行政区",
        "澳门特别行政区",
      ],
    };
  },
  created() {
    this.load(1);
  },
  methods: {
    handleReview(row) {
      // 打开复核对话框
      this.reviewForm = JSON.parse(JSON.stringify(row));
      this.reviewVisible = true;
    },
    confirmReview() {
      this.$confirm("是否确认复核通过并公示?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          // 设置审核状态为已公示
          this.reviewForm.currentstate = "已公示";
          this.submitReview();
        })
        .catch(() => {
          // 用户点击取消，不做任何操作
        });
    },
    rejectApplication() {
      this.$confirm("是否确认拒绝该申请?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          // 设置审核状态为拒绝申请
          this.reviewForm.currentstate = "拒绝申请";
          this.submitReview();
        })
        .catch(() => {
          // 用户点击取消，不做任何操作
        });
    },
    submitReview() {
      // 提交复核
      this.reviewForm.user = this.user.name;
      this.reviewForm.time = new Date().toLocaleString();
      this.$request({
        url: "/message/update",
        method: "PUT",
        data: this.reviewForm,
      }).then((res) => {
        if (res.code === 200) {
          this.$message.success("复核操作成功");
          this.load(1);
          this.reviewVisible = false;
        } else {
          this.$message.error(res.message);
        }
      });
    },

    cancel() {
      this.fromVisible = false;
      location.href = "/message";
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
    handleAudit(row) {
      // 审核数据
      this.auditForm = JSON.parse(JSON.stringify(row));
      this.auditVisible = true;
    },
    confirmAudit() {
      this.$confirm("是否确认信息并公示?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          // 设置审核状态为已公示
          this.auditForm.currentstate = "已公示";
          this.submitAudit();
        })
        .catch(() => {
          // 用户点击取消，不做任何操作
        });
    },
    submitAudit() {
      // 提交审核
      this.auditForm.user = this.user.name;
      this.auditForm.time = new Date().toLocaleString();
      this.$request({
        url: "/message/update",
        method: "PUT",
        data: this.auditForm,
      }).then((res) => {
        if (res.code === 200) {
          this.$message.success("审核成功");
          this.load(1);
          this.auditVisible = false;
        } else {
          this.$message.error(res.message);
        }
      });
    },
    save() {
      // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          // 添加确认对话框
          const confirmContent = `
            <div style="text-align: left; margin: 10px 0;">
              <div style="margin-bottom: 15px;">请仔细检查以下信息是否正确：</div>
              <div>身份证号：${this.form.sfz}</div>
              <div>申请人：${this.form.applyname}</div>
              <div>贫困状态：${this.form.poorstate}</div>
              <div>扶贫方式：${this.form.poorway || "暂无"}</div>
              <div style="margin-top: 15px; color: #E6A23C;">确认无误后点击确定提交</div>
            </div>
          `;

          this.$confirm(confirmContent, "信息确认", {
            confirmButtonText: "确定",
            cancelButtonText: "返回修改",
            type: "warning",
            dangerouslyUseHTMLString: true,
          })
            .then(() => {
              // 用户点击确定后，提交数据
              this.form.user = this.user.name;
              this.form.time = new Date().toLocaleString();
              this.$request({
                url: this.form.id ? "/message/update" : "/message/insert",
                method: this.form.id ? "PUT" : "POST",
                data: this.form,
              }).then((res) => {
                if (res.code === 200) {
                  this.$message.success("保存成功");
                  this.load(1);
                  this.fromVisible = false;
                } else {
                  this.$message.error(res.message);
                }
              });
            })
            .catch(() => {
              // 用户点击返回修改，保持表单打开
              this.$message({
                type: "info",
                message: "请继续修改信息",
              });
            });
        }
      });
    },
    del(id) {
      // 单个删除
      this.$confirm("您确定删除吗？", "确认删除", { type: "warning" })
        .then((response) => {
          this.$request.delete("/message/delete/" + id).then((res) => {
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
            .delete("/message/delete/batch", { data: this.ids })
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
      // 处理身份证号码的模糊查询
      const searchSfz = this.sfz ? `%${this.sfz}%` : null;
      this.$request
        .post("/message/page", {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          sfz: searchSfz,
          poorstate: this.poorstate,
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
      this.sfz = null;
      this.poorstate = null;
      this.load(1);
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum);
    },
    formatIdCard(idCard) {
      if (!idCard) return "";
      return idCard.replace(/^(.{6})(?:\d+)(.{4})$/, "$1********$2");
    },
    getStateType(state) {
      switch (state) {
        case "待公示":
          return "primary"; // 蓝色
        case "已公示":
          return "warning"; // 黄色
        case "异议待处理":
          return "info"; // 紫色
        case "已完成":
          return "success"; // 绿色
        case "拒绝申请":
          return "danger"; // 红色
      }
    },
    handlePoorStateChange(value) {
      if (value === "脱贫") {
        this.form.currentstate = "已完成";
      }
    },
    handleRevoke(row) {
      this.$confirm("是否确认撤回该公示?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          const revokeForm = JSON.parse(JSON.stringify(row));
          revokeForm.currentstate = "待公示";
          revokeForm.user = this.user.name;
          revokeForm.time = new Date().toLocaleString();

          this.$request({
            url: "/message/update",
            method: "PUT",
            data: revokeForm,
          }).then((res) => {
            if (res.code === 200) {
              this.$message.success("撤回成功");
              this.load(1);
            } else {
              this.$message.error(res.message);
            }
          });
        })
        .catch(() => {
          // 用户点击取消，不做任何操作
        });
    },
  },
};
</script>

<style scoped>
.search {
  margin-bottom: 20px;
}
.operation {
  margin-bottom: 20px;
}
.pagination {
  margin-top: 20px;
  text-align: right;
}
.audit-form {
  max-height: 60vh;
  overflow-y: auto;
  padding-right: 20px;
}
.audit-form >>> .el-input.is-disabled .el-input__inner {
  color: #606266;
}
</style>