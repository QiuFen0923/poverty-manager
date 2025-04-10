<template>

  <div>
    <div style="text-align: center;font-size: 28px">
      {{ detailInfo.title }}<span style="display: inline-block;font-size: 15px;margin-left: 50px">{{ detailInfo.time }}</span>
    </div>
    <div style="text-align: center">
      <div style="display: inline-block;width: 1100px">
        <span
          style="font-size: 18px;text-align: left;font-family: '宋体'"
          v-html="this.detailInfo.content"
          class="w-e-text"
        ></span>
      </div>
    </div>
    <div style="width: 1100px;margin: auto">
      <el-tabs
        v-model="activeName"
        type="card"
      >
        <el-tab-pane
          label="评论"
          name="first"
        ></el-tab-pane>
      </el-tabs>
      <el-card
        shadow="never"
        v-for="item in commentsInfo"
      >
        <el-row>
          <el-col :span="1">
            <el-avatar :src="item.avatar"></el-avatar>
          </el-col>
          <el-col
            :span="6"
            style="display: flex;align-items: center;height: 40px;margin-left: 10px"
          >
            <div>{{item.name}}</div>
          </el-col>
        </el-row>
        <el-divider></el-divider>
        <el-row>
          <el-col :span="2">：</el-col>
          <el-col :span="19">
            {{item.content}}
          </el-col>
          <el-col
            :span="3"
            style="text-align: center"
          >
            {{item.time}}
          </el-col>
        </el-row>
      </el-card>
      <div class="user_comment">
        <div class="item">
          <el-input
            @focus="openDrawer"
            ref="myInput"
            v-model="userComment"
          ></el-input>
          <el-button
            type="success"
            @click="sentComment"
          >发表评论</el-button>
        </div>
      </div>
      <el-drawer
        title="评论"
        :visible.sync="drawer"
        v-if="drawer"
        direction="btt"
        :before-close="handleClose"
        class="custom-drawer"
      >
        <el-input
          type="textarea"
          :rows="5"
          v-model="userComment"
          style="padding: 0 2%"
        />
      </el-drawer>

    </div>
  </div>

</template>

<script>
import {
  getCommentById,
  getPovertyReliefNoticesOrPolicyById,
  sendRelativeComment,
} from "@/api/user";

export default {
  name: "NoticeDetail",
  data() {
    return {
      count: 0,
      activeName: "first",
      commentsInfo: [],
      detailInfo: [],
      userComment: "",
      drawer: false,
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
    };
  },
  mounted() {
    this.getDetail();
    this.load();
  },
  created() {
    console.log(this.$route);
  },
  methods: {
    load() {
      const id = this.$route.params.id;
      getCommentById(id)
        .then((res) => {
          if (res.code === "200") {
            this.commentsInfo = res.data;
          }
        })
        .catch((err) => {
          this.$message.error(err.msg);
        });
    },
    getDetail() {
      const id = this.$route.params.id;
      // console.log(id)
      getPovertyReliefNoticesOrPolicyById(id)
        .then((res) => {
          if (res.code === "200") {
            this.detailInfo = res.data;
          }
        })
        .catch((err) => {
          this.$message.error(err.msg);
        });
    },
    handleClose() {
      setTimeout(() => {
        if (this.$refs.myInput) {
          this.$refs.myInput.blur();
        }
      }, 500);
      this.drawer = false;
      console.log(this.drawer);
    },
    openDrawer() {
      this.drawer = true;
    },
    async sentComment() {
      try {
        let data = {
          userId: this.user.id,
          content: this.userComment,
          noticeId: this.$route.params.id, // 关键字段
          username: this.user.username,
          name: this.user.name,
          avatar: this.user.avatar,
        };
        console.log("Sending comment data:", data); // 添加日志
        const res = await sendRelativeComment(data);
        console.log("Comment response:", res); // 添加日志
        this.$message.success("发送成功");
        this.userComment = "";
        this.load(); // 重新加载评论列表
      } catch (error) {
        console.error("Error sending comment:", error); // 添加错误日志
        this.$message.error("发送失败：" + error.message);
      }
    },
  },
};
</script>

<style scoped>
.infinite-list-item {
  text-align: center;
}

body {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: rgb(117, 113, 113);
  color: white;
}

#main {
  flex: 1;
  width: 60%;
}

/*#typing{*/
/*  flex: 1;*/
/*  width: 60%;*/
/*  height: 20vh;*/
/*  border: red;*/
/*  font-size:xx-large;*/
/*}*/
#commend {
  flex: 1;
  width: 100%;
}

#btn {
  background-color: red;
}

p {
  background-color: black;
}
/deep/ .el-tabs__item {
  text-align: center;
  font-weight: 500;
  font-size: 18px;
  color: #f4776d;
  width: 100px;
  height: 40px;
  /*margin-top: 10px;*/
  font-family: "华文新魏";
  background-color: #f8f8f8;
}
.user_comment {
  margin-top: 30px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-column-start: 1;
}
.user_comment > .item {
  grid-column-start: 2; /* 从第二列开始 */
  display: grid;
  grid-template-columns: 3fr 1fr;
  grid-column-gap: 10px;
}
.el-drawer__wrapper {
  width: 800px !important; /* 使用 !important 确保你的样式被应用 */
  text-align: center;
  margin: auto;
}
/*.custom-drawer .el-drawer__wrapper {*/
/*  !* 注意：这里的调整是视觉上的，并不会真正改变抽屉的物理位置 *!*/
/*  !* 如果你想要抽屉完全居中于屏幕，这可能需要更复杂的布局或JavaScript计算 *!*/
/*  !* 以下样式仅作为示例，可能需要根据实际情况调整 *!*/
/*  margin-left: calc(50% - (1000px / 2)); !* 假设drawerSize为300px，这里计算偏移量使其看起来居中 *!*/
/*  !* 如果drawerSize是百分比，则计算方式会有所不同 *!*/
/*}*/
</style>
