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
        @submit.prevent="register"
      >
        <input
          v-model="form.username"
          type="text"
          placeholder="输入用户名"
          required
        >
        <input
          v-model="form.password"
          type="password"
          placeholder="输入密码"
          required
        >
        <div class="button-group">
          <button
            type="submit"
            class="primary-button"
          >注册</button>
          <button
            type="button"
            class="secondary-button"
            @click="backToLogin"
          >返回登录</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    return {
      form: {
        username: "",
        password: "",
      },
    };
  },
  methods: {
    backToLogin() {
      this.$router.push("/login");
    },
    async register() {
      try {
        this.form.role = "USER";
        const res = await this.$request.post("/register", this.form);
        if (res.code === "200") {
          this.$message.success("注册成功");
          this.$router.push("/login");
        } else  {
          this.$message.error(res.msg);
        }
      } catch (error) {
        this.$message.error("注册失败，请重试");
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
  margin-top: 180px;
  width: 400px;
  padding: 40px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.login-form input {
  width: 100%;
  padding: 15px;
  background: rgba(255, 255, 255, 0.9);
  border: none;
  border-radius: 8px;
  font-size: 16px;
  outline: none;
  transition: all 0.3s ease;
}

.login-form input:focus {
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.5);
}

.button-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-top: 20px;
}

.primary-button {
  width: 100%;
  padding: 15px;
  background: #409eff;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.primary-button:hover {
  background: #66b1ff;
  transform: translateY(-2px);
}

.secondary-button {
  width: 100%;
  padding: 12px;
  background: transparent;
  color: #409eff;
  border: 1px solid #409eff;
  border-radius: 8px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.secondary-button:hover {
  background: rgba(64, 158, 255, 0.1);
}
</style>
