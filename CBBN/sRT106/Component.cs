using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT106
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
            return string.Format("ET{0:yyMMdd}", DateTime.Now.Date);
        }

        //���u����
        public object[] smRT1061(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1061.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUST WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCustFAQH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCUSTFaqsndwork WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "' and prtno = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds2 = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�Ȥ�w�@�o�A�L�k����(���u�楲���@�o)�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ���ɡA�L�k���סC" };
            }

            if (ds1.Tables[0].Rows.Count > 0)
            {
                if (ds1.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����׬��u����ݫȪA���Ƥw�@�o�A���i���槹�u���ק@�~" };
                }
                if (ds1.Tables[0].Rows[0]["SNDCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����׬��u����ݫȪA��w�����u�浲�פ�A�гs����T��" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣�즹���׬��u����ݫȪA����" };
            }

            //�P�_�O�_����γ楼��
            selectSql = "select count(*) as CNT FROM RTLessorAVSCustFAQHardware WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "' and prtno = '" + sdata[2] + "' and dropdat is null and rcvfinishdat is null ";
            cmd.CommandText = selectSql;
            ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "�����׬��u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{��(����Ωλ�Υ�����)�A���i���槹�u���ק@�~�C" };
                }
            }

            string sqlxx = "select * FROM RTLessorAVSCustFAQsndwork WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "' and prtno='" + sdata[2] + "' ";
            string sqlyy = "select count(*) as cnt FROM RTLessorAVSCustFaqSndworkFixCode WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "' and prtno='" + sdata[2] + "' ";
            cmd.CommandText = sqlxx;
            ds = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            ds1 = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u����" };
                }
                if (ds.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" && ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����׬��u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }
                if (ds.Tables[0].Rows[0]["REALENGINEER"].ToString() == "" && ds.Tables[0].Rows[0]["REALCONSIGNEE"].ToString() == "")
                {
                    return new object[] { 0, "�����׬��u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P�ӡC" };
                }
                if (ds.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "" && ds.Tables[0].Rows[0]["STOCKCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "�����׬��u��w�뵲�A���i���ʡC" };
                }
                if (ds.Tables[0].Rows[0]["BATCHNO"].ToString() != "")
                {
                    return new object[] { 0, "�����׬��u��w���������b�ڡA�L�k���Ƶ��סA�гs����T��" };
                }
                if (ds.Tables[0].Rows[0]["MEMO"].ToString() == "" && Convert.ToInt32(ds1.Tables[0].Rows[0]["cnt"].ToString()) < 1)
                {
                    return new object[] { 0, "���׬��u�浲�׮ɡA������J���׳B�z�L�{�����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1061.InfoParameters[0].Value = sdata[0];
                cmdRT1061.InfoParameters[1].Value = sdata[1];
                cmdRT1061.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1061.ExecuteNonQuery();
                return new object[] { 0, "�Τ���׬��u�槹�u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k������׬��u�槹�u���ק@�~,���~�T��" + ex };
            }
        }

        //�����u����
        public object[] smRT1062(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1062.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqsndwork WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "' and prtno = '" + sdata[2] + "'";
            string ss2 = "";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["DROPDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u����" };
                }
                ss1 = ds.Tables[0].Rows[0]["CLOSEDAT"].ToString();
                ss2 = ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString();
                if (ss1 != "" || ss2 != "")
                {
                    return new object[] { 0, "��������u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }
                ss1 = ds.Tables[0].Rows[0]["BATCHNO"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��������u��w���������b�ڡA�L�k���Ƶ��סA�гs����T���C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1062.InfoParameters[0].Value = sdata[0];
                cmdRT1062.InfoParameters[1].Value = sdata[1];
                cmdRT1062.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1062.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u�楼���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���������u�楼���u���ק@�~,���~�T��" + ex };
            }
        }
            
        //�@�o
        public object[] smRT1063(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1063.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtyContract WHERE comq1=" + sdata[0] + " and CONTRACTNO='" + sdata[1] + "' ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����ϦX����Ƥw���סA���i�@�o�C(�Ч�ε��ת���)" };
                }

                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����ϦX����Ƥw�@�o�A���i���а���C" };
                }
            }
            
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1063.InfoParameters[0].Value = sdata[0];
                cmdRT1063.InfoParameters[1].Value = sdata[1];
                cmdRT1063.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1063.ExecuteNonQuery();
                return new object[] { 0, "���ϦX����Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k������ϦX����Ƨ@�o�@�~,���~�T���G" + ex };
            }
        }

        //������u��@�o����
        public object[] smRT1064(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1064.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtyContract WHERE comq1=" + sdata[0] + " and CONTRACTNO='" + sdata[1] + "' ";
            string sqlYY = "select count(*) as cnt FROM RTLessorAVSCmtyContract WHERE  COMQ1=" + sdata[0] + " and canceldat is null ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����ϦX����Ʃ|���@�o�A���i����C" };
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
                cmdRT1064.InfoParameters[0].Value = sdata[0];
                cmdRT1064.InfoParameters[1].Value = sdata[1];
                cmdRT1064.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1064.ExecuteNonQuery();
                return new object[] { 0, "���ϦX����Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�����Ϥw���䥦���Ī��X����Ʀs�b�A���i�@�o����G" + ex };
            }
        }    
    }
}
