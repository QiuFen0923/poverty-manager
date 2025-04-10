<template>
  <div class="box_main">
    <div class="header">
      <h1>精准扶贫信息系统</h1>
      <div class="showTime"></div>
    </div>
    <div class="mainbox">
      <div class="colum">
        <div class="panel bar">
          <h2>柱形图-贫困人口人数</h2>
          <div class="chart">
          </div>
          <div class="panel-footer"></div>
        </div>
        <div class="panel line">
          <h2>新增贫困-脱贫人群
            <a href="javascript:;">2022 </a>
            <a href="javascript:;"> 2023</a>
          </h2>
          <div class="chart">
          </div>
          <div class="panel-footer"></div>
        </div>
        <div class="panel pie">
          <h2>待脱贫人群年龄分布</h2>
          <div class="chart">
          </div>
          <div class="panel-footer"></div>
        </div>
      </div>
      <div class="colum">
        <div class="no">
          <div class="no-hd">
            <ul>
              <li>{{ poorCount }}</li>
              <li>{{ unPoorCount }}</li>
            </ul>
          </div>
          <div class="no-bd">
            <ul>
              <li>已脱贫人数</li>
              <li>待脱贫人数</li>
            </ul>
          </div>
        </div>
        <!-- 地图模块 -->
        <div class="map">
          <div class="map1"></div>
          <div class="map2"></div>
          <div class="map3"></div>
          <div
            class="chart"
            style="width: 100%;height: 10.125rem;"
          ></div>
        </div>
      </div>

      <div class="colum">
        <div class="panel bar2">
          <h2>贫困人口民族分布图</h2>
          <div class="chart">
          </div>
          <div class="panel-footer"></div>
        </div>

        <div class="panel line2">
          <h2>脱贫人数折线图</h2>
          <div class="chart">
          </div>
          <div class="panel-footer"></div>
        </div>

        <div class="panel pie2">
          <h2>贫困人群省份分布图</h2>
          <div class="chart">

          </div>
          <div class="panel-footer"></div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import $ from "jquery";
import "../../assets/js/china";
export default {
  name: "MyHome",
  data() {
    return {
      provinceData: [], // 添加省份数据数组
      ethnicNames: [],
      ethnicValues: [],
      poorCount: 0, // 添加脱贫人数变量
      unPoorCount: 0, // 添加待脱贫人数变量
    };
  },
  mounted() {
    // 先获取数据，数据获取成功后再初始化图表
    this.getProvinceData();
    this.getAgeData();
    this.getEthnicData();
    this.getPoorCount();
    this.initBarLeft();
    this.initBarRight();
    this.initLineLeft();
    this.initLineRight();
    this.initPieLeft();
    this.initMap();
    this.showTime();
  },
  methods: {
    getPoorCount() {
      this.$request.get("/home/count").then((res) => {
        if (res.code == 200) {
          // 因为后端返回的是数组，我们取第一个元素
          const countData = res.data[0];
          this.poorCount = countData.poorCount; // 脱贫人数
          this.unPoorCount = countData.unPoorCount; // 待脱贫人数
        }
      });
    },
    getProvinceData() {
      this.$request.get("/home/province").then((res) => {
        console.log("API返回的原始数据:", res);
        if (res.code == 200) {
          this.provinceData = res.data;
          console.log("处理前的省份数据:", this.provinceData);
          // 在数据获取成功后初始化饼图
          this.initPieRight();
        }
      });
    },
    getAgeData() {
      this.$request.get("/home/age").then((res) => {
        console.log("API返回的年龄数据:", res);
        if (res.code == 200) {
          const ageData = res.data.map((item) => ({
            value: item.count,
            name: item.age_group,
          }));
          console.log("处理后的年龄数据:", ageData);
          // 更新饼图
          this.initPieLeft(ageData);
        }
      });
    },

    //柱状图1
    initBarLeft() {
      var myChart = this.$echarts.init(document.querySelector(".bar .chart"));
      var option = {
        color: ["#2f89cf"],
        tooltip: {
          trigger: "axis",
          axisPointer: {
            type: "shadow",
          },
        },
        grid: {
          left: "0%",
          top: "10px",
          right: "0%",
          bottom: "4%",
          containLabel: true,
        },
        xAxis: [
          {
            axisLabel: {
              color: ["rgba(255,255,255,0.6)"],
              fontSize: 12,
            },
            type: "category",
            data: ["2018", "2019", "2020", "2021", "2022", "2023", "2024"],
            axisTick: {
              alignWithLabel: true,
            },
            axisLine: {
              show: false,
            },
          },
        ],
        yAxis: [
          {
            type: "value",
            color: "rgba(255,255,255,0.6)",
            axisLabel: {
              color: ["rgba(255,255,255,0.6)"],
              fontSize: 12,
            },
            axisLine: {
              lineStyle: {
                color: "rgba(255,255,255,0.1)",
                width: 1,
              },
            },
            splitLine: {
              lineStyle: {
                color: "rgba(255,255,255,0.1)",
              },
            },
          },
        ],
        series: [
          {
            name: "Direct",
            type: "bar",
            barWidth: "35%",
            data: [200, 150, 130, 90, 25, 21, 2],
            itemStyle: {
              barBorderRadius: 4,
            },
          },
        ],
      };
      myChart.setOption(option);
      //图表适配窗口大小
      window.addEventListener("resize", function () {
        myChart.resize();
      });
    },

    getEthnicData() {
      this.$request.get("/home/ethnic").then((res) => {
        if (res.code == 200) {
          this.processEthnicData(res.data);
          this.initBarRight(); // 数据获取后重新渲染图表
        }
      });
    },
    processEthnicData(rawData) {
      this.ethnicNames = rawData.map((item) => item.ethnic);
      this.ethnicValues = rawData.map((item) => item.count);
    },

    //柱状图2
    initBarRight() {
      var myColor = ["#1089E7", "#F57474", "#56D0E3", "#F8B448", "#8B78F6"];
      var myChart = this.$echarts.init(document.querySelector(".bar2 .chart"));

      // 创建一个包含名称和值的对象数组，以便排序
      const sortedData = this.ethnicNames.map((name, index) => ({
        name: name,
        value: this.ethnicValues[index],
      }));

      // 按值从大到小排序
      sortedData.sort((a, b) => b.value - a.value);

      // 分离排序后的名称和值
      const sortedNames = sortedData.map((item) => item.name);
      const sortedValues = sortedData.map((item) => item.value);

      var option = {
        grid: {
          left: "25%",
          top: "10%",
          bottom: "10%",
          right: "15%",
          containLabel: false,
        },
        xAxis: {
          type: "value",
          boundaryGap: [0, 0.01],
          show: false,
        },
        yAxis: [
          {
            type: "category",
            data: sortedNames,
            axisLine: { show: false },
            axisTick: { show: false },
            axisLabel: {
              color: "#fff",
              margin: 10,
              fontSize: 14,
            },
            inverse: true,
          },
          {
            type: "category",
            data: sortedValues,
            axisLine: { show: false },
            axisTick: { show: false },
            axisLabel: {
              color: "#fff",
              margin: 10,
              fontSize: 14,
            },
            inverse: true,
          },
        ],
        series: [
          {
            name: "in",
            type: "bar",
            data: sortedValues.map((v) =>
              ((v / sortedValues.reduce((a, b) => a + b, 0)) * 100).toFixed(0)
            ),
            itemStyle: {
              barBorderRadius: 20,
              color: function (params) {
                return myColor[params.dataIndex % myColor.length];
              },
            },
            barCategoryGap: 50,
            barWidth: 15,
            label: {
              show: true,
              position: [100, 0],
              formatter: "{c}%",
              fontSize: 14,
              color: "#fff",
              offset: [0, 0],
              distance: 15,
            },
            yAxisIndex: 0,
          },
          {
            name: "out",
            type: "bar",
            barCategoryGap: 50,
            barWidth: 15,
            data: sortedValues.map(() => 100),
            itemStyle: {
              barBorderRadius: 15,
              color: "none",
              borderColor: "#00c1de",
              borderWidth: 3,
            },
            yAxisIndex: 1,
          },
        ],
      };
      myChart.setOption(option);
      window.addEventListener("resize", function () {
        myChart.resize();
      });
    },
    // //折线图
    initLineLeft() {
      var myChart = this.$echarts.init(document.querySelector(".line .chart"));
      var yearData = [
        {
          year: "2020", // 年份
          data: [
            // 两个数组是因为有两条线
            [24, 40, 101, 134, 90, 230, 210, 230, 120, 230, 210, 120],
            [40, 64, 191, 324, 290, 330, 310, 213, 180, 200, 180, 79],
          ],
        },
        {
          year: "  2021", // 年份
          data: [
            // 两个数组是因为有两条线
            [123, 175, 112, 197, 121, 67, 98, 21, 43, 64, 76, 38],
            [143, 131, 165, 123, 178, 21, 82, 64, 43, 60, 19, 34],
          ],
        },
      ];
      var option = {
        color: ["#00f2f1", "#ed3f35"],
        tooltip: {
          trigger: "axis",
        },

        legend: {
          data: ["新增人数", "新增人数2"],
          textStyle: {
            color: "#4c9bfd",
          },
          right: "10%",
        },
        grid: {
          left: "3%",
          top: "20%",
          right: "4%",
          bottom: "3%",
          containLabel: true,
          show: true,
          borderColor: "#012f4a",
        },

        xAxis: {
          type: "category",
          boundaryGap: false,
          data: [
            "1月",
            "2月",
            "3月",
            "4月",
            "5月",
            "6月",
            "7月",
            "8月",
            "9月",
            "10月",
            "11月",
            "12月",
          ],
          axisTick: {
            show: false,
          },
          axisLabel: {
            color: "#4c9bfd",
          },
          axisLine: {
            show: false,
          },
        },
        yAxis: {
          type: "value",
          axisTick: {
            show: false,
          },
          axisLabel: {
            color: "#4c9bfd",
          },
          axisLine: {
            show: false,
          },
          splitLine: {
            lineStyle: {
              color: "#012f4a",
            },
          },
        },
        series: [
          {
            smooth: true,
            name: "新增人数",
            type: "line",
            data: yearData[0].data[0],
          },
          {
            smooth: true,
            name: "新增人数2",
            type: "line",
            data: yearData[0].data[1],
          },
        ],
      };
      myChart.setOption(option);
      window.addEventListener("resize", function () {
        myChart.resize();
      });
      // 点击切换效果
      $(".line h2").on("click", "a", function () {
        var obj = yearData[$(this).index()];
        option.series[0].data = obj.data[0];
        option.series[1].data = obj.data[1];
        myChart.setOption(option);
      });
    },
    //折线图2
    initLineRight() {
      var myChart = this.$echarts.init(document.querySelector(".line2 .chart"));
      var option = {
        tooltip: {
          trigger: "axis",
        },
        legend: {
          top: "0%",
          data: [
            "待脱贫人数",
            "已脱贫人数",
            "Video Ads",
            "Direct",
            "Search Engine",
          ],
          textStyle: {
            color: "rgba(255,255,255,0.5)",
            fontSize: 12,
          },
        },

        grid: {
          left: "10px",
          right: "10px",
          bottom: "10px",
          top: "30px",
          containLabel: true,
        },
        xAxis: [
          {
            type: "category",
            boundaryGap: false,
            data: [
              "01",
              "02",
              "03",
              "04",
              "05",
              "06",
              "07",
              "08",
              "09",
              "10",
              "11",
              "12",
              "13",
              "14",
              "15",
              "16",
              "17",
              "18",
              "19",
              "20",
              "21",
              "22",
              "23",
              "24",
              "25",
              "26",
              "26",
              "28",
              "29",
              "30",
            ],
            axisLabel: {
              textStyle: {
                color: "rgba(255,255,255,0.6)",
                fontSize: 12,
              },
            },
            axisLine: {
              lineStyle: {
                color: "rgba(255,255,255,.2)",
              },
            },
          },
        ],
        yAxis: [
          {
            axisTick: { show: false },
            type: "value",
            axisLine: {
              lineStyle: {
                color: "rgba(255,255,255,.1)",
              },
            },
            axisLabel: {
              textStyle: {
                color: "rgba(255,255,255,.6)",
                fontSize: 12,
              },
            },
            // 修改分割线的颜色
            splitLine: {
              lineStyle: {
                color: "rgba(255,255,255,.1)",
              },
            },
          },
        ],
        series: [
          {
            smooth: true,
            name: "待脱贫人数",
            type: "line",
            areaStyle: {
              color: new this.$echarts.graphic.LinearGradient(
                0,
                0,
                0,
                1,
                [
                  {
                    offset: 0,
                    color: "rgba(1, 132, 213, 0.4)", // 渐变色的起始颜色
                  },
                  {
                    offset: 0.8,
                    color: "rgba(1, 132, 213, 0.1)", // 渐变线的结束颜色
                  },
                ],
                false
              ),
              shadowColor: "rgba(0, 0, 0, 0.1)",
            },

            symbol: "circle",
            symbolSize: 8,
            showSymbol: false,
            itemStyle: {
              color: "#0184d5",
              borderColor: "rgba(221, 220, 107, .1)",
              borderWidth: 12,
            },
            emphasis: {
              focus: "series",
            },
            data: [
              30, 40, 30, 40, 30, 40, 30, 60, 20, 40, 30, 40, 30, 40, 30, 40,
              30, 60, 20, 40, 30, 40, 30, 40, 30, 40, 20, 60, 50, 40,
            ],
            lineStyle: {
              color: "#0184d5",
              width: 2,
            },
          },

          {
            smooth: true,
            name: "已脱贫人数",
            type: "line",
            emphasis: {
              focus: "series",
            },
            data: [
              130, 10, 20, 40, 30, 40, 80, 60, 20, 40, 90, 40, 20, 140, 30, 40,
              130, 20, 20, 40, 80, 70, 30, 40, 30, 120, 20, 99, 50, 20,
            ],
            showSymbol: false,
            symbol: "circle",
            // 拐点大小
            symbolSize: 5,
            // 设置拐点颜色以及边框
            itemStyle: {
              color: "#00d887",
              borderColor: "rgba(221, 220, 107, .1)",
              borderWidth: 12,
            },
            lineStyle: {
              normal: {
                color: "#00d887",
                width: 2,
              },
            },
            areaStyle: {
              normal: {
                color: new this.$echarts.graphic.LinearGradient(
                  0,
                  0,
                  0,
                  1,
                  [
                    {
                      offset: 0,
                      color: "rgba(0, 216, 135, 0.4)",
                    },
                    {
                      offset: 0.8,
                      color: "rgba(0, 216, 135, 0.1)",
                    },
                  ],
                  false
                ),
                shadowColor: "rgba(0, 0, 0, 0.1)",
              },
            },
          },
        ],
      };
      myChart.setOption(option);
      window.addEventListener("resize", function () {
        myChart.resize();
      });
    },
    //饼形图2
    initPieRight() {
      // 添加数据检查
      if (!this.provinceData || this.provinceData.length === 0) {
        console.log("没有省份数据");
        return;
      }

      var myChart = this.$echarts.init(document.querySelector(".pie2 .chart"));
      var option = {
        color: [
          "#006cff",
          "#60cda0",
          "#ed8884",
          "#ff9f7f",
          "#0096ff",
          "#9fe6b8",
          "#32c5e9",
          "#1d9dff",
          "#ffd700",
          "#ff6b6b",
          "#4ecdc4",
          "#45b7d1",
          "#96c93d",
          "#ffa07a",
          "#9370db",
          "#20b2aa",
        ],
        tooltip: {
          trigger: "item",
          formatter: "{a} <br/>{b} : {c} ({d}%)",
        },
        legend: {
          bottom: "0%",
          itemWidth: 8,
          itemHeight: 8,
          textStyle: {
            color: "rgba(255,255,255,0.5)",
            fontSize: 9,
          },
        },
        series: [
          {
            name: "省份分布",
            type: "pie",
            radius: [10, 70],
            center: ["50%", "46%"],
            roseType: "radius",
            itemStyle: {
              borderRadius: 5,
            },
            data: this.provinceData.map((item) => ({
              value: item.count,
              name: item.province,
            })),
            label: {
              fontSize: 10,
              color: "#fff", // 添加标签颜色
            },
            labelLine: {
              length: 2,
              length2: 4,
              lineStyle: {
                color: "#fff", // 添加引导线颜色
              },
            },
          },
        ],
      };

      console.log("饼图配置:", option); // 添加配置日志
      myChart.setOption(option);

      // 添加图表渲染完成的回调
      myChart.on("rendered", function () {
        console.log("图表渲染完成");
      });

      window.addEventListener("resize", function () {
        myChart.resize();
      });
    },
    //饼形图--待脱贫人群年龄分布
    initPieLeft(ageData) {
      var myChart = this.$echarts.init(document.querySelector(".pie .chart"));
      var option = {
        color: [
          "#00f2f1", // 青色
          "#ed3f35", // 红色
          "#4c9bfd", // 蓝色
          "#ff9f7f", // 橙色
          "#ffd700", // 金色
          "#9370db", // 紫色
          "#20b2aa", // 青绿色
          "#ff6b6b", // 粉红色
          "#4ecdc4", // 浅青色
          "#45b7d1", // 天蓝色
        ],
        tooltip: {
          trigger: "item",
          formatter: "{a} <br/>{b}: {c}人 ({d}%)",
          backgroundColor: "rgba(0,0,0,0.7)",
          borderColor: "#00f2f1",
          borderWidth: 1,
          textStyle: {
            color: "#fff",
          },
        },
        legend: {
          bottom: "0%",
          itemWidth: 8,
          itemHeight: 8,
          textStyle: {
            color: "rgba(255,255,255,0.5)",
            fontSize: 10,
          },
        },
        series: [
          {
            center: ["50%", "40%"],
            name: "年龄分布",
            type: "pie",
            radius: ["40%", "60%"],
            avoidLabelOverlap: false,
            label: {
              show: true,
              position: "outside",
              formatter: "{b}: {c}人",
              color: "#fff",
              fontSize: 12,
              fontWeight: "bold",
            },
            labelLine: {
              show: true,
              length: 8,
              length2: 10,
              lineStyle: {
                color: "#fff",
              },
            },
            itemStyle: {
              borderRadius: 4,
              borderColor: "#fff",
              borderWidth: 2,
            },
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: "rgba(0, 0, 0, 0.5)",
              },
            },
            data: ageData,
          },
        ],
      };
      myChart.setOption(option);
      window.addEventListener("resize", function () {
        myChart.resize();
      });
    },

    initMap() {
      var myChart = this.$echarts.init(document.querySelector(".map .chart"));
      var geoCoordMap = {
        上海: [121.4648, 31.2891],
        东莞: [113.8953, 22.901],
        东营: [118.7073, 37.5513],
        中山: [113.4229, 22.478],
        临汾: [111.4783, 36.1615],
        临沂: [118.3118, 35.2936],
        丹东: [124.541, 40.4242],
        丽水: [119.5642, 28.1854],
        乌鲁木齐: [87.9236, 43.5883],
        佛山: [112.8955, 23.1097],
        保定: [115.0488, 39.0948],
        兰州: [103.5901, 36.3043],
        包头: [110.3467, 41.4899],
        北京: [116.4551, 40.2539],
        北海: [109.314, 21.6211],
        南京: [118.8062, 31.9208],
        南宁: [108.479, 23.1152],
        南昌: [116.0046, 28.6633],
        南通: [121.1023, 32.1625],
        厦门: [118.1689, 24.6478],
        台州: [121.1353, 28.6688],
        合肥: [117.29, 32.0581],
        呼和浩特: [111.4124, 40.4901],
        咸阳: [108.4131, 34.8706],
        哈尔滨: [127.9688, 45.368],
        唐山: [118.4766, 39.6826],
        嘉兴: [120.9155, 30.6354],
        大同: [113.7854, 39.8035],
        大连: [122.2229, 39.4409],
        天津: [117.4219, 39.4189],
        太原: [112.3352, 37.9413],
        威海: [121.9482, 37.1393],
        宁波: [121.5967, 29.6466],
        宝鸡: [107.1826, 34.3433],
        宿迁: [118.5535, 33.7775],
        常州: [119.4543, 31.5582],
        广州: [113.5107, 23.2196],
        廊坊: [116.521, 39.0509],
        延安: [109.1052, 36.4252],
        张家口: [115.1477, 40.8527],
        徐州: [117.5208, 34.3268],
        德州: [116.6858, 37.2107],
        惠州: [114.6204, 23.1647],
        成都: [103.9526, 30.7617],
        扬州: [119.4653, 32.8162],
        承德: [117.5757, 41.4075],
        拉萨: [91.1865, 30.1465],
        无锡: [120.3442, 31.5527],
        日照: [119.2786, 35.5023],
        昆明: [102.9199, 25.4663],
        杭州: [119.5313, 29.8773],
        枣庄: [117.323, 34.8926],
        柳州: [109.3799, 24.9774],
        株洲: [113.5327, 27.0319],
        武汉: [114.3896, 30.6628],
        汕头: [117.1692, 23.3405],
        江门: [112.6318, 22.1484],
        沈阳: [123.1238, 42.1216],
        沧州: [116.8286, 38.2104],
        河源: [114.917, 23.9722],
        泉州: [118.3228, 25.1147],
        泰安: [117.0264, 36.0516],
        泰州: [120.0586, 32.5525],
        济南: [117.1582, 36.8701],
        济宁: [116.8286, 35.3375],
        海口: [110.3893, 19.8516],
        淄博: [118.0371, 36.6064],
        淮安: [118.927, 33.4039],
        深圳: [114.5435, 22.5439],
        清远: [112.9175, 24.3292],
        温州: [120.498, 27.8119],
        渭南: [109.7864, 35.0299],
        湖州: [119.8608, 30.7782],
        湘潭: [112.5439, 27.7075],
        滨州: [117.8174, 37.4963],
        潍坊: [119.0918, 36.524],
        烟台: [120.7397, 37.5128],
        玉溪: [101.9312, 23.8898],
        珠海: [113.7305, 22.1155],
        盐城: [120.2234, 33.5577],
        盘锦: [121.9482, 41.0449],
        石家庄: [114.4995, 38.1006],
        福州: [119.4543, 25.9222],
        秦皇岛: [119.2126, 40.0232],
        绍兴: [120.564, 29.7565],
        聊城: [115.9167, 36.4032],
        肇庆: [112.1265, 23.5822],
        舟山: [122.2559, 30.2234],
        苏州: [120.6519, 31.3989],
        莱芜: [117.6526, 36.2714],
        菏泽: [115.6201, 35.2057],
        营口: [122.4316, 40.4297],
        葫芦岛: [120.1575, 40.578],
        衡水: [115.8838, 37.7161],
        衢州: [118.6853, 28.8666],
        西宁: [101.4038, 36.8207],
        西安: [109.1162, 34.2004],
        贵阳: [106.6992, 26.7682],
        连云港: [119.1248, 34.552],
        邢台: [114.8071, 37.2821],
        邯郸: [114.4775, 36.535],
        郑州: [113.4668, 34.6234],
        鄂尔多斯: [108.9734, 39.2487],
        重庆: [107.7539, 30.1904],
        金华: [120.0037, 29.1028],
        铜川: [109.0393, 35.1947],
        银川: [106.3586, 38.1775],
        镇江: [119.4763, 31.9702],
        长春: [125.8154, 44.2584],
        长沙: [113.0823, 28.2568],
        长治: [112.8625, 36.4746],
        阳泉: [113.4778, 38.0951],
        青岛: [120.4651, 36.3373],
        韶关: [113.7964, 24.7028],
      };

      var GZData = [
        [{ name: "广州" }, { name: "北京", value: 100 }],
        [{ name: "广州" }, { name: "上海", value: 100 }],
        [{ name: "广州" }, { name: "长春", value: 100 }],
        [{ name: "广州" }, { name: "西宁", value: 100 }],
        [{ name: "广州" }, { name: "银川", value: 100 }],
        [{ name: "广州" }, { name: "东莞", value: 100 }],
        [{ name: "广州" }, { name: "东营", value: 100 }],
        [{ name: "广州" }, { name: "长沙", value: 100 }],
        [{ name: "广州" }, { name: "重庆", value: 100 }],
        [{ name: "广州" }, { name: "鄂尔多斯", value: 100 }],
        [{ name: "广州" }, { name: "金华", value: 100 }],
        [{ name: "广州" }, { name: "铜川", value: 100 }],
        [{ name: "广州" }, { name: "镇江", value: 100 }],
        [{ name: "广州" }, { name: "长春", value: 100 }],
        [{ name: "广州" }, { name: "青岛", value: 100 }],
        [{ name: "广州" }, { name: "邯郸", value: 100 }],
        [{ name: "广州" }, { name: "菏泽", value: 100 }],
        [{ name: "广州" }, { name: "乌鲁木齐", value: 100 }],
      ];

      var XNData = [
        [{ name: "西宁" }, { name: "北京", value: 100 }],
        [{ name: "西宁" }, { name: "上海", value: 100 }],
        [{ name: "西宁" }, { name: "广州", value: 100 }],
        [{ name: "西宁" }, { name: "西安", value: 100 }],
        [{ name: "西宁" }, { name: "银川", value: 100 }],
      ];

      var YCData = [
        [{ name: "银川" }, { name: "北京", value: 100 }],
        [{ name: "银川" }, { name: "广州", value: 100 }],
        [{ name: "银川" }, { name: "上海", value: 100 }],
        [{ name: "银川" }, { name: "西安", value: 100 }],
        [{ name: "银川" }, { name: "西宁", value: 100 }],
      ];

      var planePath =
        "path://M1705.06,1318.313v-89.254l-319.9-221.799l0.073-208.063c0.521-84.662-26.629-121.796-63.961-121.491c-37.332-0.305-64.482,36.829-63.961,121.491l0.073,208.063l-319.9,221.799v89.254l330.343-157.288l12.238,241.308l-134.449,92.931l0.531,42.034l175.125-42.917l175.125,42.917l0.531-42.034l-134.449-92.931l12.238-241.308L1705.06,1318.313z";
      //var planePath = 'arrow';
      var convertData = function (data) {
        var res = [];
        for (var i = 0; i < data.length; i++) {
          var dataItem = data[i];

          var fromCoord = geoCoordMap[dataItem[0].name];
          var toCoord = geoCoordMap[dataItem[1].name];
          if (fromCoord && toCoord) {
            res.push({
              fromName: dataItem[0].name,
              toName: dataItem[1].name,
              coords: [fromCoord, toCoord],
              value: dataItem[1].value,
            });
          }
        }
        return res;
      };
      var color = ["#a6c84c", "#ffa022", "#46bee9"]; //航线的颜色
      var series = [];
      [
        ["广州", GZData],
        ["西宁", XNData],
        ["银川", YCData],
      ].forEach(function (item, i) {
        series.push(
          {
            name: item[0] + " Top3",
            type: "lines",
            zlevel: 1,
            effect: {
              show: true,
              period: 6,
              trailLength: 0.7,
              color: color[i],
              symbolSize: 3,
            },
            lineStyle: {
              normal: {
                color: color[i],
                width: 0,
                curveness: 0.2,
              },
            },
            data: convertData(item[1]),
          },
          {
            name: item[0] + " Top3",
            type: "lines",
            zlevel: 2,
            symbol: ["none", "arrow"],
            symbolSize: 10,
            effect: {
              show: true,
              period: 6,
              trailLength: 0,
              symbol: planePath,
              symbolSize: 15,
            },
            lineStyle: {
              normal: {
                color: color[i],
                width: 1,
                opacity: 0.6,
                curveness: 0.2,
              },
            },
            data: convertData(item[1]),
          },
          {
            name: item[0] + " Top3",
            type: "effectScatter",
            coordinateSystem: "geo",
            zlevel: 2,
            rippleEffect: {
              brushType: "stroke",
            },
            label: {
              normal: {
                show: true,
                position: "right",
                formatter: "{b}",
              },
            },
            symbolSize: function (val) {
              return val[2] / 8;
            },
            itemStyle: {
              normal: {
                color: color[i],
              },
              emphasis: {
                areaColor: "#2B91B7",
              },
            },
            data: item[1].map(function (dataItem) {
              return {
                name: dataItem[1].name,
                value: geoCoordMap[dataItem[1].name].concat([
                  dataItem[1].value,
                ]),
              };
            }),
          }
        );
      });
      var option = {
        tooltip: {
          trigger: "item",
          formatter: function (params, ticket, callback) {
            if (params.seriesType == "effectScatter") {
              return "线路：" + params.data.name + "" + params.data.value[2];
            } else if (params.seriesType == "lines") {
              return (
                params.data.fromName +
                ">" +
                params.data.toName +
                "<br />" +
                params.data.value
              );
            } else {
              return params.name;
            }
          },
        },
        legend: {
          orient: "vertical",
          top: "bottom",
          left: "right",
          data: ["广州 Top3", "西宁 Top3", "银川 Top3"],
          textStyle: {
            color: "#fff",
          },
          selectedMode: "multiple",
        },
        geo: {
          map: "china",
          label: {
            emphasis: {
              show: true,
              color: "#fff",
            },
          },
          zoom: 1.1,
          roam: true,
          itemStyle: {
            normal: {
              areaColor: "rgba(20,41,87,0.7)",
              borderColor: "#195BB9",
              borderWidth: 1,
            },
            emphasis: {
              areaColor: "#2B91B7",
            },
          },
        },
        series: series,
      };
      myChart.setOption(option);
      window.addEventListener("resize", function () {
        myChart.resize();
      });
    },

    showTime() {
      var t = null;
      function time() {
        clearTimeout(t);
        var dt = new Date();
        var y = dt.getFullYear();
        var mt = dt.getMonth() + 1;
        var day = dt.getDate();
        var h = dt.getHours();
        var m = dt.getMinutes();
        var s = dt.getSeconds();
        document.querySelector(".showTime").innerHTML =
          "当前时间：" +
          y +
          "年" +
          mt +
          "月" +
          day +
          "日" +
          "-" +
          h +
          "时" +
          m +
          "分" +
          s +
          "秒";
        t = setTimeout(time, 1000);
      }
    },
  },
};
</script>
<style>
@import "@/assets/css/index.css";

html {
  font-size: 50px;
}

.box_main {
  background: url(../../assets/imgs/myhomebg.jpg) no-repeat top center;
}

.panel.pie2 {
  position: relative;
  height: 300px; /* 确保有足够的高度 */
  margin-bottom: 20px;
}

.panel.pie2 .chart {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  min-height: 200px;
}
</style>
