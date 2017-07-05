using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT103
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
            //�w�]�ȭn�a�J���Ͻs��
            return ucRTLessorAVSCmtyLine.GetFieldCurrentValue("COMQ1").ToString();

        }

        //�@�@�@�o
        public object[] smRT1031(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1031.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINE WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            string sqlyy = "select COUNT(*) AS CNT FROM RTLessorAVSCUST WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND CANCELDAT IS NULL AND DROPDAT IS NULL AND (STRBILLINGDAT IS NOT NULL OR NEWBILLINGDAT IS NOT NULL OR DOCKETDAT IS NOT NULL OR FINISHDAT IS NOT NULL ) ";
            cmd.CommandText = sqlyy;
            DataSet RSyy = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["APPLYDAT"].ToString() != "")
                {
                    return new object[] { 0, "�u���w���X�ӽСA���i�@�o(�вM���ӽФ�)�C" };
                }

                if (RSXX.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                {
                    return new object[] { 0, "�u���w�@�o�A���i���Ƨ@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "�u���w�M�u�A�����A�@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["ADSLAPPLYDAT"].ToString() != "")
                {
                    return new object[] { 0, "�u���w���q�A���i�@�o�C" };
                }
            }

            if (RSyy.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSyy.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "���u�����|���h�����Τ�A���i�����@�o�D�u�C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1031.InfoParameters[0].Value = sdata[0];
                cmdRT1031.InfoParameters[1].Value = sdata[1];
                cmdRT1031.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1031.ExecuteNonQuery();
                return new object[] { 0, "�D�u�@�o���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�ӽЧ@�o�@�~,���~�T��" + ex };
            }
        }

        //�D�u����@�o����
        public object[] smRT1032(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1032.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINE WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() == "")
                {
                    return new object[] { 0, "�u���|���@�o�A���i����@�o����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1032.InfoParameters[0].Value = sdata[0];
                cmdRT1032.InfoParameters[1].Value = sdata[1];
                cmdRT1032.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1032.ExecuteNonQuery();
                return new object[] { 0, "�D�u�@�o���ন�\  " };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�ӽЧ@�o����@�~,���~�T���G" + ex };
            }
        }
    }
}
