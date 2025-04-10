<template>
  <div style="min-width: 1400px">
    <el-header
      height="40px"
      style=""
    >
      <div class="parent_container">
        <el-row
          :gutter="20"
          style="width: 100%;"
        >
          <el-col :span="1">
            <img
              @click="goHome"
              class="finger-hover"
              style="display: inline-block"
              src="../assets/imgs/front_image/logo.png"
            />
          </el-col>
          <el-col :span="15">
            <span
              class="navigate_style finger-hover"
              style="color: #f68a8a"
              @click="goHome"
            >精准扶贫系统</span>
          </el-col>
          <el-col :span="3">
            <span
              class="navigate_style finger-hover navigate_right"
              @click="apply"
            ></span>
          </el-col>
          <el-col :span="3">
            <span
              class="navigate_style finger-hover navigate_right"
              @click="goUserInfo"
            >个人信息</span>
          </el-col>
          <el-col :span="2">
            <!--            <span class="navigate_style finger-hover navigate_right"@click="goLogin()">登录</span>-->
            <el-dropdown v-if="user.role">
              <span class="el-dropdown-link">
                <el-avatar
                  v-if="user.avatar"
                  :src="user.avatar"
                ></el-avatar>
                <el-avatar
                  v-else
                  src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"
                ></el-avatar>
              </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item disabled>
                  <span style="color: #409EFF; font-weight: bold;">{{ user.username }}</span>
                </el-dropdown-item>
                <el-dropdown-item
                  divided
                  @click.native="Logout"
                >退出登录</el-dropdown-item>
                <el-dropdown-item
                  divided
                  @click.native="goFeedback"
                >我要反馈</el-dropdown-item>
                <!--                <el-badge is-dot class="item">-->
                <el-badge class="item">
                  <el-dropdown-item @click.native="readReply">查看回复</el-dropdown-item>
                </el-badge>
              </el-dropdown-menu>
            </el-dropdown>
          </el-col>
        </el-row>
        <el-dialog
          title="写反馈"
          :visible.sync="sendVisible"
          width="60%"
          :close-on-click-modal="false"
          destroy-on-close
          @close="cancel"
        >
          <div id="editor"></div>
          <div
            slot="footer"
            class="dialog-footer"
          >
            <el-button @click="sendVisible = false">取 消</el-button>
            <el-button
              type="primary"
              @click="save"
            >确 定</el-button>
          </div>
          <!--          <div v-html="this.receiptFeedback" class="w-e-text"></div>-->
        </el-dialog>
        <el-dialog
          title="回复"
          :visible.sync="receiptVisible"
          width="50%"
          :close-on-click-modal="false"
          destroy-on-close
        >
          <div
            style="height: 400px"
            v-html="this.receiptFeedback"
            class="w-e-text"
          ></div>
        </el-dialog>
      </div>
    </el-header>
    <el-main>
      <router-view></router-view>
    </el-main>
  </div>
</template>

<script>
import E from "wangeditor";

let editor;

function initWangEditor(content) {
  setTimeout(() => {
    if (!editor) {
      editor = new E("#editor");
      editor.config.placeholder = "请输入内容";
      editor.config.uploadFileName = "file";
      editor.config.uploadImgServer = "http://localhost:9090/files/wang/upload";
      editor.create();
    }
    editor.txt.html(content);
  });
}

export default {
  name: "Foreground",
  data() {
    return {
      sendVisible: false,
      receiptVisible: false,
      sendFeedback: "",
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      receiptFeedback: "123",
      activeIndex: "1",
      form: {},
    };
  },
  mounted() {},
  methods: {
    goHome() {
      this.$router.push({ name: "MainPage" });
    },
    goLogin() {
      this.$router.push({ name: "登录" });
    },
    goFeedback() {
      this.sendVisible = true;
      initWangEditor("");
    },
    goNeed() {
      this.$router.push({ name: "need" });
    },
    goUserInfo() {
      this.$router.push({ name: "UserPerson" });
    },
    Logout() {
      localStorage.removeItem("xm-user");
      this.$store.commit("LOGIN_OUT");
      this.$router.push("/login");
    },
    apply() {
      this.$router.push({ name: "Questionnaire" });
    },
    readReply() {
      this.$router.push({ name: "CheckReply" });
    },
    handleCommand(command) {
      this.$message("click on item " + command);
      command();
    },
    cancel() {
      this.sendVisible = false;
      location.href = this.$route.path;
    },
    viewEditor(content) {
      this.viewContent = content;
      this.editorVisible = true;
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    save() {
      // 保存按钮触发的逻辑  它会触发新增或者更新
      this.form.content = editor.txt.html();
      this.form.username = this.user.username; // 添加用户名
      this.$request({
        url: "/feedback/add",
        method: "POST",
        data: this.form,
      }).then((res) => {
        if (res.code === "200") {
          // 表示成功保存
          this.$message.success("反馈成功");
          this.sendVisible = false;
        } else {
          this.$message.error(res.msg); // 弹出错误的信息
        }
      });
    },
  },
};
</script>

<style scoped>
/**{*/
/*  margin: 0;*/
/*  padding: 0;*/
/*}*/
.parent_container {
  height: 85px;
  display: flex;
  align-items: center;
}

.parent_container img {
  height: 50px;
  display: inline-block;
  vertical-align: middle;
}

.parent_container .navigate_style {
  display: inline-block;
  vertical-align: middle;
  font-size: 1.9em;
  margin-left: 10px;
  font-family: "黑体";
}

.finger-hover {
  cursor: pointer; /* 当鼠标悬停时显示小手图标 */
}

.parent_container .navigate_right {
  margin-top: 5px;
  font-size: 18px;
  vertical-align: middle;
}
/*.item {*/
/*  margin-top: 2px;*/
/*  margin-right: 10px;*/
/*}*/

.parent_container .navigate_right:hover {
  color: #f68a8a;
}
</style>
