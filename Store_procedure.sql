        CREATE
        OR
        REPLACE TYPE TYPE_REDFAMILY_ASSET_ATTR_DTLS AS OBJECT
        (
            ATTRIBUTE_NAME    VARCHAR2(300)
            , ATTRIBUTE_VALUE VARCHAR2(300) )
        /
        CREATE
        OR
        REPLACE TYPE REDFAMILY_ATTRIBUTE_DTLS AS TABLE OF TYPE_REDFAMILY_ASSET_ATTR_DTLS CREATE
        OR
        REPLACE TYPE TYPE_REDFMLY_PROD_FEATURE_DTL AS OBJECT
        (
            FEATURE_NAME    VARCHAR2(300)
            , FEATURE_VALUE VARCHAR2(300) )
        /
        CREATE
        OR
        REPLACE TYPE REDFAMILY_PROD_FEATURE_DTL AS TABLE OF TYPE_REDFMLY_PROD_FEATURE_DTL
        /
        CREATE
        OR
        REPLACE TYPE TYPE_REDFAMILY_ASSET_DTL AS OBJECT
        (
            SIEB_ASSET_ID      VARCHAR2(30)
            , PRODUCT_NAME     VARCHAR2(300)
            , PRODUCT_TYPE     VARCHAR2(100)
            , PRODUCT_SUB_TYPE VARCHAR2(100)
            , PLAN_STATUS      VARCHAR2(30)
            , SIEB_PROD_NAME   VARCHAR2(300)
            , PART_NUMBER      VARCHAR2(100)
            , SIEB_PROD_ID     VARCHAR2(30)
            , BILL_DISC_SOC    VARCHAR2(30)
            , ATTRIBUTE_DETAILS REDFAMILY_ATTRIBUTE_DTLS
            , PROD_FEATURES_DTLS REDFAMILY_PROD_FEATURE_DTL )
        /
        CREATE
        OR
        REPLACE TYPE REDFAMILY_ASSET_DETAIL AS TABLE OF TYPE_REDFAMILY_ASSET_DTL
        /
        CREATE
        OR
        REPLACE TYPE TYPE_REDFAMILY_SR_DETAILS AS OBJECT
        (
            CONSENT_SENT_DT      DATE
            , SR_NUMBER          VARCHAR2(100)
            , SR_CREATION_DT     DATE
            , CONSENT_REQUIRED   VARCHAR2(10)
            , CONSENT_STATUS     VARCHAR2(100)
            , FAMILY_CREATION_DT DATE )
        /
        CREATE
        OR
        REPLACE TYPE REDFAMILY_SR_DETAILS AS TABLE OF TYPE_REDFAMILY_SR_DETAILS
        /
        CREATE
        OR
        REPLACE TYPE TYPE_RED_FAMILY_INFO AS OBJECT
        (
            SIEB_CIRCLE_ID      VARCHAR2(30)
            , MSISDN            VARCHAR2(30)
            , CUST_ACCNT_ID     VARCHAR2(30)
            , SIEB_OU_ID        VARCHAR2(30)
            , DOX_OU_ID         VARCHAR2(30)
            , IS_REDPLUS_FAMILY VARCHAR2(5)
            , SUBSCRIBER_TYPE   VARCHAR2(30)
            , ROW_ID            VARCHAR2(30)
            , ASSET_DETAILS REDFAMILY_ASSET_DETAIL
            , SR_DETAILS REDFAMILY_SR_DETAILS )
        /
        CREATE
        OR
        REPLACE TYPE RED_FAMILY_INFORMATION AS TABLE OF TYPE_RED_FAMILY_INFO
        /
        CREATE
        OR
        REPLACE TYPE TYPE_RED_ASSET_ATTR_DTLS AS OBJECT
        (
            ATTRIBUTE_NAME    VARCHAR2(300)
            , ATTRIBUTE_VALUE VARCHAR2(300) )
        /
        CREATE
        OR
        REPLACE TYPE RED_ASSET_ATTRIBUTE_DTLS AS TABLE OF TYPE_RED_ASSET_ATTR_DTLS
        /
        CREATE
        OR
        REPLACE TYPE TYPE_PRODUCT_FEATURE_DTL AS OBJECT
        (
            FEATURE_NAME    VARCHAR2(300)
            , FEATURE_VALUE VARCHAR2(300) )
        /
        CREATE
        OR
        REPLACE TYPE PRODUCT_FEATURE_DTL AS TABLE OF TYPE_PRODUCT_FEATURE_DTL
        /
        CREATE
        OR
        REPLACE TYPE TYPE_RED_ASSET_DETAIL AS OBJECT
        (
            SIEB_ASSET_ID      VARCHAR2(30)
            , PRODUCT_NAME     VARCHAR2(300)
            , PRODUCT_TYPE     VARCHAR2(100)
            , PRODUCT_SUB_TYPE VARCHAR2(100)
            , PLAN_STATUS      VARCHAR2(30)
            , SIEB_PROD_NAME   VARCHAR2(300)
            , PART_NUMBER      VARCHAR2(100)
            , SIEB_PROD_ID     VARCHAR2(30)
            , BILL_DISC_SOC    VARCHAR2(30)
            , ATTRIBUTE_DETAILS RED_ASSET_ATTRIBUTE_DTLS
            , PROD_FEATURES_DTLS PRODUCT_FEATURE_DTL )
        /
        CREATE
        OR
        REPLACE TYPE RED_ASSET_DETAIL AS TABLE OF TYPE_RED_ASSET_DETAIL
        /
        CREATE
        OR
        REPLACE TYPE TYPE_RED_SR_DETAILS AS OBJECT
        (
            CONSENT_SENT_DT      DATE
            , SR_NUMBER          VARCHAR2(100)
            , SR_CREATION_DT     DATE
            , CONSENT_REQUIRED   VARCHAR2(10)
            , CONSENT_STATUS     VARCHAR2(100)
            , FAMILY_CREATION_DT DATE )
        /
        CREATE
        OR
        REPLACE TYPE RED_SR_DETAILS AS TABLE OF TYPE_RED_SR_DETAILS
        /
        CREATE
        OR
        REPLACE TYPE RED_FAMILY_DETAILS_ASSET AS OBJECT
        (
            SIEB_CIRCLE_ID      VARCHAR2(30)
            , MSISDN            VARCHAR2(30)
            , CUST_ACCNT_ID     VARCHAR2(30)
            , SIEB_OU_ID        VARCHAR2(30)
            , DOX_OU_ID         VARCHAR2(30)
            , IS_REDPLUS_FAMILY VARCHAR2(5)
            , SUBSCRIBER_TYPE   VARCHAR2(30)
            , ROW_ID            VARCHAR2(30)
            , ASSET_DETAILS RED_ASSET_DETAIL
            , SR_DETAILS RED_SR_DETAILS
            , RED_FAMILY_INFO RED_FAMILY_INFORMATION )
        /
        CREATE OR REPLACE PROCEDURE GET_REDFAMILY_DETAILS
                                                         (
                                                             MSISDN    IN VARCHAR2
                                                           , CIRCLE_ID IN VARCHAR2
                                                           , RED_FAMILY_DTL OUT RED_FAMILY_DETAILS_ASSET
                                                           , ERROR_CODE OUT VARCHAR2
                                                           , ERROR_DESC OUT VARCHAR2
                                                         )
        AS
            v_asset_attr TYPE_REDFAMILY_ASSET_ATTR_DTLS;
            v_product_feature TYPE_REDFMLY_PROD_FEATURE_DTL;
            v_attr_details REDFAMILY_ATTRIBUTE_DTLS;
            v_prod_feature_dts REDFAMILY_PROD_FEATURE_DTL;
            v_rf_asset_dtl TYPE_REDFAMILY_ASSET_DTL;
            t_rf_asset_dtls REDFAMILY_ASSET_DETAIL;
            v_sr_dtl TYPE_REDFAMILY_SR_DETAILS;
            t_sr_dtls REDFAMILY_SR_DETAILS;
            v_family_info TYPE_RED_FAMILY_INFO;
            t_family_infos RED_FAMILY_INFORMATION;
            v_red_attr_dtl TYPE_RED_ASSET_ATTR_DTLS;
            t_red_attr_dtls RED_ASSET_ATTRIBUTE_DTLS;
            v_prod_fe_dtl TYPE_PRODUCT_FEATURE_DTL;
            t_prod_fe_dtls PRODUCT_FEATURE_DTL;
            v_asset_dtl TYPE_RED_ASSET_DETAIL;
            t_asset_dtls RED_ASSET_DETAIL;
            v_red_sr_dtl TYPE_RED_SR_DETAILS;
            f_red_sr_dtls RED_SR_DETAILS;
        BEGIN
			DBMS_OUTPUT.ENABLE;
            ERROR_CODE         := '0';
			DBMS_OUTPUT.PUT_LINE('1');
            ERROR_DESC         := 'Success';
			DBMS_OUTPUT.PUT_LINE('2');
            v_asset_attr       := TYPE_REDFAMILY_ASSET_ATTR_DTLS ('ATTRIBUTE_NAME','ATTRIBUTE_VALUE');
			DBMS_OUTPUT.PUT_LINE('3');
            v_product_feature  := TYPE_REDFMLY_PROD_FEATURE_DTL ('FEATURE_NAME', 'FEATURE_VALUE');
			DBMS_OUTPUT.PUT_LINE('4');
            v_attr_details     := REDFAMILY_ATTRIBUTE_DTLS(v_asset_attr,v_asset_attr);
			DBMS_OUTPUT.PUT_LINE('5');
            v_prod_feature_dts := REDFAMILY_PROD_FEATURE_DTL(v_product_feature,v_product_feature);
			DBMS_OUTPUT.PUT_LINE('6');
            v_rf_asset_dtl     := TYPE_REDFAMILY_ASSET_DTL ( 'SIEB_ASSET_ID', 'PRODUCT_NAME', 'PRODUCT_TYPE', 'PRODUCT_SUB_TYPE', 'PLAN_STATUS', 'SIEB_PROD_NAME', 'PART_NUMBER', 'SIEB_PROD_ID', 'BILL_DISC_SOC', v_attr_details, v_prod_feature_dts );
            DBMS_OUTPUT.PUT_LINE('7');
			t_rf_asset_dtls    := REDFAMILY_ASSET_DETAIL(v_rf_asset_dtl,v_rf_asset_dtl);
            DBMS_OUTPUT.PUT_LINE('8');
			v_sr_dtl           := TYPE_REDFAMILY_SR_DETAILS ( sysdate , 'SR_NUMBER' , sysdate , 'YES' , 'CONSENT_STATUS', sysdate );
            DBMS_OUTPUT.PUT_LINE('9');
			t_sr_dtls          := REDFAMILY_SR_DETAILS(v_sr_dtl,v_sr_dtl);
            DBMS_OUTPUT.PUT_LINE('10');
			v_family_info      := TYPE_RED_FAMILY_INFO ( 'SIEB_CIRCLE_ID', 'MSISDN', 'CUST_ACCNT_ID', 'SIEB_OU_ID', 'DOX_OU_ID', 'YES', 'SUBSCRIBER_TYPE', 'ROW_ID', t_rf_asset_dtls, t_sr_dtls );
            DBMS_OUTPUT.PUT_LINE('11');
			t_family_infos     := RED_FAMILY_INFORMATION(v_family_info,v_family_info);
            DBMS_OUTPUT.PUT_LINE('12');
			v_red_attr_dtl     := TYPE_RED_ASSET_ATTR_DTLS ('ATTRIBUTE_NAME','ATTRIBUTE_VALUE');
            DBMS_OUTPUT.PUT_LINE('13');
			t_red_attr_dtls    := RED_ASSET_ATTRIBUTE_DTLS(v_red_attr_dtl,v_red_attr_dtl);
            DBMS_OUTPUT.PUT_LINE('14');
			v_prod_fe_dtl      := TYPE_PRODUCT_FEATURE_DTL ('FEATURE_NAME','FEATURE_VALUE');
            DBMS_OUTPUT.PUT_LINE('15');
			t_prod_fe_dtls     := PRODUCT_FEATURE_DTL(v_prod_fe_dtl,v_prod_fe_dtl);
            DBMS_OUTPUT.PUT_LINE('16');
			v_asset_dtl        := TYPE_RED_ASSET_DETAIL ( 'SIEB_ASSET_ID', 'PRODUCT_NAME', 'PRODUCT_TYPE', 'PRODUCT_SUB_TYPE', 'PLAN_STATUS', 'SIEB_PROD_NAME' , 'PART_NUMBER', 'SIEB_PROD_ID', 'BILL_DISC_SOC', t_red_attr_dtls, t_prod_fe_dtls );
            DBMS_OUTPUT.PUT_LINE('17');
			t_asset_dtls       := RED_ASSET_DETAIL(v_asset_dtl,v_asset_dtl);
            DBMS_OUTPUT.PUT_LINE('18');
			v_red_sr_dtl       := TYPE_RED_SR_DETAILS ( sysdate, 'SR_NUMBER' , sysdate , 'YES' , 'CONSENT_STATUS', sysdate );
            DBMS_OUTPUT.PUT_LINE('19');
			f_red_sr_dtls      := RED_SR_DETAILS(v_red_sr_dtl,v_red_sr_dtl);
            DBMS_OUTPUT.PUT_LINE('20');
			RED_FAMILY_DTL     := RED_FAMILY_DETAILS_ASSET ( 'SIEB_CIRCLE_ID', 'MSISDN', 'CUST_ACCNT_ID', 'SIEB_OU_ID', 'DOX_OU_ID', 'YES', 'SUBSCRIBER_TYPE', 'ROW_ID', t_asset_dtls , f_red_sr_dtls, t_family_infos );
			DBMS_OUTPUT.PUT_LINE('21');
		END GET_REDFAMILY_DETAILS;
        /