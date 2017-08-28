using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT2033
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

        //���γ�
        public object[] smRT20331(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            var xxadslapplydat = "";
            var xxCONTAPPLYDAT = "";
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT20331.Connection;
            conn.Open();
            //�ˬd�Ӭ��u��O�_�w���שΧ@�o�Τw�L�i��]�ƶ���
            string selectSql = "select * FROM RTLessorAVScmtylineSndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND PRTNO='"+ sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || ds.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���u��w���u���שΥ����u���סA���i�ફ�~��γ�C" };
                }
                if (ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "���u��w�@�o�A���i�ફ�~��γ�" };
                }
                if (ds.Tables[0].Rows[0]["CDAT"].ToString() != "" || ds.Tables[0].Rows[0]["BATCHNO"].ToString() != "")
                {
                    return new object[] { 0, "���u��w���������b�ڡA���i�ફ�~��γ�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣�쬣�u���ɡA�L�k���סC" };
            }

            selectSql = "select count(*) as CNT FROM RTLessorAVScmtylineHardware WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND PRTNO='" + sdata[2] + "' AND dropdat is null and rcvprtno='' and rcvfinishdat is null and batchno='' and qty > 0";
            cmd.CommandText = selectSql;
            ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CNT"].ToString() == "0")
                {
                    return new object[] { 0, "���u��w�L�䥦�]�ƥi�ફ�~��γ�" };
                }
            }


            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT20331.InfoParameters[0].Value = sdata[0];
                cmdRT20331.InfoParameters[1].Value = sdata[1];
                cmdRT20331.InfoParameters[2].Value = sdata[2];
                cmdRT20331.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT20331.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u�]���ફ�~��γ�@�~���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u�]���ફ�~��γ�@�~,���~�T��" + ex };
            }
        }

        //��γ����
        public object[] smRT20332(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT20332.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVScmtylineHardware WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "' AND SEQ="+ sdata[3];
            cmd.CommandText = selectSql;
            var XXRCVPRTNO = "";
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "���]�Ƥw�@�o�A���i���ફ�~��γ�" };
                }
                if (ds.Tables[0].Rows[0]["RCVPRTNO"].ToString() == "")
                {
                    return new object[] { 0, "���]�Ʃ|���ફ�~��γ�A���i����C" };
                }
                if (ds.Tables[0].Rows[0]["RCVFINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "���]�Ƥ����~��γ�w�g���סA���i����(������Х��������~��γ浲�ק@�~)" };
                }

                 XXRCVPRTNO = ds.Tables[0].Rows[0]["RCVPRTNO"].ToString();
            }
            else
            {
                return new object[] { 0, "���]�Ƥ��]���ɸ�Ƥ��s�b�A���i����(�гq����T��)�C" };
            }
            
            try
            {
                cmdRT20332.InfoParameters[0].Value = XXRCVPRTNO;
                cmdRT20332.InfoParameters[1].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT20332.ExecuteNonQuery();
                return new object[] { 0, "�D�u���u�]�ƪ��ફ�~��γ�@�~���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u�]�ƪ��ફ�~��γ�@�~,���~�T��" + ex };
            }
        }

        //�]�Ƨ@�o
        public object[] smRT20333(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT20333.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtyLineHardware WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "' AND SEQ=" + sdata[3];
            string sqlYY = "select * FROM RTLessorAVSCmtyLinesndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno = '" + sdata[2] + "'";
            cmd.CommandText = sqlxx;
            DataSet RSxx = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSxx.Tables[0].Rows.Count > 0)
            {
                if (RSxx.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����]�Ƥw�@�o�A���i���Ч@�o�C" };
                }

                if (RSxx.Tables[0].Rows[0]["BATCHNO"].ToString() != "")
                {
                    return new object[] { 0, "�w�������b�ڡA���i�@�o(���@�o���������@�o���u��)�C" };
                }

                if (RSxx.Tables[0].Rows[0]["RCVPRTNO"].ToString() != "")
                {
                    return new object[] { 0, "�w�ફ�~��γ�A���i�@�o(���@�o�Х����ફ�~��γ�)�C" };
                }
            }
            

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" && RSYY.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���ݬ��u��w���סA���i�@�o�]�Ʃ��ӡC" };
                }
            }
            

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT20333.InfoParameters[0].Value = sdata[0];
                cmdRT20333.InfoParameters[1].Value = sdata[1];
                cmdRT20333.InfoParameters[2].Value = sdata[2];
                cmdRT20333.InfoParameters[3].Value = sdata[3];
                cmdRT20333.InfoParameters[3].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT20333.ExecuteNonQuery();
                return new object[] { 0, "�D�u�]�Ʀw�˸�Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����]�Ʀw�˸�Ƨ@�o,���~�T���G" + ex };
            }
        }

        //�@�o����
        public object[] smRT20334(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT20334.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCustReturnhardware WHERE cusid=" + sdata[0] + " and entryno=" + sdata[1] + " and prtno = '" + sdata[2] + "' and seq = " + sdata[3];
            string sqlYY = "select * FROM RTLessorAVSCmtyLinesndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and prtno='" + sdata[2] + "' ";
            cmd.CommandText = sqlxx;
            DataSet RSxx = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSxx.Tables[0].Rows.Count > 0)
            {
                if (RSxx.Tables[0].Rows[0]["DROPDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����]�Ʃ|���@�o�A���i�@�o����C" };
                }
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSYY.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���ݬ��u��w���סA���i�@�o�]�Ʃ��ӡC" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT20334.InfoParameters[0].Value = sdata[0];
                cmdRT20334.InfoParameters[1].Value = sdata[1];
                cmdRT20334.InfoParameters[2].Value = sdata[2];
                cmdRT20334.InfoParameters[3].Value = sdata[3];
                cmdRT20334.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT20334.ExecuteNonQuery();
                return new object[] { 0, "�]�Ʀw�˸�Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����]�Ʀw�˸�Ƨ@�o����,���~�T���G" + ex };
            }
        }
    }
}
