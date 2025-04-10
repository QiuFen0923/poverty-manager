/*
 Navicat Premium Data Transfer

 Source Server         : Design
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : poverty

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 10/04/2025 09:27:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键id ',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员（领导）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'hzj', '123', 'http://localhost:9090/files/1742960720806-8.jpg', 'ADMIN', '小班', '', '2974327782@qq.com');
INSERT INTO `admin` VALUES (2, 'hjb', '123', 'http://localhost:9090/files/1742805102071-1.jpg', 'ADMIN', '秋分分分分', '', '2974327782@qq.com');

-- ----------------------------
-- Table structure for archives
-- ----------------------------
DROP TABLE IF EXISTS `archives`;
CREATE TABLE `archives`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年龄',
  `price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收入',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `debt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负债',
  `education` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '教育程度',
  `skill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手艺技术',
  `work` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务产业',
  `life` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生活状态',
  `house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住房',
  `harm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '受灾情况',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '土地面积',
  `disable` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '残疾情况',
  `else_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其他描述',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `archives_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '档案' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of archives
-- ----------------------------
INSERT INTO `archives` VALUES (1, 1, '2', '3', '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '已通过');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `notice_id` int NULL DEFAULT NULL COMMENT '公告id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论时间',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `notice_id`(`notice_id` ASC) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (13, 12, 28, '123123', '2025-03-26', '非遗正骨走进乡村，助力健康扶贫');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `deal_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回复内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '反馈时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '反馈信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (3, 2, '<p>打不死u金卡卡九十年代</p>', '正在改进', '2024-06-29', '正在处理');
INSERT INTO `feedback` VALUES (4, 3, '<p>大司农看来决赛你的就看见</p>', '好的', '2024-06-29', '正在处理');
INSERT INTO `feedback` VALUES (11, 12, '<p>12312313</p>', '123123', '2025-03-25', '已处理');
INSERT INTO `feedback` VALUES (12, 12, '<p>tesy</p>', '222', '2025-03-25', '未处理');
INSERT INTO `feedback` VALUES (13, 12, '<p>12321312312</p>', '1222', '2025-03-25', '已处理');

-- ----------------------------
-- Table structure for financial
-- ----------------------------
DROP TABLE IF EXISTS `financial`;
CREATE TABLE `financial`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `budget` decimal(12, 2) NULL DEFAULT NULL COMMENT '预算金额',
  `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '使用情况',
  `project` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '项目详情',
  `target` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '扶贫对象',
  `time` datetime NULL DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of financial
-- ----------------------------
INSERT INTO `financial` VALUES (1, '12312', 123123.00, '未使用', '123123', '123123', NULL, '小班');
INSERT INTO `financial` VALUES (2, '323', 213.00, '未使用', '2313', '12312', '2025-03-26 16:07:04', '小班');
INSERT INTO `financial` VALUES (3, '213', 213.00, '未使用', '123', '1231', '2025-03-26 16:14:37', '小班');
INSERT INTO `financial` VALUES (4, 'test', 1.00, '已用完', '1', '1', '2025-03-26 16:15:51', '小班');
INSERT INTO `financial` VALUES (5, '12312', 213.00, '已使用', '123', '123', '2025-03-26 16:27:20', '小班');
INSERT INTO `financial` VALUES (6, '12321', 3123.00, '未使用', '31213', '123123', '2025-03-26 16:27:35', '小班');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `applyname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sfz` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poorstate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poorway` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `homemember` int NULL DEFAULT NULL,
  `ethnic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poorclass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poorreason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `time` date NULL DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `currentstate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待公示',
  `suggestion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (15, '2', '111111111111111111', '脱贫', '2', 2, '维吾尔族', '2', '2', '2025-03-31', '秋分分分分', '天津市', 2, '已完成', NULL);
INSERT INTO `message` VALUES (16, '1', '111111111111111111', '待扶贫', '1', 1111, '维吾尔族', '1111', '11', '2025-04-10', '小班', '天津市', 1, '异议待处理', '111');
INSERT INTO `message` VALUES (17, '11', '111111111111111111', '待扶贫', '1', 1, '维吾尔族', '1', '1', '2025-03-31', '小班', '内蒙古自治区', 1, '拒绝申请', NULL);
INSERT INTO `message` VALUES (22, '111', '111111111111111111', '待扶贫', '32', 32, '苗族', '323', '323', '2025-04-10', '小班', '内蒙古自治区', 22, '待公示', NULL);
INSERT INTO `message` VALUES (23, '12', '111111111111111111', '待扶贫', '32', 23, '维吾尔族', '32', '323', '2025-04-10', '小班', '天津市', 32, '已公示', NULL);

-- ----------------------------
-- Table structure for need
-- ----------------------------
DROP TABLE IF EXISTS `need`;
CREATE TABLE `need`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '需求内容',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理状态',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提出时间',
  `opinion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '领导建议',
  `evaluate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评价',
  `deal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基层处理',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `need_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '需求管理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of need
-- ----------------------------
INSERT INTO `need` VALUES (1, 1, '二号8的问澳跨境', '已处理', '2024-6-28', '马上处理，会第一时间回复', '4星', '');
INSERT INTO `need` VALUES (2, 1, '来杯苦咖啡', NULL, '2024-07-01 16:23:50', NULL, NULL, NULL);
INSERT INTO `need` VALUES (3, 1, '再来杯苦咖啡', NULL, '2024-07-01', NULL, NULL, NULL);
INSERT INTO `need` VALUES (4, 1, '二号8的问澳跨境', NULL, '2024-07-01', NULL, '未评价', NULL);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (2, '【“飞阅”中国】江西安福：让文物活起来 助力乡村振兴', '<p style=\"\">在江西省吉安市旅游发展大会期间，安福县大智石刻景区成为不少游客的打卡地。近年来，景区所在地大智村擦亮“大智石刻”这一文化品牌，以石为题、以村作景，打造出集现代农业观光、休闲度假、农事活动体验、石碑石刻研学为一体的精品农旅区，获评江西省4A级乡村旅游点。（王晓震 实习生董子南 邓萌奕）<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005922770-image.png\"/><br/><img src=\"http://101.35.218.50:9091/files/1702005938036-image.png\"/><br/><img src=\"http://101.35.218.50:9091/files/1702005952072-image.png\"/><br/><img src=\"http://101.35.218.50:9091/files/1702005961602-image.png\"/><br/><img src=\"http://101.35.218.50:9091/files/1702005973343-image.png\"/></p>', 'admin', '2024-06-27', '资讯');
INSERT INTO `notice` VALUES (3, '传承井冈山精神 带领村民过上好日子', '<p>坑坑洼洼的土路，摇摇欲坠的土坯房，破塑料纸封起来的窗户……2015年，赴任井冈山东上乡曲江村第一书记的扶贫干部叶维祝，第一次走进贫困户村民许明招家里时就下定决心：千难万难，一定要想办法带领乡亲们走出一条致富路。</p><p>经过一系列调研，叶维祝将脱贫产业定位在了白莲上。种白莲？村民们没有试过，应者寥寥，叶维祝决定自己先种100亩白莲做示范。从选购莲苗、施放有机肥、挑选包装，他都要一一把关。夏日雨季，莲苗在风中摇晃，叶维祝担心莲苗被吹断，戴上斗笠就冲进雨中，在泥泞的莲塘里一棵一棵地扶起倒下的莲苗。</p><p>第一年，试种的100亩白莲卖了20多万元，叶维祝赢得了村民的信任，越来越多的村民开始尝试白莲种植。在叶维祝的带领下，村里先后发展了农机合作社、苗木种植、荷塘养虾及养蜂4个富民项目，产业经济从无到有、从小到大，脱贫帮扶实现了从“输血”到“造血”的转变。</p><p>叶维祝说：“身为一名党员干部，要以传承井冈山精神为己任，实事求是闯新路、艰苦奋斗攻难关，带领老区人民把日子越过越红火。”</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (4, '陕西旬邑：凝心聚力谋发展  乡村振兴气象新', '<p>中国网讯 （记者 宽宁）脱贫摘帽不是终点，而是新生活、新奋斗的起点。面对乡村振兴工作的新形势、新变化，陕西省旬邑县以“守底线、抓衔接、促振兴”为主基调，组织搭建“1+8+4”（1个领导小组、8个工作小组、4项机制）工作架构，立足资源禀赋和基础优势，打好产业“组合拳”、用实防返贫保险、提升人居环境，持续推动巩固拓展脱贫攻坚成果同乡村振兴有效衔接，乡村振兴的崭新画卷正在旬邑徐徐铺开。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005779842-image.png\"/><br/></p><p><strong>打好产业“组合拳”，走出融合发展新路子</strong></p><p>“这里好美，静静地走在干净的街巷间，细细品读一幅幅充满年代感的墙画，仿佛整个人都受到了洗礼。”从西安慕名而来的刘先生抚摸着太村镇张家村的墙画，感慨万千。</p><p>毗邻高速路口，交通便利的张家村，如何改变村民产业单一、靠天吃饭的现状，持续巩固脱贫攻坚成果？这是时代给张家村干部群众的考题。</p><p>今年，张家村积极整合各类资金，启动了以粮油基地、生态油坊、玉顺成品牌运营中心为依托的三产融合项目。同时，充分挖掘村情村史、乡风民俗等乡土文化元素，利用楹联、挂件、铁艺等载体，勾画出“锦绣兴隆堡、幸福张家村”等文化符号；以时间为轴线，以不同年代的农村经典生活场景为断面，配以主题鲜明的文案，描绘了从上世纪六七十年代到乡村振兴时期农村发展变迁的历史画卷，吸引更多人来这里寻找寄托乡愁的净土。</p><p>下好“产业”棋，打好“组合拳”。近年来，旬邑县为促进乡村旅游和农业观光产业迅速发展，不断完善景区功能，持续扩展农旅产品种类，大力提升服务水平，用心做活农旅融合发展；引导群众发展特色农业，全方位、多角度展示和宣传“红色马栏、绿色旬邑”旅游品牌，不断提升旬邑旅游知名度和影响力；积极发展农业+旅游、互联网+农业、文化+旅游等新业态、新模式，突出“红色+绿色”底色，精心打造开心农场、智慧果园、采摘园、医药观光区等新型农业发展模式，大力宣传推介秋葵、紫苏油等特色产品，逐步形成“以点带面、补链成群”的三产融合发展新格局，全面助推乡村振兴战略实施。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005818776-image.png\"/></p><p><strong>提升人居环境，绘就美丽乡村新画卷</strong></p><p>从村民房屋搬迁，到路旁错落有致的绿化，再到家门口的公共服务设施建设提升……近些年，土桥镇井坳村以满足村民美好居住生活需求为目标，编制《井坳村总体建设规划》，新建“三纵七横”主干街道10条，完成整村搬迁237户，配套实施水、电、路、网等基础设施和公共服务设施建设，乡村面貌和人居环境水平显著提升。</p><p>据介绍，井坳村始终把改善人居环境作为推进美丽乡村建设的重点任务，累计整合资金150万元，投工投劳800余人（次），清理“三堆”、乱搭乱建230余处，铺设花砖1500平方米，绿化2100平方米，粉刷外墙4600平方米，绘制墙体画600平方米，安装路灯80盏，创建示范街3条，擦亮了“生态福地、和美井坳”靓丽名片。“没想到居住环境会变得这么漂亮，跟做梦一样，太高兴了！”众多村民的幸福之情溢于言表。</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (5, '数说宝“藏”·70年巨变丨西藏农牧业跨越式发展结出“金色”果实', '<p>新华社拉萨7月21日电（记者张兆基、李键）西藏农林牧渔业总产值从1965年的2.64亿元增长到2020年的233.5亿元；青稞产量、牦牛出栏头数比“十二五”末分别增长12.2%、25.2%，连续6年粮食产量稳定在100万吨以上。</p><p>截至2020年，西藏建成225万亩高标准农田，实施167万亩农机深松整地作业，新增14个国家级畜禽标准化养殖场，农牧综合服务中心覆盖所有乡镇。农牧业产业化龙头企业162家，主要农作物综合机械化率65%。农畜产品加工业总产值57亿元，比“十二五”末翻了一番。</p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005611090-image.png\"/><br/></p><p>家住西藏山南市乃东区亚堆乡曲德沃村的次仁央宗老人站在田地旁，静静地望着绿意盎然的青稞田。87岁高龄的她亲眼见证了几十年来西藏农牧业的巨变。</p><p>对于次仁央宗老人来说，旧西藏的记忆充满了苦楚：“生为人，过得却像牛马一样，填饱肚子就是奢望。父亲一天到晚给当地农奴主劳作，换不来一顿饱饭。”</p><p>家住西藏山南市乃东区亚堆乡曲德沃村的次仁央宗老人。左：次仁央宗老人的肖像。右上：次仁央宗老人在晒牧草。右中：次仁央宗老人的身份证。右下：次仁央宗和子女的合影。 新华社记者 晋美多吉6月3日摄</p><p>在旧西藏的黑暗年代，占人口不足5%的三大领主及其代理人几乎占有西藏全部耕地、牧场、森林、山川、河流、河滩以及大部分牲畜。占人口95%的农奴没有生产资料和人身自由，遭受着沉重的赋税、乌拉差役和高利贷盘剥，挣扎在死亡线上。</p><p>1959年西藏民主改革，次仁央宗获得了人身自由，分到了农田、牲畜，与广大历经苦难的群众一道迈入了西藏发展的新纪元。西藏农牧业从此迎来了发展的春天，各族群众也创造了西藏农牧业发展史上一个又一个奇迹。</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (6, '春风送暖！浙江摁下聚力扶贫 “快进键”', '<p><strong>浙江在线3月24日讯</strong>&nbsp;春分刚过农事忙，万绿吐翠乡村新。3月24日，全省“同心同行、聚力扶贫”主题活动在遂昌县木柘镇柘溪下村举行。省农业农村厅党组书记王通林出席活动并讲话。他强调，各地要推进思想再统一、任务再明确、合力再汇聚，以更加昂扬的斗志、更加饱满的热情、更加旺盛的干劲，同心同行、众志成城，全力打赢低收入农户增收攻坚战，确保我省农村同步高水平全面建成小康社会。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1701958978515-image.png\"/></p><p><strong>“云上”精准扶贫 各界热献爱心</strong></p><p>　　活动现场，相关方面开展了以送保险强保障、送农资稳生产、送医疗保健康、送宽带助学习、送岗位促就业、送宣传打品牌、送渠道活销售为主要内容的“送服务”活动，为当地低收入农户生产生活汇聚温暖之光。</p><p>　　网上农博平台“26县扶贫产品馆”和“丰收购”平台“26县扶贫产品专区”，也在现场正式上线启动。“疫情期间，网上农博发挥了很好的作用，此次推出扶贫产品馆，不仅是为了促进26县的产品品牌宣传，更是想通过多方数据汇总，对当地产业发展提出优化建议。”“网上农博”运行商、杭州安厨电商董事长王晓桢边说边给记者演示。只见她点开扶贫产品馆界面，在26县中选择遂昌，页面上便迅速弹出了遂昌长粽、土鸡蛋等农产品。</p><p>　　产品馆和专区的建设，是我省推进 “互联网+”云上精准扶贫的一项创举。为了促进26县的农产品销售，省扶贫办积极对接省电子商务促进会，把电子商务作为打开方式、快捷方式，把电商扶贫作为精准扶贫的有效抓手。省电子商务促进会会长卢成南现场倡议，积极创建网上扶贫专区，为26县打开网络销售渠道，把当地农产品变滞销为直销，更好助力农业增效、农民增收。</p><p>　　在活动现场，浙江在线上线了“扶贫助农”专栏，免费为26县提供乡村旅游、农产品宣传推介。微医集团在为全省低收入农户提供线上医疗支持的基础上，给遂昌县捐赠一套人工智能复诊诊疗系统，配套建设10个村卫生室。遂昌县移动公司为当地低收入农户子女捐赠宽带500条、手机流量30万G，保障低收入农户子女疫情期间“停课不停学”。</p><p><strong>扶贫“礼包”连连 暖心政策助农</strong></p><p>　　“今春没法出去打工，还好茶产业协会介绍我到茶园采茶，每天可赚140元左右。”遂昌县大柘镇柘溪上村低收入农户周某告诉记者，她丈夫是残疾人，家中没有收入来源。她来到“剑光农业”从事采茶工作，今年可以增加不少收入。</p><p>　　遂昌有茶园12万多亩，当前正是茶叶采摘旺季。“今天，我们再次向全县采茶工组织和茶叶企业倡议，优先聘用低收入农户劳力，为他们提供更多就业岗位。”遂昌县茶产业协会会长包振杰在现场发出倡议。据介绍，该协会已发动茶企优先招用低收入农户劳力800多人。</p><p>　　除了送岗位促进低收入农户就业，活动现场还积极帮助解决农户遇到的贷款难、农资储备不足、相关技术指导缺少等难题。疫情发生以来，太平洋产险浙江分公司为全省5万多驻村扶贫干部和80多万低收入农户，分别赠送新冠肺炎专项保险。该公司还特地筹措了1万个口罩，在活动现场赠送给低收入农户。</p><p>　　参加活动的省农信联社，现场安排了100亿元的信贷资金支持春耕备耕，安排20亿元支持低收入农户发展，还为遂昌县低收入农户授信3亿元。</p><p>　　省供销社现场为遂昌县重点帮扶村和低收入农户赠送化肥等农资50吨。“这次疫情期间，我们建立了‘1+11+N’农产品产销一体化机制，覆盖了11个设区市、52个县，已帮助农民销售蔬菜1.9万吨。”省供销社副主任张建表示，将继续全力为全省春耕备耕提供强有力的农资保障和生产服务。</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (7, '让穷山沟变聚宝盆，“茭白书记” 扎根大山 34 年', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (8, '助农政策：支持农业发展，提高农民收入', '<p>助农政策是指政府为了支持农业发展，提高农民收入，采取的一系列政策和措施。这些政策包括财政、税收、金融、保险、科技、教育、文化、卫生等各个方面，旨在帮助农民增加收入，改善生活条件，提高农业生产效率，促进农村经济发展。</p><p>以下是一些常见的助农政策：</p><ol><li>财政支持：政府通过财政手段，对农业进行直接补贴、专项资金支持等，以增加农民收入和促进农业发展。</li><li>税收优惠：政府对从事农业生产和相关活动的企业和个人给予税收优惠，以降低其经营成本，提高其盈利能力。</li><li>金融支持：政府通过建立农业银行、农村信用社等金融机构，为农民提供贷款、担保等金融服务，以支持农业生产和农村经济发展。</li><li>保险保障：政府通过建立农业保险制度，为农民提供风险保障，以降低自然灾害等对农业生产的影响。</li><li>科技支持：政府通过推广先进的农业技术、设备和工艺，提高农业生产效率和质量，以增加农民收入和促进农业现代化。</li><li>教育培训：政府通过开展农民教育培训，提高农民的文化素质和技能水平，以促进农村劳动力的转移和增加农民收入。</li><li>文化传承：政府通过开展农村文化活动，传承和弘扬农村优秀传统文化，以丰富农民的精神文化生活和促进农村文化发展。</li><li>卫生健康：政府通过加强农村卫生体系建设，提高农民的健康水平和生活质量，以促进农村社会的和谐稳定和发展。</li></ol><p>总之，助农政策是政府为了支持农业和农村发展而采取的一系列政策和措施，旨在提高农民收入和生活水平，促进农业和农村的可持续发展。</p>', 'admin', '2024-06-28', '政策');
INSERT INTO `notice` VALUES (9, '你好', '<p>第一天</p>', 'admin', '2024-06-28', '公告');
INSERT INTO `notice` VALUES (10, 'yes', '<p>是的</p>', 'admin', '2024-06-28', '公告');
INSERT INTO `notice` VALUES (11, '你好', '<p>12恶魔挖空了</p>', 'admin', '2024-06-28', '政策');
INSERT INTO `notice` VALUES (12, '传承井冈山精神 带领村民过上好日子', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-07-05', '资讯');
INSERT INTO `notice` VALUES (13, '数说宝“藏”·70年巨变丨西藏农牧业跨越式发展结出“金色”果实', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (14, '让穷山沟变聚宝盆，“茭白书记” 扎根大山 34 年', '<p>新华社拉萨7月21日电（记者张兆基、李键）西藏农林牧渔业总产值从1965年的2.64亿元增长到2020年的233.5亿元；青稞产量、牦牛出栏头数比“十二五”末分别增长12.2%、25.2%，连续6年粮食产量稳定在100万吨以上。</p><p>截至2020年，西藏建成225万亩高标准农田，实施167万亩农机深松整地作业，新增14个国家级畜禽标准化养殖场，农牧综合服务中心覆盖所有乡镇。农牧业产业化龙头企业162家，主要农作物综合机械化率65%。农畜产品加工业总产值57亿元，比“十二五”末翻了一番。</p><p><img src=\"http://101.35.218.50:9091/files/1702005611090-image.png\"/><br/></p><p>家住西藏山南市乃东区亚堆乡曲德沃村的次仁央宗老人站在田地旁，静静地望着绿意盎然的青稞田。87岁高龄的她亲眼见证了几十年来西藏农牧业的巨变。</p><p>对于次仁央宗老人来说，旧西藏的记忆充满了苦楚：“生为人，过得却像牛马一样，填饱肚子就是奢望。父亲一天到晚给当地农奴主劳作，换不来一顿饱饭。”</p><p>家住西藏山南市乃东区亚堆乡曲德沃村的次仁央宗老人。左：次仁央宗老人的肖像。右上：次仁央宗老人在晒牧草。右中：次仁央宗老人的身份证。右下：次仁央宗和子女的合影。 新华社记者 晋美多吉6月3日摄</p><p>在旧西藏的黑暗年代，占人口不足5%的三大领主及其代理人几乎占有西藏全部耕地、牧场、森林、山川、河流、河滩以及大部分牲畜。占人口95%的农奴没有生产资料和人身自由，遭受着沉重的赋税、乌拉差役和高利贷盘剥，挣扎在死亡线上。</p><p>1959年西藏民主改革，次仁央宗获得了人身自由，分到了农田、牲畜，与广大历经苦难的群众一道迈入了西藏发展的新纪元。西藏农牧业从此迎来了发展的春天，各族群众也创造了西藏农牧业发展史上一个又一个奇迹。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (15, '助农政策：支持农业发展，提高农民收入', '<p>坑坑洼洼的土路，摇摇欲坠的土坯房，破塑料纸封起来的窗户……2015年，赴任井冈山东上乡曲江村第一书记的扶贫干部叶维祝，第一次走进贫困户村民许明招家里时就下定决心：千难万难，一定要想办法带领乡亲们走出一条致富路。</p><p>经过一系列调研，叶维祝将脱贫产业定位在了白莲上。种白莲？村民们没有试过，应者寥寥，叶维祝决定自己先种100亩白莲做示范。从选购莲苗、施放有机肥、挑选包装，他都要一一把关。夏日雨季，莲苗在风中摇晃，叶维祝担心莲苗被吹断，戴上斗笠就冲进雨中，在泥泞的莲塘里一棵一棵地扶起倒下的莲苗。</p><p>第一年，试种的100亩白莲卖了20多万元，叶维祝赢得了村民的信任，越来越多的村民开始尝试白莲种植。在叶维祝的带领下，村里先后发展了农机合作社、苗木种植、荷塘养虾及养蜂4个富民项目，产业经济从无到有、从小到大，脱贫帮扶实现了从“输血”到“造血”的转变。</p><p>叶维祝说：“身为一名党员干部，要以传承井冈山精神为己任，实事求是闯新路、艰苦奋斗攻难关，带领老区人民把日子越过越红火。”</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (16, '传承井冈山精神 带领村民过上好日子', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (17, '数说宝“藏”·70年巨变丨西藏农牧业跨越式发展结出“金色”果实', '<p><strong>浙江在线3月24日讯</strong>&nbsp;春分刚过农事忙，万绿吐翠乡村新。3月24日，全省“同心同行、聚力扶贫”主题活动在遂昌县木柘镇柘溪下村举行。省农业农村厅党组书记王通林出席活动并讲话。他强调，各地要推进思想再统一、任务再明确、合力再汇聚，以更加昂扬的斗志、更加饱满的热情、更加旺盛的干劲，同心同行、众志成城，全力打赢低收入农户增收攻坚战，确保我省农村同步高水平全面建成小康社会。<br/></p><p><img src=\"http://101.35.218.50:9091/files/1701958978515-image.png\"/></p><p><strong>“云上”精准扶贫 各界热献爱心</strong></p><p>　　活动现场，相关方面开展了以送保险强保障、送农资稳生产、送医疗保健康、送宽带助学习、送岗位促就业、送宣传打品牌、送渠道活销售为主要内容的“送服务”活动，为当地低收入农户生产生活汇聚温暖之光。</p><p>　　网上农博平台“26县扶贫产品馆”和“丰收购”平台“26县扶贫产品专区”，也在现场正式上线启动。“疫情期间，网上农博发挥了很好的作用，此次推出扶贫产品馆，不仅是为了促进26县的产品品牌宣传，更是想通过多方数据汇总，对当地产业发展提出优化建议。”“网上农博”运行商、杭州安厨电商董事长王晓桢边说边给记者演示。只见她点开扶贫产品馆界面，在26县中选择遂昌，页面上便迅速弹出了遂昌长粽、土鸡蛋等农产品。</p><p>　　产品馆和专区的建设，是我省推进 “互联网+”云上精准扶贫的一项创举。为了促进26县的农产品销售，省扶贫办积极对接省电子商务促进会，把电子商务作为打开方式、快捷方式，把电商扶贫作为精准扶贫的有效抓手。省电子商务促进会会长卢成南现场倡议，积极创建网上扶贫专区，为26县打开网络销售渠道，把当地农产品变滞销为直销，更好助力农业增效、农民增收。</p><p>　　在活动现场，浙江在线上线了“扶贫助农”专栏，免费为26县提供乡村旅游、农产品宣传推介。微医集团在为全省低收入农户提供线上医疗支持的基础上，给遂昌县捐赠一套人工智能复诊诊疗系统，配套建设10个村卫生室。遂昌县移动公司为当地低收入农户子女捐赠宽带500条、手机流量30万G，保障低收入农户子女疫情期间“停课不停学”。</p><p><strong>扶贫“礼包”连连 暖心政策助农</strong></p><p>　　“今春没法出去打工，还好茶产业协会介绍我到茶园采茶，每天可赚140元左右。”遂昌县大柘镇柘溪上村低收入农户周某告诉记者，她丈夫是残疾人，家中没有收入来源。她来到“剑光农业”从事采茶工作，今年可以增加不少收入。</p><p>　　遂昌有茶园12万多亩，当前正是茶叶采摘旺季。“今天，我们再次向全县采茶工组织和茶叶企业倡议，优先聘用低收入农户劳力，为他们提供更多就业岗位。”遂昌县茶产业协会会长包振杰在现场发出倡议。据介绍，该协会已发动茶企优先招用低收入农户劳力800多人。</p><p>　　除了送岗位促进低收入农户就业，活动现场还积极帮助解决农户遇到的贷款难、农资储备不足、相关技术指导缺少等难题。疫情发生以来，太平洋产险浙江分公司为全省5万多驻村扶贫干部和80多万低收入农户，分别赠送新冠肺炎专项保险。该公司还特地筹措了1万个口罩，在活动现场赠送给低收入农户。</p><p>　　参加活动的省农信联社，现场安排了100亿元的信贷资金支持春耕备耕，安排20亿元支持低收入农户发展，还为遂昌县低收入农户授信3亿元。</p><p>　　省供销社现场为遂昌县重点帮扶村和低收入农户赠送化肥等农资50吨。“这次疫情期间，我们建立了‘1+11+N’农产品产销一体化机制，覆盖了11个设区市、52个县，已帮助农民销售蔬菜1.9万吨。”省供销社副主任张建表示，将继续全力为全省春耕备耕提供强有力的农资保障和生产服务。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (18, '传承井冈山精神 带领村民过上好日子', '<p>坑坑洼洼的土路，摇摇欲坠的土坯房，破塑料纸封起来的窗户……2015年，赴任井冈山东上乡曲江村第一书记的扶贫干部叶维祝，第一次走进贫困户村民许明招家里时就下定决心：千难万难，一定要想办法带领乡亲们走出一条致富路。</p><p>经过一系列调研，叶维祝将脱贫产业定位在了白莲上。种白莲？村民们没有试过，应者寥寥，叶维祝决定自己先种100亩白莲做示范。从选购莲苗、施放有机肥、挑选包装，他都要一一把关。夏日雨季，莲苗在风中摇晃，叶维祝担心莲苗被吹断，戴上斗笠就冲进雨中，在泥泞的莲塘里一棵一棵地扶起倒下的莲苗。</p><p>第一年，试种的100亩白莲卖了20多万元，叶维祝赢得了村民的信任，越来越多的村民开始尝试白莲种植。在叶维祝的带领下，村里先后发展了农机合作社、苗木种植、荷塘养虾及养蜂4个富民项目，产业经济从无到有、从小到大，脱贫帮扶实现了从“输血”到“造血”的转变。</p><p>叶维祝说：“身为一名党员干部，要以传承井冈山精神为己任，实事求是闯新路、艰苦奋斗攻难关，带领老区人民把日子越过越红火。”</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (19, '陕西旬邑：凝心聚力谋发展  乡村振兴气象新', '<p>中国网讯 （记者 宽宁）脱贫摘帽不是终点，而是新生活、新奋斗的起点。面对乡村振兴工作的新形势、新变化，陕西省旬邑县以“守底线、抓衔接、促振兴”为主基调，组织搭建“1+8+4”（1个领导小组、8个工作小组、4项机制）工作架构，立足资源禀赋和基础优势，打好产业“组合拳”、用实防返贫保险、提升人居环境，持续推动巩固拓展脱贫攻坚成果同乡村振兴有效衔接，乡村振兴的崭新画卷正在旬邑徐徐铺开。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005779842-image.png\"/><br/></p><p><strong>打好产业“组合拳”，走出融合发展新路子</strong></p><p>“这里好美，静静地走在干净的街巷间，细细品读一幅幅充满年代感的墙画，仿佛整个人都受到了洗礼。”从西安慕名而来的刘先生抚摸着太村镇张家村的墙画，感慨万千。</p><p>毗邻高速路口，交通便利的张家村，如何改变村民产业单一、靠天吃饭的现状，持续巩固脱贫攻坚成果？这是时代给张家村干部群众的考题。</p><p>今年，张家村积极整合各类资金，启动了以粮油基地、生态油坊、玉顺成品牌运营中心为依托的三产融合项目。同时，充分挖掘村情村史、乡风民俗等乡土文化元素，利用楹联、挂件、铁艺等载体，勾画出“锦绣兴隆堡、幸福张家村”等文化符号；以时间为轴线，以不同年代的农村经典生活场景为断面，配以主题鲜明的文案，描绘了从上世纪六七十年代到乡村振兴时期农村发展变迁的历史画卷，吸引更多人来这里寻找寄托乡愁的净土。</p><p>下好“产业”棋，打好“组合拳”。近年来，旬邑县为促进乡村旅游和农业观光产业迅速发展，不断完善景区功能，持续扩展农旅产品种类，大力提升服务水平，用心做活农旅融合发展；引导群众发展特色农业，全方位、多角度展示和宣传“红色马栏、绿色旬邑”旅游品牌，不断提升旬邑旅游知名度和影响力；积极发展农业+旅游、互联网+农业、文化+旅游等新业态、新模式，突出“红色+绿色”底色，精心打造开心农场、智慧果园、采摘园、医药观光区等新型农业发展模式，大力宣传推介秋葵、紫苏油等特色产品，逐步形成“以点带面、补链成群”的三产融合发展新格局，全面助推乡村振兴战略实施。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005818776-image.png\"/></p><p><strong>提升人居环境，绘就美丽乡村新画卷</strong></p><p>从村民房屋搬迁，到路旁错落有致的绿化，再到家门口的公共服务设施建设提升……近些年，土桥镇井坳村以满足村民美好居住生活需求为目标，编制《井坳村总体建设规划》，新建“三纵七横”主干街道10条，完成整村搬迁237户，配套实施水、电、路、网等基础设施和公共服务设施建设，乡村面貌和人居环境水平显著提升。</p><p>据介绍，井坳村始终把改善人居环境作为推进美丽乡村建设的重点任务，累计整合资金150万元，投工投劳800余人（次），清理“三堆”、乱搭乱建230余处，铺设花砖1500平方米，绿化2100平方米，粉刷外墙4600平方米，绘制墙体画600平方米，安装路灯80盏，创建示范街3条，擦亮了“生态福地、和美井坳”靓丽名片。“没想到居住环境会变得这么漂亮，跟做梦一样，太高兴了！”众多村民的幸福之情溢于言表。</p>', 'admin', '2024-07-03', '资讯');
INSERT INTO `notice` VALUES (20, '陕西旬邑：凝心聚力谋发展  乡村振兴气象新', '<p>中国网讯 （记者 宽宁）脱贫摘帽不是终点，而是新生活、新奋斗的起点。面对乡村振兴工作的新形势、新变化，陕西省旬邑县以“守底线、抓衔接、促振兴”为主基调，组织搭建“1+8+4”（1个领导小组、8个工作小组、4项机制）工作架构，立足资源禀赋和基础优势，打好产业“组合拳”、用实防返贫保险、提升人居环境，持续推动巩固拓展脱贫攻坚成果同乡村振兴有效衔接，乡村振兴的崭新画卷正在旬邑徐徐铺开。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005779842-image.png\"/><br/></p><p><strong>打好产业“组合拳”，走出融合发展新路子</strong></p><p>“这里好美，静静地走在干净的街巷间，细细品读一幅幅充满年代感的墙画，仿佛整个人都受到了洗礼。”从西安慕名而来的刘先生抚摸着太村镇张家村的墙画，感慨万千。</p><p>毗邻高速路口，交通便利的张家村，如何改变村民产业单一、靠天吃饭的现状，持续巩固脱贫攻坚成果？这是时代给张家村干部群众的考题。</p><p>今年，张家村积极整合各类资金，启动了以粮油基地、生态油坊、玉顺成品牌运营中心为依托的三产融合项目。同时，充分挖掘村情村史、乡风民俗等乡土文化元素，利用楹联、挂件、铁艺等载体，勾画出“锦绣兴隆堡、幸福张家村”等文化符号；以时间为轴线，以不同年代的农村经典生活场景为断面，配以主题鲜明的文案，描绘了从上世纪六七十年代到乡村振兴时期农村发展变迁的历史画卷，吸引更多人来这里寻找寄托乡愁的净土。</p><p>下好“产业”棋，打好“组合拳”。近年来，旬邑县为促进乡村旅游和农业观光产业迅速发展，不断完善景区功能，持续扩展农旅产品种类，大力提升服务水平，用心做活农旅融合发展；引导群众发展特色农业，全方位、多角度展示和宣传“红色马栏、绿色旬邑”旅游品牌，不断提升旬邑旅游知名度和影响力；积极发展农业+旅游、互联网+农业、文化+旅游等新业态、新模式，突出“红色+绿色”底色，精心打造开心农场、智慧果园、采摘园、医药观光区等新型农业发展模式，大力宣传推介秋葵、紫苏油等特色产品，逐步形成“以点带面、补链成群”的三产融合发展新格局，全面助推乡村振兴战略实施。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005818776-image.png\"/></p><p><strong>提升人居环境，绘就美丽乡村新画卷</strong></p><p>从村民房屋搬迁，到路旁错落有致的绿化，再到家门口的公共服务设施建设提升……近些年，土桥镇井坳村以满足村民美好居住生活需求为目标，编制《井坳村总体建设规划》，新建“三纵七横”主干街道10条，完成整村搬迁237户，配套实施水、电、路、网等基础设施和公共服务设施建设，乡村面貌和人居环境水平显著提升。</p><p>据介绍，井坳村始终把改善人居环境作为推进美丽乡村建设的重点任务，累计整合资金150万元，投工投劳800余人（次），清理“三堆”、乱搭乱建230余处，铺设花砖1500平方米，绿化2100平方米，粉刷外墙4600平方米，绘制墙体画600平方米，安装路灯80盏，创建示范街3条，擦亮了“生态福地、和美井坳”靓丽名片。“没想到居住环境会变得这么漂亮，跟做梦一样，太高兴了！”众多村民的幸福之情溢于言表。</p>', 'admin', '2024-07-03', '资讯');
INSERT INTO `notice` VALUES (21, '数说宝“藏”·70年巨变丨西藏农牧业跨越式发展结出“金色”果实', '<p>新华社拉萨7月21日电（记者张兆基、李键）西藏农林牧渔业总产值从1965年的2.64亿元增长到2020年的233.5亿元；青稞产量、牦牛出栏头数比“十二五”末分别增长12.2%、25.2%，连续6年粮食产量稳定在100万吨以上。</p><p>截至2020年，西藏建成225万亩高标准农田，实施167万亩农机深松整地作业，新增14个国家级畜禽标准化养殖场，农牧综合服务中心覆盖所有乡镇。农牧业产业化龙头企业162家，主要农作物综合机械化率65%。农畜产品加工业总产值57亿元，比“十二五”末翻了一番。</p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005611090-image.png\"/><br/></p><p>家住西藏山南市乃东区亚堆乡曲德沃村的次仁央宗老人站在田地旁，静静地望着绿意盎然的青稞田。87岁高龄的她亲眼见证了几十年来西藏农牧业的巨变。</p><p>对于次仁央宗老人来说，旧西藏的记忆充满了苦楚：“生为人，过得却像牛马一样，填饱肚子就是奢望。父亲一天到晚给当地农奴主劳作，换不来一顿饱饭。”</p><p>家住西藏山南市乃东区亚堆乡曲德沃村的次仁央宗老人。左：次仁央宗老人的肖像。右上：次仁央宗老人在晒牧草。右中：次仁央宗老人的身份证。右下：次仁央宗和子女的合影。 新华社记者 晋美多吉6月3日摄</p><p>在旧西藏的黑暗年代，占人口不足5%的三大领主及其代理人几乎占有西藏全部耕地、牧场、森林、山川、河流、河滩以及大部分牲畜。占人口95%的农奴没有生产资料和人身自由，遭受着沉重的赋税、乌拉差役和高利贷盘剥，挣扎在死亡线上。</p><p>1959年西藏民主改革，次仁央宗获得了人身自由，分到了农田、牲畜，与广大历经苦难的群众一道迈入了西藏发展的新纪元。西藏农牧业从此迎来了发展的春天，各族群众也创造了西藏农牧业发展史上一个又一个奇迹。</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (22, '传承井冈山精神 带领村民过上好日子', '<p>坑坑洼洼的土路，摇摇欲坠的土坯房，破塑料纸封起来的窗户……2015年，赴任井冈山东上乡曲江村第一书记的扶贫干部叶维祝，第一次走进贫困户村民许明招家里时就下定决心：千难万难，一定要想办法带领乡亲们走出一条致富路。</p><p>经过一系列调研，叶维祝将脱贫产业定位在了白莲上。种白莲？村民们没有试过，应者寥寥，叶维祝决定自己先种100亩白莲做示范。从选购莲苗、施放有机肥、挑选包装，他都要一一把关。夏日雨季，莲苗在风中摇晃，叶维祝担心莲苗被吹断，戴上斗笠就冲进雨中，在泥泞的莲塘里一棵一棵地扶起倒下的莲苗。</p><p>第一年，试种的100亩白莲卖了20多万元，叶维祝赢得了村民的信任，越来越多的村民开始尝试白莲种植。在叶维祝的带领下，村里先后发展了农机合作社、苗木种植、荷塘养虾及养蜂4个富民项目，产业经济从无到有、从小到大，脱贫帮扶实现了从“输血”到“造血”的转变。</p><p>叶维祝说：“身为一名党员干部，要以传承井冈山精神为己任，实事求是闯新路、艰苦奋斗攻难关，带领老区人民把日子越过越红火。”</p>', 'admin', '2024-06-28', '资讯');
INSERT INTO `notice` VALUES (23, '陕西旬邑：凝心聚力谋发展  乡村振兴气象新', '<p>中国网讯 （记者 宽宁）脱贫摘帽不是终点，而是新生活、新奋斗的起点。面对乡村振兴工作的新形势、新变化，陕西省旬邑县以“守底线、抓衔接、促振兴”为主基调，组织搭建“1+8+4”（1个领导小组、8个工作小组、4项机制）工作架构，立足资源禀赋和基础优势，打好产业“组合拳”、用实防返贫保险、提升人居环境，持续推动巩固拓展脱贫攻坚成果同乡村振兴有效衔接，乡村振兴的崭新画卷正在旬邑徐徐铺开。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005779842-image.png\"/><br/></p><p><strong>打好产业“组合拳”，走出融合发展新路子</strong></p><p>“这里好美，静静地走在干净的街巷间，细细品读一幅幅充满年代感的墙画，仿佛整个人都受到了洗礼。”从西安慕名而来的刘先生抚摸着太村镇张家村的墙画，感慨万千。</p><p>毗邻高速路口，交通便利的张家村，如何改变村民产业单一、靠天吃饭的现状，持续巩固脱贫攻坚成果？这是时代给张家村干部群众的考题。</p><p>今年，张家村积极整合各类资金，启动了以粮油基地、生态油坊、玉顺成品牌运营中心为依托的三产融合项目。同时，充分挖掘村情村史、乡风民俗等乡土文化元素，利用楹联、挂件、铁艺等载体，勾画出“锦绣兴隆堡、幸福张家村”等文化符号；以时间为轴线，以不同年代的农村经典生活场景为断面，配以主题鲜明的文案，描绘了从上世纪六七十年代到乡村振兴时期农村发展变迁的历史画卷，吸引更多人来这里寻找寄托乡愁的净土。</p><p>下好“产业”棋，打好“组合拳”。近年来，旬邑县为促进乡村旅游和农业观光产业迅速发展，不断完善景区功能，持续扩展农旅产品种类，大力提升服务水平，用心做活农旅融合发展；引导群众发展特色农业，全方位、多角度展示和宣传“红色马栏、绿色旬邑”旅游品牌，不断提升旬邑旅游知名度和影响力；积极发展农业+旅游、互联网+农业、文化+旅游等新业态、新模式，突出“红色+绿色”底色，精心打造开心农场、智慧果园、采摘园、医药观光区等新型农业发展模式，大力宣传推介秋葵、紫苏油等特色产品，逐步形成“以点带面、补链成群”的三产融合发展新格局，全面助推乡村振兴战略实施。<br/></p><p style=\"text-align:center;\"><img src=\"http://101.35.218.50:9091/files/1702005818776-image.png\"/></p><p><strong>提升人居环境，绘就美丽乡村新画卷</strong></p><p>从村民房屋搬迁，到路旁错落有致的绿化，再到家门口的公共服务设施建设提升……近些年，土桥镇井坳村以满足村民美好居住生活需求为目标，编制《井坳村总体建设规划》，新建“三纵七横”主干街道10条，完成整村搬迁237户，配套实施水、电、路、网等基础设施和公共服务设施建设，乡村面貌和人居环境水平显著提升。</p><p>据介绍，井坳村始终把改善人居环境作为推进美丽乡村建设的重点任务，累计整合资金150万元，投工投劳800余人（次），清理“三堆”、乱搭乱建230余处，铺设花砖1500平方米，绿化2100平方米，粉刷外墙4600平方米，绘制墙体画600平方米，安装路灯80盏，创建示范街3条，擦亮了“生态福地、和美井坳”靓丽名片。“没想到居住环境会变得这么漂亮，跟做梦一样，太高兴了！”众多村民的幸福之情溢于言表。</p>', 'admin', '2024-07-03', '资讯');
INSERT INTO `notice` VALUES (24, '传承井冈山精神 带领村民过上好日子', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (25, '数说宝“藏”·70年巨变丨西藏农牧业跨越式发展结出“金色”果实', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (26, '助农政策：支持农业发展，提高农民收入', '<p>坑坑洼洼的土路，摇摇欲坠的土坯房，破塑料纸封起来的窗户……2015年，赴任井冈山东上乡曲江村第一书记的扶贫干部叶维祝，第一次走进贫困户村民许明招家里时就下定决心：千难万难，一定要想办法带领乡亲们走出一条致富路。</p><p>经过一系列调研，叶维祝将脱贫产业定位在了白莲上。种白莲？村民们没有试过，应者寥寥，叶维祝决定自己先种100亩白莲做示范。从选购莲苗、施放有机肥、挑选包装，他都要一一把关。夏日雨季，莲苗在风中摇晃，叶维祝担心莲苗被吹断，戴上斗笠就冲进雨中，在泥泞的莲塘里一棵一棵地扶起倒下的莲苗。</p><p>第一年，试种的100亩白莲卖了20多万元，叶维祝赢得了村民的信任，越来越多的村民开始尝试白莲种植。在叶维祝的带领下，村里先后发展了农机合作社、苗木种植、荷塘养虾及养蜂4个富民项目，产业经济从无到有、从小到大，脱贫帮扶实现了从“输血”到“造血”的转变。</p><p>叶维祝说：“身为一名党员干部，要以传承井冈山精神为己任，实事求是闯新路、艰苦奋斗攻难关，带领老区人民把日子越过越红火。”</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (27, '传承井冈山精神 带领村民过上好日子', '<p><b>这是一条昂扬的曲线</b>：165元、219元……29876元，1978年以来，浙江农民收入不断走高，已经连续35年位列全国各省（区）第一；这是不断刷新的奇迹：全省贫困人口从1978年的1200万减至1999年的60万，再到全面消除绝对贫困现象……今年，我省将消除年家庭人均收入8000元以下情况。</p><p>10月12日，在景宁举办的国家扶贫日浙江主场活动上，浙江首次发布精准扶贫报告和十大案例。</p><p>浙江是全国率先完成脱贫攻坚任务的省份，也率先实现了从解决农村整体性贫困到绝对贫困、再到缓解相对贫困的迭代跃迁，成为全国人群贫困解决最好、区域发展差距最小、全面小康实现度最高的省份之一，走出了一条具有中国特色浙江特点的扶贫之路。</p><p><img src=\"http://101.35.218.50:9091/files/1701958901210-%E8%90%A8%E6%91%A9%E8%80%B6.jpeg\"/></p><p>浙江的扶贫体系怎样建立，又是怎样根据经济发展水平的不同阶段、不同区域、不同人群，与时俱进地不断调整？记者带你解码这份“浙江经验”。</p>', 'admin', '2024-07-05', '政策');
INSERT INTO `notice` VALUES (28, '非遗正骨走进乡村，助力健康扶贫', '<p>你是否也关注到乡村医疗资源的匮乏？近日，在福建省平和县南胜镇欧寮村，一场别开生面的义诊活动正在热烈开展。厦门市闽医传承医学研究院携手漳州市非物质文化遗产“曾氏自然门正骨推拿”团队，将优质健康服务精准送到村民家门口。这场活动不仅为村民带来了实实在在的健康福利，还在乡村热土上广泛传播了中医养生知识与非遗文化。</p><p>活动当天上午，晨曦微露，闽医传承团队便早早抵达欧寮村村部广场。队员们争分夺秒，迅速搭建起义诊场地。在志愿者们的协同配合下，前来问诊的村民被有序引导入座，现场氛围温馨且热烈。研究院的专家们以饱满的热情，接待每一位村民。面对村民们关心的常见病、慢性病等各类健康问题，专家们耐心倾听、细致解答，结合村民个体体质、生活习惯等差异，给出极具针对性的个性化健康建议。</p><p>活动期间，漳州市非物质文化遗产“曾氏自然门正骨推拿”团队成为现场焦点。团队成员凭借深厚的功底与精湛的技艺，为饱受颈椎病、腰椎病、关节疼痛等病痛折磨的村民施予传统中医正骨推拿治疗。手法刚柔并济，精准施力，许多村民在接受推拿后，当即舒展眉头，直呼疼痛明显缓解，身体轻松了许多。</p><p>欧寮村的林大爷激动不已，感慨道：‘我这腰疼了好些年，四处寻医效果都不佳，今天经过推拿，可算舒服多了，真心感谢你们！’</p><p>此次义诊活动成果斐然，不仅为村民带来实实在在的健康福利，有效提升村民健康意识，还在乡村热土上广泛传播了中医养生知识与非遗文化。闽医团队负责人表示，未来将持续深化合作，秉持初心，深入更多乡村基层，持续为群众提供优质、高效的健康服务，全力助推乡村振兴，为健康中国建设添砖加瓦。</p><p>通过这场活动，我们看到了传统医学在乡村大地绽放的绚丽光彩，也看到了非遗文化在健康扶贫中的独特魅力。让我们共同期待，未来有更多这样的活动走进乡村，为乡村健康事业注入澎湃动力！<br/></p>', 'zhu', '2025-03-25', '资讯');
INSERT INTO `notice` VALUES (29, 'warning', '<p>warning</p>', 'zhu', '2025-03-26', '公告');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓别',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否贫困',
  `out` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否脱贫',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'zhu', '123', '男', '小朱', '18771495230', '1517134205@qq.com', 'http://localhost:9090/files/1742872409036-1.jpg', 'USER', '贫困', '已脱贫');
INSERT INTO `user` VALUES (2, 'ji', '123', '男', '纪', '18771495212', '3211192117@qq.com', 'http://localhost:9090/files/1720185959386-smous.png', 'USER', '贫困', '已脱贫');
INSERT INTO `user` VALUES (3, 'zhang', '123', '女', '张一飞', '18371021091', 'HppkkyBmzlld@hotmail.com', 'http://localhost:9090/files/1720185986595-247402b1880511ebb6edd017c2d2eca2.jpg', 'USER', '贫困', '已脱贫');
INSERT INTO `user` VALUES (4, 'huan', '123', '未知', '张毛环', '18371021091', '3211192117@qq.com', 'http://localhost:9090/files/1720186010656-cb6a04e0c76f42828ab173cf0555a6a4.jpg', 'USER', '贫困', '已脱贫');
INSERT INTO `user` VALUES (12, '111', '111', NULL, '乌萨奇', NULL, NULL, 'http://localhost:9090/files/1742887446908-2.jpg', 'USER', NULL, NULL);

-- ----------------------------
-- Table structure for worker
-- ----------------------------
DROP TABLE IF EXISTS `worker`;
CREATE TABLE `worker`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工作角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作人员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of worker
-- ----------------------------
INSERT INTO `worker` VALUES (1, '小朱', 'zhu', '123', 'WORKER', 'http://localhost:9090/files/1719476112963-a202c44c2075478dbfac39baeb800046.png', '18771495230', '1517134205@qq.com', '领导');
INSERT INTO `worker` VALUES (2, '张毛环', 'zhang', '123', 'WORKER', NULL, '18771495230', '1517134205@qq.com', '基层工作者');
INSERT INTO `worker` VALUES (3, '张一飞', 'fei', '123', 'WORKER', NULL, '18371021091', 'HppkkyBmzlld@hotmail.com', '基层工作者');
INSERT INTO `worker` VALUES (4, '纪', 'ji', '123', 'WORKER', NULL, '18771495212', '3211192117@qq.com', '基层工作者');

SET FOREIGN_KEY_CHECKS = 1;
