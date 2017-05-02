using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1049
{
    public partial class Component : DataModule
    {
        public Component()
        {
            InitializeComponent();
        }

        public Component(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }
        public string getFix()
        {
            return string.Format("FAQ{0:yyMMdd}", DateTime.Now.Date);
        }

        //���u����
        public object[] smRT10491(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10491.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCust WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCustADJDAY WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "" || ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��Τ�D�ɸ�Ƭ��w�@�o�Τw�h���ɡA���i���סC" };
                }

                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["PERIOD"].ToString()) + Convert.ToInt32(ds1.Tables[0].Rows[0]["ADJPERIOD"].ToString()) <0)
                    {
                        return new object[] { 0, "��Τ�D�ɤ����Ƹ�ƻP�վ��Ƥ����Ƭۥ[��G�p��s�̡A�h�����\���סC" };
                    }

                    if (ds1.Tables[0].Rows[0]["ADJCLOSEDAT"].ToString() != "")
                    {
                        return new object[] { 0, "��Τ�w�@�o�ɡA���i���סC" };
                    }
                    if (ds1.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "��Τ�D�ɸ�Ƭ��w�@�o�Τw�h���ɡA���i���סC" };
                    }
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ���ɡA�L�k���סC" };
            }                    
            
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10491.InfoParameters[0].Value = sdata[0];
                cmdRT10491.InfoParameters[1].Value = sdata[1];
                cmdRT10491.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10491.ExecuteNonQuery();
                return new object[] { 0, "�Τ�վ�����Ƹ�Ƶ��צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�վ�����Ƹ�Ƶ��ק@�~,���~�T���G" + ex };
            }
        }

        //���ת���
        public object[] smRT10492(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10492.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCustADJDAY WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            string sqlYY = "select * FROM RTLessorAVSCust WHERE CUSID='" + sdata[0] + "' ";
            string sqlzz = "select count(*) as cnt FROM RTLessorAVSCustADJDAY WHERE CUSID='" + sdata[0] + "' and canceldat is null and adjclosedat is null ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();
            cmd.CommandText = sqlzz;
            DataSet RSzz = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["ADJCLOSEDAT"].ToString() == "") 
                {
                    return new object[] { 0, "��Τ�|�����סA���i�������C" };
                }

                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "��Τ�w�@�o�ɡA���i���ת���C" };
                }

                if (RSYY.Tables[0].Rows.Count > 0)
                {
                    if (RSYY.Tables[0].Rows[0]["CANCELDAT"].ToString() != "" || RSYY.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                    {
                        return new object[] { 0, "��Τ�D�ɸ�Ƭ��w�@�o�Τw�h���ɡA���i���ת���C" };
                    }

                    if (Convert.ToInt32(RSYY.Tables[0].Rows[0]["PERIOD"].ToString()) - Convert.ToInt32(RSXX.Tables[0].Rows[0]["ADJPERIOD"].ToString()) < 0)
                    {
                        return new object[] { 0, "��Τ�D�ɤ����Ƹ�ƻP�վ��Ƥ����Ƭۥ[��G�p��s�̡A�h�����\���ת���C" };
                    }
                }
            }
                      
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10492.InfoParameters[0].Value = sdata[0];
                cmdRT10492.InfoParameters[1].Value = sdata[1];
                cmdRT10492.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10492.ExecuteNonQuery();
                return new object[] { 0, "�Τ�վ�����Ƹ�Ƶ��ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�վ�����Ƹ�Ƶ��ת���@�~,���~�T��" + ex };
            }
        }

        //������u��@�o
        public object[] smRT10493(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10493.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCustADJDAY WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["ADJCLOSEDAT"].ToString() != "" || RSXX.Tables[0].Rows[0]["ADJCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�վ�����Ƹ�Ƥw���סA���i�@�o�C(�Ч�ε��ת���)" };
                }

                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�վ�����Ƹ�Ƥw�@�o�A���i���а���C" };
                }
            }
            
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10493.InfoParameters[0].Value = sdata[0];
                cmdRT10493.InfoParameters[1].Value = sdata[1];
                cmdRT10493.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10493.ExecuteNonQuery();
                return new object[] { 0, "�Τ�վ�����Ƹ�Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�վ�����Ƹ�Ƨ@�o�@�~,���~�T���G" + ex };
            }
        }

        //������u��@�o����
        public object[] smRT10494(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10494.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCustADJDAY WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            string sqlYY = "select count(*) as cnt FROM RTLessorAVSCustADJDAY WHERE CUSID='" + sdata[0] + "' and ENTRYNO >" + sdata[1] + " and canceldat is null ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() == "")
                {
                    return new object[] { 0, "���Τ�վ�����Ƹ�Ʃ|���@�o�A���i����C" };
                }
            }
            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSYY.Tables[0].Rows[0]["cnt"].ToString()) > 0)
                {
                    return new object[] { 0, "�b������Ƥ���w���䥦�վ��Ʀs�b�A�]�����i����@�o����C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10494.InfoParameters[0].Value = sdata[0];
                cmdRT10494.InfoParameters[1].Value = sdata[1];
                cmdRT10494.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10494.ExecuteNonQuery();
                return new object[] { 0, "�Τ�վ�����Ƹ�Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�վ�����Ƹ�Ƨ@�o�@�~,���~�T���G" + ex };
            }
        }
    }
}
