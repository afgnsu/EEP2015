using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT202
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

        //�ଣ�u��
        public object[] smRT2021(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2021.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCMTYLINEFaqH WHERE COMQ1='" + sdata[0] + "' and LINEQ1=" + sdata[1] + " and FAQNO = '" + sdata[2] + "'";
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
                    return new object[] { 0, "�w���׮ɡA���i�ଣ�u��C" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();                
                if (ss1 != "")
                {
                    return new object[] { 0, "�w�����u��ɡA���i���а���C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2021.InfoParameters[0].Value = sdata[0];
                cmdRT2021.InfoParameters[1].Value = sdata[1];
                cmdRT2021.InfoParameters[2].Value = sdata[2];
                cmdRT2021.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2021.ExecuteNonQuery();
                return new object[] { 0, "�D�u�ȪA���ଣ�u�榨�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȪA���ଣ�u��@�~,���~�T��" + ex };
            }
        }

        //�ȪA����
        public object[] smRT2022(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2022.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCMTYLINEFaqH WHERE COMQ1='" + sdata[0] + "' and LINEQ1=" + sdata[1] + " and FAQNO = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i����ȪA�浲��" };
                }
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���ȪA��w���סA���i���ư���C" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���ȪA��w�ଣ�u��A���u��ݵ��׫�l�i����ȪA�浲�ק@�~�C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2022.InfoParameters[0].Value = sdata[0];
                cmdRT2022.InfoParameters[1].Value = sdata[1];
                cmdRT2022.InfoParameters[2].Value = sdata[2];
                cmdRT2022.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2022.ExecuteNonQuery();
                return new object[] { 0, "�D�u�ȪA�浲�צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȪA�浲�ק@�~,���~�T��" + ex };
            }
        }

        //���ת���
        public object[] smRT2023(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2023.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCMTYLINEFaqH WHERE COMQ1='" + sdata[0] + "' and LINEQ1=" + sdata[1] + " and FAQNO = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���ȪA��|�����סA���i����ȪA�浲�ת���" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2023.InfoParameters[0].Value = sdata[0];
                cmdRT2023.InfoParameters[1].Value = sdata[1];
                cmdRT2023.InfoParameters[2].Value = sdata[2];
                cmdRT2023.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2023.ExecuteNonQuery();
                return new object[] { 0, "�D�u�ȪA�浲�ת��ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȪA�浲�ת���@�~,���~�T��" + ex };
            }
        }

        //�D�u�ȪA��@�o
        public object[] smRT2024(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2024.Connection;
            conn.Open();
            string ss1 = "";
            string selectSql = "select * FROM RTLessorAVSCMTYLINEFaqH WHERE COMQ1='" + sdata[0] + "' and LINEQ1=" + sdata[1] + " and FAQNO = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ss1 = ds.Tables[0].Rows[0]["FINISHDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���D�u�ȪA���Ƥw���סA���i�@�o�C(�Ч�ε��ת���)�C" };
                }
                ss1 = ds.Tables[0].Rows[0]["SNDPRTNO"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���D�u�ȪA���Ƥw�ଣ�u��A���i�@�o�C" };
                }
                ss1 = ds.Tables[0].Rows[0]["CALLBACKDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "�w��CALLBACK(�^�Ф�)�A���i�@�o�C(�Х������^�Ф�)" };
                }
                ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 != "")
                {
                    return new object[] { 0, "���D�u�ȪA���Ƥw�@�o�A���i���а���" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2024.InfoParameters[0].Value = sdata[0];
                cmdRT2024.InfoParameters[1].Value = sdata[1];
                cmdRT2024.InfoParameters[2].Value = sdata[2];
                cmdRT2024.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2024.ExecuteNonQuery();
                return new object[] { 0, "�D�u�ȪA���Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u�ȪA���Ƨ@�o�@�~,���~�T���G" + ex };
            }
        }

        //�D�u�ȪA��@�o����
        public object[] smRT2025(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT2025.Connection;
            conn.Open();
            string ss2 = "";
            string ss1 = "";
            string selectSql = "select * FROM RTLessorAVSCMTYLINEFaqH WHERE COMQ1='" + sdata[0] + "' and LINEQ1=" + sdata[1] + " and FAQNO = '" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���D�u�ȪA���Ʃ|���@�o�A���i����" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT2025.InfoParameters[0].Value = sdata[0];
                cmdRT2025.InfoParameters[1].Value = sdata[1];
                cmdRT2025.InfoParameters[2].Value = sdata[2];
                cmdRT2025.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT2025.ExecuteNonQuery();
                return new object[] { 0, "�D�u�ȪA���Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u�ȪA���Ƨ@�o�@�~,���~�T���G" + ex };
            }
        }
    }
}
