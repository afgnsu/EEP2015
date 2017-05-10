using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT203
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
            return string.Format("EL{0:yyMMdd}", DateTime.Now.Date);
        }

        //���u����
        public object[] smRT2031(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            var xxadslapplydat = "";
            var xxCONTAPPLYDAT = "";
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2031.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCmtyline WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                xxadslapplydat = ds.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString();
                xxCONTAPPLYDAT = ds.Tables[0].Rows[0]["DROPDAT"].ToString();
                if (ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "" || ds.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�D�u�w�h���Χ@�o�A�L�k����(���u�楲���@�o)�C" };
                }                
            }
            else
            {
                return new object[] { 0, "�䤣��D�u���ɡA�L�k���סC" };
            }

            selectSql = " select count(*) as CNT FROM RTLessorAVScmtylineHardware "
                      + " WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "' and dropdat is null and rcvfinishdat is null ";
            cmd.CommandText = selectSql;
            ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "���D�u���u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{�ǡA���i���槹�u���ק@�~�C" };
                }
            }

            selectSql = " select * FROM RTLessorAVSCmtylineSndwork "
                      + " WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "' ";
            cmd.CommandText = selectSql;
            ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u���סC" };
                }
                if (ds.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���D�u���u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }
                if (ds.Tables[0].Rows[0]["REALENGINEER"].ToString() == "" && ds.Tables[0].Rows[0]["REALCONSIGNEE"].ToString() == "")
                {
                    return new object[] { 0, "���D�u���u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P�ӡC" };
                }
                if ((ds.Tables[0].Rows[0]["EQUIPSETUPDAT"].ToString() == "" || ds.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() == "") && ds.Tables[0].Rows[0]["SNDKIND"].ToString() == "ST")
                {
                    return new object[] { 0, "�зǤu�{���׮ɡA�]�Ʀw�˨���ΥD�u���q�餣�i�ťաC" };
                }
                if ((ds.Tables[0].Rows[0]["EQUIPSETUPDAT"].ToString() != "" || ds.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() != "") && ds.Tables[0].Rows[0]["SNDKIND"].ToString() != "ST")
                {
                    return new object[] { 0, "�D�зǤu�{���׮ɡA�]�Ʀw�˨���ΥD�u���q�饲���ťաC" };
                }
                if ((xxadslapplydat != "" || xxCONTAPPLYDAT != "") && ds.Tables[0].Rows[0]["SNDKIND"].ToString() == "ST")
                {
                    return new object[] { 0, "���D�u�w���q�A���i�A��[�D�u���q]�����u��C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2031.InfoParameters[0].Value = sdata[0];
                cmdRT2031.InfoParameters[1].Value = sdata[1];
                cmdRT2031.InfoParameters[2].Value = sdata[2];
                cmdRT2031.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2031.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u�槹�u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u�槹�u���ק@�~,���~�T��" + ex };
            }
        }

        //�����u����
        public object[] smRT2032(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2032.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCmtylinesndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "'";            
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["DROPDAT"].ToString();
                string ss2 = "";
                if (ss1 != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u����" };
                }
                ss1 = ds.Tables[0].Rows[0]["CLOSEDAT"].ToString();
                ss2 = ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString();
                if (ss1 != "" || ss2 != "")
                {
                    return new object[] { 0, "���D�u���u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }                
            }

            selectSql = "select count(*) as cnt FROM RTLessorAVSCmtylinehardware WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "' and dropdat is null and RCVPRTNO <> '' ";
            cmd.CommandText = selectSql;
            ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["cnt"].ToString()) > 0)
                {
                    return new object[] { 0, "���D�u���u��w���ͪ��~��γ�A�Х������γ�~����楼���u���ק@�~�C" };
                }
            }
            try
            {
                cmdRT2032.InfoParameters[0].Value = sdata[0];
                cmdRT2032.InfoParameters[1].Value = sdata[1];
                cmdRT2032.InfoParameters[2].Value = sdata[2];
                cmdRT2032.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2032.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u�楼���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u�楼���u���ק@�~,���~�T��" + ex };
            }
        }

        //���ת���
        public object[] smRT2033(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2033.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtylinesndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            string sqlYY = "select * FROM RTLessorAVSCMTYLINE WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1];
            string sqlZZ = "select COUNT(*) AS CNT FROM RTLessorAVSCUST WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND canceldat is null and dropdat is null and finishdat is not null ";
            cmd.CommandText = sqlxx;
            DataSet RSxx = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();
            cmd.CommandText = sqlZZ;
            DataSet RSzz = cmd.ExecuteDataSet();

            if (RSxx.Tables[0].Rows.Count > 0)
            {
                if (RSxx.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "���D�u���u��w�@�o�A���i���浲�ת���@�~�C" };
                }

                if (RSxx.Tables[0].Rows[0]["CLOSEDAT"].ToString() == "" && RSxx.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() == "")
                {
                    return new object[] { 0, "���D�u���u��|�����סA���i���浲�ת���@�~�C" };
                }


            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSxx.Tables[0].Rows[0]["SNDKIND"].ToString() == "ST" && RSYY.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() == ""  && RSYY.Tables[0].Rows[0]["CONTAPPLYDAT"].ToString() == "" )
                {
                    return new object[] { 0, "�D�u�ɥثe�����A�ëD[�w���q]�A�����u�������[�зǤu�{]������A�]���L�k����C" };
                }
            }
            else
            {
                return new object[] { 0, "�L�k��즹�D�u���u�椧�D�ɸ�ơA�нT�{AVS-City�D�u�D�ɸ�ƥ��`�C" };
            }

            if (RSzz.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSzz.Tables[0].Rows[0]["CNT"].ToString()) > 0 && RSxx.Tables[0].Rows[0]["SNDKIND"].ToString() == "ST")
                {
                    return new object[] { 0, "�����u����ݥD�u�w���w���u���Τ�A�]���������[�зǤu�{]����@�~�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2033.InfoParameters[0].Value = sdata[0];
                cmdRT2033.InfoParameters[1].Value = sdata[1];
                cmdRT2033.InfoParameters[2].Value = sdata[2];
                cmdRT2033.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2033.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u�槹�u/�����u���ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u�槹�u���ת���@�~,���~�T��" + ex };
            }
        }

        //�@�o
        public object[] smRT2034(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2034.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtylinesndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            string sqlYY = "select * FROM RTLessorAVSCustRCVHardware WHERE prtno='" + sdata[2] + "' and canceldat is null ";
            cmd.CommandText = sqlxx;
            DataSet RSxx = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSxx.Tables[0].Rows.Count > 0)
            {
                if (RSxx.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSxx.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w���u���סA���i�@�o(���@�o�Х��M���˾����u��)�C" };
                }

                if (RSxx.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w�@�o�A���i���а���@�o�@�~�C" };
                }
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                return new object[] { 0, "�����u��w���ͪ��~��γ�A���i�����@�o(�Х����ફ�~��γ�)�C" };
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2034.InfoParameters[0].Value = sdata[0];
                cmdRT2034.InfoParameters[1].Value = sdata[1];
                cmdRT2034.InfoParameters[2].Value = sdata[2];
                cmdRT2034.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2034.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u��@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u��@�o�@�~,���~�T���G" + ex };
            }
        }

        //������u��@�o����
        public object[] smRT2035(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2035.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVScmtylinesndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            cmd.CommandText = sqlxx;
            DataSet RSxx = cmd.ExecuteDataSet();

            if (RSxx.Tables[0].Rows.Count > 0)
            {
                if (RSxx.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����C" };
                }

                if (RSxx.Tables[0].Rows[0]["DROPDAT"].ToString() == "")
                {
                    return new object[] { 0, "���D�u���u��|���@�o�A���i����@�o����@�~�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2035.InfoParameters[0].Value = sdata[0];
                cmdRT2035.InfoParameters[1].Value = sdata[1];
                cmdRT2035.InfoParameters[2].Value = sdata[2];
                cmdRT2035.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2035.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u��@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u��@�o����@�~,���~�T���G" + ex };
            }
        }
    }
}
