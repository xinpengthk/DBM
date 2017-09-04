
#### for mysql 5.6.28

use dbm_db;

####### 用户相关表
CREATE TABLE sys_dept (
  dept_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  dept_name varchar(32) NOT NULL COMMENT '部门名称',
  dept_loc varchar(32) NOT NULL COMMENT '部门工作地点',
  dept_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '部门激活状态，0：未激活，1：激活',
  dept_desc varchar(128) NOT NULL COMMENT '部门描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (dept_id),
  UNIQUE INDEX uq_idx_deptname (dept_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '系统部门表';

CREATE TABLE sys_title (
  title_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  title_name varchar(32) NOT NULL COMMENT '岗位名称',
  title_type tinyint(4) NOT NULL DEFAULT '100' COMMENT '岗位类型，100:普通员工，101:项目ledear，102:部门负责人，103:XXO，104:临时用户',
  title_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '岗位激活状态，0：未激活，1：激活',
  title_desc varchar(128) NOT NULL COMMENT '岗位描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (title_id),
  UNIQUE INDEX uq_idx_titlename (title_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '系统岗位表';

CREATE TABLE sys_user (
  user_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  dept_id bigint(20) NOT NULL COMMENT '部门id，外键',
  title_id bigint(20) NOT NULL COMMENT '职务id，外键',
  user_login_name varchar(32) NOT NULL COMMENT '用户登录名',
  user_realname varchar(32) NOT NULL COMMENT '用户真实姓名',
  user_pwd varchar(64) NOT NULL COMMENT '用户密码，加密',
  user_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为项目leader，1：是，0：否',
  user_mgrid bigint(20) NOT NULL COMMENT '用户领导id，0为管理员用户，自外键',
  user_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户激活状态，0：未激活，1：激活',
  user_email varchar(128) NOT NULL COMMENT '用户邮箱',
  user_phone varchar(11) NOT NULL COMMENT '用户手机号',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (user_id),
  INDEX idx_dept_id (dept_id),
  INDEX idx_title_id (title_id),
  INDEX idx_user_mgrid (user_mgrid),
  UNIQUE INDEX uq_idx_loginname (user_login_name),
  UNIQUE INDEX uq_idx_email (user_email),
  UNIQUE INDEX uq_idx_phone (user_phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '系统用户表, admin用户拥有超级权限';


CREATE TABLE sys_group (
  group_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  group_name varchar(32) NOT NULL COMMENT '项目组名称（项目名）',
  group_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '项目组状态，0：不可用，1：可用',
  group_desc varchar(128) NOT NULL COMMENT '项目组描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (group_id),
  UNIQUE INDEX uq_idx_groupname (group_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '项目组表';


CREATE TABLE sys_user_group (
  group_id bigint(20) unsigned NOT NULL COMMENT '主键id 1',
  user_id bigint(20) unsigned NOT NULL COMMENT '主键id 2',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (group_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '员工项目组关联表';

####### 权限相关表
CREATE TABLE sys_menu (
  menu_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  menu_parent_id bigint(20) unsigned NOT NULL COMMENT '菜单父id',
  menu_name varchar(32) NOT NULL COMMENT '菜单名称',
  menu_url varchar(128) NOT NULL COMMENT '菜单url',
  menu_priv varchar(32) NOT NULL COMMENT '菜单权限，CRUD...，逗号隔开',
  menu_sort tinyint(4) NOT NULL COMMENT '菜单排序',
  menu_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '菜单状态，0：不可用，1：可用',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (menu_id),
  UNIQUE INDEX uq_idx_menuname (menu_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '系统菜单表';


CREATE TABLE sys_role (
  role_id bigint(20)  unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  role_name varchar(32) NOT NULL COMMENT '角色名称，唯一',
  role_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '角色状态，0：不可用，1：可用',
  role_desc varchar(128) NOT NULL COMMENT '角色描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (role_id),
  UNIQUE INDEX uq_idx_rolename (role_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '员工项目组关联表';


CREATE TABLE sys_role_menu (
  role_id bigint(20) unsigned NOT NULL COMMENT '主键id 1',
  menu_id bigint(20) unsigned NOT NULL COMMENT '主键id 2',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (role_id, menu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '角色菜单关联表';


CREATE TABLE sys_group_role (
  group_id bigint(20) unsigned NOT NULL COMMENT '主键id 1',
  role_id bigint(20) unsigned NOT NULL COMMENT '主键id 2',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (group_id, role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '用户角色关联表';


CREATE TABLE sys_group_service (
  group_id bigint(20) unsigned NOT NULL COMMENT '主键id 1',
  service_id bigint(20) unsigned NOT NULL COMMENT '主键id 2',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (group_id, service_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '用户服务关联表';

####### 主机相关表
CREATE TABLE ma_hostroom (
  hostroom_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  hostroom_name varchar(32) NOT NULL COMMENT '机房名称',
  hostroom_addr varchar(32) NOT NULL COMMENT '机房地址',
  hostroom_floor varchar(32) NOT NULL COMMENT '机房楼层',
  hostroom_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '机房状态，100：已上架，101：已下架',
  hostroom_desc varchar(128) NOT NULL COMMENT '机房描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (hostroom_id),
  UNIQUE INDEX uq_idx_hostroomname (hostroom_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '机房信息表';

CREATE TABLE ma_hostcabinet (
  hostcabinet_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  hostroom_id bigint(20) unsigned NOT NULL COMMENT '机房id，外键',
  hostcabinet_name varchar(32) NOT NULL COMMENT '机柜名称',
  hostcabinet_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '机柜状态，100：已上架，101：已下架，102：已满，103：有空闲',
  hostcabinet_desc varchar(128) NOT NULL COMMENT '机柜描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (hostcabinet_id),
  INDEX idx_hostroom_id (hostroom_id),
  UNIQUE INDEX uq_idx_hostcabinetname (hostcabinet_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '机柜信息表';


CREATE TABLE ma_host (
  host_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  hostcabinet_id bigint(20) unsigned NOT NULL COMMENT '机柜id，外键',
  host_name varchar(32) NOT NULL COMMENT '机器名称',
  host_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '机器状态，100：已上架，101：已下架',
  host_desc varchar(128) NOT NULL COMMENT '机柜描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (host_id),
  INDEX idx_hostcabinet_id (hostcabinet_id),
  UNIQUE INDEX uq_idx_host_name (host_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '机器信息表';


CREATE TABLE ma_host_network_card (
  card_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  host_id bigint(20) unsigned NOT NULL COMMENT '机器id，外键',
  card_name varchar(32) NOT NULL COMMENT '网卡名称：eth0等',
  card_bind_ip varchar(15) NOT NULL COMMENT '网卡 ip',
  card_bind_ip_type tinyint(4) NOT NULL DEFAULT '100' COMMENT 'IP 类型，100:内网IP，101:外网IP，102: VIP',
  card_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '网卡状态，100：已停用，101：使用中',
  card_desc varchar(128) NOT NULL COMMENT '网卡描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (card_id),
  INDEX idx_host_id (host_id),
  UNIQUE INDEX uq_idx_card_name (card_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '网卡信息表';


#### 暂时不做，参考CMDB
#CREATE TABLE ma_host_profile (
#  profile_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
#  host_id bigint(20) unsigned NOT NULL COMMENT '机器ID，外键',
#  profile_type varchar(32) NOT NULL COMMENT '配置类型：mem, disk, eth, cpu',
#  profile_
#  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
#  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
#  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
#  PRIMARY KEY (profile_id),
#  INDEX idx_host_id (host_id)
#) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '机器配置表';

####### 产品相关表
CREATE TABLE prd_product (
  product_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  product_name varchar(32) NOT NULL COMMENT '产品线名称',
  product_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '产品线状态，0：未上线，1：已上线，2：已下线',
  product_desc varchar(128) NOT NULL COMMENT '产品线描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (product_id),
  UNIQUE INDEX uq_idx_prdname (product_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '产品线表';

CREATE TABLE prd_service (
  service_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  product_id bigint(20) unsigned NOT NULL COMMENT '产品线ID，外键',
  service_pro_manager bigint(20) unsigned NOT NULL COMMENT '该服务产品经理id，外键, sys_user',
  service_dev_ledear bigint(20) unsigned NOT NULL COMMENT '该服务开发ledear id，外键, sys_user',
  service_qa_ledear bigint(20) unsigned NOT NULL COMMENT '该服务测试ledear id，外键, sys_user',
  service_name varchar(32) NOT NULL COMMENT '服务名称',
  service_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '服务状态，0：未上线，1：已上线，2：已下线',
  service_desc varchar(128) NOT NULL COMMENT '服务描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (service_id),
  INDEX idx_prdid (product_id),
  INDEX idx_promanager (service_pro_manager),
  INDEX idx_devledear (service_dev_ledear),
  INDEX idx_qaledear (service_qa_ledear),
  UNIQUE INDEX uq_idx_service_name (service_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '产品线中服务表';

####### DB相关表
CREATE TABLE db_cluster (
  clu_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  clu_name varchar(32) NOT NULL COMMENT '集群名称，产品线名称+服务名称+DB类型',
  clu_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '集群状态，100：已下线，101：在线',
  clu_desc varchar(128) NOT NULL COMMENT '集群描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (clu_id),
  UNIQUE INDEX uq_idx_clu_name (clu_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库集群信息表';

CREATE TABLE db_group (
  grp_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  clu_id bigint(20) unsigned NOT NULL COMMENT '集群ID，外键',
  grp_name varchar(32) NOT NULL COMMENT '分组名称，G001,G002...',
  grp_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '分组状态，100：已下线，101：在线',
  grp_desc varchar(128) NOT NULL COMMENT '分组描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (grp_id),
  INDEX idx_clu_id (clu_id),
  UNIQUE INDEX uq_idx_grp_name (grp_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库分组表';

CREATE TABLE db_instance (
  instance_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
#  host_id bigint(20) unsigned NOT NULL COMMENT '主机id，外键',
  grp_id bigint(20) unsigned NOT NULL COMMENT '分组ID，外键',
  instance_name varchar(32) NOT NULL COMMENT '实例名称，DB001,DB002...',
  instance_type tinyint(4) NOT NULL DEFAULT '100' COMMENT '实例类型，100：MySQL官方社区版，101：REDIS，102：MONGODB，103：ORACLE',
  bind_ip varchar(15) NOT NULL COMMENT '绑定的内网IP',
  bind_port varchar(15) NOT NULL COMMENT '绑定的端口',
  instance_role varchar(15) NOT NULL COMMENT '实例角色，master, slave',
  instance_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '实例状态，100：正常服务，101：服务异常',
  instance_desc varchar(128) NOT NULL COMMENT '实例描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (instance_id),
  INDEX idx_host_id (host_id),
  INDEX idx_grp_id (grp_id),
  UNIQUE INDEX uq_idx_instance_name (instance_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '实例信息表';


CREATE TABLE db_database (
  db_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  instance_id bigint(20) unsigned NOT NULL COMMENT '实例ID，外键',
  db_name varchar(32) NOT NULL COMMENT '数据库名称，G001,G002...',
  db_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '数据库状态，100：已下线，101：在线',
  db_desc varchar(128) NOT NULL COMMENT '数据库描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (db_id),
  INDEX idx_instance_id (instance_id),
  UNIQUE INDEX uq_idx_db_name (db_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库表';


CREATE TABLE db_user (
  dbuser_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  instance_id bigint(20) unsigned NOT NULL COMMENT '实例ID，外键',
  dbuser_name varchar(32) NOT NULL COMMENT '数据库用户名称',
  dbuser_pwd varchar(64) NOT NULL COMMENT '数据库用户密码，加密存储',
  dbuser_type varchar(32) NOT NULL COMMENT 'web|admin|sys|general|readonly|rep|backup|monitor',
  dbuser_privs varchar(512) NOT NULL COMMENT '用户权限，信息',
  dbuser_auth_range varchar(32) NOT NULL COMMENT '用户授权范围',
  dbuser_desc varchar(128) NOT NULL COMMENT '数据库用户描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (dbuser_id),
  UNIQUE INDEX uq_idx_instance_id (instance_id, dbuser_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库用户表';


CREATE TABLE db_database_service (
  db_id bigint(20) unsigned NOT NULL COMMENT '主键id 1',
  service_id bigint(20) unsigned NOT NULL COMMENT '主键id 2',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (db_id, service_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库与服务关联表';