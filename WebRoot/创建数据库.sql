-- 创建数据库
CREATE DATABASE IF NOT EXISTS smart_medical_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_medical_system;

-- 1. 角色表（区分用户类型：管理员、医生、护士、患者、企业、高校、财务）
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` VARCHAR(32) NOT NULL COMMENT '角色唯一标识（主键）',
  `role_name` VARCHAR(50) NOT NULL COMMENT '角色名称（管理员/医生/护士/患者/企业用户/高校用户/财务）',
  `role_desc` VARCHAR(200) DEFAULT '' COMMENT '角色描述',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态（1-启用/0-禁用）',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `uk_role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- 2. 用户表（基础用户信息，关联角色）
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` VARCHAR(32) NOT NULL COMMENT '用户唯一标识（主键）',
  `username` VARCHAR(50) NOT NULL COMMENT '登录用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码（加密存储）',
  `id_card` VARCHAR(18) NOT NULL COMMENT '身份证号',
  `real_name` VARCHAR(50) NOT NULL COMMENT '真实姓名',
  `gender` CHAR(2) COMMENT '性别（男/女/未知）',
  `phone` VARCHAR(20) NOT NULL COMMENT '手机号码',
  `role_id` VARCHAR(32) NOT NULL COMMENT '关联角色ID',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态（1-正常/0-禁用）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_id_card` (`id_card`),
  KEY `idx_role_id` (`role_id`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 3. 就诊人信息表（患者关联的就诊人，支持代预约）
CREATE TABLE IF NOT EXISTS `patient` (
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人唯一标识（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '所属用户ID（外键，关联user表）',
  `real_name` VARCHAR(50) NOT NULL COMMENT '就诊人姓名',
  `id_card` VARCHAR(18) NOT NULL COMMENT '就诊人身份证号',
  `gender` CHAR(2) COMMENT '性别（男/女/未知）',
  `phone` VARCHAR(20) NOT NULL COMMENT '就诊人电话',
  `relationship` VARCHAR(20) NOT NULL COMMENT '与用户的关系（本人/父母/子女/其他）',
  `medical_card` VARCHAR(50) COMMENT '医保卡号',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态（1-正常/0-禁用）',
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `uk_patient_id_card` (`id_card`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_patient_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='就诊人信息表';

-- 4. 企业信息表（合作论坛企业用户扩展信息）
CREATE TABLE IF NOT EXISTS `enterprise` (
  `enterprise_id` VARCHAR(32) NOT NULL COMMENT '企业唯一标识（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '关联用户ID（外键，关联user表）',
  `enterprise_name` VARCHAR(100) NOT NULL COMMENT '企业名称',
  `contact_person` VARCHAR(50) NOT NULL COMMENT '联系人',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
  `address` VARCHAR(255) COMMENT '企业地址',
  `business_scope` VARCHAR(500) COMMENT '经营范围',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '合作状态（1-正常/0-暂停）',
  PRIMARY KEY (`enterprise_id`),
  UNIQUE KEY `uk_enterprise_user` (`user_id`),
  CONSTRAINT `fk_enterprise_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业信息表';

-- 5. 高校信息表（合作论坛高校用户扩展信息）
CREATE TABLE IF NOT EXISTS `university` (
  `university_id` VARCHAR(32) NOT NULL COMMENT '高校唯一标识（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '关联用户ID（外键，关联user表）',
  `university_name` VARCHAR(100) NOT NULL COMMENT '高校名称',
  `contact_person` VARCHAR(50) NOT NULL COMMENT '联系人',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
  `address` VARCHAR(255) COMMENT '高校地址',
  `major_field` VARCHAR(500) COMMENT '重点专业领域',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '合作状态（1-正常/0-暂停）',
  PRIMARY KEY (`university_id`),
  UNIQUE KEY `uk_university_user` (`user_id`),
  CONSTRAINT `fk_university_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='高校信息表';

-- 6. 科室表（医院科室信息）
CREATE TABLE IF NOT EXISTS `department` (
  `dept_id` VARCHAR(32) NOT NULL COMMENT '科室唯一编码（主键）',
  `dept_name` VARCHAR(50) NOT NULL COMMENT '科室名称',
  `dept_code` VARCHAR(20) NOT NULL COMMENT '科室编码',
  `dept_type` VARCHAR(20) NOT NULL COMMENT '科室类别（内科/外科/妇产科/儿科等）',
  `dept_intro` TEXT COMMENT '科室介绍',
  `dept_location` VARCHAR(100) COMMENT '科室位置',
  `contact` VARCHAR(20) COMMENT '联系电话',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态（1-正常/0-停用）',
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `uk_dept_code` (`dept_code`),
  UNIQUE KEY `uk_dept_name` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='科室表';

-- 7. 医生表（医生信息，关联科室）
CREATE TABLE IF NOT EXISTS`doctor`  (
  `doctor_id` varchar(32) NOT NULL COMMENT '医生唯一标识（主键）',
  `doctor_name` varchar(12) NOT NULL COMMENT '医生姓名',
  `gender` CHAR(2) NOT NULL COMMENT '医生性别（男/女/未知）',
  `user_id` varchar(32) NOT NULL COMMENT '关联用户ID（外键，关联user表）',
  `dept_id` varchar(32) NOT NULL COMMENT '所属科室ID（外键，关联department表）',
  `title` varchar(30) NOT NULL COMMENT '职称（主任医师/副主任医师/主治医师等）',
  `specialty` varchar(100) NOT NULL COMMENT '擅长领域',
  `doc_intro` text NULL COMMENT '医生简介',
  `img_url` varchar(255) NULL DEFAULT NULL COMMENT '头像URL',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '出诊状态（1-出诊/0-停诊）',
  PRIMARY KEY (`doctor_id`) USING BTREE,
  UNIQUE INDEX `uk_doctor_user`(`user_id`) USING BTREE,
  INDEX `idx_dept_id`(`dept_id`) USING BTREE,
  CONSTRAINT `fk_doctor_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_doctor_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医生表';



-- 8. 护士表（护士信息，关联科室）
CREATE TABLE IF NOT EXISTS `nurse` (
  `nurse_id` VARCHAR(32) NOT NULL COMMENT '护士唯一标识（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '关联用户ID（外键，关联user表）',
  `dept_id` VARCHAR(32) NOT NULL COMMENT '所属科室ID（外键，关联department表）',
  `title` VARCHAR(30) COMMENT '职称（护士长/护师/护士等）',
  `nurse_intro` TEXT COMMENT '护士简介',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '工作状态（1-在岗/0-离岗）',
  PRIMARY KEY (`nurse_id`),
  UNIQUE KEY `uk_nurse_user` (`user_id`),
  KEY `idx_nurse_dept` (`dept_id`),
  CONSTRAINT `fk_nurse_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nurse_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='护士表';

-- 9. 医生排班表（医生出诊时间规划）
CREATE TABLE IF NOT EXISTS `doctor_schedule` (
  `rule_id` VARCHAR(32) NOT NULL COMMENT '排班规则唯一标识（主键）',
  `doctor_id` VARCHAR(32) NOT NULL COMMENT '医生ID（外键，关联doctor表）',
  `week` TINYINT(1) NOT NULL COMMENT '星期（1-周一/2-周二/.../7-周日）',
  `morning_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '上午出诊（1-是/0-否）',
  `afternoon_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '下午出诊（1-是/0-否）',
  `morning_start` TIME COMMENT '上午开诊时间',
  `morning_stop` TIME COMMENT '上午闭诊时间',
  `afternoon_start` TIME COMMENT '下午开诊时间',
  `afternoon_stop` TIME COMMENT '下午闭诊时间',
  PRIMARY KEY (`rule_id`),
  KEY `idx_doctor_week` (`doctor_id`, `week`),
  CONSTRAINT `fk_schedule_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医生排班表';

-- 10. 号源表（可预约的号源信息）
CREATE TABLE IF NOT EXISTS `registration_source` (
  `schedule_id` VARCHAR(32) NOT NULL COMMENT '号源唯一标识（主键）',
  `dept_id` VARCHAR(32) NOT NULL COMMENT '科室ID（外键，关联department表）',
  `doctor_id` VARCHAR(32) NOT NULL COMMENT '医生ID（外键，关联doctor表）',
  `schedule_date` DATE NOT NULL COMMENT '出诊日期',
  `schedule_period` VARCHAR(20) NOT NULL COMMENT '出诊时段（上午/下午）',
  `start_time` TIME NOT NULL COMMENT '开始时间',
  `stop_time` TIME NOT NULL COMMENT '结束时间',
  `total` INT(4) NOT NULL COMMENT '总号源数',
  `remain` INT(4) NOT NULL COMMENT '剩余号源数',
  `fee` DECIMAL(10,2) NOT NULL COMMENT '挂号费（元）',
  `status` VARCHAR(20) NOT NULL COMMENT '状态（可预约/约满/取消）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '号源生成时间',
  PRIMARY KEY (`schedule_id`),
  KEY `idx_dept_date` (`dept_id`, `schedule_date`),
  KEY `idx_doctor_date` (`doctor_id`, `schedule_date`),
  CONSTRAINT `fk_source_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_source_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='号源表';

-- 11. 预约记录表（患者预约记录）
CREATE TABLE IF NOT EXISTS `reservation` (
  `reservation_id` VARCHAR(32) NOT NULL COMMENT '预约唯一标识（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '用户ID（外键，关联user表）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人ID（外键，关联patient表）',
  `schedule_id` VARCHAR(32) NOT NULL COMMENT '号源ID（外键，关联registration_source表）',
  `dept_id` VARCHAR(32) NOT NULL COMMENT '科室ID（外键，关联department表）',
  `doctor_id` VARCHAR(32) NOT NULL COMMENT '医生ID（外键，关联doctor表）',
  `reservation_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '预约时间',
  `reservation_status` TINYINT(1) NOT NULL COMMENT '状态（1-待就诊/2-已就诊/3-已取消/4-爽约）',
  `cancel_time` DATETIME COMMENT '取消时间',
  `visit_no` VARCHAR(50) COMMENT '就诊序号',
  `pay_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '支付状态（1-已支付/0-未支付）',
  `pay_time` DATETIME COMMENT '支付时间',
  `pay_amount` DECIMAL(10,2) COMMENT '支付金额（元）',
  PRIMARY KEY (`reservation_id`),
  KEY `idx_user_reservation` (`user_id`),
  KEY `idx_patient_reservation` (`patient_id`),
  KEY `idx_schedule_reservation` (`schedule_id`),
  CONSTRAINT `fk_reservation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reservation_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reservation_source` FOREIGN KEY (`schedule_id`) REFERENCES `registration_source` (`schedule_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reservation_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reservation_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='预约记录表';

-- 12. 患者个人信息表（电子病历基础信息）
CREATE TABLE IF NOT EXISTS `patient_info` (
  `patient_info_id` VARCHAR(32) NOT NULL COMMENT '唯一标识（主键）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人ID（外键，关联patient表）',
  `age` INT(3) COMMENT '年龄',
  `date_of_birth` DATE COMMENT '出生日期',
  `medical_card` VARCHAR(50) COMMENT '医保卡号',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系方式',
  `allergic_history` TEXT COMMENT '药物过敏史',
  `family_history` TEXT COMMENT '家族病史',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`patient_info_id`),
  UNIQUE KEY `uk_patient_info` (`patient_id`),
  CONSTRAINT `fk_info_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='患者个人信息表';

-- 13. 疾病表（疾病字典）
CREATE TABLE IF NOT EXISTS `disease` (
  `disease_id` VARCHAR(32) NOT NULL COMMENT '疾病唯一标识（主键）',
  `disease_name` VARCHAR(100) NOT NULL COMMENT '疾病名称',
  `disease_code` VARCHAR(50) COMMENT '疾病编码（ICD-10）',
  `disease_type` VARCHAR(50) COMMENT '疾病类型（内科疾病/外科疾病等）',
	`infect_level` VARCHAR(20) COMMENT '传染等级（甲类/乙类/丙类）',
  `disease_desc` TEXT COMMENT '疾病描述',
  PRIMARY KEY (`disease_id`),
  UNIQUE KEY `uk_disease_name` (`disease_name`),
  UNIQUE KEY `uk_disease_code` (`disease_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='疾病表';

-- 14. 电子病历表（核心病历数据）
CREATE TABLE IF NOT EXISTS `medical_record` (
  `record_id` VARCHAR(32) NOT NULL COMMENT '病历唯一标识（主键）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人ID（外键，关联patient表）',
  `reservation_id` VARCHAR(32) COMMENT '关联预约ID（外键，关联reservation表）',
  `dept_id` VARCHAR(32) NOT NULL COMMENT '就诊科室ID（外键，关联department表）',
  `doctor_id` VARCHAR(32) NOT NULL COMMENT '接诊医生ID（外键，关联doctor表）',
  `visit_time` DATETIME NOT NULL COMMENT '就诊时间',
  `main_complaint` VARCHAR(50) NOT NULL COMMENT '主诉',
  `present_illness` TEXT COMMENT '现病史',
  `past_illness` TEXT COMMENT '既往病史',
  `physical_exam` TEXT COMMENT '查体结果',
  `auxiliary_exam` TEXT COMMENT '辅助检查项目（查血/CT等）',
  `exam_result` TEXT COMMENT '辅助检查结果',
  `diagnosis` VARCHAR(200) NOT NULL COMMENT '初步诊断（可多个，用逗号分隔）',
  `treatment` TEXT COMMENT '处理措施',
  `notes` VARCHAR(500) COMMENT '注意事项',
  `doctor_sign` VARCHAR(50) NOT NULL COMMENT '医生签名',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`record_id`),
  KEY `idx_patient_record` (`patient_id`),
  KEY `idx_doctor_record` (`doctor_id`),
  KEY `idx_visit_time` (`visit_time`),
  CONSTRAINT `fk_record_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_record_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_record_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_record_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='电子病历表';

-- 15. 患者疾病关联表（疾病管理）
CREATE TABLE IF NOT EXISTS `patient_disease` (
  `relation_id` VARCHAR(32) NOT NULL COMMENT '关联唯一标识（主键）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人ID（外键，关联patient表）',
  `disease_id` VARCHAR(32) NOT NULL COMMENT '疾病ID（外键，关联disease表）',
  `diagnosis_time` DATETIME NOT NULL COMMENT '确诊时间',
  `diagnosis_doctor` VARCHAR(32) NOT NULL COMMENT '确诊医生ID（外键，关联doctor表）',
  `treatment_status` VARCHAR(20) NOT NULL COMMENT '治疗状态（治疗中/已治愈/好转/未治愈）',
  `follow_up_needed` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否需要随访（1-是/0-否）',
  PRIMARY KEY (`relation_id`),
  KEY `idx_patient_disease` (`patient_id`),
  KEY `idx_disease_patient` (`disease_id`),
  CONSTRAINT `fk_relation_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relation_disease` FOREIGN KEY (`disease_id`) REFERENCES `disease` (`disease_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_relation_doctor` FOREIGN KEY (`diagnosis_doctor`) REFERENCES `doctor` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='患者疾病关联表（疾病管理）';

-- 16. 护理任务表（护务管理）
CREATE TABLE IF NOT EXISTS `nursing_task` (
  `task_id` VARCHAR(32) NOT NULL COMMENT '任务唯一标识（主键）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人ID（外键，关联patient表）',
  `nurse_id` VARCHAR(32) NOT NULL COMMENT '护士ID（外键，关联nurse表）',
  `doctor_id` VARCHAR(32) COMMENT '医嘱医生ID（外键，关联doctor表）',
  `task_content` TEXT NOT NULL COMMENT '护理任务内容',
  `task_type` VARCHAR(50) COMMENT '护理类型（基础护理/专科护理等）',
  `plan_time` DATETIME NOT NULL COMMENT '计划执行时间',
  `actual_time` DATETIME COMMENT '实际执行时间',
  `status` VARCHAR(20) NOT NULL COMMENT '状态（待执行/执行中/已完成/已取消）',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`task_id`),
  KEY `idx_patient_task` (`patient_id`),
  KEY `idx_nurse_task` (`nurse_id`),
  KEY `idx_task_status` (`status`),
  CONSTRAINT `fk_task_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_task_nurse` FOREIGN KEY (`nurse_id`) REFERENCES `nurse` (`nurse_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_task_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='护理任务表（护务管理）';

-- 17. 护理记录表（护务执行记录）
CREATE TABLE IF NOT EXISTS `nursing_record` (
  `record_id` VARCHAR(32) NOT NULL COMMENT '记录唯一标识（主键）',
  `task_id` VARCHAR(32) NOT NULL COMMENT '护理任务ID（外键，关联nursing_task表）',
  `nurse_id` VARCHAR(32) NOT NULL COMMENT '执行护士ID（外键，关联nurse表）',
  `execute_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '执行时间',
  `execute_result` TEXT NOT NULL COMMENT '执行结果',
  `patient_condition` VARCHAR(500) COMMENT '患者当时状态',
  `signature` VARCHAR(50) NOT NULL COMMENT '护士签名',
  PRIMARY KEY (`record_id`),
  KEY `idx_task_record` (`task_id`),
  KEY `idx_nurse_record` (`nurse_id`),
  CONSTRAINT `fk_record_task` FOREIGN KEY (`task_id`) REFERENCES `nursing_task` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_record_nurse` FOREIGN KEY (`nurse_id`) REFERENCES `nurse` (`nurse_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='护理记录表（护务管理）';

-- 18. 会诊申请表（远程医疗）
CREATE TABLE IF NOT EXISTS `consultation_apply` (
  `request_id` VARCHAR(36) NOT NULL COMMENT '会诊申请唯一编号（主键）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '患者ID（外键，关联patient表）',
  `apply_doctor` VARCHAR(32) NOT NULL COMMENT '申请医生ID（外键，关联doctor表）',
  `target_dept` VARCHAR(32) COMMENT '目标会诊科室ID（外键，关联department表）',
  `target_doctor` VARCHAR(32) COMMENT '目标会诊医生ID（外键，关联doctor表）',
  `description` TEXT NOT NULL COMMENT '病情描述',
  `apply_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `status` VARCHAR(20) NOT NULL COMMENT '状态（待处理/已接受/已拒绝/已完成）',
  `refuse_reason` TEXT COMMENT '拒绝原因（仅状态为已拒绝时填写）',
  PRIMARY KEY (`request_id`),
  KEY `idx_patient_consultation` (`patient_id`),
  KEY `idx_apply_doctor` (`apply_doctor`),
  KEY `idx_consultation_status` (`status`),
  CONSTRAINT `fk_consultation_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_consultation_apply_doctor` FOREIGN KEY (`apply_doctor`) REFERENCES `doctor` (`doctor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_consultation_dept` FOREIGN KEY (`target_dept`) REFERENCES `department` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_consultation_target_doctor` FOREIGN KEY (`target_doctor`) REFERENCES `doctor` (`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会诊申请表（远程医疗）';

-- 19. 病例附件表（远程医疗病历资料）
CREATE TABLE IF NOT EXISTS `consultation_attachment` (
  `file_id` VARCHAR(36) NOT NULL COMMENT '附件唯一ID（主键）',
  `request_id` VARCHAR(36) NOT NULL COMMENT '关联会诊申请ID（外键，关联consultation_apply表）',
  `upload_user` VARCHAR(32) NOT NULL COMMENT '上传用户ID（外键，关联user表）',
  `upload_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `file_uri` VARCHAR(255) NOT NULL COMMENT '文件存储路径',
  `file_type` VARCHAR(50) NOT NULL COMMENT '文件类型（图片/报告/视频等）',
  `file_name` VARCHAR(100) NOT NULL COMMENT '文件名称',
  `description` VARCHAR(255) COMMENT '附件说明',
  PRIMARY KEY (`file_id`),
  KEY `idx_request_attachment` (`request_id`),
  CONSTRAINT `fk_attachment_request` FOREIGN KEY (`request_id`) REFERENCES `consultation_apply` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_attachment_user` FOREIGN KEY (`upload_user`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='病例附件表（远程医疗）';

-- 20. 会诊会议表（远程医疗会诊过程）
CREATE TABLE IF NOT EXISTS `consultation_meeting` (
  `meeting_id` VARCHAR(36) NOT NULL COMMENT '会诊会议唯一ID（主键）',
  `request_id` VARCHAR(36) NOT NULL COMMENT '关联会诊申请ID（外键，关联consultation_apply表）',
  `start_time` DATETIME NOT NULL COMMENT '开始时间',
  `end_time` DATETIME COMMENT '结束时间',
  `participants` VARCHAR(500) NOT NULL COMMENT '参会人员（医生ID列表，用逗号分隔）',
  `diagnosis` TEXT COMMENT '会诊诊断意见',
  `treatment_suggest` TEXT COMMENT '治疗建议',
  `meeting_record` VARCHAR(255) COMMENT '会议记录文件路径',
  PRIMARY KEY (`meeting_id`),
  KEY `idx_request_meeting` (`request_id`),
  CONSTRAINT `fk_meeting_request` FOREIGN KEY (`request_id`) REFERENCES `consultation_apply` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会诊会议表（远程医疗）';

-- 21. 医院资源表（资产与资源管理）
CREATE TABLE IF NOT EXISTS `hospital_resource` (
  `resource_id` VARCHAR(32) NOT NULL COMMENT '医院资源唯一标识（主键）',
  `resource_name` VARCHAR(100) NOT NULL COMMENT '资源名称',
  `resource_type` VARCHAR(50) NOT NULL COMMENT '资源类别（手术室/会议室/医疗设备/办公用品等）',
  `dept_id` VARCHAR(32) COMMENT '所属部门ID（外键，关联department表）',
  `quantity` INT NOT NULL DEFAULT 1 COMMENT '资源数量',
  `status` VARCHAR(20) NOT NULL COMMENT '当前状态（良好/待验/需维修/已报废）',
  `manager_id` VARCHAR(32) COMMENT '负责人ID（外键，关联user表）',
  `put_in_time` DATETIME COMMENT '启用日期',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`resource_id`),
  KEY `idx_resource_type` (`resource_type`),
  KEY `idx_resource_status` (`status`),
  CONSTRAINT `fk_resource_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_resource_manager` FOREIGN KEY (`manager_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医院资源表（资产与资源管理）';

-- 22. 缴费单表（资产与资源管理-缴费服务）
CREATE TABLE IF NOT EXISTS `payment_order` (
  `payment_id` VARCHAR(32) NOT NULL COMMENT '缴费单编号（主键）',
  `patient_id` VARCHAR(32) NOT NULL COMMENT '就诊人ID（外键，关联patient表）',
  `reservation_id` VARCHAR(32) COMMENT '关联预约ID（外键，关联reservation表）',
  `medical_record_id` VARCHAR(32) COMMENT '关联病历ID（外键，关联medical_record表）',
  `payment_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缴费时间',
  `total_amount` DECIMAL(10,2) NOT NULL COMMENT '缴费总金额（元）',
  `payment_method` VARCHAR(10) NOT NULL COMMENT '缴费方式（微信/支付宝/现金/医保）',
  `cashier_id` VARCHAR(32) COMMENT '收费员ID（外键，关联user表）',
  `dept_id` VARCHAR(32) COMMENT '收费科室ID（外键，关联department表）',
  `invoice_no` VARCHAR(20) UNIQUE COMMENT '发票号',
  `status` VARCHAR(10) NOT NULL COMMENT '缴费状态（已完成/已退款/待缴费）',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`payment_id`),
  KEY `idx_patient_payment` (`patient_id`),
  KEY `idx_payment_time` (`payment_time`),
  CONSTRAINT `fk_payment_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_record` FOREIGN KEY (`medical_record_id`) REFERENCES `medical_record` (`record_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_cashier` FOREIGN KEY (`cashier_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='缴费单表（资产与资源管理）';

-- 23. 资金申请表（资产与资源管理-资金申请）
CREATE TABLE IF NOT EXISTS `fund_application` (
  `apply_id` VARCHAR(32) NOT NULL COMMENT '资金申请编号（主键）',
  `applicant_id` VARCHAR(32) NOT NULL COMMENT '申请人ID（外键，关联user表）',
  `applicant_dept` VARCHAR(32) NOT NULL COMMENT '申请人所属部门ID（外键，关联department表）',
  `apply_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请提交时间',
  `fund_type` VARCHAR(30) NOT NULL COMMENT '申请资金类型（设备采购/办公经费/科研经费等）',
  `apply_amount` DECIMAL(10,2) NOT NULL COMMENT '申请总金额（元）',
  `purpose` VARCHAR(500) NOT NULL COMMENT '申请用途说明',
  `status` VARCHAR(20) NOT NULL COMMENT '当前申请状态（待审批/已批准/已驳回/已拨款）',
  `approver_id` VARCHAR(32) COMMENT '审批人ID（外键，关联user表）',
  `approve_time` DATETIME COMMENT '审批时间',
  `approve_amount` DECIMAL(10,2) COMMENT '实际批准金额（元）',
  `attachment_url` VARCHAR(255) COMMENT '附件路径',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`apply_id`),
  KEY `idx_applicant` (`applicant_id`),
  KEY `idx_apply_status` (`status`),
  CONSTRAINT `fk_apply_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_apply_dept` FOREIGN KEY (`applicant_dept`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_apply_approver` FOREIGN KEY (`approver_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资金申请表（资产与资源管理）';

-- 24. 医院流水数据表（资产与资源管理-流水管理）
CREATE TABLE IF NOT EXISTS `hospital_flow` (
  `flow_id` VARCHAR(32) NOT NULL COMMENT '流水编号（主键）',
  `flow_type` VARCHAR(20) NOT NULL COMMENT '资金流向类型（收入/支出）',
  `flow_category` VARCHAR(30) NOT NULL COMMENT '资金流水所属类别（挂号收入/药品收入/设备采购支出等）',
  `amount` DECIMAL(10,2) NOT NULL COMMENT '金额（元）',
  `transaction_method` VARCHAR(30) COMMENT '交易方式',
  `dept_id` VARCHAR(32) COMMENT '涉及部门ID（外键，关联department表）',
  `related_order` VARCHAR(32) COMMENT '关联单据编号（缴费单ID/资金申请ID/工资单ID等）',
  `flow_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '资金流发生时间',
  `description` VARCHAR(500) COMMENT '流水说明',
  `status` VARCHAR(20) NOT NULL DEFAULT '有效' COMMENT '流水状态（有效/已作废）',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`flow_id`),
  KEY `idx_flow_time` (`flow_time`),
  KEY `idx_flow_type` (`flow_type`),
  KEY `idx_related_order` (`related_order`),
  CONSTRAINT `fk_flow_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医院流水数据表（资产与资源管理）';

-- 25. 工资单数据表（资产与资源管理-工资发放）
CREATE TABLE IF NOT EXISTS `salary_slip` (
  `salary_id` VARCHAR(32) NOT NULL COMMENT '工资单编号（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '医护人员ID（外键，关联user表）',
  `user_type` VARCHAR(20) NOT NULL COMMENT '人员类型（医生/护士/行政人员等）',
  `salary_amount` DECIMAL(10,2) NOT NULL COMMENT '工资金额（元）',
  `issue_time` DATETIME NOT NULL COMMENT '发放日期',
  `issuer_id` VARCHAR(32) COMMENT '发放人ID（外键，关联user表）',
  `status` VARCHAR(20) NOT NULL COMMENT '发放状态（已发放/未发放/已撤回）',
  `deduction` DECIMAL(10,2) DEFAULT 0.00 COMMENT '扣除金额（元）',
  `tax` DECIMAL(10,2) DEFAULT 0.00 COMMENT '个人所得税（元）',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`salary_id`),
  KEY `idx_user_salary` (`user_id`),
  KEY `idx_issue_time` (`issue_time`),
  CONSTRAINT `fk_salary_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_salary_issuer` FOREIGN KEY (`issuer_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工资单数据表（资产与资源管理）';

-- 26. 药品信息表（购药管理）
CREATE TABLE IF NOT EXISTS `medicine` (
  `medicine_id` VARCHAR(32) NOT NULL COMMENT '药品唯一标识（主键）',
  `medicine_name` VARCHAR(100) NOT NULL COMMENT '药品名称',
  `specification` VARCHAR(50) NOT NULL COMMENT '药品规格',
  `manufacturer` VARCHAR(100) NOT NULL COMMENT '生产厂家',
  `purchase_price` DECIMAL(10,2) NOT NULL COMMENT '采购单价（元）',
  `retail_price` DECIMAL(10,2) NOT NULL COMMENT '零售单价（元）',
  `stock_quantity` INT NOT NULL DEFAULT 0 COMMENT '当前库存数量',
  `min_stock` INT NOT NULL COMMENT '最低库存预警值',
  `is_active` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否启用（1-是/0-否）',
  `medicine_type` VARCHAR(50) COMMENT '药品类型（处方药/非处方药/中药/西药等）',
  `expire_date` DATE COMMENT '有效期至',
  PRIMARY KEY (`medicine_id`),
  UNIQUE KEY `uk_medicine_name_spec` (`medicine_name`, `specification`, `manufacturer`),
  KEY `idx_medicine_stock` (`stock_quantity`),
  KEY `idx_medicine_type` (`medicine_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='药品信息表（购药管理）';

-- 27. 供应商表（购药管理）
CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` VARCHAR(32) NOT NULL COMMENT '供应商唯一标识（主键）',
  `supplier_name` VARCHAR(100) NOT NULL COMMENT '供应商名称',
  `contact_person` VARCHAR(50) NOT NULL COMMENT '联系人',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
  `address` VARCHAR(255) COMMENT '供应商地址',
  `business_license` VARCHAR(100) COMMENT '营业执照编号',
  `is_active` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '合作状态（1-正常/0-终止）',
  `cooperation_time` DATETIME COMMENT '合作开始时间',
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `uk_supplier_name` (`supplier_name`),
  KEY `idx_supplier_status` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商表（购药管理）';

-- 28. 采购订单表（购药管理）
CREATE TABLE IF NOT EXISTS `purchase_order` (
  `order_id` VARCHAR(32) NOT NULL COMMENT '采购订单唯一标识（主键）',
  `order_no` VARCHAR(50) NOT NULL COMMENT '订单编号',
  `supplier_id` VARCHAR(32) NOT NULL COMMENT '供应商ID（外键，关联supplier表）',
  `order_date` DATE NOT NULL COMMENT '下单日期',
  `total_amount` DECIMAL(12,2) NOT NULL COMMENT '订单总金额（元）',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态（1-待发货/2-已入库/3-已取消）',
  `creator_id` VARCHAR(32) NOT NULL COMMENT '创建人ID（外键，关联user表）',
  `approver_id` VARCHAR(32) COMMENT '审批人ID（外键，关联user表）',
  `approve_time` DATETIME COMMENT '审批时间',
  `remark` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_supplier_order` (`supplier_id`),
  KEY `idx_order_status` (`status`),
  CONSTRAINT `fk_order_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_order_creator` FOREIGN KEY (`creator_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_order_approver` FOREIGN KEY (`approver_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购订单表（购药管理）';

-- 29. 采购订单明细表（购药管理）
CREATE TABLE IF NOT EXISTS `purchase_order_item` (
  `item_id` VARCHAR(32) NOT NULL COMMENT '明细唯一标识（主键）',
  `order_id` VARCHAR(32) NOT NULL COMMENT '采购订单ID（外键，关联purchase_order表）',
  `medicine_id` VARCHAR(32) NOT NULL COMMENT '药品ID（外键，关联medicine表）',
  `purchase_quantity` INT NOT NULL COMMENT '采购数量',
  `unit_price` DECIMAL(10,2) NOT NULL COMMENT '采购单价（元）',
  `received_quantity` INT NOT NULL DEFAULT 0 COMMENT '已入库数量',
  `remark` VARCHAR(255) COMMENT '备注',
  PRIMARY KEY (`item_id`),
  KEY `idx_order_item` (`order_id`),
  KEY `idx_medicine_item` (`medicine_id`),
  CONSTRAINT `fk_item_order` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_item_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicine` (`medicine_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购订单明细表（购药管理）';

-- 30. 入库记录表（购药管理）
CREATE TABLE IF NOT EXISTS `stock_in_record` (
  `record_id` VARCHAR(32) NOT NULL COMMENT '入库记录唯一标识（主键）',
  `order_id` VARCHAR(32) NOT NULL COMMENT '采购订单ID（外键，关联purchase_order表）',
  `medicine_id` VARCHAR(32) NOT NULL COMMENT '药品ID（外键，关联medicine表）',
  `in_quantity` INT NOT NULL COMMENT '入库数量',
  `batch_number` VARCHAR(50) NOT NULL COMMENT '药品批号',
  `in_date` DATE NOT NULL COMMENT '入库日期',
  `operator_id` VARCHAR(32) NOT NULL COMMENT '操作员ID（外键，关联user表）',
  `expire_date` DATE COMMENT '药品有效期至',
  `remark` VARCHAR(255) COMMENT '备注',
  PRIMARY KEY (`record_id`),
  KEY `idx_order_in` (`order_id`),
  KEY `idx_medicine_in` (`medicine_id`),
  KEY `idx_in_date` (`in_date`),
  CONSTRAINT `fk_in_order` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_in_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicine` (`medicine_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_in_operator` FOREIGN KEY (`operator_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='入库记录表（购药管理）';

-- 31. 论坛板块表（合作论坛）
CREATE TABLE IF NOT EXISTS `forum_section` (
  `section_id` VARCHAR(32) NOT NULL COMMENT '板块唯一标识（主键）',
  `section_name` VARCHAR(50) NOT NULL COMMENT '板块名称（企业合作/高校研究/行业动态等）',
  `section_desc` TEXT COMMENT '板块描述',
  `sort_order` INT NOT NULL DEFAULT 0 COMMENT '排序序号',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态（1-启用/0-禁用）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`section_id`),
  UNIQUE KEY `uk_section_name` (`section_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='论坛板块表（合作论坛）';

-- 32. 论坛帖子表（合作论坛）
CREATE TABLE IF NOT EXISTS `forum_post` (
  `post_id` VARCHAR(32) NOT NULL COMMENT '帖子唯一标识（主键）',
  `section_id` VARCHAR(32) NOT NULL COMMENT '所属板块ID（外键，关联forum_section表）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '发布用户ID（外键，关联user表）',
  `post_title` VARCHAR(100) NOT NULL COMMENT '帖子标题',
  `post_content` TEXT NOT NULL COMMENT '帖子内容',
  `post_type` VARCHAR(20) NOT NULL COMMENT '发布者类型（企业/高校/医院/管理员）',
  `related_org` VARCHAR(32) COMMENT '关联机构ID（企业ID/高校ID）',
  `view_count` INT NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `reply_count` INT NOT NULL DEFAULT 0 COMMENT '回复次数',
  `status` VARCHAR(20) NOT NULL DEFAULT '待审核' COMMENT '状态（待审核/已发布/已驳回/已删除）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`post_id`),
  KEY `idx_section_post` (`section_id`),
  KEY `idx_user_post` (`user_id`),
  KEY `idx_post_status` (`status`),
  FULLTEXT KEY `ft_post_title_content` (`post_title`, `post_content`),
  CONSTRAINT `fk_post_section` FOREIGN KEY (`section_id`) REFERENCES `forum_section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='论坛帖子表（合作论坛）';

-- 33. 论坛回复表（合作论坛）
CREATE TABLE IF NOT EXISTS `forum_reply` (
  `reply_id` VARCHAR(32) NOT NULL COMMENT '回复唯一标识（主键）',
  `post_id` VARCHAR(32) NOT NULL COMMENT '关联帖子ID（外键，关联forum_post表）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '回复用户ID（外键，关联user表）',
  `reply_content` TEXT NOT NULL COMMENT '回复内容',
  `reply_type` VARCHAR(20) NOT NULL COMMENT '回复者类型（企业/高校/医院/管理员）',
  `related_org` VARCHAR(32) COMMENT '关联机构ID（企业ID/高校ID）',
  `status` VARCHAR(20) NOT NULL DEFAULT '已发布' COMMENT '状态（已发布/已删除）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '回复时间',
  PRIMARY KEY (`reply_id`),
  KEY `idx_post_reply` (`post_id`),
  KEY `idx_user_reply` (`user_id`),
  CONSTRAINT `fk_reply_post` FOREIGN KEY (`post_id`) REFERENCES `forum_post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reply_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='论坛回复表（合作论坛）';

-- 34. 论坛审核日志表（论坛管理）
CREATE TABLE IF NOT EXISTS `forum_audit_log` (
  `log_id` VARCHAR(32) NOT NULL COMMENT '日志唯一标识（主键）',
  `post_id` VARCHAR(32) NOT NULL COMMENT '关联帖子ID（外键，关联forum_post表）',
  `auditor_id` VARCHAR(32) NOT NULL COMMENT '审核人ID（外键，关联user表）',
  `audit_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `before_status` VARCHAR(20) NOT NULL COMMENT '审核前状态',
  `after_status` VARCHAR(20) NOT NULL COMMENT '审核后状态',
  `audit_opinion` TEXT COMMENT '审核意见',
  PRIMARY KEY (`log_id`),
  KEY `idx_post_audit` (`post_id`),
  KEY `idx_auditor` (`auditor_id`),
  CONSTRAINT `fk_audit_post` FOREIGN KEY (`post_id`) REFERENCES `forum_post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`auditor_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='论坛审核日志表（论坛管理）';

-- 35. 医疗资讯表（医疗资讯业务）
CREATE TABLE IF NOT EXISTS `medical_news` (
  `news_id` VARCHAR(32) NOT NULL COMMENT '资讯唯一标识（主键）',
  `news_title` VARCHAR(100) NOT NULL COMMENT '资讯标题',
  `news_content` TEXT NOT NULL COMMENT '资讯内容',
  `news_type` VARCHAR(50) NOT NULL COMMENT '资讯类型（健康常识/疾病预防/政策通知/行业动态等）',
  `publisher_id` VARCHAR(32) NOT NULL COMMENT '发布人ID（外键，关联user表）',
  `publisher_type` VARCHAR(20) NOT NULL COMMENT '发布人类型（医生/护士/管理员）',
  `cover_img` VARCHAR(255) COMMENT '封面图片URL',
  `view_count` INT NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `status` VARCHAR(20) NOT NULL DEFAULT '已发布' COMMENT '状态（已发布/已下架/待审核）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`news_id`),
  KEY `idx_news_type` (`news_type`),
  KEY `idx_publisher` (`publisher_id`),
  KEY `idx_news_status` (`status`),
  FULLTEXT KEY `ft_news_title_content` (`news_title`, `news_content`),
  CONSTRAINT `fk_news_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医疗资讯表（医疗资讯业务）';

-- 36. 通知信息表（全局通知服务）
CREATE TABLE IF NOT EXISTS `notification` (
  `notification_id` VARCHAR(32) NOT NULL COMMENT '通知唯一标识（主键）',
  `user_id` VARCHAR(32) NOT NULL COMMENT '接收用户ID（外键，关联user表）',
  `notification_type` VARCHAR(20) NOT NULL COMMENT '通知类型（预约提醒/缴费通知/就诊结果/审核通知等）',
  `title` VARCHAR(100) NOT NULL COMMENT '通知标题',
  `content` TEXT NOT NULL COMMENT '通知内容',
  `send_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `read_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '阅读状态（1-已读/0-未读）',
  `read_time` DATETIME COMMENT '阅读时间',
  `related_id` VARCHAR(32) COMMENT '关联业务ID（预约ID/缴费ID/帖子ID等）',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '通知状态（1-有效/0-已删除）',
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_notification` (`user_id`),
  KEY `idx_notification_type` (`notification_type`),
  KEY `idx_read_status` (`read_status`),
  CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知信息表';

-- 37. 疫情上报记录表
CREATE TABLE IF NOT EXISTS `epidemic_report` (
    `report_id`     VARCHAR(32)  NOT NULL COMMENT '主键，上报单唯一标识',
    `patient_id`    VARCHAR(32)  NOT NULL COMMENT '关联患者ID（外键）',
    `doctor_id`     VARCHAR(32)  NOT NULL COMMENT '上报医生ID（外键）',
    `disease_id`    VARCHAR(32)  NOT NULL COMMENT '关联疾病类型ID',
    `report_type`   VARCHAR(20)  NOT NULL COMMENT '上报类型（疑似/确诊/治愈/死亡）',
    `symptom`       TEXT         COMMENT '主要症状描述',
    `report_time`   DATETIME     NOT NULL COMMENT '上报时间',
    `status`        TINYINT(1)   NOT NULL DEFAULT 1 COMMENT '状态（1-已上报 2-已核实 0-作废）',
    `remark`       VARCHAR(255) COMMENT '备注',

    PRIMARY KEY (report_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (disease_id) REFERENCES disease(disease_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='疫情上报表';

-- 38. 疫情公告表
CREATE TABLE IF NOT EXISTS epidemic_notice (
    notice_id     VARCHAR(32)   NOT NULL COMMENT '主键，公告唯一标识',
    title         VARCHAR(100)  NOT NULL COMMENT '公告标题',
    content       TEXT          COMMENT '公告内容（支持HTML）',
    publisher_id  VARCHAR(32)   NOT NULL COMMENT '发布人ID',
    publish_time  DATETIME      NOT NULL COMMENT '发布时间',
    priority      TINYINT(1)    NOT NULL DEFAULT 1 COMMENT '优先级（1-普通 2-紧急 3-特急）',
    status        TINYINT(1)    NOT NULL DEFAULT 1 COMMENT '状态（1-发布 0-撤回）',

    PRIMARY KEY (notice_id),
		FOREIGN KEY (publisher_id) REFERENCES user(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='疫情公告表';

-- 1. 初始化角色数据
INSERT INTO `role` (`role_id`, `role_name`, `role_desc`) VALUES
('ROLE_ADMIN', '管理员', '系统管理员，负责论坛管理、用户管理等'),
('ROLE_DOCTOR', '医生', '负责医务管理、电子病历、远程医疗、疾病管理等'),
('ROLE_NURSE', '护士', '负责护务管理、电子病历辅助等'),
('ROLE_PATIENT', '患者', '负责预约挂号、查看电子病历、远程医疗申请等'),
('ROLE_ENTERPRISE', '企业用户', '负责合作论坛发布、互动等'),
('ROLE_UNIVERSITY', '高校用户', '负责合作论坛发布、互动等'),
('ROLE_FINANCE', '财务人员', '负责资产与资源管理、购药管理、财务统计分析等'),
('ROLE_EXECUTIVE', '医院高管', '负责医院整体管理、决策等');

-- 2. 用户表
INSERT INTO `user` (`user_id`, `username`, `password`, `id_card`, `real_name`, `gender`, `phone`, `role_id`, `status`) VALUES
('USER001', 'admin001', 'admin123', '110101199001011234', '系统管理员', '男', '13800138001', 'ROLE_ADMIN', 1),
('USER002', 'doctor001', 'doctor123', '110101199002021234', '张医生', '男', '13800138002', 'ROLE_DOCTOR', 1),
('USER003', 'nurse001', 'nurse123', '110101199003031234', '李护士', '女', '13800138003', 'ROLE_NURSE', 1),
('USER004', 'patient001', 'patient123', '110101199004041234', '王患者', '男', '13800138004', 'ROLE_PATIENT', 1),
('USER005', 'enterprise001', 'enterprise123', '110101199005051234', '企业用户', '男', '13800138005', 'ROLE_ENTERPRISE', 1),
('USER006', 'university001', 'university123', '110101199006061234', '高校用户', '女', '13800138006', 'ROLE_UNIVERSITY', 1),
('USER007', 'finance001', 'finance123', '110101199007071234', '财务人员', '男', '13800138007', 'ROLE_FINANCE', 1);

-- 3. 就诊人信息表
INSERT INTO `patient` (`patient_id`, `user_id`, `real_name`, `id_card`, `gender`, `phone`, `relationship`, `medical_card`, `status`) VALUES
('PATIENT001', 'USER004', '王患者', '110101199004041234', '男', '13800138004', '本人', 'MC001234567890', 1);

-- 4. 企业信息表
INSERT INTO `enterprise` (`enterprise_id`, `user_id`, `enterprise_name`, `contact_person`, `contact_phone`, `address`, `business_scope`, `status`) VALUES
('ENT001', 'USER005', '测试医疗设备公司', '企业用户', '13800138005', '北京市朝阳区测试路1号', '医疗设备研发与销售', 1);

-- 5. 高校信息表
INSERT INTO `university` (`university_id`, `user_id`, `university_name`, `contact_person`, `contact_phone`, `address`, `major_field`, `status`) VALUES
('UNI001', 'USER006', '测试医科大学', '高校用户', '13800138006', '北京市海淀区测试路2号', '临床医学、护理学', 1);

-- 6. 科室表
INSERT INTO `department` (`dept_id`, `dept_name`, `dept_code`, `dept_type`, `dept_intro`, `dept_location`, `contact`, `status`) VALUES
('DEPT001', '内科', 'NK001', '内科', '内科是医院的主要科室之一，负责各种内科疾病的诊治', '1号楼2层', '010-12345678', 1);

-- 7. 医生表
INSERT INTO `doctor` (`doctor_id`, `doctor_name`, `gender`, `user_id`, `dept_id`, `title`, `specialty`, `doc_intro`, `img_url`, `status`) VALUES
('DOC001', '张医生', '男', 'USER002', 'DEPT001', '主任医师', '心血管疾病、高血压', '从事临床工作20年，擅长心血管疾病的诊治', NULL, 1);

-- 8. 护士表
INSERT INTO `nurse` (`nurse_id`, `user_id`, `dept_id`, `title`, `nurse_intro`, `status`) VALUES
('NURSE001', 'USER003', 'DEPT001', '护师', '从事护理工作10年，经验丰富', 1);

-- 9. 医生排班表
INSERT INTO `doctor_schedule` (`rule_id`, `doctor_id`, `week`, `morning_status`, `afternoon_status`, `morning_start`, `morning_stop`, `afternoon_start`, `afternoon_stop`) VALUES
('SCHEDULE001', 'DOC001', 1, 1, 1, '08:00:00', '12:00:00', '14:00:00', '18:00:00');

-- 10. 号源表
INSERT INTO `registration_source` (`schedule_id`, `dept_id`, `doctor_id`, `schedule_date`, `schedule_period`, `start_time`, `stop_time`, `total`, `remain`, `fee`, `status`) VALUES
('SOURCE001', 'DEPT001', 'DOC001', '2025-12-01', '上午', '08:00:00', '12:00:00', 20, 15, 50.00, '可预约');

-- 11. 预约记录表
INSERT INTO `reservation` (`reservation_id`, `user_id`, `patient_id`, `schedule_id`, `dept_id`, `doctor_id`, `reservation_time`, `reservation_status`, `visit_no`, `pay_status`, `pay_amount`) VALUES
('RES001', 'USER004', 'PATIENT001', 'SOURCE001', 'DEPT001', 'DOC001', '2025-11-30 10:00:00', 1, 'V001', 1, 50.00);

-- 12. 患者个人信息表
INSERT INTO `patient_info` (`patient_info_id`, `patient_id`, `age`, `date_of_birth`, `medical_card`, `contact_phone`, `allergic_history`, `family_history`) VALUES
('INFO001', 'PATIENT001', 35, '1990-04-04', 'MC001234567890', '13800138004', '青霉素过敏', '父亲有高血压病史');

-- 13. 疾病表
INSERT INTO `disease` (`disease_id`, `disease_name`, `disease_code`, `disease_type`, `infect_level`, `disease_desc`) VALUES
('DISEASE001', '高血压', 'I10', '内科疾病', '非传染', '高血压是一种常见的慢性疾病，主要表现为血压持续升高');

-- 14. 电子病历表
INSERT INTO `medical_record` (`record_id`, `patient_id`, `reservation_id`, `dept_id`, `doctor_id`, `visit_time`, `main_complaint`, `present_illness`, `past_illness`, `physical_exam`, `auxiliary_exam`, `exam_result`, `diagnosis`, `treatment`, `notes`, `doctor_sign`) VALUES
('RECORD001', 'PATIENT001', 'RES001', 'DEPT001', 'DOC001', '2025-12-01 09:00:00', '头痛、头晕3天', '患者3天前出现头痛、头晕症状，无恶心呕吐', '既往有高血压病史', '血压150/95mmHg，心率80次/分', '血常规、心电图', '血常规正常，心电图提示左心室肥厚', '高血压', '口服降压药物，定期监测血压', '注意休息，低盐饮食', '张医生');

-- 15. 患者疾病关联表
INSERT INTO `patient_disease` (`relation_id`, `patient_id`, `disease_id`, `diagnosis_time`, `diagnosis_doctor`, `treatment_status`, `follow_up_needed`) VALUES
('RELATION001', 'PATIENT001', 'DISEASE001', '2025-12-01 09:00:00', 'DOC001', '治疗中', 1);

-- 16. 护理任务表
INSERT INTO `nursing_task` (`task_id`, `patient_id`, `nurse_id`, `doctor_id`, `task_content`, `task_type`, `plan_time`, `status`, `remark`) VALUES
('TASK001', 'PATIENT001', 'NURSE001', 'DOC001', '测量患者血压，记录生命体征', '基础护理', '2025-12-01 08:00:00', '待执行', '每日上午测量');

-- 17. 护理记录表
INSERT INTO `nursing_record` (`record_id`, `task_id`, `nurse_id`, `execute_time`, `execute_result`, `patient_condition`, `signature`) VALUES
('NRECORD001', 'TASK001', 'NURSE001', '2025-12-01 08:30:00', '已测量血压，结果为150/95mmHg，患者状态良好', '患者意识清楚，配合检查', '李护士');

-- 18. 会诊申请表
INSERT INTO `consultation_apply` (`request_id`, `patient_id`, `apply_doctor`, `target_dept`, `target_doctor`, `description`, `apply_time`, `status`) VALUES
('CONSULT001', 'PATIENT001', 'DOC001', 'DEPT001', 'DOC001', '患者病情复杂，需要多科室会诊', '2025-11-30 14:00:00', '待处理');

-- 19. 病例附件表
INSERT INTO `consultation_attachment` (`file_id`, `request_id`, `upload_user`, `upload_time`, `file_uri`, `file_type`, `file_name`, `description`) VALUES
('FILE001', 'CONSULT001', 'USER002', '2025-11-30 14:30:00', '/uploads/consultation/file001.jpg', '图片', '患者CT扫描图', '胸部CT扫描结果');

-- 20. 会诊会议表
INSERT INTO `consultation_meeting` (`meeting_id`, `request_id`, `start_time`, `end_time`, `participants`, `diagnosis`, `treatment_suggest`, `meeting_record`) VALUES
('MEETING001', 'CONSULT001', '2025-12-01 10:00:00', '2025-12-01 11:00:00', 'DOC001', '高血压合并冠心病', '建议继续药物治疗，定期复查', '/records/meeting001.pdf');

-- 21. 医院资源表
INSERT INTO `hospital_resource` (`resource_id`, `resource_name`, `resource_type`, `dept_id`, `quantity`, `status`, `manager_id`, `put_in_time`, `remark`) VALUES
('RESOURCE001', '心电图机', '医疗设备', 'DEPT001', 2, '良好', 'USER002', '2025-01-01 00:00:00', '设备运行正常');

-- 22. 缴费单表
INSERT INTO `payment_order` (`payment_id`, `patient_id`, `reservation_id`, `medical_record_id`, `payment_time`, `total_amount`, `payment_method`, `cashier_id`, `dept_id`, `invoice_no`, `status`) VALUES
('PAY001', 'PATIENT001', 'RES001', 'RECORD001', '2025-12-01 09:30:00', 150.00, '微信', 'USER007', 'DEPT001', 'INV001', '已完成');

-- 23. 资金申请表
INSERT INTO `fund_application` (`apply_id`, `applicant_id`, `applicant_dept`, `apply_time`, `fund_type`, `apply_amount`, `purpose`, `status`, `approver_id`, `approve_time`, `approve_amount`) VALUES
('FUND001', 'USER002', 'DEPT001', '2025-11-30 10:00:00', '设备采购', 50000.00, '采购新型心电图机', '待审批', NULL, NULL, NULL);

-- 24. 医院流水数据表
INSERT INTO `hospital_flow` (`flow_id`, `flow_type`, `flow_category`, `amount`, `transaction_method`, `dept_id`, `related_order`, `flow_time`, `description`, `status`) VALUES
('FLOW001', '收入', '挂号收入', 50.00, '微信', 'DEPT001', 'PAY001', '2025-12-01 09:30:00', '患者挂号缴费', '有效');

-- 25. 工资单数据表
INSERT INTO `salary_slip` (`salary_id`, `user_id`, `user_type`, `salary_amount`, `issue_time`, `issuer_id`, `status`, `deduction`, `tax`) VALUES
('SALARY001', 'USER003', '护士', 8000.00, '2025-11-30 00:00:00', 'USER007', '已发放', 500.00, 200.00);

-- 26. 药品信息表
INSERT INTO `medicine` (`medicine_id`, `medicine_name`, `specification`, `manufacturer`, `purchase_price`, `retail_price`, `stock_quantity`, `min_stock`, `is_active`, `medicine_type`, `expire_date`) VALUES
('MED001', '阿司匹林肠溶片', '100mg*30片', '测试制药公司', 15.00, 25.00, 500, 100, 1, '处方药', '2026-12-31');

-- 27. 供应商表
INSERT INTO `supplier` (`supplier_id`, `supplier_name`, `contact_person`, `contact_phone`, `address`, `business_license`, `is_active`, `cooperation_time`) VALUES
('SUP001', '测试药品供应商', '供应商联系人', '13800138888', '北京市测试区供应商路1号', 'BL001234567890', 1, '2025-01-01 00:00:00');

-- 28. 采购订单表
INSERT INTO `purchase_order` (`order_id`, `order_no`, `supplier_id`, `order_date`, `total_amount`, `status`, `creator_id`, `approver_id`, `approve_time`, `remark`) VALUES
('ORDER001', 'PO20251130001', 'SUP001', '2025-11-30', 15000.00, 1, 'USER007', NULL, NULL, '采购常用药品');

-- 29. 采购订单明细表
INSERT INTO `purchase_order_item` (`item_id`, `order_id`, `medicine_id`, `purchase_quantity`, `unit_price`, `received_quantity`, `remark`) VALUES
('ITEM001', 'ORDER001', 'MED001', 100, 15.00, 0, '采购阿司匹林肠溶片');

-- 30. 入库记录表
INSERT INTO `stock_in_record` (`record_id`, `order_id`, `medicine_id`, `in_quantity`, `batch_number`, `in_date`, `operator_id`, `expire_date`, `remark`) VALUES
('STOCK001', 'ORDER001', 'MED001', 100, 'BATCH20251130', '2025-11-30', 'USER007', '2026-12-31', '药品入库');

-- 31. 论坛板块表
INSERT INTO `forum_section` (`section_id`, `section_name`, `section_desc`, `sort_order`, `status`) VALUES
('SECTION001', '企业合作', '企业合作交流板块', 1, 1);

-- 32. 论坛帖子表
INSERT INTO `forum_post` (`post_id`, `section_id`, `user_id`, `post_title`, `post_content`, `post_type`, `related_org`, `view_count`, `reply_count`, `status`) VALUES
('POST001', 'SECTION001', 'USER005', '医疗设备合作意向', '我们公司希望与医院合作，提供先进的医疗设备', '企业', 'ENT001', 50, 5, '已发布');

-- 33. 论坛回复表
INSERT INTO `forum_reply` (`reply_id`, `post_id`, `user_id`, `reply_content`, `reply_type`, `related_org`, `status`) VALUES
('REPLY001', 'POST001', 'USER006', '我们高校也有相关研究，可以进一步交流', '高校', 'UNI001', '已发布');

-- 34. 论坛审核日志表
INSERT INTO `forum_audit_log` (`log_id`, `post_id`, `auditor_id`, `audit_time`, `before_status`, `after_status`, `audit_opinion`) VALUES
('AUDIT001', 'POST001', 'USER001', '2025-11-30 15:00:00', '待审核', '已发布', '内容符合要求，予以发布');

-- 35. 医疗资讯表
INSERT INTO `medical_news` (`news_id`, `news_title`, `news_content`, `news_type`, `publisher_id`, `publisher_type`, `cover_img`, `view_count`, `status`) VALUES
('NEWS001', '高血压的预防与治疗', '高血压是一种常见的慢性疾病，本文介绍高血压的预防和治疗方法...', '健康常识', 'USER002', '医生', NULL, 200, '已发布');

-- 36. 通知信息表
INSERT INTO `notification` (`notification_id`, `user_id`, `notification_type`, `title`, `content`, `send_time`, `read_status`, `related_id`, `status`) VALUES
('NOTIFY001', 'USER004', '预约提醒', '预约提醒', '您已成功预约2025-12-01上午的号源，请按时就诊', '2025-11-30 16:00:00', 0, 'RES001', 1);

-- 37. 疫情上报记录表
INSERT INTO `epidemic_report` (`report_id`, `patient_id`, `doctor_id`, `disease_id`, `report_type`, `symptom`, `report_time`, `status`, `remark`) VALUES
('EPI001', 'PATIENT001', 'DOC001', 'DISEASE001', '疑似', '患者出现发热、咳嗽症状', '2025-11-30 17:00:00', 1, '已上报，等待核实');

-- 38. 疫情公告表
INSERT INTO `epidemic_notice` (`notice_id`, `title`, `content`, `publisher_id`, `publish_time`, `priority`, `status`) VALUES
('NOTICE001', '疫情防控通知', '请各位患者和医护人员注意个人防护，佩戴口罩，勤洗手', 'USER001', '2025-11-30 18:00:00', 2, 1);