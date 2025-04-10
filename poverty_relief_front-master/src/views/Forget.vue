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
          @submit.prevent="handleSubmit"
        >
          <div v-if="step === 1">
            <input
              v-model="form.username"
              type="text"
              placeholder="输入用户名"
              required
            >
            <button
              type="submit"
              class="primary-button"
            >下一步</button>
          </div>
          <div v-else-if="step === 2">
            <input
              v-model="form.newPassword"
              type="password"
              placeholder="输入新密码"
              required
            >
            <input
              v-model="form.confirmPassword"
              type="password"
              placeholder="确认新密码"
              required
            >
            <button
              type="submit"
              class="primary-button"
            >重置密码</button>
          </div>
          <button
            type="button"
            class="secondary-button"
            @click="backToLogin"
          >返回登录</button>
        </form>
      </div>
    </div>
  </template>
  
  <script>
export default {
  name: "Forget",
  data() {
    return {
      step: 1, // 当前步骤，1为输入账号，2为重置密码
      form: {
        username: "",
        newPassword: "",
        confirmPassword: "",
      },
    };
  },
  methods: {
    backToLogin() {
      this.$router.push("/login");
    },
    async handleSubmit() {
      if (this.step === 1) {
        // 第一步：验证账号是否存在
        try {
          const res = await this.$request.post("/check-username", { username: this.form.username });
          if (res.code === "200") {
            this.$message.success("账号验证成功，请输入新密码");
            this.step = 2; // 进入下一步
          } else {
            this.$message.error(res.msg || "账号不存在");
          }
        } catch (error) {
          this.$message.error("验证失败，请重试");
        }
      } else if (this.step === 2) {
        // 第二步：重置密码
        if (this.form.newPassword !== this.form.confirmPassword) {
          this.$message.error("两次输入的密码不一致");
          return;
        }
        try {
          const res = await this.$request.post("/reset-password", {
            username: this.form.username,
            newPassword: this.form.newPassword,
          });
          if (res.code === "200") {
            this.$message.success("密码重置成功，请返回登录");
            this.$router.push("/login");
          } else {
            this.$message.error(res.msg || "密码重置失败");
          }
        } catch (error) {
          this.$message.error("重置失败，请重试");
        }
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
  