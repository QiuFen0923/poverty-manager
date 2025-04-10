<template>
  <div>
    <el-carousel
      :interval="3000"
      type="card"
      height="370px"
    >
      <el-carousel-item>
        <img
          class="set_image"
          src="../../assets/imgs/front_image/xi_1.jpg"
        >
      </el-carousel-item>
      <el-carousel-item>
        <img
          class="set_image"
          src="../../assets/imgs/front_image/xi_2.jpg"
        >
      </el-carousel-item>
      <el-carousel-item>
        <img
          class="set_image"
          src="../../assets/imgs/front_image/xi_3.jpg"
        >
      </el-carousel-item>
    </el-carousel>
    <div class="middle_content">
      <div class="block">
        <el-carousel height="420px">
          <el-carousel-item>
            <img
              style="height: 420px;padding-left: 120px"
              src="../../assets/imgs/front_image/heart.png"
            >
          </el-carousel-item>
          <el-carousel-item>
            <img
              style="height: 430px;padding-left: 20px"
              src="../../assets/imgs/front_image/heart2.png"
            >
          </el-carousel-item>
        </el-carousel>
      </div>
      <div class="right_content">
        <div style="margin-top: -1em;margin-bottom: 2em">
          <el-row>
            <el-col :span="20">
              <el-tabs
                v-model="nav_current"
                @tab-click="handleClick"
              >
                <el-tab-pane
                  label="扶贫资讯"
                  name="1"
                ></el-tab-pane>
                <el-tab-pane
                  label="政策解读"
                  name="2"
                ></el-tab-pane>
                <el-tab-pane
                  label="财政讯息"
                  name="3"
                ></el-tab-pane>
              </el-tabs>
            </el-col>
            <el-col
              :span="4"
              style="display: flex; justify-content: center; align-items: center;"
            >
              <div
                style="margin-top: 10px;"
                @click="fetchMore"
                class="finger-hover"
              >更多>>></div>
            </el-col>
          </el-row>
        </div>
        <el-row
          v-if="nav_current==='1'"
          v-for="(item,index) in notices"
          :key="item.id"
        >
          <el-col
            :span="18"
            v-if="index<6"
          >
            <div
              class="item text finger-hover"
              @click="viewDetail(item.id)"
            >
              {{ item.title }}
            </div>
          </el-col>
          <el-col
            :span="6"
            style="color: #6f7378;font-size: 1.2em;text-align: right"
            v-if="index<6"
          >
            {{ item.time }}
          </el-col>
        </el-row>
        <el-row
          v-if="nav_current==='2'"
          v-for="(item,index) in policy"
          :key="item.id"
        >
          <el-col
            :span="18"
            v-if="index<6"
          >
            <div
              class="item text finger-hover"
              @click="viewDetail(item.id)"
            >
              {{ item.title }}
            </div>
          </el-col>
          <el-col
            :span="6"
            style="color: #6f7378;font-size: 1.2em;text-align: right"
            v-if="index<6"
          >
            {{item.time}}
          </el-col>
        </el-row>
        <el-row
          v-if="nav_current==='3'"
          v-for="(item, index) in financial"
          :key="item.id"
        >
          <el-col
            :span="18"
            v-if="index < 6"
          >
            <div
              class="item text finger-hover"
              @click="viewFinancialDetail(item.id)"
            >
              {{ item.title }}
            </div>
          </el-col>
          <el-col
            :span="6"
            style="color: #6f7378; font-size: 1.2em; text-align: right"
            v-if="index < 6"
          >
            {{ item.time }}
          </el-col>
        </el-row>
      </div>
    </div>
    <div class="end_title"><img
        class="reco_img"
        src="../../assets/imgs/front_image/icon/grow.png"
      >贫困申请信息公示</div>
      <el-row
    style="padding: 1% 8%"
    :gutter="20"
  >
    <el-col
      :span="6"
      v-for="item in publicizedApplications"
      :key="item.sfz"
    >
      <el-card
        shadow="hover"
        class="custom-card"
      >
        <div class="user_info">
          <div class="info_item"><strong>姓名：</strong>{{ item.applyname }}</div>
          <div class="info_item"><strong>身份证：</strong>{{ item.sfz }}</div>
          <div class="info_item"><strong>省份：</strong>{{ item.province }}</div>
          <div class="info_item"><strong>年龄：</strong>{{ item.age }}</div>
          <div class="info_item"><strong>贫困类型：</strong>{{ item.poorclass }}</div>
          <div class="info_item"><strong>贫困原因：</strong>{{ item.poorreason }}</div>
        </div>
        <el-button
          type="danger"
          size="mini"
          @click="openObjectionDialog(item)"
        >
          异议
        </el-button>
      </el-card>
    </el-col>
  </el-row>
  
    <el-dialog
      title="异议申请"
      :visible.sync="objectionDialogVisible"
      width="30%"
    >
      <el-form :model="objectionForm">
        <el-form-item label="异议内容">
          <el-input
            type="textarea"
            v-model="objectionForm.suggestion"
            :rows="4"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="objectionDialogVisible = false">取 消</el-button>
        <el-button  type="primary" 
                    @click="submitObjection"
                    :disabled="isSubmitting || !objectionForm.suggestion"
                    :loading="isSubmitting">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import {
  getPovertyReliefNotices,
  getPovertyReliefPerson,
  getPovertyReliefPolicy,
  getPovertyReliefFinancial,
  submitObjection,
} from "@/api/user";
export default {
  name: "MainPage",
  data() {
    return {
      persons: [],
      nav_current: "1",
      avatarUrl: require("../../assets/imgs/front_image/icon/avatar.png"),
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      notices: [],
      policy: [],
      financial: [],
      publicizedApplications: [],
      objectionDialogVisible: false,
      isSubmitting: false,
      objectionForm: {
        id: null,
        suggestion: "",
      },
    };
  },
  created() {},
  mounted() {
    this.getNotices();
    this.getPolicy();
    this.getPerson();
    this.getFinancial();
    this.getPublicizedApplications();
  },
  methods: {
    getPublicizedApplications() {
      this.$request.get("/main_page/publicized").then((res) => {
        if (res.code == 200) {
          this.publicizedApplications = res.data;
        } else {
          this.$message.error("数据加载失败");
        }
      });
    },

    openObjectionDialog(item) {
      this.objectionForm.id = item.id;
      this.objectionForm.suggestion = "";
      this.objectionDialogVisible = true;
    },
    submitObjection() {
      if (this.isSubmitting) return; // 防止重复提交
      
      const { id, suggestion } = this.objectionForm;
      
      if (!suggestion.trim()) {
        this.$message.error("异议内容不能为空");
        return;
      }

      this.isSubmitting = true;

      this.$request.post("/message/suggestion", { id, suggestion })
        .then(res => {
          // 统一处理响应格式（假设后端返回code为Number类型）
          if (res.code === 200) {
            this.$message({
              type: "success",
              message: "异议提交成功",
              duration: 2000,
              customClass: "el-message-success-custom" // 自定义样式类
            });
            this.objectionDialogVisible = false;
            this.getPublicizedApplications();
          } else {
            this.$message.error(res.message || "提交异常");
          }
        })
        .catch(err => {
          this.$message.error(err.message || "请求失败");
        })
        .finally(() => {
          this.isSubmitting = false;
        });
    },

    viewDetail(id) {
      this.$router.push({ name: "NoticeDetail", params: { id: id } });
    },
    getPerson() {
      getPovertyReliefPerson()
        .then((res) => {
          if (res.code === "200") {
            this.persons = res.data;
          }
        })
        .catch((err) => {
          this.$message(err.msg);
        });
    },
    getNotices() {
      getPovertyReliefNotices()
        .then((res) => {
          if (res.code === "200") {
            this.notices = res.data;
          }
        })
        .catch((err) => {
          this.$message(err.msg);
        });
    },
    getPolicy() {
      getPovertyReliefPolicy()
        .then((res) => {
          if (res.code === "200") {
            this.policy = res.data;
          }
        })
        .catch((err) => {
          this.$message(err.msg);
        });
    },
    // 获取财政信息列表
    getFinancial() {
      getPovertyReliefFinancial()
        .then((res) => {
          console.log("接口返回数据：", res); // 调试日志
          if (res.code === 200) {
            this.financial = res.data; // 将返回的数据赋值给 financial
            console.log("财政信息数据：", this.financial); // 调试日志
          } else {
            this.$message.error(res.message || "获取财政信息失败");
          }
        })
        .catch((err) => {
          console.error("接口调用失败：", err); // 调试日志
          this.$message.error(err.message || "获取财政信息失败");
        });
    },

    // 查看财政信息详情
    viewFinancialDetail(id) {
      this.$router.push({ name: "FinancialDetail", params: { id: id } });
    },
    handleClick() {},
    fetchMore() {
      this.$router.push({
        name: "MorePolicyOrNotice",
        query: { kind: this.nav_current },
      });
    },
  },
};
</script>

<style scoped>
@import "../../assets/css/mouse.css";

.custom-card {
  border-radius: 10px; /* 圆角 */
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.custom-card:hover {
  transform: translateY(-5px); /* 悬浮效果 */
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* 阴影 */
}

.user_info {
  font-family: "Microsoft YaHei", sans-serif; /* 字体 */
  font-size: 14px;
  line-height: 1.8;
  color: #333;
}

.info_item {
  margin-bottom: 8px; /* 每项之间的间距 */
}

.info_item strong {
  color: rgb(138, 212, 244); /* 关键字段高亮 */
}

.set_image {
  border-radius: 2%;
  height: 370px;
  width: 720px;
}

.middle_content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 420px;
  column-gap: 2em;
  padding-left: 8%;
  padding-right: 8%;
  padding-top: 2%;
}

.img_content {
  overflow: hidden;
}

.el-menu-demo {
  font-size: 3em;
}

.font_style__ {
  color: #161617; /* 文字颜色 */
  font-size: 0.5em; /* 字体大小 */
  /*margin-top: -1em;*/
  font-family: "爱奇艺黑体";
}
.avatar {
  width: 60px;
  height: 60px;
  display: block;
  border-radius: 50%;
}
.text {
  font-size: 1.2em;
  font-family: "Microsoft YaHei";
}

.item {
  margin-bottom: 2.3em;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
}

.end_title {
  font-family: "爱奇艺黑体";
  font-size: 22px;
  text-align: center;
  /*margin-top: 20px;*/
  line-height: 100px;
}

.reco_img {
  width: 40px;
  height: 40px;
  display: inline-block;
  margin-right: 8px;
  margin-bottom: -10px;
  /*line-height: 100px;*/
}

.user_info:not(:last-child) {
  margin-bottom: 14px; /* 只在不是最后一个子元素的元素上设置下边距 */
}

.user_info_font {
  font-family: "华文新魏";
  font-size: 17px;
}

.el-tabs__item {
  font-weight: 500;
  font-size: 24px;
  color: #000000;
  padding-bottom: 20px;
  margin-top: 10px;
  font-family: "华文新魏";
}

/*/deep/ .el-tabs__nav-wrap::after {*/
/*  background-color: #717171;*/
/*}*/

.el-tabs__item.is-active {
  color: #27ae2d;
  opacity: 1;
}

/* 下划线颜色 */
.el-tabs__active-bar {
  background-color: #27ae2d;
}

/* 自定义消息样式 */
.el-message-success-custom {
  background: #f0f9eb !important;
  border-color: #e1f3d8 !important;
  color: #67c23a !important;
  font-size: 14px;
  min-width: 240px;
}
</style>
