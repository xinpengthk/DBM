
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
  user_realname varchar(32) NOT NULL COMMENT '用户真实姓名',
  user_login_name varchar(32) NOT NULL COMMENT '用户登录名',
  user_pwd varchar(64) NOT NULL COMMENT '用户密码，加密',
  user_role tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为项目leader，1：是，0：否',
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
  menu_priv varchar(32) NOT NULL COMMENT '菜单权限，CRUD...',
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

CREATE TABLE ma_idc (
  idc_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  idc_name varchar(32) NOT NULL COMMENT '机房名称',
  idc_addr varchar(32) NOT NULL COMMENT '机房地址',
  idc_floor varchar(32) NOT NULL COMMENT '机房楼层',
  idc_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '机房状态，100：已上架，101：已下架',
  idc_desc varchar(128) NOT NULL COMMENT '机房描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (idc_id),
  UNIQUE INDEX uq_idx_idc_name (idc_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '机房信息表';

CREATE TABLE ma_cabinet (
  cabinet_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  idc_id bigint(20) unsigned NOT NULL COMMENT '机房id，外键',
  cabinet_name varchar(32) NOT NULL COMMENT '机柜名称',
  cabinet_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '机柜状态，100：已上架，101：已下架，102：已满，103：有空闲',
  cabinet_desc varchar(128) NOT NULL COMMENT '机柜描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (cabinet_id),
  INDEX idx_idc_id (idc_id),
  UNIQUE INDEX uq_idx_cabinet_name (cabinet_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '机柜信息表';


CREATE TABLE ma_manufactory (
  manufactory_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  manufactory_name varchar(32) NOT NULL COMMENT '厂商名称',
  manufactory_support_phone varchar(11) NOT NULL COMMENT '厂商支持电话',
  manufactory_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '厂商状态，100：正常服务，101：服务商倒闭，102：无法联系，103：暂停服务',
  manufactory_desc varchar(128) NOT NULL COMMENT '厂商描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (manufactory_id),
  UNIQUE INDEX uq_idx_manufactory_name (manufactory_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '厂商信息表';

CREATE TABLE ma_software (
  software_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  software_type tinyint NOT NULL COMMENT '软件类型，100：OS，101：办公\开发软件，102：业务软件',
  license_num int NOT NULL COMMENT '授权数',
  soft_version varchar(64) NOT NULL COMMENT '软件/系统版本，eg. CentOS release 6.5 (Final)',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (software_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '软件信息表';

CREATE TABLE ma_contract (
  contract_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  contract_sn varchar(128) NOT NULL COMMENT '合同号',
  contract_name varchar(64) NOT NULL COMMENT '合同名称',
  contract_price decimal(12,2) NOT NULL COMMENT '合同金额（单位：万元）',
  contract_detail text NULL COMMENT '合同详细',
  start_date date NOT NULL COMMENT '合同开始日期',
  end_date date NOT NULL COMMENT '合同结束日期',
  license_num int NULL COMMENT 'license数量, 0表示不适用',
  contract_desc varchar(128) NOT NULL COMMENT '合同描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (contract_id),
  UNIQUE INDEX uq_idx_contract_sn (contract_sn),
  UNIQUE INDEX uq_idx_contract_name (contract_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '合同信息表';

CREATE TABLE ma_asset (
  asset_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  cabinet_id bigint(20) unsigned NOT NULL COMMENT '机柜id，外键',
  contract_id bigint(20) unsigned NOT NULL COMMENT '合同id，外键',
  business_id bigint(20) unsigned NOT NULL COMMENT '所属业务线id，外键',
  asset_admin bigint(20) unsigned NOT NULL COMMENT '资产管理员，用户id，外键',
  manufactory_id bigint(20) unsigned NOT NULL COMMENT '制造商id，外键',
  asset_type varchar(32) NOT NULL COMMENT '资产类型：server-服务器, networkdevice-网络设备, storagedevice-存储设备, securitydevice-安全设备, idcdevice-机房设备, software-软件资产',
  asset_name varchar(32) NOT NULL COMMENT '资产名称',
  asset_sn varchar(128) NOT NULL DEFAULT '0000' COMMENT '资产SN号',
  management_ip varchar(15) NOT NULL DEFAULT '0.0.0.0' COMMENT '管理IP',
  asset_trade_date date NOT NULL DEFAULT '' COMMENT '购买时间',
  asset_expire_date date NOT NULL DEFAULT '' COMMENT '过保时间',
  asset_price decimal(12, 2) NOT NULL DEFAULT 0.0 COMMENT '资产单价(单位：元)',
  asset_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '资产状态，100：已上架，101：已下架',
  asset_desc varchar(128) NOT NULL COMMENT '资产描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id),
  INDEX idx_cabinet_id (cabinet_id),
  INDEX idx_contract_id (contract_id),
  UNIQUE INDEX uq_idx_asset_sn (asset_sn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '资产信息表';

CREATE TABLE ma_network_device (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键id，跟asset表一对一',
  software_id bigint(20) unsigned NOT NULL COMMENT '软件id，外键',
  networkdevice_type tinyint NOT NULL COMMENT '设备类型，100：路由器，101：交换机，102：负载均衡，103：VPN设备',
  vlan_ip varchar(15) NOT NULL COMMENT 'vlan IP',
  intranet_ip varchar(15) NOT NULL COMMENT '内网IP',
  model varchar(128) NOT NULL COMMENT '设备型号',
  port_num int NOT NULL COMMENT '端口个数',
  device_detail text COMMENT '设备详细配置',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id),
  index idx_software_id (software_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '网络设备表';

CREATE TABLE ma_security_device (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键id，跟asset表一对一',
  device_type tinyint NOT NULL COMMENT '设备类型，100：防火墙，101：入侵检测设备，102：互联网网关，103：运维审计系统',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '安全设备表';

CREATE TABLE ma_server (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键id，跟asset表一对一',
  server_type tinyint NOT NULL DEFAULT 100 COMMENT '服务器类型，100：PC服务器，101：刀片机，102：小型机',
  created_by varchar(10) NOT NULL DEFAULT 'auto' COMMENT '创建方式：auto|manual',
  parent_asset_id bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'for vitural server, 0 代表宿主机',
  server_model varchar(128) NOT NULL COMMENT '服务器型号',
  raid_type varchar(512) NOT NULL COMMENT 'raid 类型',
  os_type varchar(64) NOT NULL COMMENT '操作系统类型',
  os_distribution varchar(64) NOT NULL COMMENT '操作系统发型版本',
  os_release varchar(64) NOT NULL COMMENT '操作系统版本',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id),
  index idx_parent_asset_id (parent_asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器信息表';

CREATE TABLE ma_server_user (
  server_user_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  asset_id bigint(20) unsigned NOT NULL COMMENT '外键，asset id',
  server_user_name varchar(64) NOT NULL COMMENT '服务器用户名',
  server_user_pwd varchar(64) NOT NULL COMMENT '服务器密码，md5加密',
  server_user_group varchar(32) NOT NULL COMMENT '所属用户组：super|dbadmin|general|',
  server_user_desc varchar(128) NOT NULL COMMENT '用户描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (server_user_id),
  unique index uq_idx_asset_id_user_name(asset_id, server_user_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器用户信息';

CREATE TABLE ma_server_ip (
  ip_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  asset_id bigint(20) unsigned NOT NULL COMMENT '外键，asset id',
  ip_type varchar(15) NOT NULL COMMENT 'IP 类型：intranet|public|vip',
  vip_status tinyint NOT NULL DEFAULT 1 COMMENT 'vip状态：1-正常服务，0-服务异常',
  ip_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (ip_id),
  index idx_asset_id (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器ip信息';

CREATE TABLE ma_ram (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键，asset id',
  ram_sn varchar(128) NOT NULL COMMENT 'SN号',
  ram_model varchar(128) NOT NULL COMMENT '内存型号',
  ram_slot varchar(64) NOT NULL COMMENT '插槽',
  ram_capacity int NOT NULL COMMENT '内存大小(单位：MB)',
  ram_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器ram组件表';

CREATE TABLE ma_cpu (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键，asset id',
  cpu_model varchar(128) NOT NULL COMMENT 'CPU型号',
  cpu_num int NOT NULL COMMENT '物理cpu个数',
  cpu_core_num int NOT NULL COMMENT 'cpu核数',
  cpu_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器cpu组件表';

CREATE TABLE ma_disk (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键，asset id',
  disk_sn varchar(128) NOT NULL COMMENT 'SN号',
  disk_slot varchar(64) NOT NULL COMMENT '插槽位',
  disk_model varchar(128) NOT NULL COMMENT '磁盘型号',
  disk_capacity decimal(12,2) NOT NULL COMMENT '磁盘容量(GB)',
  iface_type varchar(32) NOT NULL COMMENT '接口类型：SATA|SAS|SCSI|SSD',
  disk_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器DISK组件表';

CREATE TABLE ma_nic (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键，asset id',
  nic_name varchar(32) NOT NULL COMMENT '网卡名',
  nic_sn varchar(128) NOT NULL COMMENT 'SN号',
  nic_mode varchar(128) NOT NULL COMMENT '网卡型号',
  nic_macaddress varchar(17) NOT NULL COMMENT 'MAC地址',
  nic_ipaddress varchar(15)  NOT NULL COMMENT 'IP地址',
  nic_netmask varchar(15)  NOT NULL COMMENT '子网掩码',
  nic_bonding varchar(64)  NOT NULL COMMENT '',
  nic_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器DISK组件表';

CREATE TABLE ma_raid_adaptor (
  asset_id bigint(20) unsigned NOT NULL COMMENT '主键，asset id',
  raid_sn varchar(128) NOT NULL COMMENT 'SN号',
  raid_slot varchar(64) NOT NULL COMMENT '插口',
  raid_model varchar(64) NOT NULL COMMENT '型号',
  raid_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '服务器RAID组件表';

CREATE TABLE ma_asset_approval (
  approval_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，asset id',
  manufactory_id bigint(20) unsigned NOT NULL COMMENT '制造商id，外键',
  asset_sn varchar(128) NOT NULL DEFAULT '0000' COMMENT '资产SN号',
  asset_type varchar(32) NOT NULL COMMENT '资产类型：server-服务器, networkdevice-网络设备, storagedevice-存储设备, securitydevice-安全设备, idcdevice-机房设备, software-软件资产',
  model varchar(128) NOT NULL COMMENT '资产型号',
  ram_size int NOT NULL COMMENT '内存大小，MB',
  cpu_model varchar(128) NOT NULL COMMENT 'CPU型号',
  cpu_num int NOT NULL COMMENT '物理cpu个数',
  cpu_core_num int NOT NULL COMMENT 'cpu核数',
  os_type varchar(64) NOT NULL COMMENT '操作系统类型',
  os_distribution varchar(64) NOT NULL COMMENT '操作系统发型版本',
  os_release varchar(64) NOT NULL COMMENT '操作系统版本',
  asset_data text NULL COMMENT'资产数据',
  report_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '汇报日期',
  approved_stauts tinyint NOT NULL DEFAULT 0 COMMENT '审批状态：1-已批准，0-未批准',
  approved_by bigint(20) unsigned NOT NULL COMMENT '审批人，用户id，外键',
  approved_date datetime NULL COMMENT '批准日期',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (approval_id),
  INDEX idx_manufactory_id (manufactory_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '新资产审核表';

CREATE TABLE ma_eventlog (
  event_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，asset id',
  asset_id bigint(20) unsigned NOT NULL COMMENT '外键，asset id',
  event_name varchar(128) NOT NULL COMMENT '事件名称',
  event_type tinyint NOT NULL DEFAULT 107 COMMENT '时间类型：101-硬件变更，102-新增配件，103-设备下线，104-设备上线，105-定期维护，106-业务上线\更新\变更，107-其它',
  event_component varchar(256) NOT NULL COMMENT '事件子项',
  event_detail text NULL COMMENT '事件详情',
  event_datetime datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT'事件发生时间',
  user_id bigint(20) unsigned NOT NULL COMMENT '事件源，外键，用户 id',
  event_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (event_id),
  INDEX idx_asset_id (asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '事件日志表';


####### 产品相关表
CREATE TABLE prd_business (
  business_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  business_name varchar(32) NOT NULL COMMENT '业务线名称',
  business_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '业务线状态，0：未上线，1：已上线，2：已下线',
  business_desc varchar(128) NOT NULL COMMENT '业务线描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (business_id),
  UNIQUE INDEX uq_idx_prdname (business_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '业务线表';


CREATE TABLE prd_product (
  product_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  business_id bigint(20) unsigned NOT NULL COMMENT '业务线ID，外键',
  product_name varchar(32) NOT NULL COMMENT '产品线名称',
  product_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '产品线状态，0：未上线，1：已上线，2：已下线',
  product_desc varchar(128) NOT NULL COMMENT '产品线描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (product_id),
  UNIQUE INDEX uq_idx_prdname (product_name),
  INDEX idx_business_id (business_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '产品线表';

CREATE TABLE prd_service (
  service_id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  product_id bigint(20) unsigned NOT NULL COMMENT '产品线ID，外键',
  service_name varchar(32) NOT NULL COMMENT '服务名称',
  service_pdm bigint(20) unsigned NOT NULL COMMENT '该服务项目经理id，外键, sys_user',
  service_pjm bigint(20) unsigned NOT NULL COMMENT '该服务产品经理id，外键, sys_user',
  service_dev_ledear bigint(20) unsigned NOT NULL COMMENT '该服务开发ledear id，外键, sys_user',
  service_qa_ledear bigint(20) unsigned NOT NULL COMMENT '该服务测试ledear id，外键, sys_user',
  service_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '服务状态，0：未上线，1：已上线，2：已下线',
  service_desc varchar(128) NOT NULL COMMENT '服务描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (service_id),
  INDEX idx_prdid (product_id),
  INDEX idx_pdm (service_pdm),
  INDEX idx_pjm (service_pdm),
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
  server_id bigint(20) unsigned NOT NULL COMMENT '主机id，外键',
  grp_id bigint(20) unsigned NOT NULL COMMENT '分组ID，外键',
  instance_name varchar(32) NOT NULL COMMENT '实例名称，DB001,DB002...',
  instance_type tinyint(4) NOT NULL DEFAULT '100' COMMENT '实例类型，100：MySQL官方社区版，101：REDIS，102：MONGODB，103：ORACLE',
  bind_ip varchar(15) NOT NULL COMMENT '绑定的内网IP',
  bind_port varchar(15) NOT NULL COMMENT '绑定的端口',
  manage_ip varchar(15) NOT NULL COMMENT '管理IP',
  web_ip varchar(15) NOT NULL COMMENT 'WEB IP',
  instance_role varchar(15) NOT NULL COMMENT '实例角色，master, slave',
  instance_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '实例状态，100：正常服务，101：服务异常',
  instance_desc varchar(128) NOT NULL COMMENT '实例描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (instance_id),
  INDEX idx_server_id (server_id),
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
  dbinst_id bigint(20) unsigned NOT NULL COMMENT '实例ID，外键',
  dbuser_name varchar(32) NOT NULL COMMENT '数据库用户名称',
  dbuser_pwd varchar(64) NOT NULL COMMENT '数据库用户密码，加密存储',
  dbuser_type varchar(32) NOT NULL COMMENT 'web|admin|sys|general|readonly|rep|backup|monitor',
  dbuser_privs varchar(512) NOT NULL COMMENT '用户权限，信息',
  dbuser_ip_range varchar(15) NOT NULL COMMENT '用户授权IP范围',
  dbuser_db_range varchar(64) NOT NULL COMMENT '用户授权数据库范围，多库使用逗号隔开',
  dbuser_desc varchar(128) NOT NULL COMMENT '数据库用户描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (dbuser_id),
  UNIQUE INDEX uq_idx_inst_id_dbname (dbinst_id, dbuser_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库用户表';


CREATE TABLE db_database_service (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  clu_id bigint(20) unsigned NOT NULL COMMENT '集群ID，外键',
  grp_id bigint(20) unsigned NOT NULL COMMENT '分组ID，外键',
  dbinst_id bigint(20) unsigned NOT NULL COMMENT '实例ID，外键',
  db_id bigint(20) unsigned NOT NULL COMMENT '数据库ID，外键',
  service_id bigint(20) unsigned NOT NULL COMMENT '服务ID，外键',
  ds_status tinyint(4) NOT NULL DEFAULT '100' COMMENT '数据库状态，100：已下线，101：在线',
  ds_desc varchar(128) NOT NULL COMMENT '描述',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '数据库与服务关联表';
