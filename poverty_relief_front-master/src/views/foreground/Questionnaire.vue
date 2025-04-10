<template>
  <div class="main_container">
    <div class="scene">
      <article
        class="book"
        ref="book"
      >
        <div
          class="page"
          :class="{active : currentPage===0,flipped: currentPage>0}"
        >
          <div class="front"></div>
          <div class="back">
            <div class="title">
              贫 困 申 请 表
            </div>
            <div class="page_color">Page 1</div>
            <div class="form_div_style">
              <el-form
                :model="questionForm"
                label-width="15px"
                class="demo-ruleForm"
              >
                <el-form-item prop="age">
                  <div>
                    问题一 : 您的年龄是?
                  </div>
                  <el-radio-group
                    v-model="questionForm.age"
                    class="radio-vertical"
                  >
                    <el-radio :label="'22岁以下'">22岁以下</el-radio>
                    <el-radio :label="'23-35岁'">23-35岁</el-radio>
                    <el-radio :label="'36-50岁'">36-50岁</el-radio>
                    <el-radio :label="'51-65岁'">51-65岁</el-radio>
                    <el-radio :label="'66岁及以上'">66岁及以上</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item prop="skill">
                  <div>
                    问题二 : 您是否有学习过科学技术?
                  </div>
                  <el-radio-group
                    v-model="questionForm.skill"
                    class="radio-vertical"
                  >
                    <el-radio :label="'从来没有学习过'">从来没有学习过</el-radio>
                    <el-radio :label="'学过一点点'">学过一点点</el-radio>
                    <el-radio :label="'经常学习'">经常学习</el-radio>
                  </el-radio-group>
                </el-form-item>
              </el-form>
            </div>
          </div>
        </div>
        <div
          class="page"
          :class="{active : currentPage===1,flipped: currentPage>1}"
        >
          <div class="front">
            <div class="title">
              贫 困 申 请 表
            </div>
            <div class="page_color">Page 2</div>
            <div class="form_div_style">
              <el-form
                :model="questionForm"
                label-width="15px"
                class="demo-ruleForm"
              >
                <el-form-item prop="education">
                  <div>
                    问题三 : 您的文化程度?
                  </div>
                  <el-radio-group
                    v-model="questionForm.education"
                    class="radio-vertical"
                  >
                    <el-radio :label="'无文化'">无文化</el-radio>
                    <el-radio :label="'小学文化'">小学文化</el-radio>
                    <el-radio :label="'初中文化'">初中文化</el-radio>
                    <el-radio :label="'高中文化 (含中专、职高)'">高中文化 (含中专、职高)</el-radio>
                    <el-radio :label="'大专文化及以上'">大专文化及以上</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item prop="work">
                  <div>
                    问题四 : 您从事的是什么产业?
                  </div>
                  <el-radio-group
                    v-model="questionForm.work"
                    class="radio-vertical"
                  >
                    <el-radio :label="'农业'">农业</el-radio>
                    <el-radio :label="'工业'">工业</el-radio>
                    <el-radio :label="'服务业'">服务业</el-radio>
                  </el-radio-group>
                </el-form-item>
              </el-form>
            </div>
          </div>
          <div class="back">
            <div class="title">
              贫 困 申 请 表
            </div>
            <div class="page_color">Page 3</div>
            <div class="form_div_style">
              <el-form
                :model="questionForm"
                label-width="15px"
                class="demo-ruleForm"
              >
                <el-form-item prop="life">
                  <div>
                    问题五 : 对于目前的生活状态，您的态度是?
                  </div>
                  <el-radio-group
                    v-model="questionForm.life"
                    class="radio-vertical"
                  >
                    <el-radio :label="'再怎么努力，也富不起来'">再怎么努力，也富不起来</el-radio>
                    <el-radio :label="'等待政府的救助帮助'">等待政府的救助帮助</el-radio>
                    <el-radio :label="'无所谓，得过且过'">无所谓，得过且过</el-radio>
                    <el-radio :label="'将会通过自己的努力使自己富起来'">将会通过自己的努力使自己富起来</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item prop="price">
                  <div>
                    问题六 : 您的家庭年收入?
                  </div>
                  <el-radio-group
                    v-model="questionForm.price"
                    class="radio-vertical"
                  >
                    <el-radio :label="'1000元及以下'">1000元及以下</el-radio>
                    <el-radio :label="'1001-2000元'">1001-2000元</el-radio>
                    <el-radio :label="'2001-3000元'">2001-3000元</el-radio>
                    <el-radio :label="'3001-4000'">3001-4000</el-radio>
                    <el-radio :label="'4001元及以上'">4001元及以上</el-radio>
                  </el-radio-group>
                </el-form-item>
              </el-form>
            </div>
          </div>
        </div>
        <div
          class="page"
          :class="{active : currentPage===2,flipped: currentPage>2}"
        >
          <div class="front">
            <div class="title">
              贫 困 申 请 表
            </div>
            <div class="page_color">Page 4</div>
            <div class="form_div_style">
              <el-form
                :model="questionForm"
                label-width="15px"
                class="demo-ruleForm"
              >
                <el-form-item prop="house">
                  <div>
                    问题七 : 您家目前的住房是以下哪种类型?
                  </div>
                  <el-radio-group
                    v-model="questionForm.house"
                    class="radio-vertical"
                  >
                    <el-radio :label="'楼房'">楼房</el-radio>
                    <el-radio :label="'砖瓦房'">砖瓦房</el-radio>
                    <el-radio :label="'木头房'">木头房</el-radio>
                    <el-radio :label="'茅草房'">茅草房</el-radio>
                    <el-radio :label="'其他'">其他</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item prop="harm">
                  <div>
                    问题八 : 您家里是否遭受过自然灾害的侵害?
                  </div>
                  <el-radio-group
                    v-model="questionForm.harm"
                    class="radio-vertical"
                  >
                    <el-radio :label="'从来没有遭受过'">从来没有遭受过</el-radio>
                    <el-radio :label="'遭受过'">遭受过</el-radio>
                    <el-radio :label="'经常遭受'">经常遭受</el-radio>
                  </el-radio-group>
                </el-form-item>
              </el-form>
            </div>
          </div>
          <div class="back">
            <div class="title">
              贫 困 申 请 表
            </div>
            <div class="page_color">Page 5</div>
            <div class="form_div_style">
              <el-form
                :model="questionForm"
                label-width="15px"
                class="demo-ruleForm"
              >
                <el-form-item prop="area">
                  <div>
                    问题九 : 你家的耕地有多少?
                  </div>
                  <el-radio-group
                    v-model="questionForm.area"
                    class="radio-vertical"
                  >
                    <el-radio :label="'1亩以下'">1亩以下</el-radio>
                    <el-radio :label="'1-2亩'">1-2亩</el-radio>
                    <el-radio :label="'2-3亩'">2-3亩</el-radio>
                    <el-radio :label="'3亩以上'">3亩以上</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item prop="disable">
                  <div>
                    问题十 : 您自己或者周围的人中是否有因为生病或者残疾导致贫困的?
                  </div>
                  <el-radio-group
                    v-model="questionForm.disable"
                    class="radio-vertical"
                  >
                    <el-radio :label="'有'">有</el-radio>
                    <el-radio :label="'没有'">没有</el-radio>
                  </el-radio-group>
                </el-form-item>
              </el-form>
            </div>
          </div>
        </div>
        <div
          class="page"
          :class="{active : currentPage===3,flipped: currentPage>3}"
        >
          <div class="front">
            <div class="title">
              贫 困 申 请 表
            </div>
            <div class="page_color">Page 6</div>
            <div class="form_div_style">
              <el-form
                :model="questionForm"
                label-width="15px"
                class="demo-ruleForm"
              >
                <el-form-item prop="elseDescription">
                  <div>
                    问题十一 : 您的其他情况描述?
                  </div>
                  <el-input
                    type="textarea"
                    placeholder="请输入内容"
                    v-model="questionForm.elseDescription"
                    show-word-limit
                    :rows="6"
                  >
                  </el-input>
                </el-form-item>
              </el-form>
              <div class="button-container">
                <el-button
                  class="custom-button"
                  @click="submit"
                >提 交</el-button>
                <el-button
                  class="custom-button"
                  @click="resetForm"
                >重 置</el-button>
              </div>
            </div>
          </div>
        </div>
      </article>
    </div>
  </div>
</template>

<script>
import Hammer from "hammerjs";
import { uploadPovertyArchives } from "@/api/user";

export default {
  name: "Questionnaire",
  data() {
    return {
      user: JSON.parse(localStorage.getItem("xm-user") || "{}"),
      currentPage: 1,
      questionForm: {
        // userId :'',
        age: "",
        skill: "",
        education: "",
        work: "",
        life: "",
        price: "",
        house: "",
        harm: "",
        area: "",
        disable: "",
        elseDescription: "",
        status: "未审核",
      },
    };
  },
  mounted() {
    this.initHammer();
  },
  methods: {
    initHammer() {
      // 使用 Vue 的 $refs 而不是 jQuery 选择器
      const hammertime = new Hammer(this.$refs.book);
      hammertime.on("swipe", (event) => {
        switch (event.direction) {
          case Hammer.DIRECTION_LEFT:
            this.nextPage();
            break;
          case Hammer.DIRECTION_RIGHT:
            this.prevPage();
            break;
          // 可以添加更多方向的处理...
          default:
          // 处理其他情况或不做任何操作
        }
      });
    },
    nextPage() {
      // 更新 currentPage 并处理页面切换逻辑
      if (this.currentPage < 3) {
        this.currentPage++;
      }
    },
    submit() {
      // questionForm.userId = this.user.id;
      if (this.submitForm()) {
        uploadPovertyArchives(this.questionForm)
          .then((res) => {
            if (res.code === "200") {
              // 表示成功保存
              this.resetForm("questionForm");
              this.$message.success("保存成功");
            }
          })
          .catch((err) => {
            this.$message(err.msg);
          });
      }
    },
    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
      }
    },
    resetForm() {
      for (let key in this.questionForm) {
        if (this.questionForm.hasOwnProperty(key)) {
          // 确保属性是对象自身的，而不是继承的
          this.questionForm[key] = ""; // 将值设置为null
        }
      }
      this.$message.success("表单已重置");
      this.currentPage = 1;
      // console.log(this.questionForm)
    },
    submitForm() {
      let flag = 0;
      let i = 0;
      for (let key in this.questionForm) {
        i++;
        if (this.questionForm.hasOwnProperty(key)) {
          // 确保属性是对象自身的，而不是继承的
          if (this.questionForm[key] === "") {
            flag = 1;
            break;
          }
        }
      }
      if (flag) {
        this.$message.error("有未选择的问题，提交失败");
        this.currentPage = Math.ceil(i / 4);
        return false;
      }
      return true;
    },
  },
};
</script>

<style scoped>
/*html {*/
/*  height: 100%;*/
/*  overflow: hidden;*/
/*}*/
/*body {*/
/*  background: black;*/
/*  margin: 0;*/
/*  width: 100%;*/
/*  height: 100%;*/
/*}*/

h1 {
  text-align: center;
}

.scene {
  width: 40%;
  height: 500px;
  margin: 3% 5% 0 50%;
  perspective: 1000px;
}

.book {
  position: relative;
  width: 100%;
  height: 100%;

  transform-style: preserve-3d;
}

.page {
  cursor: pointer;
  position: absolute;
  color: black;
  width: 100%;
  height: 100%;

  transition: 1.5s transform;
  transform: translateZ(-1px);
  transform-style: preserve-3d;
  transform-origin: left center;
}

.front,
.back {
  position: absolute;

  width: 100%;
  height: 100%;
  padding: 10% 5% 5%;
  box-sizing: border-box;

  backface-visibility: hidden;
  background: -webkit-gradient(
    linear,
    0% 0%,
    100% 100%,
    from(#e3e3e3),
    to(#ffffff)
  );
  background: linear-gradient(to bottom right, #e0e0e0, #ffffff);
}

.back {
  transform: rotateY(180deg);
}

.page.active {
  z-index: 1;
  transform: translateZ(0);
}

.page.flipped {
  transform: translateZ(0) rotateY(-180deg);
}

.page.flipped:last-of-type {
  z-index: 1;
}

p {
  margin: 0 0 0.1em;
  text-indent: 1em;
}

.qr {
  margin: 50px auto;
  max-width: 50%;
}

.qr img {
  display: block;
}

/* iPads (portrait) ----------- */
@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) and (orientation: portrait) {
  .scene {
    width: 90%;
    height: 90%;
    margin: 5%;
    /* 其他针对此媒体查询的样式 */
  }
}

.main_container {
  /* 设置 div 的宽度和高度 */
  height: 670px;
  /*background: url("../../assets/imgs/front_image/background_questionnaire.jpg");*/
  background-image: url("../../assets/imgs/front_image/background_questionnaire.jpg"); /* 注意这里的路径可能是项目特定的 */
  /* 设置背景图片的位置，比如居中 */
  background-position: center bottom;
  padding: 2% 2% 3% 2%;
  border-radius: 2%;
}
.radio-vertical .el-radio {
  display: block;
  margin-top: 15px; /* 根据需要调整间距 */
  margin-left: 20px;
}
.title {
  text-align: center;
  font-size: 25px;
  font-family: "黑体";
  margin-top: -30px;
}
.form_div_style {
  position: relative;
  width: 90%;
  height: 90%;
  /*background-color: #409EFF;*/
  margin: 4%;
}
.page_color {
  color: #5a5a59;
}
.button-container {
  display: flex;
  justify-content: space-between;
  position: absolute;
  bottom: 0;
  width: 100%; /* 确保容器宽度与父容器相同 */
  box-sizing: border-box; /* 包括 padding 和 border 在内计算宽度 */
  padding: 0 20px; /* 可选，用于内部间距 */
}
.custom-button {
  background-color: #ff6347; /* 自定义背景颜色 */
  border-color: #ff6347; /* 自定义边框颜色 */
  color: #fff; /* 自定义文本颜色 */
  width: 200px;
  /* 其他你想要的样式 */
}
</style>
