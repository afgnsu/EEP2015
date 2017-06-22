using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1031
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

        //�������
        public object[] smRT10311(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10312.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINEcont WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];
            string sqlYY = "select * FROM RTLessorAVSCMTYLINE WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�u������w�@�o�A���i���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����Ƥw���סA���i���Ƶ��סC" };
                }

                if (RSXX.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����ƵL���q��A���i���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["LINEDUEDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����ƵL�����A���i���סC" };
                }

                if (RSYY.Tables[0].Rows.Count > 0)
                {
                    if (RSYY.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                    {
                        return new object[] { 0, "���D�u���D�ɸ�Ƥw�M�u�A���i����������ק@�~�C" };
                    }

                    if (RSYY.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "���D�u���D�ɸ�Ƥw�@�o�A���i����������ק@�~�C" };
                    }

                    if (RSYY.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() == "")
                    {
                        return new object[] { 0, "���D�u���D�ɸ�Ʃ|�����q�A���i����������ק@�~�C" };
                    }
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10311.InfoParameters[0].Value = sdata[0];
                cmdRT10311.InfoParameters[1].Value = sdata[1];
                cmdRT10311.InfoParameters[2].Value = sdata[2];
                cmdRT10311.InfoParameters[2].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10311.ExecuteNonQuery();
                return new object[] { 0, "�D�u������צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u������ק@�~,���~�T��" + ex };
            }
        }

        //�@�@�@�o
        public object[] smRT10312(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10312.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINEcont WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];
            string sqlYY = "select * FROM RTLessorAVSCMTYLINE WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����Ƥw�@�o�A���i���Ƨ@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����Ƥw���סA���i�@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() != "")
                {
                    return new object[] { 0, "�u������w���q�A���i�@�o(�вM�����q��)�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10312.InfoParameters[0].Value = sdata[0];
                cmdRT10312.InfoParameters[1].Value = sdata[1];
                cmdRT10312.InfoParameters[2].Value = sdata[2];
                cmdRT10312.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10312.ExecuteNonQuery();
                return new object[] { 0, "�D�u����@�o���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u����@�o�@�~,���~�T��" + ex };
            }
        }

        //�D�u����@�o����
        public object[] smRT10313(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10313.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINEcont WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];

            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() == "")
                {
                    return new object[] { 0, "�������Ʃ|���@�o�A���i����@�o����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10313.InfoParameters[0].Value = sdata[0];
                cmdRT10313.InfoParameters[1].Value = sdata[1];
                cmdRT10313.InfoParameters[2].Value = sdata[2];
                cmdRT10313.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10313.ExecuteNonQuery();
                return new object[] { 0, "�D�u����@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k��������ӽЧ@�o����@�~,���~�T���G" + ex };
            }
        }
    }
}
