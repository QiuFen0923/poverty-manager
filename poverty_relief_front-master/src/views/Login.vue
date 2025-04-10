<template>
  <div class="login-container">
    <video
      class="background-video"
      autoplay
      loop
      muted
      playsinline
    >
      <source
        src="../assets/video/background.mp4"
        type="video/mp4"
      >
    </video>
    <div class="title-container">
      <h1 class="main-title">精 准 扶 贫 系 统</h1>
      <div class="subtitle">Poverty Alleviation System</div>
    </div>
    <div class="login-box">
      <form
        class="login-form"
        @submit.prevent="login"
      >
        <div class="form-item">
          <input
            v-model="form.username"
            type="text"
            placeholder="输入用户名"
            required
          >
        </div>
        <div class="form-item">
          <input
            v-model="form.password"
            type="password"
            placeholder="输入密码"
            required
          >
        </div>
        <div class="form-item">
          <select v-model="form.role">
            <option
              label="群众"
              value="USER"
            ></option>
            <option
              label="管理员"
              value="ADMIN"
            ></option>
            <option
              label="工作人员"
              value="WORKER"
            ></option>
          </select>
        </div>
        <button
          type="submit"
          class="login-button"
        >登录</button>
        <div class="form-footer">
          <a
            href="#"
            @click.prevent="Registe"
          >注册账号</a>
          <a 
            href="#"
            @click.prevent="Forget"
          >忘记密码</a>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import router from "@/router";

export default {
  name: "Login",
  data() {
    return {
      form: {
        role: "USER",
        username: "",
        password: "",
      },
    };
  },
  created() {},
  methods: {
    Registe() {
      this.$router.push({ name: "Register" });
    },
    Forget() {
    this.$router.push({ name: "Forget" }); // 假设你有一个名为 ForgetPassword 的路由
  },
    async login() {
      try {
        const res = await this.$request.post("/login", this.form);
        if (res.code === "200") {
          localStorage.setItem("xm-user", JSON.stringify(res.data)); // 存储用户数据
          let user = JSON.parse(localStorage.getItem("xm-user") || "{}");
          const token = res.data.token;
          this.$store.commit("LOGIN_IN", token); // 提交登录状态到Vuex
          // 等待权限数据加载
          this.$store.dispatch("permission/FETCH_PERMISSION").then(() => {
            // if(user.role==='USER') {
            //   router.push({name:"MainPage"});
            // }else {
            //   router.push({name:"Home"})
            // }
          });
          this.$message.success("登录成功");
        } else {
          this.$message.error(res.msg);
        }
      } catch (error) {
        this.$message.error("登录失败，请重试");
      }
    },
  },
};
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  position: relative;
  overflow: hidden;
}

.background-video {
  position: absolute;
  top: 50%;
  left: 50%;
  min-width: 100%;
  min-height: 100%;
  width: auto;
  height: auto;
  transform: translate(-50%, -50%);
  z-index: -1;
  object-fit: cover;
}

.title-container {
  position: absolute;
  top: 10%;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  width: 100%;
}

.main-title {
  font-size: 48px;
  color: #fff;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  letter-spacing: 8px;
  margin-bottom: 10px;
  font-weight: bold;
}

.subtitle {
  font-size: 20px;
  color: #fff;
  letter-spacing: 2px;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
  opacity: 0.9;
}

.login-box {
  margin-top: 180px; /* 为标题留出空间 */
  width: 400px;
  padding: 40px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(5px);
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-item {
  width: 100%;
}

.form-item input,
.form-item select {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  outline: none;
}

.form-item input:focus,
.form-item select:focus {
  border-color: #409eff;
}

.login-button {
  width: 100%;
  padding: 12px;
  background: #409eff;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.login-button:hover {
  background: #66b1ff;
}

.form-footer {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}

.form-footer a {
  color: #409eff;
  text-decoration: none;
  font-size: 14px;
}

.form-footer a:hover {
  color: #66b1ff;
}
</style>
