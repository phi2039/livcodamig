DROP SCHEMA IF EXISTS STAGING;
CREATE SCHEMA STAGING;
DROP SCHEMA IF EXISTS  STAGING_TEMPLATES;
CREATE SCHEMA STAGING_TEMPLATES;

CREATE TABLE STAGING_TEMPLATES.CMPCODE_MAP
(
  CMPCODE_FROM VARCHAR(12)
, CMPCODE_TO VARCHAR(12)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_CMPCODE_MAP_lookup ON STAGING_TEMPLATES.CMPCODE_MAP(CMPCODE_FROM, CMPCODE_TO)
;

CREATE TABLE STAGING_TEMPLATES.EL1_GEN_MAP
(
  EL1_FROM VARCHAR(72)
, EL1_TO VARCHAR(72)
, sourceSheet VARCHAR(250)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL1_GEN_MAP_lookup ON STAGING_TEMPLATES.EL1_GEN_MAP(EL1_FROM, EL1_TO)
;

CREATE TABLE STAGING_TEMPLATES.EL1_PPE_MAP
(
  CMPCODE VARCHAR(12)
, EL1_FROM VARCHAR(72)
, DOCCODE_FROM VARCHAR(72)
, DOCNUM_FROM VARCHAR(72)
, EL1_TO VARCHAR(72)
, DOCCODE_TO VARCHAR(72)
, sourceSheet VARCHAR(250)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL1_PPE_MAP_lookup ON STAGING_TEMPLATES.EL1_PPE_MAP(CMPCODE, EL1_FROM, DOCCODE_FROM, DOCNUM_FROM, EL1_TO, DOCCODE_TO)
;

CREATE TABLE STAGING_TEMPLATES.EL1_BANK_MAP
(
  CMPCODE VARCHAR(12)
, EL1_FROM VARCHAR(72)
, EL1_TO VARCHAR(72)
, CURCODE CHAR(3)
, sourceSheet VARCHAR(250)
, sourceRow BIGINT
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL1_BANK_MAP_lookup ON STAGING_TEMPLATES.EL1_BANK_MAP(CMPCODE, EL1_FROM, EL1_TO)
;

CREATE TABLE STAGING_TEMPLATES.EL3_IC_MAP
(
  CMPCODE VARCHAR(12)
, EL3_FROM VARCHAR(72)
, EL3_TO VARCHAR(72)
, EL4_TO VARCHAR(72)
, sourceSheet VARCHAR(250)
, sourceRow BIGINT
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL3_IC_MAP_lookup ON STAGING_TEMPLATES.EL3_IC_MAP(CMPCODE, EL3_FROM, EL3_TO, EL4_TO)
;

CREATE TABLE STAGING_TEMPLATES.EL3_GEN_MAP
(
  CMPCODE VARCHAR(12)
, EL3_FROM VARCHAR(72)
, EL3_TO VARCHAR(72)
, sourceSheet VARCHAR(250)
, sourceRow BIGINT
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL3_GEN_MAP_lookup ON STAGING_TEMPLATES.EL3_GEN_MAP(CMPCODE, EL3_FROM, EL3_TO)
;

CREATE TABLE STAGING_TEMPLATES.EL4_SOURCE
(
  CODE VARCHAR(72)
, ELMLEVEL INTEGER
, INSTANCES DOUBLE PRECISION
, queryDate TIMESTAMP
)
;CREATE INDEX idx_EL4_SOURCE_lookup ON STAGING_TEMPLATES.EL4_SOURCE(CODE, ELMLEVEL)
;

CREATE TABLE STAGING_TEMPLATES.EL1_MASTER_NEW
(
  EL1 VARCHAR(72)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, TEMPLATE_CMP VARCHAR(12)
, TEMPLATE_ELM VARCHAR(72)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL1_MASTER_NEW_lookup ON STAGING_TEMPLATES.EL1_MASTER_NEW(EL1)
;

CREATE TABLE STAGING_TEMPLATES.EL3_MASTER_NEW
(
  CMPCODE VARCHAR(12)
, EL3 VARCHAR(72)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, TEMPLATE_CMP VARCHAR(12)
, TEMPLATE_ELM VARCHAR(72)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL3_MASTER_NEW_lookup ON STAGING_TEMPLATES.EL3_MASTER_NEW(CMPCODE,EL3)
;

CREATE TABLE STAGING_TEMPLATES.EL4_MASTER_NEW
(
  CMPCODE VARCHAR(12)
, EL4 VARCHAR(72)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, CURCODE VARCHAR(3)
, TEMPLATE_CMP VARCHAR(12)
, TEMPLATE_ELM VARCHAR(72)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_EL4_MASTER_NEW_lookup ON STAGING_TEMPLATES.EL4_MASTER_NEW(CMPCODE,EL4)
;

CREATE TABLE STAGING_TEMPLATES.CMP_MASTER
(
  CMPCODE VARCHAR(12)
, INSTANCE VARCHAR(32)
, CURLOCAL VARCHAR(3)
, CURFUNC VARCHAR(3)
, CURDUAL VARCHAR(3)
, PARENT VARCHAR(12)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_CMP_MASTER_lookup ON STAGING_TEMPLATES.CMP_MASTER(CMPCODE)
;

CREATE TABLE STAGING_TEMPLATES.RATE_MASTER
(
	YR INTEGER
, PERIOD INTEGER
, BASE VARCHAR(3)
, PARENT VARCHAR(3)
, RATE_TYPE VARCHAR(32)
, RATE DOUBLE
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_RATE_MASTER_lookup ON STAGING_TEMPLATES.RATE_MASTER(BASE, PARENT, RATE_TYPE)
;CREATE INDEX idx_RATE_MASTER_lookup2 ON STAGING_TEMPLATES.RATE_MASTER(YR, PERIOD, BASE, PARENT, RATE_TYPE)
;

CREATE TABLE STAGING_TEMPLATES.ACCT_MIG_RULES
(
  ACCT VARCHAR(72)
, SUBLEDGER_RULE VARCHAR(72)
, VASTERA_RULE VARCHAR(72)
, DEFAULT_RULE VARCHAR(72)
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;
-- Configuration --

CREATE TABLE STAGING.ENTITY_STAGING
(
  CODE VARCHAR(12)
, INSTANCE VARCHAR(32)
)
;CREATE INDEX idx_ENTITY_STAGING_lookup ON STAGING.ENTITY_STAGING(CODE)
;

CREATE TABLE STAGING.ELEMENT_STAGING
(
  CODE VARCHAR(72)
, ELMLEVEL INTEGER
, CMPCODE VARCHAR(12)
, SOURCE VARCHAR(32)
)
;CREATE INDEX idx_ELEMENT_STAGING_lookup ON STAGING.ELEMENT_STAGING(CODE, ELMLEVEL, CMPCODE)
;

CREATE TABLE STAGING.ELEMENT_PRE_STAGING
(
  CODE VARCHAR(72)
, ELMLEVEL INTEGER
, CMPCODE VARCHAR(12)
, SOURCE VARCHAR(64)
, INSTANCES INTEGER
)
;CREATE INDEX idx_ELEMENT_PRE_STAGING_lookup ON STAGING.ELEMENT_PRE_STAGING(CODE, ELMLEVEL, CMPCODE)
;

CREATE TABLE STAGING.NEW_ELEMENT_STAGING
(
  CODE VARCHAR(72)
, ELMLEVEL INTEGER
, CMPCODE VARCHAR(12)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, TEMPLATE_CMP VARCHAR(12)
, TEMPLATE_ELM VARCHAR(72)
)
;CREATE INDEX idx_NEW_ELEMENT_STAGING_lookup ON STAGING.NEW_ELEMENT_STAGING(CODE, ELMLEVEL, CMPCODE)
;

CREATE TABLE STAGING.NEW_ELEMENT_PRE_STAGING
(
  CODE VARCHAR(72)
, ELMLEVEL DOUBLE PRECISION
, CMPCODE VARCHAR(12)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, TEMPLATE_CMP VARCHAR(12)
, TEMPLATE_ELM VARCHAR(72)
)
;CREATE INDEX idx_NEW_ELEMENT_PRE_STAGING_lookup ON STAGING.NEW_ELEMENT_PRE_STAGING(CODE, ELMLEVEL, CMPCODE)
;

CREATE TABLE STAGING.NEW_ELEMENT_ERR
(
  CODE VARCHAR(72)
, ELMLEVEL INTEGER
, CMPCODE VARCHAR(12)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, TEMPLATE_CMP VARCHAR(12)
, TEMPLATE_ELM VARCHAR(72)
, errDate TIMESTAMP
, errLevel VARCHAR(16)
, errMessage VARCHAR(1024)
)
;

CREATE TABLE STAGING.ELEMENT_STAGING_ERR
(
  CODE VARCHAR(72)
, ELMLEVEL INTEGER
, CMPCODE VARCHAR(12)
, ERRDATE TIMESTAMP
, errLevel VARCHAR(16)
, errMessage VARCHAR(1024)
)
;CREATE INDEX idx_ELEMENT_STAGING_ERR_lookup ON STAGING.ELEMENT_STAGING_ERR(CODE, ELMLEVEL, CMPCODE)
;

CREATE TABLE STAGING.ENTITY_ERR
(
  CMPCODE_FROM VARCHAR(72)
, CMPCODE_TO VARCHAR(72)
, errMessage VARCHAR(1024)
)
;CREATE INDEX idx_ENTITY_ERR_lookup ON STAGING.ENTITY_ERR(CODE)
;

CREATE TABLE STAGING.ENTITY_MAPPING
(
  CMPCODE_FROM VARCHAR(12)
, CMPCODE_TO VARCHAR(12)
) AS SELECT CMPCODE_FROM,CMPCODE_TO FROM STAGING_TEMPLATES.CMPCODE_MAP
;INSERT INTO STAGING.ENTITY_MAPPING(CMPCODE_FROM,CMPCODE_TO) SELECT CMPCODE_FROM,CMPCODE_TO FROM STAGING_TEMPLATES.CMPCODE_MAP
;CREATE INDEX idx_ENTITY_MAPPING_lookup ON STAGING.ENTITY_MAPPING(CMPCODE_FROM)
;CREATE INDEX idx_ENTITY_MAPPING_lookup2 ON STAGING.ENTITY_MAPPING(CMPCODE_TO)
;

CREATE TABLE STAGING.ELEMENT_MAPPING
(
  CMPCODE_FROM VARCHAR(12)
, CMPCODE_TO VARCHAR(12)
, ELMLEVEL INTEGER
, ELMCODE_FROM VARCHAR(72)
, ELMCODE_TO VARCHAR(72)
, SOURCE VARCHAR(72)
)
;CREATE INDEX idx_ELEMENT_MAPPING_lookup ON STAGING.ELEMENT_MAPPING(CMPCODE_FROM, ELMLEVEL, ELMCODE_FROM)
;


CREATE TABLE STAGING.ELEMENT_MAPPING_ERR
(
  CMPCODE VARCHAR(12)
, ELMLEVEL INTEGER
, ELMCODE_FROM VARCHAR(72)
, ELMCODE_TO VARCHAR(72)
, errDate TIMESTAMP
, errLevel VARCHAR(16)
, errMessage VARCHAR(1024)
)
;

CREATE TABLE STAGING.ELEMENT_PRE_MAPPING
(
  CMPCODE VARCHAR(12)
, ELMLEVEL INTEGER
, ELMCODE_FROM VARCHAR(72)
, ELMCODE_TO VARCHAR(72)
, SOURCE VARCHAR(72)
)
;CREATE INDEX idx_ELEMENT_PRE_MAPPING_lookup ON STAGING.ELEMENT_PRE_MAPPING(CMPCODE, ELMLEVEL, ELMCODE_FROM)
;

CREATE TABLE STAGING.EL4_OVERRIDE
(
  CMPCODE VARCHAR(12)
, EL3_FROM VARCHAR(72)
, EL4_TO VARCHAR(72)
, SOURCE VARCHAR(72)
)
;CREATE INDEX idx_EL4_OVERRIDE_lookup ON STAGING.EL4_OVERRIDE(CMPCODE, EL3_FROM)
;

CREATE TABLE STAGING.UNMAPPED_ELEMENT_ERR
(
  CMPCODE VARCHAR(12)
, ELMLEVEL INTEGER
, CODE VARCHAR(72)
, NAME VARCHAR(72)
, errMessage VARCHAR(1024)
)
;

CREATE TABLE STAGING.MAPPED_BALANCE_CHECK_LOG
(
  CMPCODE_FROM VARCHAR(12)
, ELMLEVEL INTEGER
, ELMCODE_FROM VARCHAR(72)
, CMPCODE_TO VARCHAR(12)
, ELMCODE_TO VARCHAR(72)
)
;

CREATE TABLE STAGING.UNMAPPED_ENTITY_ERR
(
  CMPCODE VARCHAR(12)
, ELMLEVEL INTEGER
, CODE VARCHAR(72)
, NAME VARCHAR(72)
, errMessage VARCHAR(1024)
)
;

CREATE TABLE STAGING.GLOBAL_PRIO
(
  CMPCODE VARCHAR(12)
, PRIORITY INTEGER
, SOURCEFILE VARCHAR(100)
, SOURCEFILESIZE INTEGER
, SOURCEFILEMOD TIMESTAMP
)
;
CREATE INDEX idx_GLOBAL_PRIO_lookup ON STAGING.GLOBAL_PRIO(CMPCODE)
;

CREATE TABLE STAGING.ELEMENT_LOAD_DEF
(
  ELMLEVEL_SRC INTEGER
, CMPCODE_SRC VARCHAR(12)
,	ELMCODE_SRC VARCHAR(72)
, ELMLEVEL_DEST INTEGER
, CMPCODE_DEST VARCHAR(12)
,	ELMCODE_DEST VARCHAR(72)
, CURCODE_DEST CHAR(3)
, NAME_DEST VARCHAR(36)
, SNAME_DEST VARCHAR(20)
)
;CREATE INDEX idx_ELEMENT_LOAD_DEF_DEST ON STAGING.ELEMENT_LOAD_DEF(CMPCODE_DEST,ELMLEVEL_DEST,ELMCODE_DEST,CURCODE_DEST)
;CREATE INDEX idx_ELEMENT_LOAD_DEF_SRC ON STAGING.ELEMENT_LOAD_DEF(CMPCODE_SRC,ELMLEVEL_SRC,ELMCODE_SRC)
;

CREATE TABLE STAGING.ELEMENT_LOAD_DEF_ERR
(
  ELMLEVEL_SRC INTEGER
, CMPCODE_SRC VARCHAR(12)
,	ELMCODE_SRC VARCHAR(72)
, ELMLEVEL_DEST INTEGER
, CMPCODE_DEST VARCHAR(12)
,	ELMCODE_DEST VARCHAR(72)
, CURCODE_DEST CHAR(3)
, NAME_DEST VARCHAR(36)
, SNAME_DEST VARCHAR(20)
, ERRDATE TIMESTAMP DEFAULT SYSDATE
, ERRLEVEL VARCHAR(16)
, ERRMESSAGE VARCHAR(1024)
)
;

-- Partial Balances --

CREATE TABLE STAGING_TEMPLATES.PART_BALANCES
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, CURCODE CHAR(3)
, AMOUNT DECIMAL
)
;CREATE INDEX idx_PART_BALANCES ON STAGING_TEMPLATES.PART_BALANCES(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,CURCODE)
;

-- Balances --

CREATE TABLE STAGING.BALANCE_STAGING
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, SRC_CMPCODE VARCHAR(12)
, SRC_EL1 VARCHAR(72)
, SRC_EL2 VARCHAR(72)
, SRC_EL3 VARCHAR(72)
, SRC_EL4 VARCHAR(72)
, SRC_EL5 VARCHAR(72)
, SRC_EL6 VARCHAR(72)
, SRC_ACCODE VARCHAR(79)
, YR INTEGER
, PERIOD INTEGER
, CURFLAG INTEGER
, CURCODE CHAR(3)
, DEBIT_VALUE DECIMAL
, CREDIT_VALUE DECIMAL
, FULL_VALUE DECIMAL
)
;CREATE INDEX idx_BALANCE_STAGING_lookup ON STAGING.BALANCE_STAGING(CMPCODE, EL1, EL2, EL3, EL4, EL5, EL6, YR, PERIOD, CURCODE)
;

CREATE TABLE STAGING.BALANCE_STAGING_ERR
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, DEST_CMPCODE VARCHAR(12)
, DEST_EL1 VARCHAR(72)
, DEST_EL3 VARCHAR(72)
, DEST_EL4 VARCHAR(72)
, DEST_EL2 VARCHAR(72)
, DEST_EL5 VARCHAR(72)
, DEST_EL6 VARCHAR(72)
, DEST_ACCODE VARCHAR(72)
, YR INTEGER
, PERIOD INTEGER
, CURFLAG INTEGER
, CURCODE CHAR(3)
, DEBIT_VALUE DOUBLE PRECISION
, CREDIT_VALUE DOUBLE PRECISION
, FULL_VALUE DOUBLE PRECISION
, errFields VARCHAR(256)
, errCodes VARCHAR(256)
)
;

CREATE TABLE STAGING.CONSOLIDATED_BALANCES
(
  CMPCODE VARCHAR(12)
, ELMLEVEL INTEGER
, CODE VARCHAR(72)
, YR INTEGER
, PERIOD INTEGER
, CURCODE CHAR(3)
, DEBIT_VALUE DECIMAL
, CREDIT_VALUE DECIMAL
, FULL_VALUE DECIMAL
)
;

CREATE TABLE STAGING.MAPPED_BALANCES
(
  YR INTEGER
, PERIOD INTEGER
, CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, CURCODE CHAR(3)
, DEBIT_VALUE DECIMAL
, CREDIT_VALUE DECIMAL
, FULL_VALUE DECIMAL
)
;
;CREATE INDEX idx_MAPPED_BALANCES_lookup ON STAGING.MAPPED_BALANCES(CMPCODE, EL1, EL2, EL3, EL4, EL5, EL6, YR, PERIOD, CURCODE)
;CREATE INDEX idx_MAPPED_BALANCES_lookup2 ON STAGING.MAPPED_BALANCES(CMPCODE, YR, PERIOD)
;



-- Assets --

CREATE TABLE STAGING_TEMPLATES.ASSET_MASTER
(
  CATG_CODE VARCHAR(12)
, PPA_CATG_CODE VARCHAR(12)
, CATG_NAME VARCHAR(36)
, CATG_SNAME VARCHAR(20)
, CATG_TYPE VARCHAR(32)
, DEPR_RULE VARCHAR(12)
, CATG_ID INTEGER
, WIP_PARTNER VARCHAR(12)
, DEPR_AMORT VARCHAR(4)
, SALEABLE VARCHAR(4)
, sourceSheet VARCHAR(250)
, sourceRow BIGINT
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_ASSET_MASTER_lookup ON STAGING_TEMPLATES.ASSET_MASTER(CATG_CODE)
;

CREATE TABLE STAGING_TEMPLATES.ASSET_MAP
(
  CATG_CODE_FROM VARCHAR(12)
, CATG_CODE_TO VARCHAR(12)
, sourceSheet VARCHAR(250)
, sourceRow BIGINT
, sourceFile VARCHAR(100)
, sourceFileSize INTEGER
, sourceFileMod TIMESTAMP
)
;CREATE INDEX idx_ASSET_MAP_lookup ON STAGING_TEMPLATES.ASSET_MAP(CATG_CODE_FROM)
;

CREATE TABLE STAGING.ASSET_PRE_MAP
(
  CMPCODE_FROM VARCHAR(12)
, CATG_CODE_FROM VARCHAR(12)
, CATG_CODE_TO VARCHAR(12)
, ACCOUNT_TYPE VARCHAR(32)
, ELMCODE_FROM VARCHAR(79)
, ELMCODE_TO VARCHAR(79)
)
;

CREATE TABLE STAGING.ASSET_CATEGORY
(
  CODE VARCHAR(12)
, PPA_CODE VARCHAR(12)
, NAME VARCHAR(36)
, SNAME VARCHAR(20)
, DEPNCODE VARCHAR(12)
, POSTRULECODE VARCHAR(12)
, NUMRULECODE VARCHAR(2)
, DOCCAPNCODE VARCHAR(12)
, DOCDISPCODE VARCHAR(12)
, DOCDEPNCODE VARCHAR(12)
, DOCREVALCODE VARCHAR(12)
, DOCTRANCODE VARCHAR(12)
, DOCRECLASSCODE VARCHAR(12)
, ACCTCAPITAL VARCHAR(79)
, ACCTDEPNACCUM VARCHAR(79)
, ACCTDEPNCHARGE VARCHAR(79)
, DISPPROFACCT VARCHAR(79)
, DISPLOSSACCT VARCHAR(79)
, ACCTOUTOFWIP VARCHAR(79)
, ACCTINTOCAP VARCHAR(79)
, SUSPENSE VARCHAR(79)
, ALTCAPACCSALE VARCHAR(79)
, ALTDEPNACCSALE VARCHAR(79)
, BEGBAL_CAP_ACCT VARCHAR(79)
, BEGBAL_AD_ACCT VARCHAR(79)
, ASSOCCAT VARCHAR(12)
, COSTCENTRELEVEL INTEGER
, ELEMENTLEVEL INTEGER
, WIP INTEGER
)
;CREATE INDEX idx_ASSET_CATEGORY_lookup ON STAGING.ASSET_CATEGORY(CODE)
;

CREATE TABLE STAGING_TEMPLATES.ASSET_PROPS
(
  CATG_CODE VARCHAR(12)
, FIELD_NO INTEGER
, LABEL VARCHAR(32)
, FIELD_TYPE VARCHAR(32)
, USERFIELD_REQ VARCHAR(32)
, MAPUSERFIELD VARCHAR(32)
, ELM_LEVEL INTEGER
)
;CREATE INDEX idx_ASSET_PROPS_lookup ON STAGING_TEMPLATES.ASSET_PROPS(CATG_CODE, LABEL)
;

-- Opening balance migration --

DROP SCHEMA IF EXISTS OPEN_MIG;
CREATE SCHEMA OPEN_MIG;

CREATE TABLE OPEN_MIG.ACCT_BALANCE_SOURCE
(
	CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, RULE VARCHAR(72)
)
;
;CREATE INDEX idx_ACCT_BALANCE_SOURCE_lookup ON OPEN_MIG.ACCT_BALANCE_SOURCE(CMPCODE, EL1)
;

CREATE TABLE OPEN_MIG.ACCT_BALANCE_SOURCE_ERR
(
	CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, RULE VARCHAR(72)
, ERRDATE TIMESTAMP DEFAULT SYSDATE
, ERRLEVEL VARCHAR(16)
, ERRMESSAGE VARCHAR(1024)
)
;

CREATE TABLE OPEN_MIG.STAGED_BALANCES
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, DOC_CURCODE CHAR(3)
, DOC_AMT DECIMAL(100,2)
, LOCAL_CURCODE CHAR(3)
, LOCAL_RATE DOUBLE
, LOCAL_AMT DECIMAL(100,2)
, FUNC_CURCODE CHAR(3)
, FUNC_RATE DOUBLE
, FUNC_AMT DECIMAL(100,2)
, CAD_RATE DOUBLE
, CAD_AMT DECIMAL(100,2)
, SOURCE VARCHAR(32)
)
;CREATE INDEX idx_STAGED_BALANCES ON OPEN_MIG.STAGED_BALANCES(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,DOC_CURCODE)
;CREATE INDEX idx_STAGED_BALANCES2 ON OPEN_MIG.STAGED_BALANCES(CMPCODE,ACCODE,DOC_CURCODE)
;


CREATE TABLE OPEN_MIG.STAGED_BALANCES_PRE_MAPPING
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, DOC_CURCODE CHAR(3)
, DOC_AMT DECIMAL
, LOCAL_CURCODE CHAR(3)
, LOCAL_RATE DOUBLE
, LOCAL_AMT DECIMAL
, FUNC_CURCODE CHAR(3)
, FUNC_RATE DOUBLE
, FUNC_AMT DECIMAL
, CAD_RATE DOUBLE
, CAD_AMT DECIMAL
, SOURCE VARCHAR(32)
)
;CREATE INDEX idx_STAGED_BALANCES_PRE_MAPPING ON OPEN_MIG.STAGED_BALANCES_PRE_MAPPING(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,DOC_CURCODE)
;CREATE INDEX idx_STAGED_BALANCES_PRE_MAPPING2 ON OPEN_MIG.STAGED_BALANCES_PRE_MAPPING(CMPCODE,ACCODE,DOC_CURCODE)
;


CREATE TABLE OPEN_MIG.GL_BALANCES
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, CURCODE CHAR(3)
, AMOUNT DECIMAL
)
;CREATE INDEX idx_GL_BALANCES ON OPEN_MIG.GL_BALANCES(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,CURCODE)
;CREATE INDEX idx_GL_BALANCES2 ON OPEN_MIG.GL_BALANCES(CMPCODE,ACCODE,CURCODE)
;


CREATE TABLE OPEN_MIG.GL_BALANCES_PRE_MAPPING
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, ACCODE VARCHAR(79)
, CURCODE CHAR(3)
, AMOUNT DECIMAL
)
;CREATE INDEX idx_GL_BALANCES_PRE_MAPPING ON OPEN_MIG.GL_BALANCES_PRE_MAPPING(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,CURCODE)
;CREATE INDEX idx_GL_BALANCES_PRE_MAPPING2 ON OPEN_MIG.GL_BALANCES_PRE_MAPPING(CMPCODE,ACCODE,CURCODE)
;


CREATE TABLE OPEN_MIG.SOURCE_BALANCING_AMOUNTS
(
  CMPCODE VARCHAR(12)
, CURCODE VARCHAR(3)
, VAL_TYPE VARCHAR(32)
, AMOUNT DECIMAL
)
;CREATE INDEX idx_SOURCE_BALANCING_AMOUNTS ON OPEN_MIG.SOURCE_BALANCING_AMOUNTS(CMPCODE,CURCODE,VAL_TYPE)
;

CREATE TABLE OPEN_MIG.MANUAL_PARTIAL_BAL_SOURCE
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, DOC_CURCODE CHAR(3)
, DOC_AMOUNT DECIMAL
)
;CREATE INDEX idx_MANUAL_PARTIAL_BAL_SOURCE ON OPEN_MIG.MANUAL_PARTIAL_BAL_SOURCE(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,DOC_CURCODE)
;

CREATE TABLE OPEN_MIG.AUTO_PARTIAL_BAL_SOURCE
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, DOC_CURCODE CHAR(3)
, DOC_AMOUNT DECIMAL
)
;CREATE INDEX idx_AUTO_PARTIAL_BAL_SOURCE ON OPEN_MIG.AUTO_PARTIAL_BAL_SOURCE(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,DOC_CURCODE)
;

CREATE TABLE OPEN_MIG.OPEN_DOC_SOURCE
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, DOC_CURCODE CHAR(3)
, DOC_AMOUNT DECIMAL
)
;CREATE INDEX idx_OPEN_DOC_SOURCE ON OPEN_MIG.OPEN_DOC_SOURCE(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,DOC_CURCODE)
;

CREATE TABLE OPEN_MIG.LOCAL_BALANCE_SOURCE
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, DOC_CURCODE CHAR(3)
, DOC_AMOUNT DECIMAL
)
;CREATE INDEX idx_LOCAL_BALANCE_SOURCE ON OPEN_MIG.LOCAL_BALANCE_SOURCE(CMPCODE,EL1,EL2,EL3,EL4,EL5,EL6,DOC_CURCODE)
;

CREATE TABLE OPEN_MIG.MANUAL_PARTIAL_SOURCE_ERR
(
	CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, RULE VARCHAR(72)
, CAD_BALANCE DECIMAL
, LOAD_CUR VARCHAR(3)
, LOAD_AMT DECIMAL
, ERRDATE TIMESTAMP DEFAULT SYSDATE
, ERRLEVEL VARCHAR(16)
, ERRMESSAGE VARCHAR(1024)
)
;

CREATE TABLE OPEN_MIG.OPENING_BALANCE_ERR
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, CAD_AMT DECIMAL
, CAD_RATE DOUBLE
, CURCODE CHAR(3)
, CURLOCAL VARCHAR(3)
, DOC_AMT DECIMAL
, LOCAL_AMT DECIMAL
, LOCAL_RATE DOUBLE
, FUNC_AMT DECIMAL
, FUNC_RATE DOUBLE
, DEST_CMPCODE VARCHAR(12)
, DEST_EL2 VARCHAR(72)
, DEST_EL5 VARCHAR(72)
, DEST_EL6 VARCHAR(72)
, DEST_EL1 VARCHAR(72)
, DEST_EL3 VARCHAR(72)
, DEST_EL4 VARCHAR(72)
, DEST_ACCODE VARCHAR(79)
, SOURCE VARCHAR(32)
, errFields VARCHAR(256)
, errCodes VARCHAR(256)
)
;

CREATE TABLE OPEN_MIG.GL_BALANCE_ERR
(
  CMPCODE VARCHAR(12)
, EL1 VARCHAR(72)
, EL2 VARCHAR(72)
, EL3 VARCHAR(72)
, EL4 VARCHAR(72)
, EL5 VARCHAR(72)
, EL6 VARCHAR(72)
, CURCODE CHAR(3)
, AMOUNT DECIMAL
, DEST_CMPCODE VARCHAR(12)
, DEST_EL2 VARCHAR(72)
, DEST_EL5 VARCHAR(72)
, DEST_EL6 VARCHAR(72)
, DEST_EL1 VARCHAR(72)
, DEST_EL3 VARCHAR(72)
, DEST_EL4 VARCHAR(72)
, DEST_ACCODE VARCHAR(79)
, errFields VARCHAR(256)
, errCodes VARCHAR(256)
)
;

CREATE SCHEMA IF NOT EXISTS META;
CREATE TABLE IF NOT EXISTS META.SCENARIO
(
  ID VARCHAR(32)
, NAME VARCHAR(128)
)
;

CREATE TABLE IF NOT EXISTS META.VERSION
(
  SCENARIO VARCHAR(32)
, SEQNUMBER INTEGER
, RUNDATE TIMESTAMP DEFAULT SYSDATE
)
;
