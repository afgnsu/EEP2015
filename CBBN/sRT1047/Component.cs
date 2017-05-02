using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1047
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
        public object[] smRT10471(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10471.Connection;
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
            string sqlyy = "select count(*) as cnt FROM RTLessorAVSCustFaqSndworkFixCode WHERE CUSID='" + sdata[0]+ "' and FAQNO='"+ sdata[1] + "' and prtno='" + sdata[2] + "' ";
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
                cmdRT10471.InfoParameters[0].Value = sdata[0];
                cmdRT10471.InfoParameters[1].Value = sdata[1];
                cmdRT10471.InfoParameters[2].Value = sdata[2];
                cmdRT10471.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10471.ExecuteNonQuery();
                return new object[] { 0, "�Τ���׬��u�槹�u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k������׬��u�槹�u���ק@�~,���~�T��" + ex };
            }
        }

        //�����u����
        public object[] smRT10472(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10472.Connection;
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
                cmdRT10472.InfoParameters[0].Value = sdata[0];
                cmdRT10472.InfoParameters[1].Value = sdata[1];
                cmdRT10472.InfoParameters[2].Value = sdata[2];
                cmdRT10472.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10472.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u�楼���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���������u�楼���u���ק@�~,���~�T��" + ex };
            }
        }

        //���ת���
        public object[] smRT10473(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            string selectSql = "";
            string XXSNDWORK = "";
            string XXSNDUSR = "";
            string XXSNDPRTNO = "";
        //�}�Ҹ�Ƴs��
        IDbConnection conn = cmdRT10473.Connection;
            conn.Open();
            selectSql = "select * FROM RTLessorAvsCUST WHERE CUSID='" + sdata[0] + "' ";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAvsCustFaqH WHERE CUSID='" + sdata[0] + "' and Faqno='" + sdata[1] + "' ";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�Ȥ��Ƥw�@�o�A�L�k����C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ���ɡA�L�k����C" };
            }

            if (ds1.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CALLBACKDAT"].ToString() != "")
                {
                    return new object[] { 0, "�ȪA��w��^�Ф�A���i���欣�u�浲�ת���C" };
                }
                if (ds.Tables[0].Rows[0]["FINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "�ȪA��w���סA���i���欣�u�浲�ת���C" };
                }
                if (ds.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�Ȥ�ȪA���Ƥw�@�o�A���i����C" };
                }
                XXSNDWORK = ds.Tables[0].Rows[0]["SNDWORK"].ToString();  
                XXSNDUSR = ds.Tables[0].Rows[0]["SNDUSR"].ToString(); 
                XXSNDPRTNO = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString(); 
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�ȪA�����ɡA�L�k����C" };
            }

            selectSql = "select * FROM RTLessorAvsCustfaqsndwork WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "' and prtno = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAvsCUSTAR WHERE CUSID='" + sdata[0] + "' AND BATCHNO='" + ds.Tables[0].Rows[0]["BATCHNO"].ToString() + "'";
            cmd.CommandText = selectSql;
            ds1 = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (ds1.Tables[0].Rows[0]["MDAT"].ToString() != "" && Convert.ToInt32(ds1.Tables[0].Rows[0]["REALAMT"].ToString()) > 1)
                    {
                        return new object[] { 0, "�����b�ڤw�R�b�A���i���浲�ת���@�~(�лP��T���sô)�C" };
                    }
                }

                if (ds.Tables[0].Rows[0]["CLOSEDAT"].ToString() == "" && ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����u��|�����סA���i���浲�ת���@�~�C" };
                }
                if (ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����׬��u��w�@�o�A���i����C" };
                }
                if ((XXSNDPRTNO != "" || XXSNDWORK != "") && ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "") 
                {
                    return new object[] { 0, "�����׬��u����ݫȪA��w���ͨ䥦���u��A�]��������榹���u�����@�~�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10473.InfoParameters[0].Value = sdata[0];
                cmdRT10473.InfoParameters[1].Value = sdata[1];
                cmdRT10473.InfoParameters[2].Value = sdata[2];
                cmdRT10473.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10473.ExecuteNonQuery();
                return new object[] { 0, "�Τ���׬��u�浲�ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k������׬��u�槹�u���ת���@�~,���~�T��" + ex };
            }
        }

        //������u��@�o
        public object[] smRT10474(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10474.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCUSTFAQsndwork WHERE CUSID='" + sdata[0] + "' and faqno='" + sdata[1] + "' and prtno='" + sdata[2] + "' ";
            string sqlYY = "select * FROM RTLessorAVSCUSTFAQH WHERE CUSID='" + sdata[0] + "' and faqno='" + sdata[1] + "' ";
            string sqlzz = "select * FROM RTLessorAVSCustRCVHardware WHERE prtno='" + sdata[2] + "' and canceldat is null ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();
            cmd.CommandText = sqlzz;
            DataSet RSzz = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {                
                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSXX.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w���u���סA���i�@�o(���@�o�Х����浲�ת���)" };
                }
                
                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w�@�o�A���i���а���@�o�@�~�C" };
                }
            }
            if (RSYY.Tables[0].Rows.Count > 0)
            {                
                if (RSYY.Tables[0].Rows[0]["CALLBACKDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u����ݫȪA��w����CALLBACK(��^�Ф�)�A���i�@�o���u��(�Х������^��)�C" };
                }
                if (RSYY.Tables[0].Rows[0]["FINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u����ݫȪA��w���סA���i�@�o���u��C" };
                }
            }
            if (RSYY.Tables[0].Rows.Count > 0)
            {
                return new object[] { 0, "�����u��w���ͪ��~��γ�A���i�����@�o(�Х����ફ�~��γ�)�C" };
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10474.InfoParameters[0].Value = sdata[0];
                cmdRT10474.InfoParameters[1].Value = sdata[1];
                cmdRT10474.InfoParameters[2].Value = sdata[2];
                cmdRT10474.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10474.ExecuteNonQuery();
                return new object[] { 0, "�Τ���׬��u��@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���欣�u��@�o�@�~,���~�T���G" + ex };
            }
        }

        //������u��@�o����
        public object[] smRT10475(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10475.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCUSTFAQsndwork WHERE CUSID='" + sdata[0] + "' and faqno='" + sdata[1] + "' and prtno='" + sdata[2] + "' ";
            string sqlYY = "select * FROM RTLessorAVSCUSTFAQH WHERE CUSID='" + sdata[0] + "' and faqno='" + sdata[1] + "' ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����C" };
                }

                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() == "")
                {
                    return new object[] { 0, "���Τᬣ�u��|���@�o�A���i����@�o����@�~�C" };
                }
            }
            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "" || RSXX.Tables[0].Rows[0]["SNDWORK"].ToString() != "")
                {
                    return new object[] { 0, "�����u����ݫȪA��w�t�~���ͬ��u��A�]��������欣�u��@�o����" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10475.InfoParameters[0].Value = sdata[0];
                cmdRT10475.InfoParameters[1].Value = sdata[1];
                cmdRT10475.InfoParameters[2].Value = sdata[2];
                cmdRT10475.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10475.ExecuteNonQuery();
                return new object[] { 0, "�Τ���׬��u��@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τᬣ�u��@�o����@�~,���~�T���G" + ex };
            }
        }

        //�Τ�ȪA���ȪACALLBACK���
        public object[] smRT10476(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10476.Connection;
            conn.Open();

            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i�����ȪA�^�Ф�" };
                }
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w���׮ɡA���i�����ȪACALLBACK���" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "�����ͬ��u��ɡA���i�����ȪACALLBACK���" };
                }

                if (ss1 != "" && ds.Tables[0].Rows[0]["CALLBACKDAT"].ToString() != "")
                {
                    return new object[] { 0, "�w��CALLBACK����ɡA���i���а���" };
                }

                if (ds.Tables[0].Rows[0]["SNDCLOSEDAT"].ToString() == "" && ds.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "")
                {
                    return new object[] { 0, "���u��|�����סA���i�����^�Ф�@�~" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10476.InfoParameters[0].Value = sdata[0];
                cmdRT10476.InfoParameters[1].Value = sdata[1];
                cmdRT10476.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10476.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA���ȪACALLBACK������\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k�����ȪACALLBACK����@�~,���~�T��" + ex };
            }
        }

        //�Τ�ȪA������ȪACALLBACK���
        public object[] smRT10477(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10477.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "��|��callback�ɡA���i����callback���" };
                }

                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w�ȪA�浲�׮ɡA���i��������ȪACALLBACK���(�Х����浲�ת���)" };
                }
            }
            ReleaseConnection(GetClientInfo(ClientInfoType.LoginDB).ToString(), conn);

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10477.InfoParameters[0].Value = sdata[0];
                cmdRT10477.InfoParameters[1].Value = sdata[1];
                cmdRT10477.InfoParameters[2].Value = sdata[2];
                cmdRT10477.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10477.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA������ȪACALLBACK������\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k��������ȪACALLBACK����@�~,���~�T��" + ex };
            }
        }

        //�ȪA����
        public object[] smRT10478(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            string ss1 = "";
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10478.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i����ȪA�浲�סC" };
                }
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "" && ds.Tables[0].Rows[0]["SNDCLOSEDAT"].ToString() == "")
                {
                    return new object[] { 0, "���ȪA��w���סA���i���ư���C" };
                }

                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 != "" && ds.Tables[0].Rows[0]["SNDCLOSEDAT"].ToString()=="")
                {
                    return new object[] { 0, "���ȪA��w�ଣ�u��A���u��ݵ��׫�l�i����ȪA�浲�ק@�~�C" };
                }

                if (ss1 != "" && ds.Tables[0].Rows[0]["SNDCLOSEDAT"].ToString() != "" && ds.Tables[0].Rows[0]["CALLBACKDAT"].ToString() == "")
                {
                    return new object[] { 0, "���ȪA��w�ଣ�u��A�Х��^�ХΤ�T�{�G�٤w�ư��A�����^�Ф��A�l�i����ȪA�浲�ק@�~" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10478.InfoParameters[0].Value = sdata[0];
                cmdRT10478.InfoParameters[1].Value = sdata[1];
                cmdRT10478.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10478.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA�浲�צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȪA�浲�ק@�~,���~�T��" + ex };
            }
        }

        //�ȪA���ת��� 
        public object[] smRT10479(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10479.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] +"'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���ȪA��|�����סA���i����ȪA�浲�ת���C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10479.InfoParameters[0].Value = sdata[0];
                cmdRT10479.InfoParameters[1].Value = sdata[1];
                cmdRT10479.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10479.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA�浲�ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȪA�浲�ת���@�~,���~�T��" + ex };
            }
        }

        //������
        public object[] smRT1047A(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1047A.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i�ଣ�u��" };
                }
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w���׮ɡA���i�ଣ�u��" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w�����u��ɡA���i���а���" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1047A.InfoParameters[0].Value = sdata[0];
                cmdRT1047A.InfoParameters[1].Value = sdata[1];
                cmdRT1047A.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1047A.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA���ଣ�u�榨�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȪA���ଣ�u��@�~,���~�T���G" + ex };
            }
        }
        //�ȪA�@�o
        public object[] smRT1047B(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1047B.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���Τ�ȪA���Ƥw���סA���i�@�o�C(�Ч�ε��ת���)" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���Τ�ȪA���Ƥw�ଣ�u��A���i�@�o�C" };
                }
                ss1 = ds.Tables[0].Rows[0]["CALLBACKDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w��CALLBACK(�^�Ф�)�A���i�@�o�C(�Х������^�Ф�)" };
                }
                ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���Τ�ȪA���Ƥw�@�o�A���i���а���C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1047B.InfoParameters[0].Value = sdata[0];
                cmdRT1047B.InfoParameters[1].Value = sdata[1];
                cmdRT1047B.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1047B.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA���Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�ȪA���Ƨ@�o�@�~,���~�T��" + ex };
            }
        }

        //�h���@�o���� 
        public object[] smRT1047C(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1047C.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" + sdata[0] + "' and FAQNO='" + sdata[1] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���Τ�ȪA���Ʃ|���@�o�A���i����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1047C.InfoParameters[0].Value = sdata[0];
                cmdRT1047C.InfoParameters[1].Value = sdata[1];
                cmdRT1047C.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1047C.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ȪA���Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�ȪA���Ƨ@�o�@�~,���~�T��" + ex };
            }
        }
    }
}
