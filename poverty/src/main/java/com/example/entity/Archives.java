package com.example.entity;

import java.io.Serializable;

/**
 * 管理员
*/
public class Archives extends Account implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Integer id;

    /** 用户id */
    private Integer userId;

    /** 年龄 */
    private String age;

    /** 收入 */

    private String price;

    /** 家庭住址 */
    private String address;

    /** 负债 */

    private String debt;

    /** 教育程度 */

    private String education;

    /** 手艺技术 */

    private String skill;

    /** 服务产业 */

    private String work;

    /** 生活状态 */

    private String life;

    /** 住房 */

    private String house;

    /** 受灾情况 */

    private String harm;

    /** 土地面积 */

    private String area;

    /** 残疾情况 */

    private String disable;

    /** 其他描述 */
    private String elseDescription;

    /** 状态 */

    private String status;

    private String userName;


    public String getHouse() {
        return house;
    }

    public void setHouse(String house) {
        this.house = house;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }


    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDebt() {
        return debt;
    }

    public void setDebt(String debt) {
        this.debt = debt;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public String getWork() {
        return work;
    }

    public void setWork(String work) {
        this.work = work;
    }

    public String getLife() {
        return life;
    }

    public void setLife(String life) {
        this.life = life;
    }

    public String getHose() {
        return house;
    }

    public void setHose(String hose) {
        this.house = hose;
    }

    public String getHarm() {
        return harm;
    }

    public void setHarm(String harm) {
        this.harm = harm;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDisable() {
        return disable;
    }

    public void setDisable(String disable) {
        this.disable = disable;
    }

    public String getElseDescription() {
        return elseDescription;
    }

    public void setElseDescription(String elseDescription) {
        this.elseDescription = elseDescription;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
