<template>
    <div class="financial-detail">
      <div class="detail-card">
        <h1 class="detail-title">{{ detail.title }}</h1>
        <div class="detail-content">
          <p><strong>预算：</strong> {{ detail.budget }} 元</p>
          <p><strong>状态：</strong> <span :class="statusClass">{{ detail.status }}</span></p>
          <p><strong>项目：</strong> {{ detail.project }}</p>
          <p><strong>目标：</strong> {{ detail.target }}</p>
          <p><strong>时间：</strong> {{ detail.time || "暂无时间" }}</p>
          <p><strong>负责人：</strong> {{ detail.user }}</p>
        </div>
        <el-button type="primary" @click="backToMainPage" class="back-button">返回</el-button>
      </div>
    </div>
  </template>
  
  <script>
  import { getFinancialDetail } from "@/api/user";
  
  export default {
    name: "FinancialDetail",
    data() {
      return {
        detail: {}, // 存储财政信息详情
      };
    },
    computed: {
      statusClass() {
        // 根据状态动态设置样式
        return {
          "status-unused": this.detail.status === "未使用",
          "status-used": this.detail.status === "已使用",
          "status-completed": this.detail.status === "已用完",
        };
      },
    },
    created() {
      const id = this.$route.params.id; // 获取路由参数中的 ID
      this.getDetail(id);
    },
    methods: {
      getDetail(id) {
        getFinancialDetail(id)
          .then((res) => {
            if (res.code === 200) {
              this.detail = res.data; // 将返回的数据赋值给 detail
            } else {
              this.$message.error(res.message || "获取详情失败");
            }
          })
          .catch((err) => {
            this.$message.error(err.message || "获取详情失败");
          });
      },
      backToMainPage() {
        this.$router.push({ name: "MainPage" });
      },
    },
  };
  </script>
  
  <style scoped>
  .financial-detail {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background-color: #f5f5f5;
    padding: 20px;
  }
  
  .detail-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    padding: 30px;
    max-width: 600px;
    width: 100%;
    text-align: left;
  }
  
  .detail-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
    text-align: center;
  }
  
  .detail-content p {
    font-size: 16px;
    color: #555;
    margin: 10px 0;
    line-height: 1.6;
  }
  
  .detail-content strong {
    color: #333;
  }
  
  .status-unused {
    color: #e67e22; /* 橙色 */
    font-weight: bold;
  }
  
  .status-used {
    color: #3498db; /* 蓝色 */
    font-weight: bold;
  }
  
  .status-completed {
    color: #2ecc71; /* 绿色 */
    font-weight: bold;
  }
  
  .back-button {
    display: block;
    margin: 20px auto 0;
    width: 100px;
    text-align: center;
  }
  </style>