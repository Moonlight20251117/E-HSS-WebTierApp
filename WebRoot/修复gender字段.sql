-- ============================================
-- 修复所有表中 gender 字段长度问题
-- 将所有表的 gender 字段统一改为 CHAR(2) 以支持"未知"等2个字符的值
-- ============================================

-- 1. 修改 user 表（用户表）
ALTER TABLE `user` MODIFY COLUMN `gender` CHAR(2) COMMENT '性别（男/女/未知）';

-- 2. 修改 patient 表（就诊人信息表）
ALTER TABLE `patient` MODIFY COLUMN `gender` CHAR(2) COMMENT '性别（男/女/未知）';

-- 3. 修改 doctor 表（医生表）
ALTER TABLE `doctor` MODIFY COLUMN `gender` CHAR(2) NOT NULL COMMENT '医生性别（男/女/未知）';

-- ============================================
-- 执行说明：
-- 1. 请在数据库中执行以上SQL语句
-- 2. 如果表不存在，会报错，可以忽略
-- 3. 执行完成后，注册功能中的"未知"选项将可以正常保存
-- ============================================
