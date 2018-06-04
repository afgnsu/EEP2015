using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1045
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
            return string.Format("EM{0:yyMMdd}", DateTime.Now.Date);
        }

        //���u����
        public object[] smRT10451(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10451.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCustdropsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno = '"+ sdata[2] + "'";
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
                ss1 = ds.Tables[0].Rows[0]["REALENGINEER"].ToString();
                ss2 = ds.Tables[0].Rows[0]["REALCONSIGNEE"].ToString();
                if (ss1 == "" && ss2 == "")
                {
                    return new object[] { 0, "��������u�槹�u�ɡA��������J��ک���H���ι�ک���g�P�ӡC" };
                }
                ss1 = ds.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString();
                ss2 = ds.Tables[0].Rows[0]["STOCKCLOSEYM"].ToString();
                if (ss1 != "" || ss2 != "")
                {
                    return new object[] { 0, "��������u��w�뵲�A���i���ʡC" };
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
                cmdRT10451.InfoParameters[0].Value = sdata[0];
                cmdRT10451.InfoParameters[1].Value = sdata[1];
                cmdRT10451.InfoParameters[2].Value = sdata[2];
                cmdRT10451.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10451.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u�槹�u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���������u�槹�u���ק@�~,���~�T��" + ex };
            }
        }
        
        //�����u����
        public object[] smRT10452(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10452.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCustdropsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
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
                cmdRT10452.InfoParameters[0].Value = sdata[0];
                cmdRT10452.InfoParameters[1].Value = sdata[1];
                cmdRT10452.InfoParameters[2].Value = sdata[2];
                cmdRT10452.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10452.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u�楼���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���������u�楼���u���ק@�~,���~�T��" + ex };
            }
        }

        //���ת���
        public object[] smRT10453(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10453.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCustDROPsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            string ss2 = "";
            string ss1 = "";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ss1 = ds.Tables[0].Rows[0]["CLOSEDAT"].ToString();
                ss2 = ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString();
                if (ss1 == "" && ss2 == "")
                {
                    return new object[] { 0, "��������u��|�����סA���i���浲�ת���@�~�C" };
                }
                ss1 = ds.Tables[0].Rows[0]["DROPDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��������u��w�@�o�A���i����C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10453.InfoParameters[0].Value = sdata[0];
                cmdRT10453.InfoParameters[1].Value = sdata[1];
                cmdRT10453.InfoParameters[2].Value = sdata[2];
                cmdRT10453.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10453.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u�浲�ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���������u�槹�u���ק@�~,���~�T��" + ex };
            }
        }

        //������u��@�o
        public object[] smRT10454(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10454.Connection;
            conn.Open();
            string ss2 = "";
            string ss1 = "";
            string selectSql = "select * FROM RTLessorAVSCustDROPsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ss1 = ds.Tables[0].Rows[0]["CLOSEDAT"].ToString();
                ss2 = ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString();
                if (ss1 != "" || ss2 != "")
                {
                    return new object[] { 0, "��������u��w���u���סA���i�@�o(���@�o�Х����浲�ת���)" };
                }
                ss1 = ds.Tables[0].Rows[0]["DROPDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��������u��w�@�o�A���i���а���@�o�@�~�C" };
                }
            }
            if (ds1.Tables[0].Rows.Count > 0)
            {
                ss1 = ds1.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��������u����ݰh����Ƥw���סA���i�@�o���u��C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10454.InfoParameters[0].Value = sdata[0];
                cmdRT10454.InfoParameters[1].Value = sdata[1];
                cmdRT10454.InfoParameters[2].Value = sdata[2];
                cmdRT10454.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10454.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u��@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���������u��@�o�@�~,���~�T���G" + ex };
            }
        }

        //������u��@�o����
        public object[] smRT10455(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10455.Connection;
            conn.Open();
            string ss2 = "";
            string ss1 = "";
            string selectSql = "select * FROM RTLessorAVSCustDROPsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();
            selectSql = "select MAX(prtno) AS XXPRTNO FROM RTLessorAVSCUSTDROPsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds2 = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ss1 = ds.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����C" };
                }
                ss1 = ds.Tables[0].Rows[0]["DROPDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���Τ������u��|���@�o�A���i����@�o����@�~" };
                }
            }
            if (ds1.Tables[0].Rows.Count > 0)
            {
                ss1 = ds1.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                ss2 = ds1.Tables[0].Rows[0]["SNDWORK"].ToString();
                if (ss1 != "" || ss2 != "")
                {
                    return new object[] { 0, "��������u����ݰh����Ƥw�t�~���ͩ�����u��A�]��������欣�u��@�o����C" };
                }
            }

            if (ds2.Tables[0].Rows.Count > 0)
            {
                ss1 = ds2.Tables[0].Rows[0]["XXPRTNO"].ToString();
                if (ss1.CompareTo(sdata[2]) > 0)
                {
                    return new object[] { 0, "���䥦������u��s�b��(�B����渹�j�󥻳�渹�A�h�����\�@�o����) �C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10455.InfoParameters[0].Value = sdata[0];
                cmdRT10455.InfoParameters[1].Value = sdata[1];
                cmdRT10455.InfoParameters[2].Value = sdata[2];
                cmdRT10455.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10455.ExecuteNonQuery();
                return new object[] { 0, "�Τ������u��@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ������u��@�o����@�~, ���~�T���G" + ex };
            }
        }

        //�h������
        public object[] smRT10456(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10456.Connection;
            conn.Open();
            
            string selectSql = "select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCUST WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��h����w�@�o�ɡA���i����!!" };
                }
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w�h���浲�׮ɡA���i���ư���" };
                }
                /*
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���h����|���������u��A���u��ݵ��׫�l�i����h���浲�ק@�~" };
                }
                
                if (ss1 != "" && ds.Tables[0].Rows[0]["SNDWORKCLOSE"].ToString() == "")
                {
                    return new object[] { 0, "���h���椧������u��|�����סA���i����h���浲�ק@�~" };
                }*/

                if (ds1.Tables[0].Rows[0]["batchno"].ToString() == "" && ds.Tables[0].Rows[0]["DROPKIND"].ToString() == "02")
                {
                    return new object[] { 0, "���Ȥᤧ�D�ɤ��õL�����b�ڽs����ơA�L�k����h���浲�ק@�~�C(���p����T��)" };
                }
            }
            
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10456.InfoParameters[0].Value = sdata[0];
                cmdRT10456.InfoParameters[1].Value = sdata[1];
                cmdRT10456.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10456.ExecuteNonQuery();
                return new object[] { 0, "�Τ�h���浲�צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����h���浲�ק@�~,���~�T��" + ex };
            }
        }

        //�h�����ת���
        public object[] smRT10457(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10457.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCUST WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();
            String batchno = ds.Tables[0].Rows[0]["batchno"].ToString();
            if (batchno == "")
            {

            }
            else
            {
                selectSql = "select * FROM RTLessorAVSCUSTAR WHERE CUSID='" + sdata[0] + "' AND batchno='" + batchno + "'";
                cmd.CommandText = selectSql;
                DataSet ds2 = cmd.ExecuteDataSet();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                    if (ss1 == "")
                    {
                        return new object[] { 0, "���h����|�����סA���i���浲�ת���" };
                    }
                }
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    string ss1 = ds1.Tables[0].Rows[0]["dropdat"].ToString();
                    if (ss1 == "")
                    {
                        return new object[] { 0, "���Ȥ�ثe�ëD�h�����A�A���i����h�����ת���" };
                    }
                }
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    string ss1 = ds2.Tables[0].Rows[0]["mdat"].ToString();
                    if (ss1 != "" && ds2.Tables[0].Rows[0]["realamt"].ToString() != "0")
                    {
                        return new object[] { 0, "���h���椧�����b�ڤw�R�b�A���i���浲�ת���@�~" };
                    }
                }
            }
            ReleaseConnection(GetClientInfo(ClientInfoType.LoginDB).ToString(), conn);

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10457.InfoParameters[0].Value = sdata[0];
                cmdRT10457.InfoParameters[1].Value = sdata[1];
                cmdRT10457.InfoParameters[2].Value = sdata[2];
                
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10457.ExecuteNonQuery();
                return new object[] { 0, "�h�����ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�h�����ת���@�~,���~�T��" + ex };
            }
        }

        //�h���@�o
        public object[] smRT10458(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10458.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���Τ�h�����Ƥw���סA���i�@�o�C(�Ч�ε��ת���)" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                /*
                if (ss1 != "")
                {
                    return new object[] { 0, "�Τ�h�����Ƥw�ଣ�u��A���i�@�o�C" };
                }
                */
                ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���Τ�h�����Ƥw�@�o�A���i���а���C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10458.InfoParameters[0].Value = sdata[0];
                cmdRT10458.InfoParameters[1].Value = sdata[1];
                cmdRT10458.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10458.ExecuteNonQuery();
                return new object[] { 0, "�Τ�h�����Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�h�����Ƨ@�o�@�~,���~�T��" + ex };
            }
        }

        //�h���@�o���� 
        public object[] smRT10459(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10459.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select max(entryno) as XXENTRYNO FROM RTLessorAVSCustDrop WHERE  CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���Τ�h�����Ƥw�@�o�A���i���а���C" };
                }
            }

            if (ds1.Tables[0].Rows.Count > 0)
            {
                int ss1 = Convert.ToInt32(ds1.Tables[0].Rows[0]["XXENTRYNO"].ToString());
                if (ss1 > Convert.ToInt32(sdata[1]))
                {
                    return new object[] { 0, "���䥦�h����s�b��(�B�h�������j�󥻳涵���A�h�����\�@�o����)�C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10459.InfoParameters[0].Value = sdata[0];
                cmdRT10459.InfoParameters[1].Value = sdata[1];
                cmdRT10459.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10459.ExecuteNonQuery();
                return new object[] { 0, "�Τ�h�����Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0,"�L�k����Τ�h�����Ƨ@�o�@�~,���~�T��" +  ex };
            }
        }

        //������
        public object[] smRT1045A(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1045A.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUSTDrop WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0) {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��h����w�@�o�ɡA���i�ଣ�u��" };
                }
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w�h���浲�׮ɡA���i�ଣ�u��" };
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
                cmdRT1045A.InfoParameters[0].Value = sdata[0];
                cmdRT1045A.InfoParameters[1].Value = sdata[1];
                cmdRT1045A.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1045A.ExecuteNonQuery();
                return new object[] { 0, "�Τ�h�����ଣ�u�榨�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�Τ�h�����ଣ�u�楢�ѡA���~�T���G" + ex };
            }
            
        }
    }
}
